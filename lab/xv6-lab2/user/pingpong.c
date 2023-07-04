#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/syscall.h"
#include "user/user.h"
#include "kernel/fs.h"


int
main(int argc, char *argv[])
{
    if(argc != 1){
        printf("pingpong: need no parameter\n");
    }

    // 父->子: pipe1; 子->父: pipe2;
    int pipe1[2],pipe2[2];
    int stat1 = pipe(pipe1);
    int stat2 = pipe(pipe2);
    if(stat1 != 0 || stat2 != 0){
        printf("pipe() failed\n");
        exit(0);
    }
    
    int pid = fork();
    if(pid < 0){
        printf("fork() failed\n");
    }else if(pid == 0){
        // 子
        int pid_c = getpid();
        char buf[1024];
        read(pipe1[0],buf,sizeof(buf));
        if(buf[0] != 0){
            printf("%d: received ping\n",pid_c);
            write(pipe2[1],"b",1);
        }
    }else{
        // 父
        int pid_f = getpid();
        write(pipe1[1],"a",1);
        char buf[1024];
        read(pipe2[0],buf,sizeof(buf));
        if(buf[0] != 0){
            printf("%d: received pong\n",pid_f);
        }  
    }
    exit(0);
}