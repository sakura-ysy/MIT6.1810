#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include <stddef.h>

// fmtname照搬ls
char* fmtname(char *path){
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  if(strlen(p) >= DIRSIZ)
    return p;
  // Return blank-padded name.
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p)); //空格补全
  return buf;
}

void find(char *path, char *target){

    //printf("enter find()\n");

    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;

    if((fd = open(path, 0)) < 0){
        printf("find: cannot open %s\n", path);
        return;
    }
    
    if(fstat(fd, &st) < 0){
        printf("find: cannot stat %s\n", path);
        close(fd);
        return;
    }

    //printf("path: %s\n",path);
    switch(st.type){
        case T_DEVICE:
        case T_FILE:
            // target补全至fmtname格式
            memset(target+strlen(target),' ', DIRSIZ-strlen(target));
            if(strcmp(fmtname(path), target) == 0){
                printf("%s\n",path);
            }
            break;

        case T_DIR:
            if(strlen(path) + 1 + DIRSIZ + 1 > sizeof(buf)){
                printf("find: path too long \n");
                break;
            }
            strcpy(buf, path);
            p = buf + strlen(buf);
            *p++ = '/';

            while(read(fd, &de, sizeof(de)) == sizeof(de)){

                if(de.inum == 0) continue;
                memmove(p,de.name,DIRSIZ);
                p[DIRSIZ] = 0;

                if(strcmp(de.name,".") != 0 && strcmp(de.name,"..") != 0){
                    //printf("file: %s\n", de.name);
                    //printf("buf: %s\n",buf);
                    find(buf, target);
                }
            }
            break;
    }

    // 一定要记住关fd
    // 经测试，xv6最多允许同时存在14个fd
    // 如果不关的话，资源会很快超限
    close(fd);
}


int main(int argc, char *argv[]){
    int i;
    if(argc == 2){
        find(".", argv[1]);
        exit(0);
    }
    for(i=2; i<argc; i++)
    find(argv[1], argv[i]);
    exit(0);
}