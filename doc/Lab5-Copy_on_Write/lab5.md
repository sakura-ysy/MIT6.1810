## Lab: Copy-on-Write Fork for xv6

> Virtual memory provides a level of indirection: the kernel can intercept memory references by marking PTEs invalid or read-only, leading to page faults, and can change what addresses mean by modifying PTEs. There is a saying in computer systems that any systems problem can be solved with a level of indirection. This lab explores an example: copy-on-write fork.

本实验要实现写时复制（COW），概念本科 OS 课都学过。具体实现方面，需要用到两个核心知识点：1. page table，2. page fault。

COW 的主要原理如下。当父进程 fork 出子进程时，子进程建立自己的页表，但是不会复制父进程的物理页，而是将每一个 PTE 都指向父进程的物理页，即两大页表同时指向同一片物理内存。而当某一个进程需要对物理页进行写时（可以是父也可以是子），再开辟一个新的物理页，内容为复制原有的物理页，使进程的 PTE 由原来的物理页指向这个新的物理页。

而如何触发 COW 呢？就是通过 page fault。需要被 COW 的 PTE 会被标记为 PTE_COW，并且清空 PTE_W （父与子均是这样），即不可写。此时，若某一个进程试图写该 PTE 对应的共享物理页（假设是子进程），那么就会触发 page fault，进行 usertrap。接下来，只需要在 usertrap 中复制物理页并重新映射该 PTE 置新开辟的物理页即可。重映射完成后，将 PTE_W 置位，清空 PTE_COW，这样一来子进程再一次写该页就成功了。

具体的实现流程在 [Lecture 08](https://github.com/huihongxiao/MIT6.S081/tree/master/lec08-page-faults-frans) 中讲的很清楚，建议先看完再写。

### Implement copy-on-write fork (hard)

> Your task is to implement copy-on-write fork in the xv6 kernel. You are done if your modified kernel executes both the cowtest and 'usertests -q' programs successfully.

本实验一共就这一个子实验，来实现 COW，虽然标的是 hard，但并不难。唯一比较狗的地方是不好调试，因为错误全都是和内存相关的。甚至说，如果哪一个地方写错了，os 可能都启动不了，我就遇见过。

首先我们知道，运用了 COW 之后，一块物理页可能被多个进程同时映射，这样的话就不用使用传统的 kfree 了，原因显而易见。这里需要为每一个物理页记录一个引用数 ref，当该物理页初次被 kalloc 时，ref 赋值为 1，每当一个新进程有 PTE 映射到该物理页时，ref ++，反之，解映射时 ref --，当 ref == 0 时，方将其回收至 freelist 中。

如何保存每个物理页的 ref ？lab guide 给了官方的建议，用全局数组。

> It's OK to to keep these counts in a fixed-size array of integers. You'll have to work out a scheme for how to index the array and how to choose its size. For example, you could index the array with the page's physical address divided by 4096, and give the array a number of elements equal to highest physical address of any page placed on the free list by `kinit()` in kalloc.c

和物理内存有关的代码均在 `kernel/kalloc.c` 中，故在其中定义 ref：

```c
// kernel/kalloc.c
struct spinlock ref_lock;  // 别忘了锁
int pm_ref[(PHYSTOP - KERNBASE)/PGSIZE];  // 记录物理页的引用计数

// va映射为idx
uint64
getRefIdx(uint64 pa){
  return (pa-KERNBASE)/PGSIZE;
}

// 初始化锁
void
kinit()
{
  initlock(&kmem.lock, "kmem");
  initlock(&ref_lock, "pm_ref");  // this one
  freerange(end, (void*)PHYSTOP);
}
```

定义了 ref，那么顺气自然的要定义对 ref 的加减操作，如下：

```c
// kernel/kalloc.c
void
refup(void* pa){
  acquire(&ref_lock);
  pm_ref[getRefIdx((uint64)pa)] ++;
  release(&ref_lock);
}

void
refdown(void* pa){
  acquire(&ref_lock);
  pm_ref[getRefIdx((uint64)pa)] --;
  release(&ref_lock);
}
```

接下来修改 kalloc 和 kfree，在物理页被 kalloc 时，由于是第一次引用，因此 ref = 1，同时，因为 kalloc 不会存在多线程竞争问题，因此这里不需要加锁。kfree 则不着急讲物理页回收，而是将 ref -- ，如果 ref <=0 再将其回收。注意，为什么这里需要明确 ref <= 0 ，而不是 ref == 0 ？这是因为在 os 刚启动时，要调用 kinit，而 kinit 会调用 freerange，即初始化 freelist，而此时 pm_ref 中的所有元素均是 -1，所以如果用 ref == 0 来判断，那么 os 启动时将找不到任何空闲内存。kalloc 和 kfree 代码如下：

```c
// kernel/kalloc.c
void *
kalloc(void)
{
  struct run *r;

  acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  release(&kmem.lock);

  if(r){
    memset((char*)r, 5, PGSIZE); // fill with junk
    pm_ref[getRefIdx((uint64)r)] = 1;  // 初始化不用加锁
  }
  return (void*)r;
}

void
kfree(void *pa)
{
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    panic("kfree");

  acquire(&ref_lock);
  pm_ref[getRefIdx((uint64)pa)] --;
  if(pm_ref[getRefIdx((uint64)pa)] <= 0){
    // Fill with junk to catch dangling refs.
    memset(pa, 1, PGSIZE);
    r = (struct run*)pa;
    acquire(&kmem.lock);
    r->next = kmem.freelist;
    kmem.freelist = r;
    release(&kmem.lock);
  }
  
  release(&ref_lock);
}
```

至此，与 ref 相关的基础操作就完成了。接下来需要修改 uvmcopy，该函数是 fork 时调用的，用来让子进程复制父进程的物理页并映射进子进程的页表中，这里需要修改它，使物理页不再复制，而是让子进程直接映射父进程的物理页。

需要注意，如果父进程的一个 PTE 本身就是不可写的，那么还有必要 COW 吗？答案是无，因为子进程对这块物理页也一定是不可写的，那么就没必要复制，因此只有当父进程的 PTE_W 标记时，才去附加 PTE_COW。这里 PTE_COW 用的是 PTE 的第 8 位（预留位），`#define PTE_COW (1L << 8)` 。uvmcopy 代码如下：

```c
// kernel/vm.c
int
uvmcopy(pagetable_t old, pagetable_t new, uint64 sz)
{
  pte_t *pte;
  uint64 pa, i;
  uint flags;

  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walk(old, i, 0)) == 0)
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);

    // lab5: Copy on write
    // father
    // 如果该页本身就不可写，那么子进程肯定也不可写，不用对其考虑COW
    if(*pte & PTE_W){  
        *pte &= ~PTE_W;
        *pte |= PTE_COW;
    }
    flags = PTE_FLAGS(*pte);
    // child
    if(mappages(new, i, PGSIZE, (uint64)pa, flags) != 0){
      goto err;
    }
    refup((void*)pa);
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
  return -1;
}
```

接下来，就是在 page fault 触发时进行进行 cow copy 了。page fault 的 trap 号为 15 和 13，因此修改 usertrap，添加新的分支：

```c
// kernel/trap.c
void
usertrap(void)
{
  // ...
  } else if((r_scause() == 15 || r_scause() == 13) && iscowpage(r_stval())){
    startcowcopy(r_stval());
  } else {
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    setkilled(p);
  } 
  // ...
}
```

其中，iscowpage 用来检查该页是否为 cow page，应为和 PTE 有关，因此放在 vm.c 下：

```c
// kernel/vm.c
int
iscowpage(uint64 va){
  struct proc* p = myproc();
  va = PGROUNDDOWN((uint64)va);
  if(va >= MAXVA)  // 要在walk之前
    return 0;
  pte_t* pte = walk(p->pagetable,va,0);
  if(pte == 0)
    return 0;
  if((va < p->sz)&& (*pte & PTE_COW) && (*pte & PTE_V))
    return 1;
  else
    return 0;
}
```

这里需要特别注意的是，在 usertrap 中，一旦 iscowpage 不满足，应该杀死进程，而不是继续执行。因为满足 iscowpage 的 page fault 是我们需要的，而不满足的就是平常的页错误，比如用户尝试读取内核、va 超过 MAXVA 等等，这些都是需要杀死进程的。因此，将 iscowpage 放在外层分支中，一旦不满足就进入接下来的分支 kill 掉。

startcowcopy 就是 cow 的主要操作，将该 PTE 重新映射至新的物理内存，并修改 flags：

```c
// kernel/vm.c
void
startcowcopy(uint64 va){
  struct proc* p = myproc();
  va = PGROUNDDOWN((uint64)va);
  pte_t* pte = walk(p->pagetable,va,0);
  uint64 pa = PTE2PA(*pte);

  void* new = cowcopy_pa((void*)pa);
  if((uint64)new == 0){
    panic("cowcopy_pa err\n");
    exit(-1);
  }

  uint64 flags = (PTE_FLAGS(*pte) | PTE_W) & (~PTE_COW);
  uvmunmap(p->pagetable, va, 1, 0);  // 不包含kfree，因为ref--在cowcopy_pa中已经进行了

  if(mappages(p->pagetable, va, 1, (uint64)new, flags) == -1){
    kfree(new);
    panic("cow mappages failed");
  }
}
```

需要注意的是，不管是映射还是解映射，都只能操作对齐的页，因此要先将 va 向下对齐。此外，uvmunmap 会将原来的 pte 重置，此时 * pte == 0，因此 PTE_FLAGS(*pte) 要在 uvmunmap 之前。而代码中的 cowcopy_pa 就是复制物理内存，因为其涉及到物理内存的释放与分配，我将其放在 kalloc.c 中。

如果一个物理页的 ref == 1，那么 cowcopy_pa 不再复制，而是直接返回它。反之，如果 ref > 1，那么就开辟一个新的物理页，将原物理页进行复制，同时原物理页 ref --。代码如下：

```c
// kernel/kalloc.c
void*
cowcopy_pa(void* pa){
  acquire(&ref_lock);
  if(pm_ref[getRefIdx((uint64)pa)] <= 1){
    release(&ref_lock);
    return pa;
  }

  char* new = kalloc();
  if(new == 0){
    release(&ref_lock);
    panic("out of memory");
    return 0;
  }

  memmove((void*)new, pa, PGSIZE);

  // 变更引用计数
  pm_ref[getRefIdx((uint64)pa)] --;
  release(&ref_lock);
  return (void*)new;
}
```

至此，利用 page fault 进行的 cow 就完成了。然而，还有一些不会触发 page fault 的访问，需要我们修改，比如 copyout。copyout 通过软件访问页表（即通过 walkaddr，就像我们自己写的代码那样），因此如果出错了不会触发 page fault，也就无法 cow。这里要修改 copyout 使其能够进行 cow，加四行代码就行，流程和 usertrap 一模一样，如下：

```c
// kernel/vm.c
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    va0 = PGROUNDDOWN(dstva);
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    
    if(iscowpage(va0)){                 // 这
      startcowcopy(va0);                // 是
      pa0 = walkaddr(pagetable, va0);   // 加
    }                                   // 的

    n = PGSIZE - (dstva - va0);
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);

    len -= n;
    src += n;
    dstva = va0 + PGSIZE;
  }
  return 0;
}
```

至此，本实验完成，测试结果：

```shell
== Test running cowtest == 
$ make qemu-gdb
(9.1s) 
== Test   simple == 
  simple: OK 
== Test   three == 
  three: OK 
== Test   file == 
  file: OK 
== Test usertests == 
$ make qemu-gdb
(53.1s) 
    (Old xv6.out.usertests failure log removed)
== Test   usertests: copyin == 
  usertests: copyin: OK 
== Test   usertests: copyout == 
  usertests: copyout: OK 
== Test   usertests: all tests == 
  usertests: all tests: OK 
== Test time == 
time: OK 
Score: 110/110
```

### 问题与注意点

`make qemu` 启动不了，一直卡在 xv6 kernel is booting

- 很显然，os 无法启动。在 fork 中进行打印，发现没有输出，说明根进程都没有启动，问题大概率出现在内存方面。

- 在 os 启动时，要先对内存进行一个初始化，即函数 kinit，该函数主要用来初始化 freelist，调用的函数为 freerange，在追溯下去就是多次调用 kfree。我在 kfree 中打印日志，发现 kfree 一直在调用，死循环了，怪不得 os 启动不了。

- 看了下我更改后的 kfree 实现，发现是个非常憨批的问题。问题代码如下：

- ```c
  void
  kfree(void *pa)
  {
    // ...
    if(pm_ref[getRefIdx((uint64)pa)] == 0){
      // ...
    }
    // ...
  }
  ```

- 这里就是个初始化问题了，虽然在 kalloc 会将相应 pm_ref[idx] 初始化为 1，但是在 kalloc 之前 pm_ref[] 的初始值并不是 0，因此如果 kfree 只进行 == 0 判断，那很显然 os 启动时一块空闲内存都找不到，改成 <= 即可。

- ```c
  void
  kfree(void *pa)
  {
    // ...
    if(pm_ref[getRefIdx((uint64)pa)] <= 0){
      // ...
    }
    // ...
  }
  ```

报错 panic: uvmunmap: not aligned

- 这是因为触发 page fault 的 va 可能是没对齐的，但是进行 mappage 和 uvmunmap 时，va一定要对齐，因此在进行映射和解映射前将 va 向下对齐一下即可，PGROUNDDOWN(va)。

`make qemu` 执行成功，但是所有命令都卡住，经过打印日志发现在同一个 cow va 下持续触发 page fault，死循环。

- 按照正常的逻辑，当 cow va 正常处理后（指写时复制执行完毕，指向独立的物理页，Flag也更改了），flag 除了置位了 PTE_W 和清空了 PTE_COW 以外均没有变化，下次再读/写该页的时候不会发生了 page fault。所以持续 page fault 的问题大概率是因为 flag 没弄好，这一点我想到了，但是 debug 排错我弄了蛮久，最后发现是个特别憨的错误。

- 首先，在 startcowcopy 中，我是先进行 uvmunmap 后再更改 flag，逻辑上没错，但代码就出现了很大的问题，错误代码：

- ```c
  // ...
  uvmunmap(p->pagetable, va, 1, 0); 
  uint64 flags = (PTE_FLAGS(*pte) | PTE_W) & (~PTE_COW);
  // ...
  ```

- 如果这样的话，就会发现更改后的 flag 完全变了。这是因为当 uvmunmap 解映射了该 pte 之后，再通过 * pte 得到的就不再是原来的值了，而是 0，那么相应的 PTE_FLAGS(*pte) 也不再是原来的 flag 了，而是 0，导致了 flag 更改错误。解决办法很简单，换下位置就行了。

- ```c
  // ...
  uint64 flags = (PTE_FLAGS(*pte) | PTE_W) & (~PTE_COW);
  uvmunmap(p->pagetable, va, 1, 0); 
  // ...
  ```

`usertests -q` 卡在了 `test kernmem ` 

- kernmem 用来测试进程是否能读 kernel 区域，正确情况应该是不能，然后子进程被杀死，测试点通过。

- 但是我跑的时候，发现子进程在 KERNELBASE 处持续触发 13 号 trap（page fault），导致死循环。个人理解，尝试读取 kernel 本身就是错误的，因此这里不能像之前一样进去处理 COW。如果对该地址调用 walk 获取 pte，会发现 pte == 0。

- 解决办法，如果 pte == 0，直接杀死进程。

- 实际上，在 iscowapge 中，我对这个情况进行了判断，如果 pte == 0，那么就返回 0，说明不是 cow page。然后，usertrap 收到这个 0 后，并没有杀死进程，导致进程持续不断的 page fault。因此要在 usertrap 上稍作该动，当 iscowpage 返回 0 时，usertrap 直接杀死进程。只需要将 iscowpage 放在大分支里即可：

- 原错误代码：

- ```c
    } else if((r_scause() == 15 || r_scause() == 13)){
      if(iscowpage(r_stval()))
        startcowcopy(r_stval());
    }
  ```

- 现正确代码：

- ```c
    } else if((r_scause() == 15 || r_scause() == 13) && iscowpage(r_stval())){
      startcowcopy(r_stval());
    }
  ```

`usertests -q` 执行 `test MAXVAplus ` 时报错 panic: walk

- MAXVAplus 用来测试访问超过 MAXVA 的情况会怎么样。
- 在 iscowpage 判断时， va >= MAXVA 的判断应该在 pte = walk 之前，因为当 va >= MAXVA 时，walk 不是返回 0，而是直接报 panic。

