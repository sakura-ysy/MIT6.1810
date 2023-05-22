#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "sysinfo.h"

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

