#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include <stddef.h>

// 写代码前先搞清两个问题
// 1. | 是干什么的
// 2. xargs 是干什么的
// 答案：https://www.ruanyifeng.com/blog/2019/08/xargs-tutorial.html

#define STDIN_FILENO   0 /* Standard input.  */
#define MAX_STDIN_LEN  512
#define MAX_PARAMS_CNT  100
#define MAX_PARAM_LEN 50

// 将一行命令拆解为多个参数，以空格为分隔符
void fmt_params(char* line, char** params, int* cnt){
    char cur_param[MAX_PARAM_LEN];
    int cur_param_len = 0;
    for(int i=0; i<strlen(line); i++){

        if((line[i] == ' ' || line[i] == '\n')&& cur_param_len!=0){
            //printf("%s\n",cur_param);
            params[*cnt] = malloc(MAX_PARAM_LEN);
            memmove(params[*cnt],cur_param,cur_param_len);
            params[*cnt][cur_param_len] = 0;
            cur_param_len = 0;
            (*cnt) ++;
        } 
        else {
            cur_param[cur_param_len] = line[i];
            cur_param_len ++;
        }
    }

}

int main(int argc, char *argv[]){

    // 读取 xargs 后的命令以及参数
    if(argc == 1) exit(0);
    char* params[MAX_PARAMS_CNT];  // 参数
    int cnt = 0;
    for(int i=1; i<argc; i++){
        params[i-1] = argv[i];
        cnt ++;
    }
    //printf("params[0]:%s\n",params[0]);

    // 读取 | 产生的标准输入
    char r_buf[MAX_STDIN_LEN];
    while(read(STDIN_FILENO,r_buf,MAX_STDIN_LEN) > 0){  // 逐行读取
        if(fork()==0){
            // 子
            fmt_params(r_buf,params,&cnt);
            // 注意，exec第二个参数的第一个元素指向cmd可执行文件，而不是指命令参数
            // 类似于argv
            exec(params[0],params);
        }else{
            // 父
            wait(0);
        }
    }
    exit(0);
}