#include "kernel/types.h"
#include "kernel/stat.h"
#include "kernel/syscall.h"
#include "user/user.h"
#include "kernel/fs.h"
#include "kernel/param.h"
#include "kernel/fcntl.h"
#include "kernel/riscv.h"


int
main(int argc, char *argv[])
{
  char *buf;
  unsigned int abits;
  printf("pgaccess_test starting\n");
  buf = malloc(32 * PGSIZE);
  if (pgaccess(buf, 32, &abits) < 0)
    printf("pgaccess failed");
  buf[PGSIZE * 1] += 1;
  buf[PGSIZE * 2] += 1;
  buf[PGSIZE * 30] += 1;
  
  if (pgaccess(buf, 32, &abits) < 0)
    printf("pgaccess failed\n");
  printf("abits: %d\n",abits);
  if (abits != ((1 << 1) | (1 << 2) | (1 << 30)))
    printf("incorrect access bits set\n");
  free(buf);
  printf("pgaccess_test: OK\n");
  return 0;
}