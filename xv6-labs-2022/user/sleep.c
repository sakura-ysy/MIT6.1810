#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"


int
main(int argc, char *argv[])
{
    if(argc < 2){
        printf("sleep: missing time parameter\n");
        printf("Try 'sleep [time]'\n");
        exit(0);
    } else if(argc > 2) {
        printf("sleep: too many parameters\n");
        printf("Try 'sleep [time]'\n");
        exit(0);
    }

    int time = atoi(argv[1]);
    sleep(time);
    exit(0);
}
