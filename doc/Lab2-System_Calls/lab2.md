## Lab: system calls

> In the last lab you used system calls to write a few utilities. In this lab you will add some new system calls to xv6, which will help you understand how they work and will expose you to some of the internals of the xv6 kernel. You will add more system calls in later labs

本 lab 会让你编写几个简单的系统调用，主要目的为熟悉如何新增系统调用，并在用户态调用它们，比较简单，无需阅读 xv6 book。一共分为 3 个子 lab：

- **Using gdb**：学会用 gdb 进行调试，这里不再赘述。
- **System call tracing**：编写一个能够最终系统调用的工具 trace，传入一个 mask，每当进程及子进程调用了 mask 中对应的系统调用，trace 就会输出相关信息。
- **Sysinfo**：添加一个系统调用 sysinfo，返回空闲的内存、以及已创建的进程数量。

进行实验前，先介绍下如果新增系统调用。

### 如何创建系统调用

首先在内核适当位置（`kernel/`目录下），创建系统调用相关的 .c 文件，但是注意，这里的 .c 文件只是起一个归纳作用，而不是像用户态那样一个文件一个命令。比如，所有和进程相关的系统调用基本都在 `kernel/sysproc.c` 中实现。这是因为，用户态命令需要 main 函数作为入口，因此一个文件一个命令，而内核系统调用则不需要如此。所有系统调用均以 sys_xxx 来进行命名，比如：

```c
uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  exit(n);
  return 0;  // not reached
}
```

其次，在 `kernel/syscall.h` 中加入新的 systemcall 编号，递增即可，如下：

```c
// kernel/syscall.h
// System call numbers
#define SYS_fork    1
#define SYS_exit    2
#define SYS_wait    3
#define SYS_pipe    4
#define SYS_read    5
// ....
```

然后，在 `kernel/syscall.c` 中用 extern 全局声明新的内核调用函数，并且在 syscalls 映射表中，加入从前面定义的编号到系统调用函数指针的函数。

``` c
// kernel/syscall.c 
extern uint64 sys_chdir(void);
extern uint64 sys_close(void);
extern uint64 sys_dup(void);
extern uint64 sys_exec(void);
extern uint64 sys_exit(void);
// ...

static uint64 (*syscalls[])(void) = {
[SYS_fork]    sys_fork,
[SYS_exit]    sys_exit,
[SYS_wait]    sys_wait,
[SYS_pipe]    sys_pipe,
[SYS_read]    sys_read,
// ...
}
```

这里 `[SYS_trace] sys_trace` 是 C 语言数组的一个语法，表示以方括号内的值作为元素下标。比如 `int arr[] = {[3] 2333, [6] 6666}` 代表 arr 的下标 3 的元素为 2333，下标 6 的元素为 6666，其他元素填充 0 的数组。（该语法在 C++ 中已不可用）

接下来，在 `user/usys.pl` 中，加入用户态到内核态的跳板函数。

```c
# user/usys.pl
entry("fork");
entry("exit");
entry("wait");
entry("pipe");
entry("read");
entry("write");
# ...
```

这个脚本在 make qemu 后会生成 usys.S 汇编文件，里面定义了每个系统调用的用户态跳板函数，比如：

```assembly
wait:
 li a7, SYS_wait
 ecall
 ret
.global pipe
pipe:
 li a7, SYS_pipe
 ecall
 ret
.global read
```

最后，在用户态的头文件（`user/user.h`）中加入定义，使得用户态程序可以找到这个跳板的入口。

```c
// user/user.h
// system calls
int fork(void);
int exit(int) __attribute__((noreturn));
int wait(int*);
int pipe(int*)
// ...
```

综上，系统调用的流程整合如下：

``` c
user/user.h:		用户态程序调用跳板函数
user/usys.S:		跳板函数使用 CPU 提供的 ecall 指令，调用到内核态
kernel/syscall.c	到达内核态统一系统调用处理函数 syscall()，所有系统调用都会跳到这里来处理。
kernel/syscall.c	syscall() 根据跳板传进来的系统调用编号，查询 syscalls[] 表，找到对应的内核函数并调用。
kernel/sysproc.c	到达 sys_xxx() 系统调用函数，执行具体内核操作
```

如此繁琐的操作，就是为了实现内核态与用户态的隔离，保证安全。而这样就引出了一个问题，系统调用的参数怎么传递？

由于内核与用户进程的页表不同，寄存器也不互通，所以参数无法直接通过 C 语言参数的形式传过来，而是需要使用 argaddr、argint、argstr 等系列函数，从进程的 trapframe 中读取用户进程寄存器中的参数。

同样的，页表不同，指针也不同，内核不能直接对用户态传进来的指针进行解引用，而是需要使用 copyin、copyout 方法结合进程的页表，才能顺利找到用户态指针（逻辑地址）对应的物理内存地址。因此，当系统调用传递给用户态返回值时，则需要通过 copyout 来拷贝。

流程完毕，开始实验。

### System call tracing (moderate)

> In this assignment you will add a system call tracing feature that may help you when debugging later labs. You'll create a new `trace` system call that will control tracing. It should take one argument, an integer "mask", whose bits specify which system calls to trace. For example, to trace the fork system call, a program calls `trace(1 << SYS_fork)`, where `SYS_fork` is a syscall number from `kernel/syscall.h`. You have to modify the xv6 kernel to print out a line when each system call is about to return, if the system call's number is set in the mask. The line should contain the process id, the name of the system call and the return value; you don't need to print the system call arguments. The `trace` system call should enable tracing for the process that calls it and any children that it subsequently forks, but should not affect other processes.

该实验需要实现一个系统调用 trace，用来监控进程调用的系统调用，通过 mask 来决定哪些系统调用需要监视。由于和进程有关，所有大部分代码位于 `kernel/proc.c` 和 `kernel/sysproc.c` 中。

每个进程都需要有个 mask，以此来决定 trace 监控的系统调用，因此需要给进程的结构加上一个新的字段。进程通过 struct proc 来记录，如下：

```c
// kernel/proc.h
// Per-process state
struct proc {
  struct spinlock lock;

  // p->lock must be held when using these:
  enum procstate state;        // Process state
  void *chan;                  // If non-zero, sleeping on chan
  int killed;                  // If non-zero, have been killed
  int xstate;                  // Exit status to be returned to parent's wait
  int pid;                     // Process ID

  // wait_lock must be held when using this:
  struct proc *parent;         // Parent process

  // these are private to the process, so p->lock need not be held.
  uint64 kstack;               // Virtual address of kernel stack
  uint64 sz;                   // Size of process memory (bytes)
  pagetable_t pagetable;       // User page table
  struct trapframe *trapframe; // data page for trampoline.S
  struct context context;      // swtch() here to run process
  struct file *ofile[NOFILE];  // Open files
  struct inode *cwd;           // Current directory
  char name[16];               // Process name (debugging)

  int trace_mask;              // mask for sys_trace
};
```

在创建新进程时，需要初始化 trace_mask 为 0，那么在哪里创建新进程呢？和进程有关的核心操作均在 `kernel/proc.c` 中，当然这不属于系统调用，只是内核函数。创建进程会调用 allocproc 函数来进行，因此需要在其中对 trace_mask 进行初始化。

```c
// kernel/proc.c
static struct proc*
allocproc(void)
{
  struct proc *p;
  // ...
  p->trace_mask = 0;
  return p;
}
```

因为实验要求子进程也需要一并监控，因此在 fork 时要将 trace_mask 传递下去，更改 fork 的代码：

```c
// kernel/proc.c
int
fork(void)
{
  int i, pid;
  struct proc *np;
  struct proc *p = myproc();
  // ...
  np->trace_mask = p->trace_mask;
  // ...
}
```

而 sys_trace 要做的，就是给 trace_mask 进行赋值。

```c
// kernel/sysproc.c
uint64
sys_trace(void){
  int mask;
  argint(0,&mask);
  if(mask < 0){
    return -1;
  }
  struct proc *p = myproc();
  p->trace_mask = mask;
  return 0;
}
```

mask 解决了，接下来解决如何监控的问题。

我们需要知道，trace 要做的，是每当 mask 指明的系统调用被调用时，进行一次打印，问题就转化为了何时调用 打印，即在哪里进行插桩。如果在每一个系统调用里都进行插桩，如果 mask 符合就打印，反之不调用，当然是能够解决问题的，不过这肯定不是最终解，太憨了。实际上，所有的系统调用均有一个统一的入口，只要在该入口处进行插桩即可。

系统调用的统一入口为函数 syscall，通过其代码可知，该函数读取 p->trapframe->a7 中存的系统调用编号，来跳转到对应的系统调用，因此在此处插桩即可，代码如下：

```c
// kernel/syscall.c
void
syscall(void)
{
  int num;
  struct proc *p = myproc();

  num = p->trapframe->a7;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    // sys_trace插桩
    if((p->trace_mask >> num) & 1){
      printf("%d: syscall %s -> %d\n",p->pid, syscall_names[num], p->trapframe->a0);
    }
  } else {
    printf("%d %s: unknown sys call %d\n",
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
  }
}
```

实现完毕后，需要将 sys_trace 系统调用注册进去，具体步骤如第一小节所示，这里不再赘述。根据实验要求，我们要实现用户态的 trace 命令。实际上，`user/trace.c` 已经写好了， 不用我们来完成。因此，lab2 到这就完成了。运行结果：

```shell
$ trace 32 grep hello README
3: syscall read -> 1023
3: syscall read -> 961
3: syscall read -> 321
3: syscall read -> 0
```

### Sysinfo (moderate)

> In this assignment you will add a system call, `sysinfo`, that collects information about the running system. The system call takes one argument: a pointer to a `struct sysinfo` (see `kernel/sysinfo.h`). The kernel should fill out the fields of this struct: the `freemem` field should be set to the number of bytes of free memory, and the `nproc` field should be set to the number of processes whose `state` is not `UNUSED`. We provide a test program `sysinfotest`; you pass this assignment if it prints "sysinfotest: OK".

本实验需要添加一个系统调用 sysinfo，返回空闲的内存、以及已创建的进程数量。测试本实验的代码文件为 sysinfotest.c，在其中可看见该系统调用的用法：

```c
// user/sysinfotest.c
void
testcall() {
  struct sysinfo info;
  
  if (sysinfo(&info) < 0) {
    printf("FAIL: sysinfo failed\n");
    exit(1);
  }

  if (sysinfo((struct sysinfo *) 0xeaeb0b5b00002f5e) !=  0xffffffffffffffff) {
    printf("FAIL: sysinfo succeeded with bad argument\n");
    exit(1);
  }
}
```

可以看到，sysinfo 需要接收一个 struct sysinfo 地址，然后把结果存进去返回给用户态。

```c
// kernel/sysinfo.h
struct sysinfo {
  uint64 freemem;   // amount of free memory (bytes)
  uint64 nproc;     // number of process
};
```

**1. 获取空闲内存**

工程里没有先成的获取空闲内存函数让我们使用，因此需要自己写一个。和物理内存相关的函数位于 `kernel/kalloc.c` 中，比如 kalloc，kfree。

在编写前，需要知道 xv6 是怎么管理空闲内存的，在 xv6 book 的 chapter 3 中讲到，xv6 通过一个链表将各个空闲内存页连接起来，一个节点代表一个空闲内存页，形成一个空闲链表 freelist。每次需要分配，就把链表根部对应的页分配出去。每次需要回收，就把这个页作为新的根节点，把原来的 freelist 链表接到后面。需要注意，这里是直接使用空闲页本身作为链表节点，所以不需要使用额外空间来存储空闲页链表。在代码里，初始节点名为 kmem：

```c
struct {
  struct spinlock lock;
  struct run *freelist;
} kmem;
```

每一个节点对应的内存大小为 PGSIZE，因此只要遍历链表累加即可获取所有空闲内存，代码如下：

```c
// kernel/kalloc.c
uint64
kcollect_free(void)
{
  acquire(&kmem.lock);
  
  uint64 free_bytes = 0;
  struct run *r = kmem.freelist;
  while(r){
    free_bytes += PGSIZE;
    r = r->next;
  }

  release(&kmem.lock);
  return free_bytes;
}
```

需要注意的是，此时该函数不能被其他文件使用，除非使用者 include kalloc.c。工程在这里做了一个统一，将内核之间需要用到的内核函数均声明在 `kernel/defs.h` 中，其他文件只需 include defs.h 即可使用。因此，在 defs.h 中对 kcollect_free 进行声明：

```c
// kernel/defs.h
void*           kalloc(void);
void            kfree(void *);
void            kinit(void);
uint64          kcollect_free(void);
```

**2. 获取运行进程数**

在 xv6 中，有个进程数组 `struct proc proc[NPROC]` ，其中 NPROC = 64，所有的进程均记录在其中。proc 有个字段名为 state，当进行未运行时，state 值为 UNUSED，只要 state != UNUSED，就代表正在运行中。

因此，只需要遍历 proc 数组，统计 state != UNUSED 的数量即可。代码如下：

```c
// kernel/proc.c
int
collect_proc_num(void)
{
  int num = 0;
  struct proc *p;
  for(p = proc; p < &proc[NPROC]; p++){
    if(p->state != UNUSED)
      num++;
  }
  return num;
}
```

不要忘了在 defs.h 中进行声明。

**3. 实现系统调用**

首先，在 sys_sysinfo 中调用刚刚实现的两个内核函数，获取到 freemem 和 proc。接着，将结果拷贝给用户态返回出去。

从内核态拷贝至用户态，需要用到函数 copyout，其四个参数依次为：进程页表、用户态用于存储结果的地址、拷贝内容源地址、拷贝大小。

综上，sys_sysinfo 的代码如下：

```c
// kernel/sysinfo.c
uint64
sys_sysinfo(void)
{
    struct proc *p = myproc();

    struct sysinfo info;
    uint64 info_addr; // user pointer to struct stat
    argaddr(0, &info_addr);

    info.freemem = kcollect_free();
    info.nproc = collect_proc_num();

    // 将struct sysinfo拷贝至用户态
    if(copyout(p->pagetable, info_addr, (char*)&info, sizeof(info)) < 0){
        return -1;
    }
    return 0;
}
```

最后，将该系统调用在 xv6 中进行注册，过程不再赘述。

