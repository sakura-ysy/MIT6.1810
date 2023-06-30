## Lab: traps

> This lab explores how system calls are implemented using traps. You will first do a warm-up exercises with stacks and then you will implement an example of user-level trap handling.

本 lab 旨在了解 RSIC-V 汇编指令集和 xv6 的 trap 机制，个人认为很重要，能学到的东西很多。实验主要围绕 Lecture 5、Lecture 6 和 xv6 book Chapter 4 展开，虽然只有两个子实验，代码量小，但是涉及到的理论知识很多很细。因此，本实验主要以阅读 Lecture 和 xv6 book 相关内容以学习理论知识为主，不要光想着过点。

如果不去阅读相关参考资料，实验会无从下手，即使误打误撞过了也毫无意义。不同于前几个 lab，本 lab 需要观看课程的 Lecture，其会很详细的介绍 RISC-V 指令集概要、RISC-V 常用寄存器、RISC-V 栈空间、Trap 相关等知识点，非常推荐。不过视频是纯英文的，这里要感谢 huihongxiao 大佬把所有的 Lecture 全部翻译为中文文档，起到了很大的扫盲作用。

- [Lecture 05: Calling conventions and stack frames](https://github.com/huihongxiao/MIT6.S081/tree/master/lec05-calling-conventions-and-stack-frames-risc-v)
- [Lecture 06: Isolation and system call](https://github.com/huihongxiao/MIT6.S081/tree/master/lec06-isolation-and-system-call-entry-exit-robert)

读完上述两个 Lecture，对实验的大方向就了解了，接着看一下 [xv6 book](https://pdos.csail.mit.edu/6.828/2022/xv6/book-riscv-rev3.pdf) 的 Chapter 4 学习一下 trap 和 system call 的机制即可。

### RISC-V 寄存器

在 Lecture 5.4 中介绍了 RISC-V 的相关寄存器，如下：

<img src="lab4/image-20230630135716866.png" alt="image-20230630135716866" style="zoom:67%;" />

在谈到寄存器的时候，我们会用它们的 ABI 名字，不仅是因为这样描述更清晰和标准，同时也因为在写汇编代码的时候使用的也是ABI名字。第一列中的寄存器名字并不是超级重要，它唯一重要的场景是在 RISC-V 的 Compressed Instruction 中。RISC-V中通常的指令是 64bit，但是在 Compressed Instruction 中指令是 16bit。在 Compressed Instruction 中我们使用更少的寄存器，也就是 x8 - x15 寄存器。同样的，s1 和 s2-s11 分开列出，是因为 s1 在 Compressed Instruction 中有效，而 s2-s11 无效。a0-a7 用来存放函数调用的参数，如果一个函数超过 8 个参数，就需要用内存了。

Caller Saver 和 Callee Saver 是什么意思？

- Caller Saved 寄存器在函数调用的时候不会保存；
- Callee Saved 寄存器在函数调用的时候会保存；

通俗点讲，一个 Caller Saved 寄存器可能被其他函数重写。举个例子，ra 寄存器是 Caller Saved ，当函数 a 调用函数 b 的时侯，b 会重写 ra 寄存器，存放 a 的地址用作返回。

### RISC-V 函数栈结构

在 Lecture 5.4 中介绍了 RISC-V 的函数栈，如下图所示：

<img src="lab4/image-20230630141404914.png" alt="image-20230630141404914" style="zoom: 67%;" />

其中每一格为 8 字节（64 bit），一个 Stack Frame 称为一个函数栈空间，每一个函数均有自己独立的 Stack Frame，并且调用链之间的 Stack Frame 是连续的，这点从函数的序言中可以看出。fp 指向 Stack Frame 的首址，sp 指向 Stack Frame 的最低地址。Return Address（ra） 和 To Prev.Frame(fp) 在每个 Stack Frame 中位置固定，前者存放调用者的 pc，后者存放调用者的 fp。需要注意，栈的生长是从高到低，但是取址是从低到高，因此 Return Address 的栈指针是 fp - 8，相应的，Prev 为 fp - 16。

如果一个函数调用了另一个函数，那么该函数的汇编中会有 `序言` 和 `后记`。在序言中，对 sp 减去 16，即为子函数创造栈空间，并将 ra 存进相关位置。

知道这些就可以写前两个子实验了，因为没有涉及到 trap。

### RISC-V assembly (easy)

不用写代码，回答下述问题。

> Which registers contain arguments to functions? For example, which register holds 13 in main's call to `printf`?

- a0 ~ a7 存放函数的参数，且编号越小存放越往左的参数。比如在 printf 中，a2 存放参数 13，a1 存放 f(8)+1 的结果 12，a0 存放格式化字符串的首址。汇编如下：

- ```assembly
  printf("%d %d\n", f(8)+1, 13);
  24:	4635                	li	a2,13
  26:	45b1                	li	a1,12
  28:	00000517          	auipc	a0,0x0
  2c:	7c850513          	addi	a0,a0,1992 # 7f0 <malloc+0xe8>
  30:	00000097          	auipc	ra,0x0
  34:	61a080e7          	jalr	1562(ra) # 64a <printf>
  ...
  ```

- 问题的答案在 Lecture 5 中有原话，翻译过来就是：a0 到 a7 寄存器是用来作为函数的参数，如果一个函数有超过 8 个参数，我们就需要用内存了。

>  Where is the call to function `f` in the assembly code for main? Where is the call to `g`? (Hint: the compiler may inline functions.)

- 没有跳转，被编译器 inline 了。正常情况下，main 在调用 printf 之前，应该是要通过 jalr 跳转到 f 的首址的，同样的 f 也要跳转到 g 去。但这里没有这样的语句，而是直接算出了结果 12，这是因为 g 被 inline 进 f 了，同时 f 也被 inline 进了 main。

> At what address is the function `printf` located?

- 0x30+0x61a=0x64a。由如下跳转命令所得：

- ```assembly
  30:	00000097          	auipc	ra,0x0
  34:	61a080e7          	jalr	1562(ra) # 64a <printf>
  ```

- 首先，RISC-V 的 () 运算符是加立即数的操作，1562(ra) <=> ra + 1562。auipc 和 jalr 为常用的跳转命令组合。其中 `auipc a, i` 指将 i 左移 12 位然后和 pc 相加，值赋给寄存器 a，`jalr a` 指无条件跳转到 a 所存地址处。这里进行 auipc 时 pc == 0x30，i = 0，因此 ra == 0x30，故最终跳转位置为 0x30 + 0x61a(1562) = 0x64a，即 printf 的地址。

> What value is in the register `ra` just after the `jalr` to `printf` in `main`?

- 0x34 + 4 = 0x38。auipc 通过 ra 来存储返回地址，其在更新 pc 为跳转地址之前，将当前 pc + 4 赋值给 ra，即返回处的指令地址。

> Run the following code.
>
> ```
> 	unsigned int i = 0x00646c72;
> 	printf("H%x Wo%s", 57616, &i);
> ```
>
> What is the output? [Here's an ASCII table](https://www.asciitable.com/) that maps bytes to characters.
>
> The output depends on that fact that the RISC-V is little-endian. If the RISC-V were instead big-endian what would you set `i` to in order to yield the same output? Would you need to change `57616` to a different value?
>
> [Here's a description of little- and big-endian](http://www.webopedia.com/TERM/b/big_endian.html) and [a more whimsical description](https://www.rfc-editor.org/ien/ien137.txt).

- He110 World。%x 输出 57616 的十六进制格式 110，%s 输出以 &i 为首址的字符串，因为是小端对齐，所以从低地址到高地址依次是 "0x72"、"0x6c"、"0x64"，遇 0 结尾，即 "rld" 。若为大端对齐，i 需要改为 0x726c6400， 57616 不需要改。

> In the following code, what is going to be printed after `'y='`? (note: the answer is not a specific value.) Why does this happen?
>
> ```
> 	printf("x=%d y=%d", 3);
> ```

- 取决于寄存器 a2 的值，上述指令需要读取 a1 和 a2 的参数，a1 为 3，a2 没有传入，用 gdb 看一下 a2 的值为多少即可。

### Backtrace (moderate)

> For debugging it is often useful to have a backtrace: a list of the function calls on the stack above the point at which the error occurred. To help with backtraces, the compiler generates machine code that maintains a stack frame on the stack corresponding to each function in the current call chain. Each stack frame consists of the return address and a "frame pointer" to the caller's stack frame. Register `s0` contains a pointer to the current stack frame (it actually points to the the address of the saved return address on the stack plus 8). Your `backtrace` should use the frame pointers to walk up the stack and print the saved return address in each stack frame.

本实验要实现一个内核函数 backtrace，该函数用来回溯调用者的函数调用链，将所有的调用者的 pc 打印出来，也就子函数的 ra。只需要从当前 Stack Frame 开始，通过 Prev 找到调用者的 Stack Frame，直至调用链结束为止。

首先，要获取到当前 Stack Frame 的 fp，这个它已经帮我们写了，在 `kernel/riscv.h` 中添加函数：

```c
// kernel/riscv.h
static inline uint64
r_fp()
{
  uint64 x;
  asm volatile("mv %0, s0" : "=r" (x) );
  return x;
}
```

接下来，在 `kernel/printf.c` 中实现 backtrace，调用 r_fp 来获得栈指针 fp，打印出 *(fp - 8)，然后跳转到 *(fp - 16) 即可，以此循环。那么问题来了，循环结束点（最后一个 Stack Frame）在哪呢？

> Your `backtrace()` will need a way to recognize that it has seen the last stack frame, and should stop. A useful fact is that the memory allocated for each kernel stack consists of a single page-aligned page, so that all the stack frames for a given stack are on the same page. You can use `PGROUNDDOWN(fp)` (see `kernel/riscv.h`) to identify the page that a frame pointer refers to

整个栈空间是有个范围的，所有的函数的 Stack Frame 均在其中，可以通过 PGROUNDUP(fp) 和 PGROUNDDOWN(fp) 得到栈空间最高地址与最低地址，因此要通过他们来限制循环。代码如下：

```c
// kernel/printf.c
void backtrace()
{
  uint64 fp = r_fp();
  uint64 up = PGROUNDUP(fp);
  uint64 down = PGROUNDDOWN(fp);
  while(fp <= up && fp >= down){
    uint64 ra = fp - 8;
    uint64 pre = fp - 16;
    printf("%p\n",*(uint64*)ra);
    fp = *(uint64*)pre;
  }
}
```









