## Lab: Multithreading

> This lab will familiarize you with multithreading. You will implement switching between threads in a user-level threads package, use multiple threads to speed up a program, and implement a barrier.
>
> Before writing code, you should make sure you have read "Chapter 7: Scheduling" from the [xv6 book](https://pdos.csail.mit.edu/6.828/2022/xv6/book-riscv-rev3.pdf) and studied the corresponding code.

本实验单看三个子 lab 的话可以说是巨简单，因为并没有涉及到编写 xv6 的实际线程切换，即使是在 lab1 中也进行是在用户态进行模拟。但是，[Lecture 11](https://github.com/huihongxiao/MIT6.S081/tree/master/lec11-thread-switching-robert) 详细介绍了 xv6 线程切换的原理和实现，并借助最常规的线程切换触发方式（CPU 时间片到，让位给下一个线程）来缕清整个切换流程的代码细节，讲的很好，个人感觉是 OS 多线程中非常好的基础教学。

因此，本实验侧重点还是学习 [Lecture 11](https://github.com/huihongxiao/MIT6.S081/tree/master/lec11-thread-switching-robert) ，看完之后完成三个子 lab 会非常简单。这里抽离出 Lecture 中讲的一些核心部分，细节还是要自己去看。

首先，在 Linux 中，线程本质上就是共用一片内存的进程，因此多线程就是多进程，线程的概念很模糊。实际上，在 xv6 中线程的概念也很模糊。规范地说，xv6 中每个进程包含两个线程，一个叫用户线程，另一个叫内核线程。实际上，这两个线程就是进程在不同态下的运行时，当进程（proc）运行在内核态时，就是用户线程，当进程运行在内核态时。因此当 Lecture 中提及用户/内核线程时，要对这俩概念清楚。

而线程切换指的是啥？其实也是进程间的切换，去看切换实现的代码可知，没有 thread 一说，所有 “当前线程” 都是 myproc()，也就是进程。因此当下文不管提到线程切换还是进程切换，都是一个意思，实际上就是进程，只不过官方把它叫成线程。

单个 CPU 核每时只能运行一个线程，因此 OS 通过时间片轮转的方式让多个线程轮流使用 CPU，因此并行的多线程实际上就是快速切换的串行执行。当然，出让 CPU 的方式不止有时间片到，还有中断等待等等，很多。

进程之间的切换一定是要走内核的，因此让步的触发条件就是中断。很直观的想到，一个简单的调度模式分为如下四步：

1. 从一个用户进程切换到另一个用户进程，都需要从第一个用户进程接入到内核中，保存用户进程的状态并运行第一个用户进程的内核线程；
2. 再从第一个用户进程的内核线程切换到第二个用户进程的内核线程；
3. 之后，第二个用户进程的内核线程暂停自己，并恢复第二个用户进程的用户寄存器；
4. 最后返回到第二个用户进程继续执行。

这个线路很简单也很直观，相应的，这个线路有一些寄存器需要保存，用户线程的寄存器和内核线程的寄存器。前者我们都知道了，用 trapframe 保存，而后者也类似，在 proc 中通过 context 来保存。 context 中保存 ra、sp 和 Callee saved register，这很容易理解。因为Caller saved register 会被 C 语言自动保存，而 ra、sp、Callee saved register 不行，需要汇编来手动保存。再理解不了就去看 Lecture。

```c
struct proc {
  // ...
  struct trapframe *trapframe; // data page for trampoline.S
  struct context context;      // swtch() here to run process
  // ...
}
```

然而，xv6 用的不是这套四步流程。xv6 给每个 CPU 核绑定一个固有的调度器线程，专门用于线程切换，起到桥梁的作用。加入了调度器的切换流程，如下（由 P1 切换至 P2，时间片触发）：

1. 首先与我之前介绍的一样，一个定时器中断强迫 CPU 从用户空间进程切换到内核，trampoline 代码将用户寄存器保存于用户进程对应的 trapframe 对象中；
2. 之后在内核中运行 usertrap，来实际执行相应的中断处理程序。这时，CPU 正在进程 P1 的内核线程和内核栈上，执行内核中普通的 C 代码；
3. 假设进程 P1 对应的内核线程决定它想出让 CPU，它会做很多工作，具体什么工作去看 Lecture，但是最后它会调用 swtch 函数。（因此 switch 是 C 关键字，因此函数名为 swtch 以作区分）；
4. swtch函数会保存用户进程P1对应内核线程的寄存器至context对象。所以目前为止有两类寄存器：用户寄存器存在trapframe中，内核线程的寄存器存在context中；
5. 但是， swtch 函数并不是直接从一个内核线程切换到另一个内核线程，而是跳到调度器线程中；
6. 此时，P1 的各种寄存器已被保存，CPU 现在由调度器线程接管；
7. 调度器线程保存自己的内核寄存器到 context 中；
8. 找到进程 P2 之前保存的 context ，恢复其中的寄存器；
9. 因为进程 P2 在进入 RUNABLE 状态之前，如刚刚介绍的进程 P1 一样，必然也调用了 swtch 函数。所以之前的 swtch 函数会被恢复，并返回到进程 P2 所在的系统调用或者中断处理程序中；
10. 不论是系统调用也好中断处理程序也好，在从用户空间进入到内核空间时会保存用户寄存器到 trapframe 对象。所以当内核程序执行完成之后，trapframe 中的用户寄存器会被恢复。最终，P2 恢复运行。

大致就这么个流程，也很简单，就是加了个调度器而已，细节去看 [Lecture 11](https://github.com/huihongxiao/MIT6.S081/tree/master/lec11-thread-switching-robert) 。开始做实验。

### Uthread: switching between threads (moderate)

> In this exercise you will design the context switch mechanism for a user-level threading system, and then implement it. To get you started, your xv6 has two files user/uthread.c and user/uthread_switch.S, and a rule in the Makefile to build a uthread program. uthread.c contains most of a user-level threading package, and code for three simple test threads. The threading package is missing some of the code to create a thread and to switch between threads.

顾名思义，本 lab 是在用户态进行线程切换，也就是说模拟，没有涉及到内核。实际上，上面讲到的调度器在这里不会出现，而是直接由 P1 转到 P2，很简单。代码参考 xv6 真实的实现即可。

首先，需要给 thread 结构一个字段用来保存相关寄存器，直接用 context 即可：

```c
// user/uthread.c
struct context {
  uint64 ra;
  uint64 sp;

  // callee-saved
  uint64 s0;
  uint64 s1;
  uint64 s2;
  uint64 s3;
  uint64 s4;
  uint64 s5;
  uint64 s6;
  uint64 s7;
  uint64 s8;
  uint64 s9;
  uint64 s10;
  uint64 s11;
};

struct thread {
  char       stack[STACK_SIZE]; /* the thread's stack */
  int        state;             /* FREE, RUNNING, RUNNABLE */
  struct context context;       // 借鉴proc的context
};
```

在 thread_create 时，讲传入的 func 赋值给 context 的 ra，这样当切换到该 thread 时就会返回到 func 处从而执行。同时，保存 thread 的栈起始地址，注意栈是从高到低生长的，因此要用栈的最高地址初始化。这里就有个问题了，thread 中不是有个 stack 吗，为什么还需要 sp 来保存它？stack 只是一个被分配了的连续空间，OS 并没有把它认为是线程的栈，没有任何意义，OS 只会通过 sp 寄存器来确定线程的栈，因此这里操作的最终目的就是将 stack 的地址给 sp 寄存器，让 OS 知道这片空间是栈。

 ```c
// user/uthread.c
void 
thread_create(void (*func)())
{
  struct thread *t;

  for (t = all_thread; t < all_thread + MAX_THREAD; t++) {
    if (t->state == FREE) break;
  }
  t->state = RUNNABLE;
  // YOUR CODE HERE
  t->context.ra = (uint64)func;
  t->context.sp = (uint64)(t->stack) + STACK_SIZE - 1;  // sp初始指向栈底
}
 ```

在 thread_schedule 中只需要简单调用一下 thread_switch 即可，调用方式和 swtch 一样：

```c
// user/uthread.c
void 
thread_schedule(void)
{
  // ...
  if (current_thread != next_thread) {         /* switch threads?  */
    next_thread->state = RUNNING;
    t = current_thread;
    current_thread = next_thread;
    /* YOUR CODE HERE
     * Invoke thread_switch to switch from t to next_thread:
     * thread_switch(??, ??);
     */
    thread_switch((uint64)&t->context, (uint64)&next_thread->context);
  }
  // ...
}
```

thread_switch 的实现在 uthread_switch.S 中，需要自己实现，但其实现和 swtch.S 完全一致，就是保存原寄存器，读取目标寄存器，搬过来即可。

```assembly
thread_switch:
	/* YOUR CODE HERE */
	# 仿照switch.S

	# 当前线程
	sd ra, 0(a0)
	sd sp, 8(a0)
	sd s0, 16(a0)
	sd s1, 24(a0)
	sd s2, 32(a0)
	sd s3, 40(a0)
	sd s4, 48(a0)
	sd s5, 56(a0)
	sd s6, 64(a0)
	sd s7, 72(a0)
	sd s8, 80(a0)
	sd s9, 88(a0)
	sd s10, 96(a0)
	sd s11, 104(a0)

    # 目标线程
	ld ra, 0(a1)
	ld sp, 8(a1)
	ld s0, 16(a1)
	ld s1, 24(a1)
	ld s2, 32(a1)
	ld s3, 40(a1)
	ld s4, 48(a1)
	ld s5, 56(a1)
	ld s6, 64(a1)
	ld s7, 72(a1)
	ld s8, 80(a1)
	ld s9, 88(a1)
	ld s10, 96(a1)
	ld s11, 104(a1)
	ret    /* return to ra */
```

至此，lab1 完成，运行结果如下。

```shell
$ uthread
thread_a started
thread_b started
thread_c started
thread_c 0
thread_a 0
thread_b 0
thread_c 1
thread_a 1
thread_b 1

......

thread_c 98
thread_a 98
thread_b 98
thread_c 99
thread_a 99
thread_b 99
thread_c: exit after 100
thread_a: exit after 100
thread_b: exit after 100
thread_schedule: no runnable threads
```

后面俩子 lab 就和 xv6 没啥关系了，为了学习多线程的同步问题而设计的。

### Using threads (moderate)

> In this assignment you'll implement a [barrier](http://en.wikipedia.org/wiki/Barrier_(computer_science)): a point in an application at which all participating threads must wait until all other participating threads reach that point too. You'll use pthread condition variables, which are a sequence coordination technique similar to xv6's sleep and wakeup.

本 lab 直接跑在 Linux 上，和 xv6 无关，使用 pthread 的锁机制，在保证速度的同时解决同步问题。

原代码因为多个写线程同时写 table 时，存在同步问题，所以数据错误，在 put 时加锁即可解决。但是不能直接一个锁，如果对所有 table 共用一个锁，那么 put 实际上单线程没差，甚至多线程比单线程还要慢，这是因为每一次只能有一个线程在写 table，并在多线程等待 lock 还会花时间，因此比单线程还慢，pf_fast 测试无法通过。

解决办法就是常规的降低锁粒度。

因为每个 bucket（==5） 之间是互不影响的，因此对每个 bucket 一个独立的锁即可。即使这样，也只能在 thread_num <= 5 时加速，因为同一时间最多 5 个线程在写，当超过 5 时多余的线程会被阻塞。

代码如下：

```c
// notxv6/ph.c
int
main(int argc, char *argv[])
{
  // ...
  for(int i = 0; i < NBUCKET; i++){
    pthread_mutex_init(&lock[i], NULL);
  }
  // ...
}

static 
void put(int key, int value)
{
  
  int i = key % NBUCKET;
  // is the key already present?
  pthread_mutex_lock(&lock[i]);
  struct entry *e = 0;
  for (e = table[i]; e != 0; e = e->next) {
    if (e->key == key)
      break;
  }
  if(e){
    // update the existing key.
    e->value = value;
  } else {
    // the new is new.
    insert(key, value, &table[i], table[i]);
  }
  pthread_mutex_unlock(&lock[i]);
}
```

### Barrier (moderate)

> In this assignment you'll implement a [barrier](http://en.wikipedia.org/wiki/Barrier_(computer_science)): a point in an application at which all participating threads must wait until all other participating threads reach that point too. You'll use pthread condition variables, which are a sequence coordination technique similar to xv6's sleep and wakeup.

本 lab 用在实现多线程同步屏障，即必须等所有线程均到一个点，才能继续执行。实现很简单，在 barrier 中将 bstate.nthread ++，如果 bstate.nthread == nthread 则通过 pthread_cond_broadcast 唤醒所有线程，否则通过 pthread_cond_wait 阻塞线程。注意锁的问题即可，代码如下：

```c
// notxv6/barrier.c
static void 
barrier()
{
  // YOUR CODE HERE
  //
  // Block until all threads have called barrier() and
  // then increment bstate.round.
  //
  pthread_mutex_lock(&bstate.barrier_mutex);
  bstate.nthread ++;
  if(bstate.nthread == nthread){
    bstate.nthread = 0;
    bstate.round ++;
    pthread_cond_broadcast(&bstate.barrier_cond); 
  } else {
    pthread_cond_wait(&bstate.barrier_cond, &bstate.barrier_mutex); // 本身就会释放锁，被唤醒后再次获得锁
  }
  pthread_mutex_unlock(&bstate.barrier_mutex);
}
```

注意，释放锁时，pthread_mutex_unlock 写在 pthread_cond_wait 之前就会卡死

- 这是因为不了解 pthread_cond_wait(&cond, &mutex) 的流程。
- pthread_cond_wait(&cond, &mutex) 不同于 pthread_cond_wait(&cond)，后者仅仅阻塞，而前者阻塞的同时会对锁进行操作。前者流程如下：
  - 调用者线程首先释放 mutex；
  - 然后阻塞，等待被别的线程唤醒；
  - 当调用者线程被唤醒后，调用者线程会再次获取mutex
- 因此，调用 pthread_cond_wait(&cond, &mutex) 的前提是已经拥有锁，由于其自身存在释放的行为，故在其之前不能 pthread_mutex_unlock。
- 此外，当被 pthread_cond_broadcast 唤醒后，pthread_cond_wait(&cond, &mutex) 会重新获得锁，不再释放，故在被唤醒后需要调用 pthread_mutex_unlock 来释放。