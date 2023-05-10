
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	bge	a5,a0,7a <main+0x7a>
  16:	00858493          	addi	s1,a1,8
  1a:	ffe5099b          	addiw	s3,a0,-2
  1e:	1982                	slli	s3,s3,0x20
  20:	0209d993          	srli	s3,s3,0x20
  24:	098e                	slli	s3,s3,0x3
  26:	05c1                	addi	a1,a1,16
  28:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2a:	00001a17          	auipc	s4,0x1
  2e:	806a0a13          	addi	s4,s4,-2042 # 830 <malloc+0xe6>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	0ae080e7          	jalr	174(ra) # e6 <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	2ec080e7          	jalr	748(ra) # 334 <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	2d8080e7          	jalr	728(ra) # 334 <write>
  for(i = 1; i < argc; i++){
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00000597          	auipc	a1,0x0
  6c:	7d058593          	addi	a1,a1,2000 # 838 <malloc+0xee>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	2c2080e7          	jalr	706(ra) # 334 <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	298080e7          	jalr	664(ra) # 314 <exit>

0000000000000084 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
  84:	1141                	addi	sp,sp,-16
  86:	e406                	sd	ra,8(sp)
  88:	e022                	sd	s0,0(sp)
  8a:	0800                	addi	s0,sp,16
  extern int main();
  main();
  8c:	00000097          	auipc	ra,0x0
  90:	f74080e7          	jalr	-140(ra) # 0 <main>
  exit(0);
  94:	4501                	li	a0,0
  96:	00000097          	auipc	ra,0x0
  9a:	27e080e7          	jalr	638(ra) # 314 <exit>

000000000000009e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9e:	1141                	addi	sp,sp,-16
  a0:	e422                	sd	s0,8(sp)
  a2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a4:	87aa                	mv	a5,a0
  a6:	0585                	addi	a1,a1,1
  a8:	0785                	addi	a5,a5,1
  aa:	fff5c703          	lbu	a4,-1(a1)
  ae:	fee78fa3          	sb	a4,-1(a5)
  b2:	fb75                	bnez	a4,a6 <strcpy+0x8>
    ;
  return os;
}
  b4:	6422                	ld	s0,8(sp)
  b6:	0141                	addi	sp,sp,16
  b8:	8082                	ret

00000000000000ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ba:	1141                	addi	sp,sp,-16
  bc:	e422                	sd	s0,8(sp)
  be:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  c0:	00054783          	lbu	a5,0(a0)
  c4:	cb91                	beqz	a5,d8 <strcmp+0x1e>
  c6:	0005c703          	lbu	a4,0(a1)
  ca:	00f71763          	bne	a4,a5,d8 <strcmp+0x1e>
    p++, q++;
  ce:	0505                	addi	a0,a0,1
  d0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  d2:	00054783          	lbu	a5,0(a0)
  d6:	fbe5                	bnez	a5,c6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  d8:	0005c503          	lbu	a0,0(a1)
}
  dc:	40a7853b          	subw	a0,a5,a0
  e0:	6422                	ld	s0,8(sp)
  e2:	0141                	addi	sp,sp,16
  e4:	8082                	ret

00000000000000e6 <strlen>:

uint
strlen(const char *s)
{
  e6:	1141                	addi	sp,sp,-16
  e8:	e422                	sd	s0,8(sp)
  ea:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ec:	00054783          	lbu	a5,0(a0)
  f0:	cf91                	beqz	a5,10c <strlen+0x26>
  f2:	0505                	addi	a0,a0,1
  f4:	87aa                	mv	a5,a0
  f6:	4685                	li	a3,1
  f8:	9e89                	subw	a3,a3,a0
  fa:	00f6853b          	addw	a0,a3,a5
  fe:	0785                	addi	a5,a5,1
 100:	fff7c703          	lbu	a4,-1(a5)
 104:	fb7d                	bnez	a4,fa <strlen+0x14>
    ;
  return n;
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret
  for(n = 0; s[n]; n++)
 10c:	4501                	li	a0,0
 10e:	bfe5                	j	106 <strlen+0x20>

0000000000000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	1141                	addi	sp,sp,-16
 112:	e422                	sd	s0,8(sp)
 114:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 116:	ce09                	beqz	a2,130 <memset+0x20>
 118:	87aa                	mv	a5,a0
 11a:	fff6071b          	addiw	a4,a2,-1
 11e:	1702                	slli	a4,a4,0x20
 120:	9301                	srli	a4,a4,0x20
 122:	0705                	addi	a4,a4,1
 124:	972a                	add	a4,a4,a0
    cdst[i] = c;
 126:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 12a:	0785                	addi	a5,a5,1
 12c:	fee79de3          	bne	a5,a4,126 <memset+0x16>
  }
  return dst;
}
 130:	6422                	ld	s0,8(sp)
 132:	0141                	addi	sp,sp,16
 134:	8082                	ret

0000000000000136 <strchr>:

char*
strchr(const char *s, char c)
{
 136:	1141                	addi	sp,sp,-16
 138:	e422                	sd	s0,8(sp)
 13a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 13c:	00054783          	lbu	a5,0(a0)
 140:	cb99                	beqz	a5,156 <strchr+0x20>
    if(*s == c)
 142:	00f58763          	beq	a1,a5,150 <strchr+0x1a>
  for(; *s; s++)
 146:	0505                	addi	a0,a0,1
 148:	00054783          	lbu	a5,0(a0)
 14c:	fbfd                	bnez	a5,142 <strchr+0xc>
      return (char*)s;
  return 0;
 14e:	4501                	li	a0,0
}
 150:	6422                	ld	s0,8(sp)
 152:	0141                	addi	sp,sp,16
 154:	8082                	ret
  return 0;
 156:	4501                	li	a0,0
 158:	bfe5                	j	150 <strchr+0x1a>

000000000000015a <gets>:

char*
gets(char *buf, int max)
{
 15a:	711d                	addi	sp,sp,-96
 15c:	ec86                	sd	ra,88(sp)
 15e:	e8a2                	sd	s0,80(sp)
 160:	e4a6                	sd	s1,72(sp)
 162:	e0ca                	sd	s2,64(sp)
 164:	fc4e                	sd	s3,56(sp)
 166:	f852                	sd	s4,48(sp)
 168:	f456                	sd	s5,40(sp)
 16a:	f05a                	sd	s6,32(sp)
 16c:	ec5e                	sd	s7,24(sp)
 16e:	1080                	addi	s0,sp,96
 170:	8baa                	mv	s7,a0
 172:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 174:	892a                	mv	s2,a0
 176:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 178:	4aa9                	li	s5,10
 17a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 17c:	89a6                	mv	s3,s1
 17e:	2485                	addiw	s1,s1,1
 180:	0344d863          	bge	s1,s4,1b0 <gets+0x56>
    cc = read(0, &c, 1);
 184:	4605                	li	a2,1
 186:	faf40593          	addi	a1,s0,-81
 18a:	4501                	li	a0,0
 18c:	00000097          	auipc	ra,0x0
 190:	1a0080e7          	jalr	416(ra) # 32c <read>
    if(cc < 1)
 194:	00a05e63          	blez	a0,1b0 <gets+0x56>
    buf[i++] = c;
 198:	faf44783          	lbu	a5,-81(s0)
 19c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1a0:	01578763          	beq	a5,s5,1ae <gets+0x54>
 1a4:	0905                	addi	s2,s2,1
 1a6:	fd679be3          	bne	a5,s6,17c <gets+0x22>
  for(i=0; i+1 < max; ){
 1aa:	89a6                	mv	s3,s1
 1ac:	a011                	j	1b0 <gets+0x56>
 1ae:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1b0:	99de                	add	s3,s3,s7
 1b2:	00098023          	sb	zero,0(s3)
  return buf;
}
 1b6:	855e                	mv	a0,s7
 1b8:	60e6                	ld	ra,88(sp)
 1ba:	6446                	ld	s0,80(sp)
 1bc:	64a6                	ld	s1,72(sp)
 1be:	6906                	ld	s2,64(sp)
 1c0:	79e2                	ld	s3,56(sp)
 1c2:	7a42                	ld	s4,48(sp)
 1c4:	7aa2                	ld	s5,40(sp)
 1c6:	7b02                	ld	s6,32(sp)
 1c8:	6be2                	ld	s7,24(sp)
 1ca:	6125                	addi	sp,sp,96
 1cc:	8082                	ret

00000000000001ce <stat>:

int
stat(const char *n, struct stat *st)
{
 1ce:	1101                	addi	sp,sp,-32
 1d0:	ec06                	sd	ra,24(sp)
 1d2:	e822                	sd	s0,16(sp)
 1d4:	e426                	sd	s1,8(sp)
 1d6:	e04a                	sd	s2,0(sp)
 1d8:	1000                	addi	s0,sp,32
 1da:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1dc:	4581                	li	a1,0
 1de:	00000097          	auipc	ra,0x0
 1e2:	176080e7          	jalr	374(ra) # 354 <open>
  if(fd < 0)
 1e6:	02054563          	bltz	a0,210 <stat+0x42>
 1ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1ec:	85ca                	mv	a1,s2
 1ee:	00000097          	auipc	ra,0x0
 1f2:	17e080e7          	jalr	382(ra) # 36c <fstat>
 1f6:	892a                	mv	s2,a0
  close(fd);
 1f8:	8526                	mv	a0,s1
 1fa:	00000097          	auipc	ra,0x0
 1fe:	142080e7          	jalr	322(ra) # 33c <close>
  return r;
}
 202:	854a                	mv	a0,s2
 204:	60e2                	ld	ra,24(sp)
 206:	6442                	ld	s0,16(sp)
 208:	64a2                	ld	s1,8(sp)
 20a:	6902                	ld	s2,0(sp)
 20c:	6105                	addi	sp,sp,32
 20e:	8082                	ret
    return -1;
 210:	597d                	li	s2,-1
 212:	bfc5                	j	202 <stat+0x34>

0000000000000214 <atoi>:

int
atoi(const char *s)
{
 214:	1141                	addi	sp,sp,-16
 216:	e422                	sd	s0,8(sp)
 218:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 21a:	00054603          	lbu	a2,0(a0)
 21e:	fd06079b          	addiw	a5,a2,-48
 222:	0ff7f793          	andi	a5,a5,255
 226:	4725                	li	a4,9
 228:	02f76963          	bltu	a4,a5,25a <atoi+0x46>
 22c:	86aa                	mv	a3,a0
  n = 0;
 22e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 230:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 232:	0685                	addi	a3,a3,1
 234:	0025179b          	slliw	a5,a0,0x2
 238:	9fa9                	addw	a5,a5,a0
 23a:	0017979b          	slliw	a5,a5,0x1
 23e:	9fb1                	addw	a5,a5,a2
 240:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 244:	0006c603          	lbu	a2,0(a3)
 248:	fd06071b          	addiw	a4,a2,-48
 24c:	0ff77713          	andi	a4,a4,255
 250:	fee5f1e3          	bgeu	a1,a4,232 <atoi+0x1e>
  return n;
}
 254:	6422                	ld	s0,8(sp)
 256:	0141                	addi	sp,sp,16
 258:	8082                	ret
  n = 0;
 25a:	4501                	li	a0,0
 25c:	bfe5                	j	254 <atoi+0x40>

000000000000025e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 25e:	1141                	addi	sp,sp,-16
 260:	e422                	sd	s0,8(sp)
 262:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 264:	02b57663          	bgeu	a0,a1,290 <memmove+0x32>
    while(n-- > 0)
 268:	02c05163          	blez	a2,28a <memmove+0x2c>
 26c:	fff6079b          	addiw	a5,a2,-1
 270:	1782                	slli	a5,a5,0x20
 272:	9381                	srli	a5,a5,0x20
 274:	0785                	addi	a5,a5,1
 276:	97aa                	add	a5,a5,a0
  dst = vdst;
 278:	872a                	mv	a4,a0
      *dst++ = *src++;
 27a:	0585                	addi	a1,a1,1
 27c:	0705                	addi	a4,a4,1
 27e:	fff5c683          	lbu	a3,-1(a1)
 282:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 286:	fee79ae3          	bne	a5,a4,27a <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 28a:	6422                	ld	s0,8(sp)
 28c:	0141                	addi	sp,sp,16
 28e:	8082                	ret
    dst += n;
 290:	00c50733          	add	a4,a0,a2
    src += n;
 294:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 296:	fec05ae3          	blez	a2,28a <memmove+0x2c>
 29a:	fff6079b          	addiw	a5,a2,-1
 29e:	1782                	slli	a5,a5,0x20
 2a0:	9381                	srli	a5,a5,0x20
 2a2:	fff7c793          	not	a5,a5
 2a6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2a8:	15fd                	addi	a1,a1,-1
 2aa:	177d                	addi	a4,a4,-1
 2ac:	0005c683          	lbu	a3,0(a1)
 2b0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2b4:	fee79ae3          	bne	a5,a4,2a8 <memmove+0x4a>
 2b8:	bfc9                	j	28a <memmove+0x2c>

00000000000002ba <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2c0:	ca05                	beqz	a2,2f0 <memcmp+0x36>
 2c2:	fff6069b          	addiw	a3,a2,-1
 2c6:	1682                	slli	a3,a3,0x20
 2c8:	9281                	srli	a3,a3,0x20
 2ca:	0685                	addi	a3,a3,1
 2cc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ce:	00054783          	lbu	a5,0(a0)
 2d2:	0005c703          	lbu	a4,0(a1)
 2d6:	00e79863          	bne	a5,a4,2e6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2da:	0505                	addi	a0,a0,1
    p2++;
 2dc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2de:	fed518e3          	bne	a0,a3,2ce <memcmp+0x14>
  }
  return 0;
 2e2:	4501                	li	a0,0
 2e4:	a019                	j	2ea <memcmp+0x30>
      return *p1 - *p2;
 2e6:	40e7853b          	subw	a0,a5,a4
}
 2ea:	6422                	ld	s0,8(sp)
 2ec:	0141                	addi	sp,sp,16
 2ee:	8082                	ret
  return 0;
 2f0:	4501                	li	a0,0
 2f2:	bfe5                	j	2ea <memcmp+0x30>

00000000000002f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2f4:	1141                	addi	sp,sp,-16
 2f6:	e406                	sd	ra,8(sp)
 2f8:	e022                	sd	s0,0(sp)
 2fa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2fc:	00000097          	auipc	ra,0x0
 300:	f62080e7          	jalr	-158(ra) # 25e <memmove>
}
 304:	60a2                	ld	ra,8(sp)
 306:	6402                	ld	s0,0(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret

000000000000030c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 30c:	4885                	li	a7,1
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <exit>:
.global exit
exit:
 li a7, SYS_exit
 314:	4889                	li	a7,2
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <wait>:
.global wait
wait:
 li a7, SYS_wait
 31c:	488d                	li	a7,3
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 324:	4891                	li	a7,4
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <read>:
.global read
read:
 li a7, SYS_read
 32c:	4895                	li	a7,5
 ecall
 32e:	00000073          	ecall
 ret
 332:	8082                	ret

0000000000000334 <write>:
.global write
write:
 li a7, SYS_write
 334:	48c1                	li	a7,16
 ecall
 336:	00000073          	ecall
 ret
 33a:	8082                	ret

000000000000033c <close>:
.global close
close:
 li a7, SYS_close
 33c:	48d5                	li	a7,21
 ecall
 33e:	00000073          	ecall
 ret
 342:	8082                	ret

0000000000000344 <kill>:
.global kill
kill:
 li a7, SYS_kill
 344:	4899                	li	a7,6
 ecall
 346:	00000073          	ecall
 ret
 34a:	8082                	ret

000000000000034c <exec>:
.global exec
exec:
 li a7, SYS_exec
 34c:	489d                	li	a7,7
 ecall
 34e:	00000073          	ecall
 ret
 352:	8082                	ret

0000000000000354 <open>:
.global open
open:
 li a7, SYS_open
 354:	48bd                	li	a7,15
 ecall
 356:	00000073          	ecall
 ret
 35a:	8082                	ret

000000000000035c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 35c:	48c5                	li	a7,17
 ecall
 35e:	00000073          	ecall
 ret
 362:	8082                	ret

0000000000000364 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 364:	48c9                	li	a7,18
 ecall
 366:	00000073          	ecall
 ret
 36a:	8082                	ret

000000000000036c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 36c:	48a1                	li	a7,8
 ecall
 36e:	00000073          	ecall
 ret
 372:	8082                	ret

0000000000000374 <link>:
.global link
link:
 li a7, SYS_link
 374:	48cd                	li	a7,19
 ecall
 376:	00000073          	ecall
 ret
 37a:	8082                	ret

000000000000037c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 37c:	48d1                	li	a7,20
 ecall
 37e:	00000073          	ecall
 ret
 382:	8082                	ret

0000000000000384 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 384:	48a5                	li	a7,9
 ecall
 386:	00000073          	ecall
 ret
 38a:	8082                	ret

000000000000038c <dup>:
.global dup
dup:
 li a7, SYS_dup
 38c:	48a9                	li	a7,10
 ecall
 38e:	00000073          	ecall
 ret
 392:	8082                	ret

0000000000000394 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 394:	48ad                	li	a7,11
 ecall
 396:	00000073          	ecall
 ret
 39a:	8082                	ret

000000000000039c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 39c:	48b1                	li	a7,12
 ecall
 39e:	00000073          	ecall
 ret
 3a2:	8082                	ret

00000000000003a4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 3a4:	48b5                	li	a7,13
 ecall
 3a6:	00000073          	ecall
 ret
 3aa:	8082                	ret

00000000000003ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3ac:	48b9                	li	a7,14
 ecall
 3ae:	00000073          	ecall
 ret
 3b2:	8082                	ret

00000000000003b4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3b4:	1101                	addi	sp,sp,-32
 3b6:	ec06                	sd	ra,24(sp)
 3b8:	e822                	sd	s0,16(sp)
 3ba:	1000                	addi	s0,sp,32
 3bc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3c0:	4605                	li	a2,1
 3c2:	fef40593          	addi	a1,s0,-17
 3c6:	00000097          	auipc	ra,0x0
 3ca:	f6e080e7          	jalr	-146(ra) # 334 <write>
}
 3ce:	60e2                	ld	ra,24(sp)
 3d0:	6442                	ld	s0,16(sp)
 3d2:	6105                	addi	sp,sp,32
 3d4:	8082                	ret

00000000000003d6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3d6:	7139                	addi	sp,sp,-64
 3d8:	fc06                	sd	ra,56(sp)
 3da:	f822                	sd	s0,48(sp)
 3dc:	f426                	sd	s1,40(sp)
 3de:	f04a                	sd	s2,32(sp)
 3e0:	ec4e                	sd	s3,24(sp)
 3e2:	0080                	addi	s0,sp,64
 3e4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3e6:	c299                	beqz	a3,3ec <printint+0x16>
 3e8:	0805c863          	bltz	a1,478 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3ec:	2581                	sext.w	a1,a1
  neg = 0;
 3ee:	4881                	li	a7,0
 3f0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 3f4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 3f6:	2601                	sext.w	a2,a2
 3f8:	00000517          	auipc	a0,0x0
 3fc:	45050513          	addi	a0,a0,1104 # 848 <digits>
 400:	883a                	mv	a6,a4
 402:	2705                	addiw	a4,a4,1
 404:	02c5f7bb          	remuw	a5,a1,a2
 408:	1782                	slli	a5,a5,0x20
 40a:	9381                	srli	a5,a5,0x20
 40c:	97aa                	add	a5,a5,a0
 40e:	0007c783          	lbu	a5,0(a5)
 412:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 416:	0005879b          	sext.w	a5,a1
 41a:	02c5d5bb          	divuw	a1,a1,a2
 41e:	0685                	addi	a3,a3,1
 420:	fec7f0e3          	bgeu	a5,a2,400 <printint+0x2a>
  if(neg)
 424:	00088b63          	beqz	a7,43a <printint+0x64>
    buf[i++] = '-';
 428:	fd040793          	addi	a5,s0,-48
 42c:	973e                	add	a4,a4,a5
 42e:	02d00793          	li	a5,45
 432:	fef70823          	sb	a5,-16(a4)
 436:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 43a:	02e05863          	blez	a4,46a <printint+0x94>
 43e:	fc040793          	addi	a5,s0,-64
 442:	00e78933          	add	s2,a5,a4
 446:	fff78993          	addi	s3,a5,-1
 44a:	99ba                	add	s3,s3,a4
 44c:	377d                	addiw	a4,a4,-1
 44e:	1702                	slli	a4,a4,0x20
 450:	9301                	srli	a4,a4,0x20
 452:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 456:	fff94583          	lbu	a1,-1(s2)
 45a:	8526                	mv	a0,s1
 45c:	00000097          	auipc	ra,0x0
 460:	f58080e7          	jalr	-168(ra) # 3b4 <putc>
  while(--i >= 0)
 464:	197d                	addi	s2,s2,-1
 466:	ff3918e3          	bne	s2,s3,456 <printint+0x80>
}
 46a:	70e2                	ld	ra,56(sp)
 46c:	7442                	ld	s0,48(sp)
 46e:	74a2                	ld	s1,40(sp)
 470:	7902                	ld	s2,32(sp)
 472:	69e2                	ld	s3,24(sp)
 474:	6121                	addi	sp,sp,64
 476:	8082                	ret
    x = -xx;
 478:	40b005bb          	negw	a1,a1
    neg = 1;
 47c:	4885                	li	a7,1
    x = -xx;
 47e:	bf8d                	j	3f0 <printint+0x1a>

0000000000000480 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 480:	7119                	addi	sp,sp,-128
 482:	fc86                	sd	ra,120(sp)
 484:	f8a2                	sd	s0,112(sp)
 486:	f4a6                	sd	s1,104(sp)
 488:	f0ca                	sd	s2,96(sp)
 48a:	ecce                	sd	s3,88(sp)
 48c:	e8d2                	sd	s4,80(sp)
 48e:	e4d6                	sd	s5,72(sp)
 490:	e0da                	sd	s6,64(sp)
 492:	fc5e                	sd	s7,56(sp)
 494:	f862                	sd	s8,48(sp)
 496:	f466                	sd	s9,40(sp)
 498:	f06a                	sd	s10,32(sp)
 49a:	ec6e                	sd	s11,24(sp)
 49c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 49e:	0005c903          	lbu	s2,0(a1)
 4a2:	18090f63          	beqz	s2,640 <vprintf+0x1c0>
 4a6:	8aaa                	mv	s5,a0
 4a8:	8b32                	mv	s6,a2
 4aa:	00158493          	addi	s1,a1,1
  state = 0;
 4ae:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 4b0:	02500a13          	li	s4,37
      if(c == 'd'){
 4b4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 4b8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 4bc:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 4c0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 4c4:	00000b97          	auipc	s7,0x0
 4c8:	384b8b93          	addi	s7,s7,900 # 848 <digits>
 4cc:	a839                	j	4ea <vprintf+0x6a>
        putc(fd, c);
 4ce:	85ca                	mv	a1,s2
 4d0:	8556                	mv	a0,s5
 4d2:	00000097          	auipc	ra,0x0
 4d6:	ee2080e7          	jalr	-286(ra) # 3b4 <putc>
 4da:	a019                	j	4e0 <vprintf+0x60>
    } else if(state == '%'){
 4dc:	01498f63          	beq	s3,s4,4fa <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 4e0:	0485                	addi	s1,s1,1
 4e2:	fff4c903          	lbu	s2,-1(s1)
 4e6:	14090d63          	beqz	s2,640 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 4ea:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4ee:	fe0997e3          	bnez	s3,4dc <vprintf+0x5c>
      if(c == '%'){
 4f2:	fd479ee3          	bne	a5,s4,4ce <vprintf+0x4e>
        state = '%';
 4f6:	89be                	mv	s3,a5
 4f8:	b7e5                	j	4e0 <vprintf+0x60>
      if(c == 'd'){
 4fa:	05878063          	beq	a5,s8,53a <vprintf+0xba>
      } else if(c == 'l') {
 4fe:	05978c63          	beq	a5,s9,556 <vprintf+0xd6>
      } else if(c == 'x') {
 502:	07a78863          	beq	a5,s10,572 <vprintf+0xf2>
      } else if(c == 'p') {
 506:	09b78463          	beq	a5,s11,58e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 50a:	07300713          	li	a4,115
 50e:	0ce78663          	beq	a5,a4,5da <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 512:	06300713          	li	a4,99
 516:	0ee78e63          	beq	a5,a4,612 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 51a:	11478863          	beq	a5,s4,62a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 51e:	85d2                	mv	a1,s4
 520:	8556                	mv	a0,s5
 522:	00000097          	auipc	ra,0x0
 526:	e92080e7          	jalr	-366(ra) # 3b4 <putc>
        putc(fd, c);
 52a:	85ca                	mv	a1,s2
 52c:	8556                	mv	a0,s5
 52e:	00000097          	auipc	ra,0x0
 532:	e86080e7          	jalr	-378(ra) # 3b4 <putc>
      }
      state = 0;
 536:	4981                	li	s3,0
 538:	b765                	j	4e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 53a:	008b0913          	addi	s2,s6,8
 53e:	4685                	li	a3,1
 540:	4629                	li	a2,10
 542:	000b2583          	lw	a1,0(s6)
 546:	8556                	mv	a0,s5
 548:	00000097          	auipc	ra,0x0
 54c:	e8e080e7          	jalr	-370(ra) # 3d6 <printint>
 550:	8b4a                	mv	s6,s2
      state = 0;
 552:	4981                	li	s3,0
 554:	b771                	j	4e0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 556:	008b0913          	addi	s2,s6,8
 55a:	4681                	li	a3,0
 55c:	4629                	li	a2,10
 55e:	000b2583          	lw	a1,0(s6)
 562:	8556                	mv	a0,s5
 564:	00000097          	auipc	ra,0x0
 568:	e72080e7          	jalr	-398(ra) # 3d6 <printint>
 56c:	8b4a                	mv	s6,s2
      state = 0;
 56e:	4981                	li	s3,0
 570:	bf85                	j	4e0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 572:	008b0913          	addi	s2,s6,8
 576:	4681                	li	a3,0
 578:	4641                	li	a2,16
 57a:	000b2583          	lw	a1,0(s6)
 57e:	8556                	mv	a0,s5
 580:	00000097          	auipc	ra,0x0
 584:	e56080e7          	jalr	-426(ra) # 3d6 <printint>
 588:	8b4a                	mv	s6,s2
      state = 0;
 58a:	4981                	li	s3,0
 58c:	bf91                	j	4e0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 58e:	008b0793          	addi	a5,s6,8
 592:	f8f43423          	sd	a5,-120(s0)
 596:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 59a:	03000593          	li	a1,48
 59e:	8556                	mv	a0,s5
 5a0:	00000097          	auipc	ra,0x0
 5a4:	e14080e7          	jalr	-492(ra) # 3b4 <putc>
  putc(fd, 'x');
 5a8:	85ea                	mv	a1,s10
 5aa:	8556                	mv	a0,s5
 5ac:	00000097          	auipc	ra,0x0
 5b0:	e08080e7          	jalr	-504(ra) # 3b4 <putc>
 5b4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 5b6:	03c9d793          	srli	a5,s3,0x3c
 5ba:	97de                	add	a5,a5,s7
 5bc:	0007c583          	lbu	a1,0(a5)
 5c0:	8556                	mv	a0,s5
 5c2:	00000097          	auipc	ra,0x0
 5c6:	df2080e7          	jalr	-526(ra) # 3b4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 5ca:	0992                	slli	s3,s3,0x4
 5cc:	397d                	addiw	s2,s2,-1
 5ce:	fe0914e3          	bnez	s2,5b6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 5d2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 5d6:	4981                	li	s3,0
 5d8:	b721                	j	4e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 5da:	008b0993          	addi	s3,s6,8
 5de:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 5e2:	02090163          	beqz	s2,604 <vprintf+0x184>
        while(*s != 0){
 5e6:	00094583          	lbu	a1,0(s2)
 5ea:	c9a1                	beqz	a1,63a <vprintf+0x1ba>
          putc(fd, *s);
 5ec:	8556                	mv	a0,s5
 5ee:	00000097          	auipc	ra,0x0
 5f2:	dc6080e7          	jalr	-570(ra) # 3b4 <putc>
          s++;
 5f6:	0905                	addi	s2,s2,1
        while(*s != 0){
 5f8:	00094583          	lbu	a1,0(s2)
 5fc:	f9e5                	bnez	a1,5ec <vprintf+0x16c>
        s = va_arg(ap, char*);
 5fe:	8b4e                	mv	s6,s3
      state = 0;
 600:	4981                	li	s3,0
 602:	bdf9                	j	4e0 <vprintf+0x60>
          s = "(null)";
 604:	00000917          	auipc	s2,0x0
 608:	23c90913          	addi	s2,s2,572 # 840 <malloc+0xf6>
        while(*s != 0){
 60c:	02800593          	li	a1,40
 610:	bff1                	j	5ec <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 612:	008b0913          	addi	s2,s6,8
 616:	000b4583          	lbu	a1,0(s6)
 61a:	8556                	mv	a0,s5
 61c:	00000097          	auipc	ra,0x0
 620:	d98080e7          	jalr	-616(ra) # 3b4 <putc>
 624:	8b4a                	mv	s6,s2
      state = 0;
 626:	4981                	li	s3,0
 628:	bd65                	j	4e0 <vprintf+0x60>
        putc(fd, c);
 62a:	85d2                	mv	a1,s4
 62c:	8556                	mv	a0,s5
 62e:	00000097          	auipc	ra,0x0
 632:	d86080e7          	jalr	-634(ra) # 3b4 <putc>
      state = 0;
 636:	4981                	li	s3,0
 638:	b565                	j	4e0 <vprintf+0x60>
        s = va_arg(ap, char*);
 63a:	8b4e                	mv	s6,s3
      state = 0;
 63c:	4981                	li	s3,0
 63e:	b54d                	j	4e0 <vprintf+0x60>
    }
  }
}
 640:	70e6                	ld	ra,120(sp)
 642:	7446                	ld	s0,112(sp)
 644:	74a6                	ld	s1,104(sp)
 646:	7906                	ld	s2,96(sp)
 648:	69e6                	ld	s3,88(sp)
 64a:	6a46                	ld	s4,80(sp)
 64c:	6aa6                	ld	s5,72(sp)
 64e:	6b06                	ld	s6,64(sp)
 650:	7be2                	ld	s7,56(sp)
 652:	7c42                	ld	s8,48(sp)
 654:	7ca2                	ld	s9,40(sp)
 656:	7d02                	ld	s10,32(sp)
 658:	6de2                	ld	s11,24(sp)
 65a:	6109                	addi	sp,sp,128
 65c:	8082                	ret

000000000000065e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 65e:	715d                	addi	sp,sp,-80
 660:	ec06                	sd	ra,24(sp)
 662:	e822                	sd	s0,16(sp)
 664:	1000                	addi	s0,sp,32
 666:	e010                	sd	a2,0(s0)
 668:	e414                	sd	a3,8(s0)
 66a:	e818                	sd	a4,16(s0)
 66c:	ec1c                	sd	a5,24(s0)
 66e:	03043023          	sd	a6,32(s0)
 672:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 676:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 67a:	8622                	mv	a2,s0
 67c:	00000097          	auipc	ra,0x0
 680:	e04080e7          	jalr	-508(ra) # 480 <vprintf>
}
 684:	60e2                	ld	ra,24(sp)
 686:	6442                	ld	s0,16(sp)
 688:	6161                	addi	sp,sp,80
 68a:	8082                	ret

000000000000068c <printf>:

void
printf(const char *fmt, ...)
{
 68c:	711d                	addi	sp,sp,-96
 68e:	ec06                	sd	ra,24(sp)
 690:	e822                	sd	s0,16(sp)
 692:	1000                	addi	s0,sp,32
 694:	e40c                	sd	a1,8(s0)
 696:	e810                	sd	a2,16(s0)
 698:	ec14                	sd	a3,24(s0)
 69a:	f018                	sd	a4,32(s0)
 69c:	f41c                	sd	a5,40(s0)
 69e:	03043823          	sd	a6,48(s0)
 6a2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 6a6:	00840613          	addi	a2,s0,8
 6aa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 6ae:	85aa                	mv	a1,a0
 6b0:	4505                	li	a0,1
 6b2:	00000097          	auipc	ra,0x0
 6b6:	dce080e7          	jalr	-562(ra) # 480 <vprintf>
}
 6ba:	60e2                	ld	ra,24(sp)
 6bc:	6442                	ld	s0,16(sp)
 6be:	6125                	addi	sp,sp,96
 6c0:	8082                	ret

00000000000006c2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c2:	1141                	addi	sp,sp,-16
 6c4:	e422                	sd	s0,8(sp)
 6c6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6c8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6cc:	00001797          	auipc	a5,0x1
 6d0:	9347b783          	ld	a5,-1740(a5) # 1000 <freep>
 6d4:	a805                	j	704 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6d6:	4618                	lw	a4,8(a2)
 6d8:	9db9                	addw	a1,a1,a4
 6da:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 6de:	6398                	ld	a4,0(a5)
 6e0:	6318                	ld	a4,0(a4)
 6e2:	fee53823          	sd	a4,-16(a0)
 6e6:	a091                	j	72a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 6e8:	ff852703          	lw	a4,-8(a0)
 6ec:	9e39                	addw	a2,a2,a4
 6ee:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 6f0:	ff053703          	ld	a4,-16(a0)
 6f4:	e398                	sd	a4,0(a5)
 6f6:	a099                	j	73c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f8:	6398                	ld	a4,0(a5)
 6fa:	00e7e463          	bltu	a5,a4,702 <free+0x40>
 6fe:	00e6ea63          	bltu	a3,a4,712 <free+0x50>
{
 702:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 704:	fed7fae3          	bgeu	a5,a3,6f8 <free+0x36>
 708:	6398                	ld	a4,0(a5)
 70a:	00e6e463          	bltu	a3,a4,712 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70e:	fee7eae3          	bltu	a5,a4,702 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 712:	ff852583          	lw	a1,-8(a0)
 716:	6390                	ld	a2,0(a5)
 718:	02059713          	slli	a4,a1,0x20
 71c:	9301                	srli	a4,a4,0x20
 71e:	0712                	slli	a4,a4,0x4
 720:	9736                	add	a4,a4,a3
 722:	fae60ae3          	beq	a2,a4,6d6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 726:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 72a:	4790                	lw	a2,8(a5)
 72c:	02061713          	slli	a4,a2,0x20
 730:	9301                	srli	a4,a4,0x20
 732:	0712                	slli	a4,a4,0x4
 734:	973e                	add	a4,a4,a5
 736:	fae689e3          	beq	a3,a4,6e8 <free+0x26>
  } else
    p->s.ptr = bp;
 73a:	e394                	sd	a3,0(a5)
  freep = p;
 73c:	00001717          	auipc	a4,0x1
 740:	8cf73223          	sd	a5,-1852(a4) # 1000 <freep>
}
 744:	6422                	ld	s0,8(sp)
 746:	0141                	addi	sp,sp,16
 748:	8082                	ret

000000000000074a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 74a:	7139                	addi	sp,sp,-64
 74c:	fc06                	sd	ra,56(sp)
 74e:	f822                	sd	s0,48(sp)
 750:	f426                	sd	s1,40(sp)
 752:	f04a                	sd	s2,32(sp)
 754:	ec4e                	sd	s3,24(sp)
 756:	e852                	sd	s4,16(sp)
 758:	e456                	sd	s5,8(sp)
 75a:	e05a                	sd	s6,0(sp)
 75c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 75e:	02051493          	slli	s1,a0,0x20
 762:	9081                	srli	s1,s1,0x20
 764:	04bd                	addi	s1,s1,15
 766:	8091                	srli	s1,s1,0x4
 768:	0014899b          	addiw	s3,s1,1
 76c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 76e:	00001517          	auipc	a0,0x1
 772:	89253503          	ld	a0,-1902(a0) # 1000 <freep>
 776:	c515                	beqz	a0,7a2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 778:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 77a:	4798                	lw	a4,8(a5)
 77c:	02977f63          	bgeu	a4,s1,7ba <malloc+0x70>
 780:	8a4e                	mv	s4,s3
 782:	0009871b          	sext.w	a4,s3
 786:	6685                	lui	a3,0x1
 788:	00d77363          	bgeu	a4,a3,78e <malloc+0x44>
 78c:	6a05                	lui	s4,0x1
 78e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 792:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 796:	00001917          	auipc	s2,0x1
 79a:	86a90913          	addi	s2,s2,-1942 # 1000 <freep>
  if(p == (char*)-1)
 79e:	5afd                	li	s5,-1
 7a0:	a88d                	j	812 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
 7a2:	00001797          	auipc	a5,0x1
 7a6:	86e78793          	addi	a5,a5,-1938 # 1010 <base>
 7aa:	00001717          	auipc	a4,0x1
 7ae:	84f73b23          	sd	a5,-1962(a4) # 1000 <freep>
 7b2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 7b4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 7b8:	b7e1                	j	780 <malloc+0x36>
      if(p->s.size == nunits)
 7ba:	02e48b63          	beq	s1,a4,7f0 <malloc+0xa6>
        p->s.size -= nunits;
 7be:	4137073b          	subw	a4,a4,s3
 7c2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 7c4:	1702                	slli	a4,a4,0x20
 7c6:	9301                	srli	a4,a4,0x20
 7c8:	0712                	slli	a4,a4,0x4
 7ca:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 7cc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 7d0:	00001717          	auipc	a4,0x1
 7d4:	82a73823          	sd	a0,-2000(a4) # 1000 <freep>
      return (void*)(p + 1);
 7d8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7dc:	70e2                	ld	ra,56(sp)
 7de:	7442                	ld	s0,48(sp)
 7e0:	74a2                	ld	s1,40(sp)
 7e2:	7902                	ld	s2,32(sp)
 7e4:	69e2                	ld	s3,24(sp)
 7e6:	6a42                	ld	s4,16(sp)
 7e8:	6aa2                	ld	s5,8(sp)
 7ea:	6b02                	ld	s6,0(sp)
 7ec:	6121                	addi	sp,sp,64
 7ee:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 7f0:	6398                	ld	a4,0(a5)
 7f2:	e118                	sd	a4,0(a0)
 7f4:	bff1                	j	7d0 <malloc+0x86>
  hp->s.size = nu;
 7f6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 7fa:	0541                	addi	a0,a0,16
 7fc:	00000097          	auipc	ra,0x0
 800:	ec6080e7          	jalr	-314(ra) # 6c2 <free>
  return freep;
 804:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 808:	d971                	beqz	a0,7dc <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 80c:	4798                	lw	a4,8(a5)
 80e:	fa9776e3          	bgeu	a4,s1,7ba <malloc+0x70>
    if(p == freep)
 812:	00093703          	ld	a4,0(s2)
 816:	853e                	mv	a0,a5
 818:	fef719e3          	bne	a4,a5,80a <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
 81c:	8552                	mv	a0,s4
 81e:	00000097          	auipc	ra,0x0
 822:	b7e080e7          	jalr	-1154(ra) # 39c <sbrk>
  if(p == (char*)-1)
 826:	fd5518e3          	bne	a0,s5,7f6 <malloc+0xac>
        return 0;
 82a:	4501                	li	a0,0
 82c:	bf45                	j	7dc <malloc+0x92>
