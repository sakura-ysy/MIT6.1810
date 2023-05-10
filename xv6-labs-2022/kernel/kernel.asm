
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	0001a117          	auipc	sp,0x1a
    80000004:	c3010113          	addi	sp,sp,-976 # 80019c30 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	706050ef          	jal	ra,8000571c <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	00022797          	auipc	a5,0x22
    80000034:	d0078793          	addi	a5,a5,-768 # 80021d30 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	130080e7          	jalr	304(ra) # 80000178 <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	87090913          	addi	s2,s2,-1936 # 800088c0 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	0c2080e7          	jalr	194(ra) # 8000611c <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	162080e7          	jalr	354(ra) # 800061d0 <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	addi	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	b48080e7          	jalr	-1208(ra) # 80005bd2 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	94aa                	add	s1,s1,a0
    800000aa:	757d                	lui	a0,0xfffff
    800000ac:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ae:	94be                	add	s1,s1,a5
    800000b0:	0095ee63          	bltu	a1,s1,800000cc <freerange+0x3a>
    800000b4:	892e                	mv	s2,a1
    kfree(p);
    800000b6:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b8:	6985                	lui	s3,0x1
    kfree(p);
    800000ba:	01448533          	add	a0,s1,s4
    800000be:	00000097          	auipc	ra,0x0
    800000c2:	f5e080e7          	jalr	-162(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c6:	94ce                	add	s1,s1,s3
    800000c8:	fe9979e3          	bgeu	s2,s1,800000ba <freerange+0x28>
}
    800000cc:	70a2                	ld	ra,40(sp)
    800000ce:	7402                	ld	s0,32(sp)
    800000d0:	64e2                	ld	s1,24(sp)
    800000d2:	6942                	ld	s2,16(sp)
    800000d4:	69a2                	ld	s3,8(sp)
    800000d6:	6a02                	ld	s4,0(sp)
    800000d8:	6145                	addi	sp,sp,48
    800000da:	8082                	ret

00000000800000dc <kinit>:
{
    800000dc:	1141                	addi	sp,sp,-16
    800000de:	e406                	sd	ra,8(sp)
    800000e0:	e022                	sd	s0,0(sp)
    800000e2:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e4:	00008597          	auipc	a1,0x8
    800000e8:	f3458593          	addi	a1,a1,-204 # 80008018 <etext+0x18>
    800000ec:	00008517          	auipc	a0,0x8
    800000f0:	7d450513          	addi	a0,a0,2004 # 800088c0 <kmem>
    800000f4:	00006097          	auipc	ra,0x6
    800000f8:	f98080e7          	jalr	-104(ra) # 8000608c <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fc:	45c5                	li	a1,17
    800000fe:	05ee                	slli	a1,a1,0x1b
    80000100:	00022517          	auipc	a0,0x22
    80000104:	c3050513          	addi	a0,a0,-976 # 80021d30 <end>
    80000108:	00000097          	auipc	ra,0x0
    8000010c:	f8a080e7          	jalr	-118(ra) # 80000092 <freerange>
}
    80000110:	60a2                	ld	ra,8(sp)
    80000112:	6402                	ld	s0,0(sp)
    80000114:	0141                	addi	sp,sp,16
    80000116:	8082                	ret

0000000080000118 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000118:	1101                	addi	sp,sp,-32
    8000011a:	ec06                	sd	ra,24(sp)
    8000011c:	e822                	sd	s0,16(sp)
    8000011e:	e426                	sd	s1,8(sp)
    80000120:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000122:	00008497          	auipc	s1,0x8
    80000126:	79e48493          	addi	s1,s1,1950 # 800088c0 <kmem>
    8000012a:	8526                	mv	a0,s1
    8000012c:	00006097          	auipc	ra,0x6
    80000130:	ff0080e7          	jalr	-16(ra) # 8000611c <acquire>
  r = kmem.freelist;
    80000134:	6c84                	ld	s1,24(s1)
  if(r)
    80000136:	c885                	beqz	s1,80000166 <kalloc+0x4e>
    kmem.freelist = r->next;
    80000138:	609c                	ld	a5,0(s1)
    8000013a:	00008517          	auipc	a0,0x8
    8000013e:	78650513          	addi	a0,a0,1926 # 800088c0 <kmem>
    80000142:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000144:	00006097          	auipc	ra,0x6
    80000148:	08c080e7          	jalr	140(ra) # 800061d0 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014c:	6605                	lui	a2,0x1
    8000014e:	4595                	li	a1,5
    80000150:	8526                	mv	a0,s1
    80000152:	00000097          	auipc	ra,0x0
    80000156:	026080e7          	jalr	38(ra) # 80000178 <memset>
  return (void*)r;
}
    8000015a:	8526                	mv	a0,s1
    8000015c:	60e2                	ld	ra,24(sp)
    8000015e:	6442                	ld	s0,16(sp)
    80000160:	64a2                	ld	s1,8(sp)
    80000162:	6105                	addi	sp,sp,32
    80000164:	8082                	ret
  release(&kmem.lock);
    80000166:	00008517          	auipc	a0,0x8
    8000016a:	75a50513          	addi	a0,a0,1882 # 800088c0 <kmem>
    8000016e:	00006097          	auipc	ra,0x6
    80000172:	062080e7          	jalr	98(ra) # 800061d0 <release>
  if(r)
    80000176:	b7d5                	j	8000015a <kalloc+0x42>

0000000080000178 <memset>:
#include "types.h"

void*
memset(void *dst, int c, uint n)
{
    80000178:	1141                	addi	sp,sp,-16
    8000017a:	e422                	sd	s0,8(sp)
    8000017c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    8000017e:	ce09                	beqz	a2,80000198 <memset+0x20>
    80000180:	87aa                	mv	a5,a0
    80000182:	fff6071b          	addiw	a4,a2,-1
    80000186:	1702                	slli	a4,a4,0x20
    80000188:	9301                	srli	a4,a4,0x20
    8000018a:	0705                	addi	a4,a4,1
    8000018c:	972a                	add	a4,a4,a0
    cdst[i] = c;
    8000018e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000192:	0785                	addi	a5,a5,1
    80000194:	fee79de3          	bne	a5,a4,8000018e <memset+0x16>
  }
  return dst;
}
    80000198:	6422                	ld	s0,8(sp)
    8000019a:	0141                	addi	sp,sp,16
    8000019c:	8082                	ret

000000008000019e <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019e:	1141                	addi	sp,sp,-16
    800001a0:	e422                	sd	s0,8(sp)
    800001a2:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a4:	ca05                	beqz	a2,800001d4 <memcmp+0x36>
    800001a6:	fff6069b          	addiw	a3,a2,-1
    800001aa:	1682                	slli	a3,a3,0x20
    800001ac:	9281                	srli	a3,a3,0x20
    800001ae:	0685                	addi	a3,a3,1
    800001b0:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b2:	00054783          	lbu	a5,0(a0)
    800001b6:	0005c703          	lbu	a4,0(a1)
    800001ba:	00e79863          	bne	a5,a4,800001ca <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001be:	0505                	addi	a0,a0,1
    800001c0:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c2:	fed518e3          	bne	a0,a3,800001b2 <memcmp+0x14>
  }

  return 0;
    800001c6:	4501                	li	a0,0
    800001c8:	a019                	j	800001ce <memcmp+0x30>
      return *s1 - *s2;
    800001ca:	40e7853b          	subw	a0,a5,a4
}
    800001ce:	6422                	ld	s0,8(sp)
    800001d0:	0141                	addi	sp,sp,16
    800001d2:	8082                	ret
  return 0;
    800001d4:	4501                	li	a0,0
    800001d6:	bfe5                	j	800001ce <memcmp+0x30>

00000000800001d8 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d8:	1141                	addi	sp,sp,-16
    800001da:	e422                	sd	s0,8(sp)
    800001dc:	0800                	addi	s0,sp,16
  const char *s;
  char *d;

  if(n == 0)
    800001de:	ca0d                	beqz	a2,80000210 <memmove+0x38>
    return dst;
  
  s = src;
  d = dst;
  if(s < d && s + n > d){
    800001e0:	00a5f963          	bgeu	a1,a0,800001f2 <memmove+0x1a>
    800001e4:	02061693          	slli	a3,a2,0x20
    800001e8:	9281                	srli	a3,a3,0x20
    800001ea:	00d58733          	add	a4,a1,a3
    800001ee:	02e56463          	bltu	a0,a4,80000216 <memmove+0x3e>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    800001f2:	fff6079b          	addiw	a5,a2,-1
    800001f6:	1782                	slli	a5,a5,0x20
    800001f8:	9381                	srli	a5,a5,0x20
    800001fa:	0785                	addi	a5,a5,1
    800001fc:	97ae                	add	a5,a5,a1
    800001fe:	872a                	mv	a4,a0
      *d++ = *s++;
    80000200:	0585                	addi	a1,a1,1
    80000202:	0705                	addi	a4,a4,1
    80000204:	fff5c683          	lbu	a3,-1(a1)
    80000208:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    8000020c:	fef59ae3          	bne	a1,a5,80000200 <memmove+0x28>

  return dst;
}
    80000210:	6422                	ld	s0,8(sp)
    80000212:	0141                	addi	sp,sp,16
    80000214:	8082                	ret
    d += n;
    80000216:	96aa                	add	a3,a3,a0
    while(n-- > 0)
    80000218:	fff6079b          	addiw	a5,a2,-1
    8000021c:	1782                	slli	a5,a5,0x20
    8000021e:	9381                	srli	a5,a5,0x20
    80000220:	fff7c793          	not	a5,a5
    80000224:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000226:	177d                	addi	a4,a4,-1
    80000228:	16fd                	addi	a3,a3,-1
    8000022a:	00074603          	lbu	a2,0(a4)
    8000022e:	00c68023          	sb	a2,0(a3)
    while(n-- > 0)
    80000232:	fef71ae3          	bne	a4,a5,80000226 <memmove+0x4e>
    80000236:	bfe9                	j	80000210 <memmove+0x38>

0000000080000238 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000238:	1141                	addi	sp,sp,-16
    8000023a:	e406                	sd	ra,8(sp)
    8000023c:	e022                	sd	s0,0(sp)
    8000023e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000240:	00000097          	auipc	ra,0x0
    80000244:	f98080e7          	jalr	-104(ra) # 800001d8 <memmove>
}
    80000248:	60a2                	ld	ra,8(sp)
    8000024a:	6402                	ld	s0,0(sp)
    8000024c:	0141                	addi	sp,sp,16
    8000024e:	8082                	ret

0000000080000250 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000250:	1141                	addi	sp,sp,-16
    80000252:	e422                	sd	s0,8(sp)
    80000254:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000256:	ce11                	beqz	a2,80000272 <strncmp+0x22>
    80000258:	00054783          	lbu	a5,0(a0)
    8000025c:	cf89                	beqz	a5,80000276 <strncmp+0x26>
    8000025e:	0005c703          	lbu	a4,0(a1)
    80000262:	00f71a63          	bne	a4,a5,80000276 <strncmp+0x26>
    n--, p++, q++;
    80000266:	367d                	addiw	a2,a2,-1
    80000268:	0505                	addi	a0,a0,1
    8000026a:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    8000026c:	f675                	bnez	a2,80000258 <strncmp+0x8>
  if(n == 0)
    return 0;
    8000026e:	4501                	li	a0,0
    80000270:	a809                	j	80000282 <strncmp+0x32>
    80000272:	4501                	li	a0,0
    80000274:	a039                	j	80000282 <strncmp+0x32>
  if(n == 0)
    80000276:	ca09                	beqz	a2,80000288 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000278:	00054503          	lbu	a0,0(a0)
    8000027c:	0005c783          	lbu	a5,0(a1)
    80000280:	9d1d                	subw	a0,a0,a5
}
    80000282:	6422                	ld	s0,8(sp)
    80000284:	0141                	addi	sp,sp,16
    80000286:	8082                	ret
    return 0;
    80000288:	4501                	li	a0,0
    8000028a:	bfe5                	j	80000282 <strncmp+0x32>

000000008000028c <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    8000028c:	1141                	addi	sp,sp,-16
    8000028e:	e422                	sd	s0,8(sp)
    80000290:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000292:	872a                	mv	a4,a0
    80000294:	8832                	mv	a6,a2
    80000296:	367d                	addiw	a2,a2,-1
    80000298:	01005963          	blez	a6,800002aa <strncpy+0x1e>
    8000029c:	0705                	addi	a4,a4,1
    8000029e:	0005c783          	lbu	a5,0(a1)
    800002a2:	fef70fa3          	sb	a5,-1(a4)
    800002a6:	0585                	addi	a1,a1,1
    800002a8:	f7f5                	bnez	a5,80000294 <strncpy+0x8>
    ;
  while(n-- > 0)
    800002aa:	00c05d63          	blez	a2,800002c4 <strncpy+0x38>
    800002ae:	86ba                	mv	a3,a4
    *s++ = 0;
    800002b0:	0685                	addi	a3,a3,1
    800002b2:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800002b6:	fff6c793          	not	a5,a3
    800002ba:	9fb9                	addw	a5,a5,a4
    800002bc:	010787bb          	addw	a5,a5,a6
    800002c0:	fef048e3          	bgtz	a5,800002b0 <strncpy+0x24>
  return os;
}
    800002c4:	6422                	ld	s0,8(sp)
    800002c6:	0141                	addi	sp,sp,16
    800002c8:	8082                	ret

00000000800002ca <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002ca:	1141                	addi	sp,sp,-16
    800002cc:	e422                	sd	s0,8(sp)
    800002ce:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002d0:	02c05363          	blez	a2,800002f6 <safestrcpy+0x2c>
    800002d4:	fff6069b          	addiw	a3,a2,-1
    800002d8:	1682                	slli	a3,a3,0x20
    800002da:	9281                	srli	a3,a3,0x20
    800002dc:	96ae                	add	a3,a3,a1
    800002de:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002e0:	00d58963          	beq	a1,a3,800002f2 <safestrcpy+0x28>
    800002e4:	0585                	addi	a1,a1,1
    800002e6:	0785                	addi	a5,a5,1
    800002e8:	fff5c703          	lbu	a4,-1(a1)
    800002ec:	fee78fa3          	sb	a4,-1(a5)
    800002f0:	fb65                	bnez	a4,800002e0 <safestrcpy+0x16>
    ;
  *s = 0;
    800002f2:	00078023          	sb	zero,0(a5)
  return os;
}
    800002f6:	6422                	ld	s0,8(sp)
    800002f8:	0141                	addi	sp,sp,16
    800002fa:	8082                	ret

00000000800002fc <strlen>:

int
strlen(const char *s)
{
    800002fc:	1141                	addi	sp,sp,-16
    800002fe:	e422                	sd	s0,8(sp)
    80000300:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000302:	00054783          	lbu	a5,0(a0)
    80000306:	cf91                	beqz	a5,80000322 <strlen+0x26>
    80000308:	0505                	addi	a0,a0,1
    8000030a:	87aa                	mv	a5,a0
    8000030c:	4685                	li	a3,1
    8000030e:	9e89                	subw	a3,a3,a0
    80000310:	00f6853b          	addw	a0,a3,a5
    80000314:	0785                	addi	a5,a5,1
    80000316:	fff7c703          	lbu	a4,-1(a5)
    8000031a:	fb7d                	bnez	a4,80000310 <strlen+0x14>
    ;
  return n;
}
    8000031c:	6422                	ld	s0,8(sp)
    8000031e:	0141                	addi	sp,sp,16
    80000320:	8082                	ret
  for(n = 0; s[n]; n++)
    80000322:	4501                	li	a0,0
    80000324:	bfe5                	j	8000031c <strlen+0x20>

0000000080000326 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000326:	1141                	addi	sp,sp,-16
    80000328:	e406                	sd	ra,8(sp)
    8000032a:	e022                	sd	s0,0(sp)
    8000032c:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    8000032e:	00001097          	auipc	ra,0x1
    80000332:	afe080e7          	jalr	-1282(ra) # 80000e2c <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000336:	00008717          	auipc	a4,0x8
    8000033a:	55a70713          	addi	a4,a4,1370 # 80008890 <started>
  if(cpuid() == 0){
    8000033e:	c139                	beqz	a0,80000384 <main+0x5e>
    while(started == 0)
    80000340:	431c                	lw	a5,0(a4)
    80000342:	2781                	sext.w	a5,a5
    80000344:	dff5                	beqz	a5,80000340 <main+0x1a>
      ;
    __sync_synchronize();
    80000346:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    8000034a:	00001097          	auipc	ra,0x1
    8000034e:	ae2080e7          	jalr	-1310(ra) # 80000e2c <cpuid>
    80000352:	85aa                	mv	a1,a0
    80000354:	00008517          	auipc	a0,0x8
    80000358:	ce450513          	addi	a0,a0,-796 # 80008038 <etext+0x38>
    8000035c:	00006097          	auipc	ra,0x6
    80000360:	8c0080e7          	jalr	-1856(ra) # 80005c1c <printf>
    kvminithart();    // turn on paging
    80000364:	00000097          	auipc	ra,0x0
    80000368:	0d8080e7          	jalr	216(ra) # 8000043c <kvminithart>
    trapinithart();   // install kernel trap vector
    8000036c:	00001097          	auipc	ra,0x1
    80000370:	784080e7          	jalr	1924(ra) # 80001af0 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000374:	00005097          	auipc	ra,0x5
    80000378:	cfc080e7          	jalr	-772(ra) # 80005070 <plicinithart>
  }

  scheduler();        
    8000037c:	00001097          	auipc	ra,0x1
    80000380:	fce080e7          	jalr	-50(ra) # 8000134a <scheduler>
    consoleinit();
    80000384:	00005097          	auipc	ra,0x5
    80000388:	760080e7          	jalr	1888(ra) # 80005ae4 <consoleinit>
    printfinit();
    8000038c:	00006097          	auipc	ra,0x6
    80000390:	a76080e7          	jalr	-1418(ra) # 80005e02 <printfinit>
    printf("\n");
    80000394:	00008517          	auipc	a0,0x8
    80000398:	cb450513          	addi	a0,a0,-844 # 80008048 <etext+0x48>
    8000039c:	00006097          	auipc	ra,0x6
    800003a0:	880080e7          	jalr	-1920(ra) # 80005c1c <printf>
    printf("xv6 kernel is booting\n");
    800003a4:	00008517          	auipc	a0,0x8
    800003a8:	c7c50513          	addi	a0,a0,-900 # 80008020 <etext+0x20>
    800003ac:	00006097          	auipc	ra,0x6
    800003b0:	870080e7          	jalr	-1936(ra) # 80005c1c <printf>
    printf("\n");
    800003b4:	00008517          	auipc	a0,0x8
    800003b8:	c9450513          	addi	a0,a0,-876 # 80008048 <etext+0x48>
    800003bc:	00006097          	auipc	ra,0x6
    800003c0:	860080e7          	jalr	-1952(ra) # 80005c1c <printf>
    kinit();         // physical page allocator
    800003c4:	00000097          	auipc	ra,0x0
    800003c8:	d18080e7          	jalr	-744(ra) # 800000dc <kinit>
    kvminit();       // create kernel page table
    800003cc:	00000097          	auipc	ra,0x0
    800003d0:	326080e7          	jalr	806(ra) # 800006f2 <kvminit>
    kvminithart();   // turn on paging
    800003d4:	00000097          	auipc	ra,0x0
    800003d8:	068080e7          	jalr	104(ra) # 8000043c <kvminithart>
    procinit();      // process table
    800003dc:	00001097          	auipc	ra,0x1
    800003e0:	99c080e7          	jalr	-1636(ra) # 80000d78 <procinit>
    trapinit();      // trap vectors
    800003e4:	00001097          	auipc	ra,0x1
    800003e8:	6e4080e7          	jalr	1764(ra) # 80001ac8 <trapinit>
    trapinithart();  // install kernel trap vector
    800003ec:	00001097          	auipc	ra,0x1
    800003f0:	704080e7          	jalr	1796(ra) # 80001af0 <trapinithart>
    plicinit();      // set up interrupt controller
    800003f4:	00005097          	auipc	ra,0x5
    800003f8:	c66080e7          	jalr	-922(ra) # 8000505a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003fc:	00005097          	auipc	ra,0x5
    80000400:	c74080e7          	jalr	-908(ra) # 80005070 <plicinithart>
    binit();         // buffer cache
    80000404:	00002097          	auipc	ra,0x2
    80000408:	e28080e7          	jalr	-472(ra) # 8000222c <binit>
    iinit();         // inode table
    8000040c:	00002097          	auipc	ra,0x2
    80000410:	4cc080e7          	jalr	1228(ra) # 800028d8 <iinit>
    fileinit();      // file table
    80000414:	00003097          	auipc	ra,0x3
    80000418:	46a080e7          	jalr	1130(ra) # 8000387e <fileinit>
    virtio_disk_init(); // emulated hard disk
    8000041c:	00005097          	auipc	ra,0x5
    80000420:	d5c080e7          	jalr	-676(ra) # 80005178 <virtio_disk_init>
    userinit();      // first user process
    80000424:	00001097          	auipc	ra,0x1
    80000428:	d0c080e7          	jalr	-756(ra) # 80001130 <userinit>
    __sync_synchronize();
    8000042c:	0ff0000f          	fence
    started = 1;
    80000430:	4785                	li	a5,1
    80000432:	00008717          	auipc	a4,0x8
    80000436:	44f72f23          	sw	a5,1118(a4) # 80008890 <started>
    8000043a:	b789                	j	8000037c <main+0x56>

000000008000043c <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    8000043c:	1141                	addi	sp,sp,-16
    8000043e:	e422                	sd	s0,8(sp)
    80000440:	0800                	addi	s0,sp,16
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000442:	12000073          	sfence.vma
  // wait for any previous writes to the page table memory to finish.
  sfence_vma();

  w_satp(MAKE_SATP(kernel_pagetable));
    80000446:	00008797          	auipc	a5,0x8
    8000044a:	4527b783          	ld	a5,1106(a5) # 80008898 <kernel_pagetable>
    8000044e:	83b1                	srli	a5,a5,0xc
    80000450:	577d                	li	a4,-1
    80000452:	177e                	slli	a4,a4,0x3f
    80000454:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000456:	18079073          	csrw	satp,a5
  asm volatile("sfence.vma zero, zero");
    8000045a:	12000073          	sfence.vma

  // flush stale entries from the TLB.
  sfence_vma();
}
    8000045e:	6422                	ld	s0,8(sp)
    80000460:	0141                	addi	sp,sp,16
    80000462:	8082                	ret

0000000080000464 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000464:	7139                	addi	sp,sp,-64
    80000466:	fc06                	sd	ra,56(sp)
    80000468:	f822                	sd	s0,48(sp)
    8000046a:	f426                	sd	s1,40(sp)
    8000046c:	f04a                	sd	s2,32(sp)
    8000046e:	ec4e                	sd	s3,24(sp)
    80000470:	e852                	sd	s4,16(sp)
    80000472:	e456                	sd	s5,8(sp)
    80000474:	e05a                	sd	s6,0(sp)
    80000476:	0080                	addi	s0,sp,64
    80000478:	84aa                	mv	s1,a0
    8000047a:	89ae                	mv	s3,a1
    8000047c:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    8000047e:	57fd                	li	a5,-1
    80000480:	83e9                	srli	a5,a5,0x1a
    80000482:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000484:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000486:	04b7f263          	bgeu	a5,a1,800004ca <walk+0x66>
    panic("walk");
    8000048a:	00008517          	auipc	a0,0x8
    8000048e:	bc650513          	addi	a0,a0,-1082 # 80008050 <etext+0x50>
    80000492:	00005097          	auipc	ra,0x5
    80000496:	740080e7          	jalr	1856(ra) # 80005bd2 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    8000049a:	060a8663          	beqz	s5,80000506 <walk+0xa2>
    8000049e:	00000097          	auipc	ra,0x0
    800004a2:	c7a080e7          	jalr	-902(ra) # 80000118 <kalloc>
    800004a6:	84aa                	mv	s1,a0
    800004a8:	c529                	beqz	a0,800004f2 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800004aa:	6605                	lui	a2,0x1
    800004ac:	4581                	li	a1,0
    800004ae:	00000097          	auipc	ra,0x0
    800004b2:	cca080e7          	jalr	-822(ra) # 80000178 <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004b6:	00c4d793          	srli	a5,s1,0xc
    800004ba:	07aa                	slli	a5,a5,0xa
    800004bc:	0017e793          	ori	a5,a5,1
    800004c0:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800004c4:	3a5d                	addiw	s4,s4,-9
    800004c6:	036a0063          	beq	s4,s6,800004e6 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800004ca:	0149d933          	srl	s2,s3,s4
    800004ce:	1ff97913          	andi	s2,s2,511
    800004d2:	090e                	slli	s2,s2,0x3
    800004d4:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004d6:	00093483          	ld	s1,0(s2)
    800004da:	0014f793          	andi	a5,s1,1
    800004de:	dfd5                	beqz	a5,8000049a <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004e0:	80a9                	srli	s1,s1,0xa
    800004e2:	04b2                	slli	s1,s1,0xc
    800004e4:	b7c5                	j	800004c4 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800004e6:	00c9d513          	srli	a0,s3,0xc
    800004ea:	1ff57513          	andi	a0,a0,511
    800004ee:	050e                	slli	a0,a0,0x3
    800004f0:	9526                	add	a0,a0,s1
}
    800004f2:	70e2                	ld	ra,56(sp)
    800004f4:	7442                	ld	s0,48(sp)
    800004f6:	74a2                	ld	s1,40(sp)
    800004f8:	7902                	ld	s2,32(sp)
    800004fa:	69e2                	ld	s3,24(sp)
    800004fc:	6a42                	ld	s4,16(sp)
    800004fe:	6aa2                	ld	s5,8(sp)
    80000500:	6b02                	ld	s6,0(sp)
    80000502:	6121                	addi	sp,sp,64
    80000504:	8082                	ret
        return 0;
    80000506:	4501                	li	a0,0
    80000508:	b7ed                	j	800004f2 <walk+0x8e>

000000008000050a <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000050a:	57fd                	li	a5,-1
    8000050c:	83e9                	srli	a5,a5,0x1a
    8000050e:	00b7f463          	bgeu	a5,a1,80000516 <walkaddr+0xc>
    return 0;
    80000512:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80000514:	8082                	ret
{
    80000516:	1141                	addi	sp,sp,-16
    80000518:	e406                	sd	ra,8(sp)
    8000051a:	e022                	sd	s0,0(sp)
    8000051c:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000051e:	4601                	li	a2,0
    80000520:	00000097          	auipc	ra,0x0
    80000524:	f44080e7          	jalr	-188(ra) # 80000464 <walk>
  if(pte == 0)
    80000528:	c105                	beqz	a0,80000548 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    8000052a:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000052c:	0117f693          	andi	a3,a5,17
    80000530:	4745                	li	a4,17
    return 0;
    80000532:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80000534:	00e68663          	beq	a3,a4,80000540 <walkaddr+0x36>
}
    80000538:	60a2                	ld	ra,8(sp)
    8000053a:	6402                	ld	s0,0(sp)
    8000053c:	0141                	addi	sp,sp,16
    8000053e:	8082                	ret
  pa = PTE2PA(*pte);
    80000540:	00a7d513          	srli	a0,a5,0xa
    80000544:	0532                	slli	a0,a0,0xc
  return pa;
    80000546:	bfcd                	j	80000538 <walkaddr+0x2e>
    return 0;
    80000548:	4501                	li	a0,0
    8000054a:	b7fd                	j	80000538 <walkaddr+0x2e>

000000008000054c <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000054c:	715d                	addi	sp,sp,-80
    8000054e:	e486                	sd	ra,72(sp)
    80000550:	e0a2                	sd	s0,64(sp)
    80000552:	fc26                	sd	s1,56(sp)
    80000554:	f84a                	sd	s2,48(sp)
    80000556:	f44e                	sd	s3,40(sp)
    80000558:	f052                	sd	s4,32(sp)
    8000055a:	ec56                	sd	s5,24(sp)
    8000055c:	e85a                	sd	s6,16(sp)
    8000055e:	e45e                	sd	s7,8(sp)
    80000560:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80000562:	c205                	beqz	a2,80000582 <mappages+0x36>
    80000564:	8aaa                	mv	s5,a0
    80000566:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    80000568:	77fd                	lui	a5,0xfffff
    8000056a:	00f5fa33          	and	s4,a1,a5
  last = PGROUNDDOWN(va + size - 1);
    8000056e:	15fd                	addi	a1,a1,-1
    80000570:	00c589b3          	add	s3,a1,a2
    80000574:	00f9f9b3          	and	s3,s3,a5
  a = PGROUNDDOWN(va);
    80000578:	8952                	mv	s2,s4
    8000057a:	41468a33          	sub	s4,a3,s4
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    8000057e:	6b85                	lui	s7,0x1
    80000580:	a015                	j	800005a4 <mappages+0x58>
    panic("mappages: size");
    80000582:	00008517          	auipc	a0,0x8
    80000586:	ad650513          	addi	a0,a0,-1322 # 80008058 <etext+0x58>
    8000058a:	00005097          	auipc	ra,0x5
    8000058e:	648080e7          	jalr	1608(ra) # 80005bd2 <panic>
      panic("mappages: remap");
    80000592:	00008517          	auipc	a0,0x8
    80000596:	ad650513          	addi	a0,a0,-1322 # 80008068 <etext+0x68>
    8000059a:	00005097          	auipc	ra,0x5
    8000059e:	638080e7          	jalr	1592(ra) # 80005bd2 <panic>
    a += PGSIZE;
    800005a2:	995e                	add	s2,s2,s7
  for(;;){
    800005a4:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800005a8:	4605                	li	a2,1
    800005aa:	85ca                	mv	a1,s2
    800005ac:	8556                	mv	a0,s5
    800005ae:	00000097          	auipc	ra,0x0
    800005b2:	eb6080e7          	jalr	-330(ra) # 80000464 <walk>
    800005b6:	cd19                	beqz	a0,800005d4 <mappages+0x88>
    if(*pte & PTE_V)
    800005b8:	611c                	ld	a5,0(a0)
    800005ba:	8b85                	andi	a5,a5,1
    800005bc:	fbf9                	bnez	a5,80000592 <mappages+0x46>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800005be:	80b1                	srli	s1,s1,0xc
    800005c0:	04aa                	slli	s1,s1,0xa
    800005c2:	0164e4b3          	or	s1,s1,s6
    800005c6:	0014e493          	ori	s1,s1,1
    800005ca:	e104                	sd	s1,0(a0)
    if(a == last)
    800005cc:	fd391be3          	bne	s2,s3,800005a2 <mappages+0x56>
    pa += PGSIZE;
  }
  return 0;
    800005d0:	4501                	li	a0,0
    800005d2:	a011                	j	800005d6 <mappages+0x8a>
      return -1;
    800005d4:	557d                	li	a0,-1
}
    800005d6:	60a6                	ld	ra,72(sp)
    800005d8:	6406                	ld	s0,64(sp)
    800005da:	74e2                	ld	s1,56(sp)
    800005dc:	7942                	ld	s2,48(sp)
    800005de:	79a2                	ld	s3,40(sp)
    800005e0:	7a02                	ld	s4,32(sp)
    800005e2:	6ae2                	ld	s5,24(sp)
    800005e4:	6b42                	ld	s6,16(sp)
    800005e6:	6ba2                	ld	s7,8(sp)
    800005e8:	6161                	addi	sp,sp,80
    800005ea:	8082                	ret

00000000800005ec <kvmmap>:
{
    800005ec:	1141                	addi	sp,sp,-16
    800005ee:	e406                	sd	ra,8(sp)
    800005f0:	e022                	sd	s0,0(sp)
    800005f2:	0800                	addi	s0,sp,16
    800005f4:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    800005f6:	86b2                	mv	a3,a2
    800005f8:	863e                	mv	a2,a5
    800005fa:	00000097          	auipc	ra,0x0
    800005fe:	f52080e7          	jalr	-174(ra) # 8000054c <mappages>
    80000602:	e509                	bnez	a0,8000060c <kvmmap+0x20>
}
    80000604:	60a2                	ld	ra,8(sp)
    80000606:	6402                	ld	s0,0(sp)
    80000608:	0141                	addi	sp,sp,16
    8000060a:	8082                	ret
    panic("kvmmap");
    8000060c:	00008517          	auipc	a0,0x8
    80000610:	a6c50513          	addi	a0,a0,-1428 # 80008078 <etext+0x78>
    80000614:	00005097          	auipc	ra,0x5
    80000618:	5be080e7          	jalr	1470(ra) # 80005bd2 <panic>

000000008000061c <kvmmake>:
{
    8000061c:	1101                	addi	sp,sp,-32
    8000061e:	ec06                	sd	ra,24(sp)
    80000620:	e822                	sd	s0,16(sp)
    80000622:	e426                	sd	s1,8(sp)
    80000624:	e04a                	sd	s2,0(sp)
    80000626:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80000628:	00000097          	auipc	ra,0x0
    8000062c:	af0080e7          	jalr	-1296(ra) # 80000118 <kalloc>
    80000630:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000632:	6605                	lui	a2,0x1
    80000634:	4581                	li	a1,0
    80000636:	00000097          	auipc	ra,0x0
    8000063a:	b42080e7          	jalr	-1214(ra) # 80000178 <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000063e:	4719                	li	a4,6
    80000640:	6685                	lui	a3,0x1
    80000642:	10000637          	lui	a2,0x10000
    80000646:	100005b7          	lui	a1,0x10000
    8000064a:	8526                	mv	a0,s1
    8000064c:	00000097          	auipc	ra,0x0
    80000650:	fa0080e7          	jalr	-96(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80000654:	4719                	li	a4,6
    80000656:	6685                	lui	a3,0x1
    80000658:	10001637          	lui	a2,0x10001
    8000065c:	100015b7          	lui	a1,0x10001
    80000660:	8526                	mv	a0,s1
    80000662:	00000097          	auipc	ra,0x0
    80000666:	f8a080e7          	jalr	-118(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    8000066a:	4719                	li	a4,6
    8000066c:	004006b7          	lui	a3,0x400
    80000670:	0c000637          	lui	a2,0xc000
    80000674:	0c0005b7          	lui	a1,0xc000
    80000678:	8526                	mv	a0,s1
    8000067a:	00000097          	auipc	ra,0x0
    8000067e:	f72080e7          	jalr	-142(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000682:	00008917          	auipc	s2,0x8
    80000686:	97e90913          	addi	s2,s2,-1666 # 80008000 <etext>
    8000068a:	4729                	li	a4,10
    8000068c:	80008697          	auipc	a3,0x80008
    80000690:	97468693          	addi	a3,a3,-1676 # 8000 <_entry-0x7fff8000>
    80000694:	4605                	li	a2,1
    80000696:	067e                	slli	a2,a2,0x1f
    80000698:	85b2                	mv	a1,a2
    8000069a:	8526                	mv	a0,s1
    8000069c:	00000097          	auipc	ra,0x0
    800006a0:	f50080e7          	jalr	-176(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800006a4:	4719                	li	a4,6
    800006a6:	46c5                	li	a3,17
    800006a8:	06ee                	slli	a3,a3,0x1b
    800006aa:	412686b3          	sub	a3,a3,s2
    800006ae:	864a                	mv	a2,s2
    800006b0:	85ca                	mv	a1,s2
    800006b2:	8526                	mv	a0,s1
    800006b4:	00000097          	auipc	ra,0x0
    800006b8:	f38080e7          	jalr	-200(ra) # 800005ec <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006bc:	4729                	li	a4,10
    800006be:	6685                	lui	a3,0x1
    800006c0:	00007617          	auipc	a2,0x7
    800006c4:	94060613          	addi	a2,a2,-1728 # 80007000 <_trampoline>
    800006c8:	040005b7          	lui	a1,0x4000
    800006cc:	15fd                	addi	a1,a1,-1
    800006ce:	05b2                	slli	a1,a1,0xc
    800006d0:	8526                	mv	a0,s1
    800006d2:	00000097          	auipc	ra,0x0
    800006d6:	f1a080e7          	jalr	-230(ra) # 800005ec <kvmmap>
  proc_mapstacks(kpgtbl);
    800006da:	8526                	mv	a0,s1
    800006dc:	00000097          	auipc	ra,0x0
    800006e0:	606080e7          	jalr	1542(ra) # 80000ce2 <proc_mapstacks>
}
    800006e4:	8526                	mv	a0,s1
    800006e6:	60e2                	ld	ra,24(sp)
    800006e8:	6442                	ld	s0,16(sp)
    800006ea:	64a2                	ld	s1,8(sp)
    800006ec:	6902                	ld	s2,0(sp)
    800006ee:	6105                	addi	sp,sp,32
    800006f0:	8082                	ret

00000000800006f2 <kvminit>:
{
    800006f2:	1141                	addi	sp,sp,-16
    800006f4:	e406                	sd	ra,8(sp)
    800006f6:	e022                	sd	s0,0(sp)
    800006f8:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    800006fa:	00000097          	auipc	ra,0x0
    800006fe:	f22080e7          	jalr	-222(ra) # 8000061c <kvmmake>
    80000702:	00008797          	auipc	a5,0x8
    80000706:	18a7bb23          	sd	a0,406(a5) # 80008898 <kernel_pagetable>
}
    8000070a:	60a2                	ld	ra,8(sp)
    8000070c:	6402                	ld	s0,0(sp)
    8000070e:	0141                	addi	sp,sp,16
    80000710:	8082                	ret

0000000080000712 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000712:	715d                	addi	sp,sp,-80
    80000714:	e486                	sd	ra,72(sp)
    80000716:	e0a2                	sd	s0,64(sp)
    80000718:	fc26                	sd	s1,56(sp)
    8000071a:	f84a                	sd	s2,48(sp)
    8000071c:	f44e                	sd	s3,40(sp)
    8000071e:	f052                	sd	s4,32(sp)
    80000720:	ec56                	sd	s5,24(sp)
    80000722:	e85a                	sd	s6,16(sp)
    80000724:	e45e                	sd	s7,8(sp)
    80000726:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80000728:	03459793          	slli	a5,a1,0x34
    8000072c:	e795                	bnez	a5,80000758 <uvmunmap+0x46>
    8000072e:	8a2a                	mv	s4,a0
    80000730:	892e                	mv	s2,a1
    80000732:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000734:	0632                	slli	a2,a2,0xc
    80000736:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    8000073a:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000073c:	6b05                	lui	s6,0x1
    8000073e:	0735e863          	bltu	a1,s3,800007ae <uvmunmap+0x9c>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80000742:	60a6                	ld	ra,72(sp)
    80000744:	6406                	ld	s0,64(sp)
    80000746:	74e2                	ld	s1,56(sp)
    80000748:	7942                	ld	s2,48(sp)
    8000074a:	79a2                	ld	s3,40(sp)
    8000074c:	7a02                	ld	s4,32(sp)
    8000074e:	6ae2                	ld	s5,24(sp)
    80000750:	6b42                	ld	s6,16(sp)
    80000752:	6ba2                	ld	s7,8(sp)
    80000754:	6161                	addi	sp,sp,80
    80000756:	8082                	ret
    panic("uvmunmap: not aligned");
    80000758:	00008517          	auipc	a0,0x8
    8000075c:	92850513          	addi	a0,a0,-1752 # 80008080 <etext+0x80>
    80000760:	00005097          	auipc	ra,0x5
    80000764:	472080e7          	jalr	1138(ra) # 80005bd2 <panic>
      panic("uvmunmap: walk");
    80000768:	00008517          	auipc	a0,0x8
    8000076c:	93050513          	addi	a0,a0,-1744 # 80008098 <etext+0x98>
    80000770:	00005097          	auipc	ra,0x5
    80000774:	462080e7          	jalr	1122(ra) # 80005bd2 <panic>
      panic("uvmunmap: not mapped");
    80000778:	00008517          	auipc	a0,0x8
    8000077c:	93050513          	addi	a0,a0,-1744 # 800080a8 <etext+0xa8>
    80000780:	00005097          	auipc	ra,0x5
    80000784:	452080e7          	jalr	1106(ra) # 80005bd2 <panic>
      panic("uvmunmap: not a leaf");
    80000788:	00008517          	auipc	a0,0x8
    8000078c:	93850513          	addi	a0,a0,-1736 # 800080c0 <etext+0xc0>
    80000790:	00005097          	auipc	ra,0x5
    80000794:	442080e7          	jalr	1090(ra) # 80005bd2 <panic>
      uint64 pa = PTE2PA(*pte);
    80000798:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    8000079a:	0532                	slli	a0,a0,0xc
    8000079c:	00000097          	auipc	ra,0x0
    800007a0:	880080e7          	jalr	-1920(ra) # 8000001c <kfree>
    *pte = 0;
    800007a4:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800007a8:	995a                	add	s2,s2,s6
    800007aa:	f9397ce3          	bgeu	s2,s3,80000742 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    800007ae:	4601                	li	a2,0
    800007b0:	85ca                	mv	a1,s2
    800007b2:	8552                	mv	a0,s4
    800007b4:	00000097          	auipc	ra,0x0
    800007b8:	cb0080e7          	jalr	-848(ra) # 80000464 <walk>
    800007bc:	84aa                	mv	s1,a0
    800007be:	d54d                	beqz	a0,80000768 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800007c0:	6108                	ld	a0,0(a0)
    800007c2:	00157793          	andi	a5,a0,1
    800007c6:	dbcd                	beqz	a5,80000778 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007c8:	3ff57793          	andi	a5,a0,1023
    800007cc:	fb778ee3          	beq	a5,s7,80000788 <uvmunmap+0x76>
    if(do_free){
    800007d0:	fc0a8ae3          	beqz	s5,800007a4 <uvmunmap+0x92>
    800007d4:	b7d1                	j	80000798 <uvmunmap+0x86>

00000000800007d6 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007d6:	1101                	addi	sp,sp,-32
    800007d8:	ec06                	sd	ra,24(sp)
    800007da:	e822                	sd	s0,16(sp)
    800007dc:	e426                	sd	s1,8(sp)
    800007de:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800007e0:	00000097          	auipc	ra,0x0
    800007e4:	938080e7          	jalr	-1736(ra) # 80000118 <kalloc>
    800007e8:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800007ea:	c519                	beqz	a0,800007f8 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800007ec:	6605                	lui	a2,0x1
    800007ee:	4581                	li	a1,0
    800007f0:	00000097          	auipc	ra,0x0
    800007f4:	988080e7          	jalr	-1656(ra) # 80000178 <memset>
  return pagetable;
}
    800007f8:	8526                	mv	a0,s1
    800007fa:	60e2                	ld	ra,24(sp)
    800007fc:	6442                	ld	s0,16(sp)
    800007fe:	64a2                	ld	s1,8(sp)
    80000800:	6105                	addi	sp,sp,32
    80000802:	8082                	ret

0000000080000804 <uvmfirst>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvmfirst(pagetable_t pagetable, uchar *src, uint sz)
{
    80000804:	7179                	addi	sp,sp,-48
    80000806:	f406                	sd	ra,40(sp)
    80000808:	f022                	sd	s0,32(sp)
    8000080a:	ec26                	sd	s1,24(sp)
    8000080c:	e84a                	sd	s2,16(sp)
    8000080e:	e44e                	sd	s3,8(sp)
    80000810:	e052                	sd	s4,0(sp)
    80000812:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80000814:	6785                	lui	a5,0x1
    80000816:	04f67863          	bgeu	a2,a5,80000866 <uvmfirst+0x62>
    8000081a:	8a2a                	mv	s4,a0
    8000081c:	89ae                	mv	s3,a1
    8000081e:	84b2                	mv	s1,a2
    panic("uvmfirst: more than a page");
  mem = kalloc();
    80000820:	00000097          	auipc	ra,0x0
    80000824:	8f8080e7          	jalr	-1800(ra) # 80000118 <kalloc>
    80000828:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    8000082a:	6605                	lui	a2,0x1
    8000082c:	4581                	li	a1,0
    8000082e:	00000097          	auipc	ra,0x0
    80000832:	94a080e7          	jalr	-1718(ra) # 80000178 <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80000836:	4779                	li	a4,30
    80000838:	86ca                	mv	a3,s2
    8000083a:	6605                	lui	a2,0x1
    8000083c:	4581                	li	a1,0
    8000083e:	8552                	mv	a0,s4
    80000840:	00000097          	auipc	ra,0x0
    80000844:	d0c080e7          	jalr	-756(ra) # 8000054c <mappages>
  memmove(mem, src, sz);
    80000848:	8626                	mv	a2,s1
    8000084a:	85ce                	mv	a1,s3
    8000084c:	854a                	mv	a0,s2
    8000084e:	00000097          	auipc	ra,0x0
    80000852:	98a080e7          	jalr	-1654(ra) # 800001d8 <memmove>
}
    80000856:	70a2                	ld	ra,40(sp)
    80000858:	7402                	ld	s0,32(sp)
    8000085a:	64e2                	ld	s1,24(sp)
    8000085c:	6942                	ld	s2,16(sp)
    8000085e:	69a2                	ld	s3,8(sp)
    80000860:	6a02                	ld	s4,0(sp)
    80000862:	6145                	addi	sp,sp,48
    80000864:	8082                	ret
    panic("uvmfirst: more than a page");
    80000866:	00008517          	auipc	a0,0x8
    8000086a:	87250513          	addi	a0,a0,-1934 # 800080d8 <etext+0xd8>
    8000086e:	00005097          	auipc	ra,0x5
    80000872:	364080e7          	jalr	868(ra) # 80005bd2 <panic>

0000000080000876 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    80000876:	1101                	addi	sp,sp,-32
    80000878:	ec06                	sd	ra,24(sp)
    8000087a:	e822                	sd	s0,16(sp)
    8000087c:	e426                	sd	s1,8(sp)
    8000087e:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80000880:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80000882:	00b67d63          	bgeu	a2,a1,8000089c <uvmdealloc+0x26>
    80000886:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    80000888:	6785                	lui	a5,0x1
    8000088a:	17fd                	addi	a5,a5,-1
    8000088c:	00f60733          	add	a4,a2,a5
    80000890:	767d                	lui	a2,0xfffff
    80000892:	8f71                	and	a4,a4,a2
    80000894:	97ae                	add	a5,a5,a1
    80000896:	8ff1                	and	a5,a5,a2
    80000898:	00f76863          	bltu	a4,a5,800008a8 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    8000089c:	8526                	mv	a0,s1
    8000089e:	60e2                	ld	ra,24(sp)
    800008a0:	6442                	ld	s0,16(sp)
    800008a2:	64a2                	ld	s1,8(sp)
    800008a4:	6105                	addi	sp,sp,32
    800008a6:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800008a8:	8f99                	sub	a5,a5,a4
    800008aa:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008ac:	4685                	li	a3,1
    800008ae:	0007861b          	sext.w	a2,a5
    800008b2:	85ba                	mv	a1,a4
    800008b4:	00000097          	auipc	ra,0x0
    800008b8:	e5e080e7          	jalr	-418(ra) # 80000712 <uvmunmap>
    800008bc:	b7c5                	j	8000089c <uvmdealloc+0x26>

00000000800008be <uvmalloc>:
  if(newsz < oldsz)
    800008be:	0ab66563          	bltu	a2,a1,80000968 <uvmalloc+0xaa>
{
    800008c2:	7139                	addi	sp,sp,-64
    800008c4:	fc06                	sd	ra,56(sp)
    800008c6:	f822                	sd	s0,48(sp)
    800008c8:	f426                	sd	s1,40(sp)
    800008ca:	f04a                	sd	s2,32(sp)
    800008cc:	ec4e                	sd	s3,24(sp)
    800008ce:	e852                	sd	s4,16(sp)
    800008d0:	e456                	sd	s5,8(sp)
    800008d2:	e05a                	sd	s6,0(sp)
    800008d4:	0080                	addi	s0,sp,64
    800008d6:	8aaa                	mv	s5,a0
    800008d8:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008da:	6985                	lui	s3,0x1
    800008dc:	19fd                	addi	s3,s3,-1
    800008de:	95ce                	add	a1,a1,s3
    800008e0:	79fd                	lui	s3,0xfffff
    800008e2:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    800008e6:	08c9f363          	bgeu	s3,a2,8000096c <uvmalloc+0xae>
    800008ea:	894e                	mv	s2,s3
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    800008ec:	0126eb13          	ori	s6,a3,18
    mem = kalloc();
    800008f0:	00000097          	auipc	ra,0x0
    800008f4:	828080e7          	jalr	-2008(ra) # 80000118 <kalloc>
    800008f8:	84aa                	mv	s1,a0
    if(mem == 0){
    800008fa:	c51d                	beqz	a0,80000928 <uvmalloc+0x6a>
    memset(mem, 0, PGSIZE);
    800008fc:	6605                	lui	a2,0x1
    800008fe:	4581                	li	a1,0
    80000900:	00000097          	auipc	ra,0x0
    80000904:	878080e7          	jalr	-1928(ra) # 80000178 <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_R|PTE_U|xperm) != 0){
    80000908:	875a                	mv	a4,s6
    8000090a:	86a6                	mv	a3,s1
    8000090c:	6605                	lui	a2,0x1
    8000090e:	85ca                	mv	a1,s2
    80000910:	8556                	mv	a0,s5
    80000912:	00000097          	auipc	ra,0x0
    80000916:	c3a080e7          	jalr	-966(ra) # 8000054c <mappages>
    8000091a:	e90d                	bnez	a0,8000094c <uvmalloc+0x8e>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000091c:	6785                	lui	a5,0x1
    8000091e:	993e                	add	s2,s2,a5
    80000920:	fd4968e3          	bltu	s2,s4,800008f0 <uvmalloc+0x32>
  return newsz;
    80000924:	8552                	mv	a0,s4
    80000926:	a809                	j	80000938 <uvmalloc+0x7a>
      uvmdealloc(pagetable, a, oldsz);
    80000928:	864e                	mv	a2,s3
    8000092a:	85ca                	mv	a1,s2
    8000092c:	8556                	mv	a0,s5
    8000092e:	00000097          	auipc	ra,0x0
    80000932:	f48080e7          	jalr	-184(ra) # 80000876 <uvmdealloc>
      return 0;
    80000936:	4501                	li	a0,0
}
    80000938:	70e2                	ld	ra,56(sp)
    8000093a:	7442                	ld	s0,48(sp)
    8000093c:	74a2                	ld	s1,40(sp)
    8000093e:	7902                	ld	s2,32(sp)
    80000940:	69e2                	ld	s3,24(sp)
    80000942:	6a42                	ld	s4,16(sp)
    80000944:	6aa2                	ld	s5,8(sp)
    80000946:	6b02                	ld	s6,0(sp)
    80000948:	6121                	addi	sp,sp,64
    8000094a:	8082                	ret
      kfree(mem);
    8000094c:	8526                	mv	a0,s1
    8000094e:	fffff097          	auipc	ra,0xfffff
    80000952:	6ce080e7          	jalr	1742(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000956:	864e                	mv	a2,s3
    80000958:	85ca                	mv	a1,s2
    8000095a:	8556                	mv	a0,s5
    8000095c:	00000097          	auipc	ra,0x0
    80000960:	f1a080e7          	jalr	-230(ra) # 80000876 <uvmdealloc>
      return 0;
    80000964:	4501                	li	a0,0
    80000966:	bfc9                	j	80000938 <uvmalloc+0x7a>
    return oldsz;
    80000968:	852e                	mv	a0,a1
}
    8000096a:	8082                	ret
  return newsz;
    8000096c:	8532                	mv	a0,a2
    8000096e:	b7e9                	j	80000938 <uvmalloc+0x7a>

0000000080000970 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    80000970:	7179                	addi	sp,sp,-48
    80000972:	f406                	sd	ra,40(sp)
    80000974:	f022                	sd	s0,32(sp)
    80000976:	ec26                	sd	s1,24(sp)
    80000978:	e84a                	sd	s2,16(sp)
    8000097a:	e44e                	sd	s3,8(sp)
    8000097c:	e052                	sd	s4,0(sp)
    8000097e:	1800                	addi	s0,sp,48
    80000980:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000982:	84aa                	mv	s1,a0
    80000984:	6905                	lui	s2,0x1
    80000986:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000988:	4985                	li	s3,1
    8000098a:	a821                	j	800009a2 <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    8000098c:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    8000098e:	0532                	slli	a0,a0,0xc
    80000990:	00000097          	auipc	ra,0x0
    80000994:	fe0080e7          	jalr	-32(ra) # 80000970 <freewalk>
      pagetable[i] = 0;
    80000998:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    8000099c:	04a1                	addi	s1,s1,8
    8000099e:	03248163          	beq	s1,s2,800009c0 <freewalk+0x50>
    pte_t pte = pagetable[i];
    800009a2:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800009a4:	00f57793          	andi	a5,a0,15
    800009a8:	ff3782e3          	beq	a5,s3,8000098c <freewalk+0x1c>
    } else if(pte & PTE_V){
    800009ac:	8905                	andi	a0,a0,1
    800009ae:	d57d                	beqz	a0,8000099c <freewalk+0x2c>
      panic("freewalk: leaf");
    800009b0:	00007517          	auipc	a0,0x7
    800009b4:	74850513          	addi	a0,a0,1864 # 800080f8 <etext+0xf8>
    800009b8:	00005097          	auipc	ra,0x5
    800009bc:	21a080e7          	jalr	538(ra) # 80005bd2 <panic>
    }
  }
  kfree((void*)pagetable);
    800009c0:	8552                	mv	a0,s4
    800009c2:	fffff097          	auipc	ra,0xfffff
    800009c6:	65a080e7          	jalr	1626(ra) # 8000001c <kfree>
}
    800009ca:	70a2                	ld	ra,40(sp)
    800009cc:	7402                	ld	s0,32(sp)
    800009ce:	64e2                	ld	s1,24(sp)
    800009d0:	6942                	ld	s2,16(sp)
    800009d2:	69a2                	ld	s3,8(sp)
    800009d4:	6a02                	ld	s4,0(sp)
    800009d6:	6145                	addi	sp,sp,48
    800009d8:	8082                	ret

00000000800009da <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800009da:	1101                	addi	sp,sp,-32
    800009dc:	ec06                	sd	ra,24(sp)
    800009de:	e822                	sd	s0,16(sp)
    800009e0:	e426                	sd	s1,8(sp)
    800009e2:	1000                	addi	s0,sp,32
    800009e4:	84aa                	mv	s1,a0
  if(sz > 0)
    800009e6:	e999                	bnez	a1,800009fc <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    800009e8:	8526                	mv	a0,s1
    800009ea:	00000097          	auipc	ra,0x0
    800009ee:	f86080e7          	jalr	-122(ra) # 80000970 <freewalk>
}
    800009f2:	60e2                	ld	ra,24(sp)
    800009f4:	6442                	ld	s0,16(sp)
    800009f6:	64a2                	ld	s1,8(sp)
    800009f8:	6105                	addi	sp,sp,32
    800009fa:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    800009fc:	6605                	lui	a2,0x1
    800009fe:	167d                	addi	a2,a2,-1
    80000a00:	962e                	add	a2,a2,a1
    80000a02:	4685                	li	a3,1
    80000a04:	8231                	srli	a2,a2,0xc
    80000a06:	4581                	li	a1,0
    80000a08:	00000097          	auipc	ra,0x0
    80000a0c:	d0a080e7          	jalr	-758(ra) # 80000712 <uvmunmap>
    80000a10:	bfe1                	j	800009e8 <uvmfree+0xe>

0000000080000a12 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a12:	c679                	beqz	a2,80000ae0 <uvmcopy+0xce>
{
    80000a14:	715d                	addi	sp,sp,-80
    80000a16:	e486                	sd	ra,72(sp)
    80000a18:	e0a2                	sd	s0,64(sp)
    80000a1a:	fc26                	sd	s1,56(sp)
    80000a1c:	f84a                	sd	s2,48(sp)
    80000a1e:	f44e                	sd	s3,40(sp)
    80000a20:	f052                	sd	s4,32(sp)
    80000a22:	ec56                	sd	s5,24(sp)
    80000a24:	e85a                	sd	s6,16(sp)
    80000a26:	e45e                	sd	s7,8(sp)
    80000a28:	0880                	addi	s0,sp,80
    80000a2a:	8b2a                	mv	s6,a0
    80000a2c:	8aae                	mv	s5,a1
    80000a2e:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a30:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000a32:	4601                	li	a2,0
    80000a34:	85ce                	mv	a1,s3
    80000a36:	855a                	mv	a0,s6
    80000a38:	00000097          	auipc	ra,0x0
    80000a3c:	a2c080e7          	jalr	-1492(ra) # 80000464 <walk>
    80000a40:	c531                	beqz	a0,80000a8c <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000a42:	6118                	ld	a4,0(a0)
    80000a44:	00177793          	andi	a5,a4,1
    80000a48:	cbb1                	beqz	a5,80000a9c <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a4a:	00a75593          	srli	a1,a4,0xa
    80000a4e:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a52:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a56:	fffff097          	auipc	ra,0xfffff
    80000a5a:	6c2080e7          	jalr	1730(ra) # 80000118 <kalloc>
    80000a5e:	892a                	mv	s2,a0
    80000a60:	c939                	beqz	a0,80000ab6 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a62:	6605                	lui	a2,0x1
    80000a64:	85de                	mv	a1,s7
    80000a66:	fffff097          	auipc	ra,0xfffff
    80000a6a:	772080e7          	jalr	1906(ra) # 800001d8 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000a6e:	8726                	mv	a4,s1
    80000a70:	86ca                	mv	a3,s2
    80000a72:	6605                	lui	a2,0x1
    80000a74:	85ce                	mv	a1,s3
    80000a76:	8556                	mv	a0,s5
    80000a78:	00000097          	auipc	ra,0x0
    80000a7c:	ad4080e7          	jalr	-1324(ra) # 8000054c <mappages>
    80000a80:	e515                	bnez	a0,80000aac <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000a82:	6785                	lui	a5,0x1
    80000a84:	99be                	add	s3,s3,a5
    80000a86:	fb49e6e3          	bltu	s3,s4,80000a32 <uvmcopy+0x20>
    80000a8a:	a081                	j	80000aca <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000a8c:	00007517          	auipc	a0,0x7
    80000a90:	67c50513          	addi	a0,a0,1660 # 80008108 <etext+0x108>
    80000a94:	00005097          	auipc	ra,0x5
    80000a98:	13e080e7          	jalr	318(ra) # 80005bd2 <panic>
      panic("uvmcopy: page not present");
    80000a9c:	00007517          	auipc	a0,0x7
    80000aa0:	68c50513          	addi	a0,a0,1676 # 80008128 <etext+0x128>
    80000aa4:	00005097          	auipc	ra,0x5
    80000aa8:	12e080e7          	jalr	302(ra) # 80005bd2 <panic>
      kfree(mem);
    80000aac:	854a                	mv	a0,s2
    80000aae:	fffff097          	auipc	ra,0xfffff
    80000ab2:	56e080e7          	jalr	1390(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000ab6:	4685                	li	a3,1
    80000ab8:	00c9d613          	srli	a2,s3,0xc
    80000abc:	4581                	li	a1,0
    80000abe:	8556                	mv	a0,s5
    80000ac0:	00000097          	auipc	ra,0x0
    80000ac4:	c52080e7          	jalr	-942(ra) # 80000712 <uvmunmap>
  return -1;
    80000ac8:	557d                	li	a0,-1
}
    80000aca:	60a6                	ld	ra,72(sp)
    80000acc:	6406                	ld	s0,64(sp)
    80000ace:	74e2                	ld	s1,56(sp)
    80000ad0:	7942                	ld	s2,48(sp)
    80000ad2:	79a2                	ld	s3,40(sp)
    80000ad4:	7a02                	ld	s4,32(sp)
    80000ad6:	6ae2                	ld	s5,24(sp)
    80000ad8:	6b42                	ld	s6,16(sp)
    80000ada:	6ba2                	ld	s7,8(sp)
    80000adc:	6161                	addi	sp,sp,80
    80000ade:	8082                	ret
  return 0;
    80000ae0:	4501                	li	a0,0
}
    80000ae2:	8082                	ret

0000000080000ae4 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000ae4:	1141                	addi	sp,sp,-16
    80000ae6:	e406                	sd	ra,8(sp)
    80000ae8:	e022                	sd	s0,0(sp)
    80000aea:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000aec:	4601                	li	a2,0
    80000aee:	00000097          	auipc	ra,0x0
    80000af2:	976080e7          	jalr	-1674(ra) # 80000464 <walk>
  if(pte == 0)
    80000af6:	c901                	beqz	a0,80000b06 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000af8:	611c                	ld	a5,0(a0)
    80000afa:	9bbd                	andi	a5,a5,-17
    80000afc:	e11c                	sd	a5,0(a0)
}
    80000afe:	60a2                	ld	ra,8(sp)
    80000b00:	6402                	ld	s0,0(sp)
    80000b02:	0141                	addi	sp,sp,16
    80000b04:	8082                	ret
    panic("uvmclear");
    80000b06:	00007517          	auipc	a0,0x7
    80000b0a:	64250513          	addi	a0,a0,1602 # 80008148 <etext+0x148>
    80000b0e:	00005097          	auipc	ra,0x5
    80000b12:	0c4080e7          	jalr	196(ra) # 80005bd2 <panic>

0000000080000b16 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b16:	c6bd                	beqz	a3,80000b84 <copyout+0x6e>
{
    80000b18:	715d                	addi	sp,sp,-80
    80000b1a:	e486                	sd	ra,72(sp)
    80000b1c:	e0a2                	sd	s0,64(sp)
    80000b1e:	fc26                	sd	s1,56(sp)
    80000b20:	f84a                	sd	s2,48(sp)
    80000b22:	f44e                	sd	s3,40(sp)
    80000b24:	f052                	sd	s4,32(sp)
    80000b26:	ec56                	sd	s5,24(sp)
    80000b28:	e85a                	sd	s6,16(sp)
    80000b2a:	e45e                	sd	s7,8(sp)
    80000b2c:	e062                	sd	s8,0(sp)
    80000b2e:	0880                	addi	s0,sp,80
    80000b30:	8b2a                	mv	s6,a0
    80000b32:	8c2e                	mv	s8,a1
    80000b34:	8a32                	mv	s4,a2
    80000b36:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b38:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b3a:	6a85                	lui	s5,0x1
    80000b3c:	a015                	j	80000b60 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b3e:	9562                	add	a0,a0,s8
    80000b40:	0004861b          	sext.w	a2,s1
    80000b44:	85d2                	mv	a1,s4
    80000b46:	41250533          	sub	a0,a0,s2
    80000b4a:	fffff097          	auipc	ra,0xfffff
    80000b4e:	68e080e7          	jalr	1678(ra) # 800001d8 <memmove>

    len -= n;
    80000b52:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b56:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b58:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b5c:	02098263          	beqz	s3,80000b80 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b60:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b64:	85ca                	mv	a1,s2
    80000b66:	855a                	mv	a0,s6
    80000b68:	00000097          	auipc	ra,0x0
    80000b6c:	9a2080e7          	jalr	-1630(ra) # 8000050a <walkaddr>
    if(pa0 == 0)
    80000b70:	cd01                	beqz	a0,80000b88 <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000b72:	418904b3          	sub	s1,s2,s8
    80000b76:	94d6                	add	s1,s1,s5
    if(n > len)
    80000b78:	fc99f3e3          	bgeu	s3,s1,80000b3e <copyout+0x28>
    80000b7c:	84ce                	mv	s1,s3
    80000b7e:	b7c1                	j	80000b3e <copyout+0x28>
  }
  return 0;
    80000b80:	4501                	li	a0,0
    80000b82:	a021                	j	80000b8a <copyout+0x74>
    80000b84:	4501                	li	a0,0
}
    80000b86:	8082                	ret
      return -1;
    80000b88:	557d                	li	a0,-1
}
    80000b8a:	60a6                	ld	ra,72(sp)
    80000b8c:	6406                	ld	s0,64(sp)
    80000b8e:	74e2                	ld	s1,56(sp)
    80000b90:	7942                	ld	s2,48(sp)
    80000b92:	79a2                	ld	s3,40(sp)
    80000b94:	7a02                	ld	s4,32(sp)
    80000b96:	6ae2                	ld	s5,24(sp)
    80000b98:	6b42                	ld	s6,16(sp)
    80000b9a:	6ba2                	ld	s7,8(sp)
    80000b9c:	6c02                	ld	s8,0(sp)
    80000b9e:	6161                	addi	sp,sp,80
    80000ba0:	8082                	ret

0000000080000ba2 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000ba2:	c6bd                	beqz	a3,80000c10 <copyin+0x6e>
{
    80000ba4:	715d                	addi	sp,sp,-80
    80000ba6:	e486                	sd	ra,72(sp)
    80000ba8:	e0a2                	sd	s0,64(sp)
    80000baa:	fc26                	sd	s1,56(sp)
    80000bac:	f84a                	sd	s2,48(sp)
    80000bae:	f44e                	sd	s3,40(sp)
    80000bb0:	f052                	sd	s4,32(sp)
    80000bb2:	ec56                	sd	s5,24(sp)
    80000bb4:	e85a                	sd	s6,16(sp)
    80000bb6:	e45e                	sd	s7,8(sp)
    80000bb8:	e062                	sd	s8,0(sp)
    80000bba:	0880                	addi	s0,sp,80
    80000bbc:	8b2a                	mv	s6,a0
    80000bbe:	8a2e                	mv	s4,a1
    80000bc0:	8c32                	mv	s8,a2
    80000bc2:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000bc4:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bc6:	6a85                	lui	s5,0x1
    80000bc8:	a015                	j	80000bec <copyin+0x4a>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000bca:	9562                	add	a0,a0,s8
    80000bcc:	0004861b          	sext.w	a2,s1
    80000bd0:	412505b3          	sub	a1,a0,s2
    80000bd4:	8552                	mv	a0,s4
    80000bd6:	fffff097          	auipc	ra,0xfffff
    80000bda:	602080e7          	jalr	1538(ra) # 800001d8 <memmove>

    len -= n;
    80000bde:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000be2:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000be4:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000be8:	02098263          	beqz	s3,80000c0c <copyin+0x6a>
    va0 = PGROUNDDOWN(srcva);
    80000bec:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000bf0:	85ca                	mv	a1,s2
    80000bf2:	855a                	mv	a0,s6
    80000bf4:	00000097          	auipc	ra,0x0
    80000bf8:	916080e7          	jalr	-1770(ra) # 8000050a <walkaddr>
    if(pa0 == 0)
    80000bfc:	cd01                	beqz	a0,80000c14 <copyin+0x72>
    n = PGSIZE - (srcva - va0);
    80000bfe:	418904b3          	sub	s1,s2,s8
    80000c02:	94d6                	add	s1,s1,s5
    if(n > len)
    80000c04:	fc99f3e3          	bgeu	s3,s1,80000bca <copyin+0x28>
    80000c08:	84ce                	mv	s1,s3
    80000c0a:	b7c1                	j	80000bca <copyin+0x28>
  }
  return 0;
    80000c0c:	4501                	li	a0,0
    80000c0e:	a021                	j	80000c16 <copyin+0x74>
    80000c10:	4501                	li	a0,0
}
    80000c12:	8082                	ret
      return -1;
    80000c14:	557d                	li	a0,-1
}
    80000c16:	60a6                	ld	ra,72(sp)
    80000c18:	6406                	ld	s0,64(sp)
    80000c1a:	74e2                	ld	s1,56(sp)
    80000c1c:	7942                	ld	s2,48(sp)
    80000c1e:	79a2                	ld	s3,40(sp)
    80000c20:	7a02                	ld	s4,32(sp)
    80000c22:	6ae2                	ld	s5,24(sp)
    80000c24:	6b42                	ld	s6,16(sp)
    80000c26:	6ba2                	ld	s7,8(sp)
    80000c28:	6c02                	ld	s8,0(sp)
    80000c2a:	6161                	addi	sp,sp,80
    80000c2c:	8082                	ret

0000000080000c2e <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c2e:	c6c5                	beqz	a3,80000cd6 <copyinstr+0xa8>
{
    80000c30:	715d                	addi	sp,sp,-80
    80000c32:	e486                	sd	ra,72(sp)
    80000c34:	e0a2                	sd	s0,64(sp)
    80000c36:	fc26                	sd	s1,56(sp)
    80000c38:	f84a                	sd	s2,48(sp)
    80000c3a:	f44e                	sd	s3,40(sp)
    80000c3c:	f052                	sd	s4,32(sp)
    80000c3e:	ec56                	sd	s5,24(sp)
    80000c40:	e85a                	sd	s6,16(sp)
    80000c42:	e45e                	sd	s7,8(sp)
    80000c44:	0880                	addi	s0,sp,80
    80000c46:	8a2a                	mv	s4,a0
    80000c48:	8b2e                	mv	s6,a1
    80000c4a:	8bb2                	mv	s7,a2
    80000c4c:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000c4e:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c50:	6985                	lui	s3,0x1
    80000c52:	a035                	j	80000c7e <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c54:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000c58:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000c5a:	0017b793          	seqz	a5,a5
    80000c5e:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000c62:	60a6                	ld	ra,72(sp)
    80000c64:	6406                	ld	s0,64(sp)
    80000c66:	74e2                	ld	s1,56(sp)
    80000c68:	7942                	ld	s2,48(sp)
    80000c6a:	79a2                	ld	s3,40(sp)
    80000c6c:	7a02                	ld	s4,32(sp)
    80000c6e:	6ae2                	ld	s5,24(sp)
    80000c70:	6b42                	ld	s6,16(sp)
    80000c72:	6ba2                	ld	s7,8(sp)
    80000c74:	6161                	addi	sp,sp,80
    80000c76:	8082                	ret
    srcva = va0 + PGSIZE;
    80000c78:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000c7c:	c8a9                	beqz	s1,80000cce <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80000c7e:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000c82:	85ca                	mv	a1,s2
    80000c84:	8552                	mv	a0,s4
    80000c86:	00000097          	auipc	ra,0x0
    80000c8a:	884080e7          	jalr	-1916(ra) # 8000050a <walkaddr>
    if(pa0 == 0)
    80000c8e:	c131                	beqz	a0,80000cd2 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    80000c90:	41790833          	sub	a6,s2,s7
    80000c94:	984e                	add	a6,a6,s3
    if(n > max)
    80000c96:	0104f363          	bgeu	s1,a6,80000c9c <copyinstr+0x6e>
    80000c9a:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000c9c:	955e                	add	a0,a0,s7
    80000c9e:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000ca2:	fc080be3          	beqz	a6,80000c78 <copyinstr+0x4a>
    80000ca6:	985a                	add	a6,a6,s6
    80000ca8:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000caa:	41650633          	sub	a2,a0,s6
    80000cae:	14fd                	addi	s1,s1,-1
    80000cb0:	9b26                	add	s6,s6,s1
    80000cb2:	00f60733          	add	a4,a2,a5
    80000cb6:	00074703          	lbu	a4,0(a4)
    80000cba:	df49                	beqz	a4,80000c54 <copyinstr+0x26>
        *dst = *p;
    80000cbc:	00e78023          	sb	a4,0(a5)
      --max;
    80000cc0:	40fb04b3          	sub	s1,s6,a5
      dst++;
    80000cc4:	0785                	addi	a5,a5,1
    while(n > 0){
    80000cc6:	ff0796e3          	bne	a5,a6,80000cb2 <copyinstr+0x84>
      dst++;
    80000cca:	8b42                	mv	s6,a6
    80000ccc:	b775                	j	80000c78 <copyinstr+0x4a>
    80000cce:	4781                	li	a5,0
    80000cd0:	b769                	j	80000c5a <copyinstr+0x2c>
      return -1;
    80000cd2:	557d                	li	a0,-1
    80000cd4:	b779                	j	80000c62 <copyinstr+0x34>
  int got_null = 0;
    80000cd6:	4781                	li	a5,0
  if(got_null){
    80000cd8:	0017b793          	seqz	a5,a5
    80000cdc:	40f00533          	neg	a0,a5
}
    80000ce0:	8082                	ret

0000000080000ce2 <proc_mapstacks>:
// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl)
{
    80000ce2:	7139                	addi	sp,sp,-64
    80000ce4:	fc06                	sd	ra,56(sp)
    80000ce6:	f822                	sd	s0,48(sp)
    80000ce8:	f426                	sd	s1,40(sp)
    80000cea:	f04a                	sd	s2,32(sp)
    80000cec:	ec4e                	sd	s3,24(sp)
    80000cee:	e852                	sd	s4,16(sp)
    80000cf0:	e456                	sd	s5,8(sp)
    80000cf2:	e05a                	sd	s6,0(sp)
    80000cf4:	0080                	addi	s0,sp,64
    80000cf6:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000cf8:	00008497          	auipc	s1,0x8
    80000cfc:	01848493          	addi	s1,s1,24 # 80008d10 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000d00:	8b26                	mv	s6,s1
    80000d02:	00007a97          	auipc	s5,0x7
    80000d06:	2fea8a93          	addi	s5,s5,766 # 80008000 <etext>
    80000d0a:	04000937          	lui	s2,0x4000
    80000d0e:	197d                	addi	s2,s2,-1
    80000d10:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d12:	0000ea17          	auipc	s4,0xe
    80000d16:	9fea0a13          	addi	s4,s4,-1538 # 8000e710 <tickslock>
    char *pa = kalloc();
    80000d1a:	fffff097          	auipc	ra,0xfffff
    80000d1e:	3fe080e7          	jalr	1022(ra) # 80000118 <kalloc>
    80000d22:	862a                	mv	a2,a0
    if(pa == 0)
    80000d24:	c131                	beqz	a0,80000d68 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000d26:	416485b3          	sub	a1,s1,s6
    80000d2a:	858d                	srai	a1,a1,0x3
    80000d2c:	000ab783          	ld	a5,0(s5)
    80000d30:	02f585b3          	mul	a1,a1,a5
    80000d34:	2585                	addiw	a1,a1,1
    80000d36:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d3a:	4719                	li	a4,6
    80000d3c:	6685                	lui	a3,0x1
    80000d3e:	40b905b3          	sub	a1,s2,a1
    80000d42:	854e                	mv	a0,s3
    80000d44:	00000097          	auipc	ra,0x0
    80000d48:	8a8080e7          	jalr	-1880(ra) # 800005ec <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d4c:	16848493          	addi	s1,s1,360
    80000d50:	fd4495e3          	bne	s1,s4,80000d1a <proc_mapstacks+0x38>
  }
}
    80000d54:	70e2                	ld	ra,56(sp)
    80000d56:	7442                	ld	s0,48(sp)
    80000d58:	74a2                	ld	s1,40(sp)
    80000d5a:	7902                	ld	s2,32(sp)
    80000d5c:	69e2                	ld	s3,24(sp)
    80000d5e:	6a42                	ld	s4,16(sp)
    80000d60:	6aa2                	ld	s5,8(sp)
    80000d62:	6b02                	ld	s6,0(sp)
    80000d64:	6121                	addi	sp,sp,64
    80000d66:	8082                	ret
      panic("kalloc");
    80000d68:	00007517          	auipc	a0,0x7
    80000d6c:	3f050513          	addi	a0,a0,1008 # 80008158 <etext+0x158>
    80000d70:	00005097          	auipc	ra,0x5
    80000d74:	e62080e7          	jalr	-414(ra) # 80005bd2 <panic>

0000000080000d78 <procinit>:

// initialize the proc table.
void
procinit(void)
{
    80000d78:	7139                	addi	sp,sp,-64
    80000d7a:	fc06                	sd	ra,56(sp)
    80000d7c:	f822                	sd	s0,48(sp)
    80000d7e:	f426                	sd	s1,40(sp)
    80000d80:	f04a                	sd	s2,32(sp)
    80000d82:	ec4e                	sd	s3,24(sp)
    80000d84:	e852                	sd	s4,16(sp)
    80000d86:	e456                	sd	s5,8(sp)
    80000d88:	e05a                	sd	s6,0(sp)
    80000d8a:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000d8c:	00007597          	auipc	a1,0x7
    80000d90:	3d458593          	addi	a1,a1,980 # 80008160 <etext+0x160>
    80000d94:	00008517          	auipc	a0,0x8
    80000d98:	b4c50513          	addi	a0,a0,-1204 # 800088e0 <pid_lock>
    80000d9c:	00005097          	auipc	ra,0x5
    80000da0:	2f0080e7          	jalr	752(ra) # 8000608c <initlock>
  initlock(&wait_lock, "wait_lock");
    80000da4:	00007597          	auipc	a1,0x7
    80000da8:	3c458593          	addi	a1,a1,964 # 80008168 <etext+0x168>
    80000dac:	00008517          	auipc	a0,0x8
    80000db0:	b4c50513          	addi	a0,a0,-1204 # 800088f8 <wait_lock>
    80000db4:	00005097          	auipc	ra,0x5
    80000db8:	2d8080e7          	jalr	728(ra) # 8000608c <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dbc:	00008497          	auipc	s1,0x8
    80000dc0:	f5448493          	addi	s1,s1,-172 # 80008d10 <proc>
      initlock(&p->lock, "proc");
    80000dc4:	00007b17          	auipc	s6,0x7
    80000dc8:	3b4b0b13          	addi	s6,s6,948 # 80008178 <etext+0x178>
      p->state = UNUSED;
      p->kstack = KSTACK((int) (p - proc));
    80000dcc:	8aa6                	mv	s5,s1
    80000dce:	00007a17          	auipc	s4,0x7
    80000dd2:	232a0a13          	addi	s4,s4,562 # 80008000 <etext>
    80000dd6:	04000937          	lui	s2,0x4000
    80000dda:	197d                	addi	s2,s2,-1
    80000ddc:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dde:	0000e997          	auipc	s3,0xe
    80000de2:	93298993          	addi	s3,s3,-1742 # 8000e710 <tickslock>
      initlock(&p->lock, "proc");
    80000de6:	85da                	mv	a1,s6
    80000de8:	8526                	mv	a0,s1
    80000dea:	00005097          	auipc	ra,0x5
    80000dee:	2a2080e7          	jalr	674(ra) # 8000608c <initlock>
      p->state = UNUSED;
    80000df2:	0004ac23          	sw	zero,24(s1)
      p->kstack = KSTACK((int) (p - proc));
    80000df6:	415487b3          	sub	a5,s1,s5
    80000dfa:	878d                	srai	a5,a5,0x3
    80000dfc:	000a3703          	ld	a4,0(s4)
    80000e00:	02e787b3          	mul	a5,a5,a4
    80000e04:	2785                	addiw	a5,a5,1
    80000e06:	00d7979b          	slliw	a5,a5,0xd
    80000e0a:	40f907b3          	sub	a5,s2,a5
    80000e0e:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000e10:	16848493          	addi	s1,s1,360
    80000e14:	fd3499e3          	bne	s1,s3,80000de6 <procinit+0x6e>
  }
}
    80000e18:	70e2                	ld	ra,56(sp)
    80000e1a:	7442                	ld	s0,48(sp)
    80000e1c:	74a2                	ld	s1,40(sp)
    80000e1e:	7902                	ld	s2,32(sp)
    80000e20:	69e2                	ld	s3,24(sp)
    80000e22:	6a42                	ld	s4,16(sp)
    80000e24:	6aa2                	ld	s5,8(sp)
    80000e26:	6b02                	ld	s6,0(sp)
    80000e28:	6121                	addi	sp,sp,64
    80000e2a:	8082                	ret

0000000080000e2c <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000e2c:	1141                	addi	sp,sp,-16
    80000e2e:	e422                	sd	s0,8(sp)
    80000e30:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000e32:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000e34:	2501                	sext.w	a0,a0
    80000e36:	6422                	ld	s0,8(sp)
    80000e38:	0141                	addi	sp,sp,16
    80000e3a:	8082                	ret

0000000080000e3c <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void)
{
    80000e3c:	1141                	addi	sp,sp,-16
    80000e3e:	e422                	sd	s0,8(sp)
    80000e40:	0800                	addi	s0,sp,16
    80000e42:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000e44:	2781                	sext.w	a5,a5
    80000e46:	079e                	slli	a5,a5,0x7
  return c;
}
    80000e48:	00008517          	auipc	a0,0x8
    80000e4c:	ac850513          	addi	a0,a0,-1336 # 80008910 <cpus>
    80000e50:	953e                	add	a0,a0,a5
    80000e52:	6422                	ld	s0,8(sp)
    80000e54:	0141                	addi	sp,sp,16
    80000e56:	8082                	ret

0000000080000e58 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void)
{
    80000e58:	1101                	addi	sp,sp,-32
    80000e5a:	ec06                	sd	ra,24(sp)
    80000e5c:	e822                	sd	s0,16(sp)
    80000e5e:	e426                	sd	s1,8(sp)
    80000e60:	1000                	addi	s0,sp,32
  push_off();
    80000e62:	00005097          	auipc	ra,0x5
    80000e66:	26e080e7          	jalr	622(ra) # 800060d0 <push_off>
    80000e6a:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000e6c:	2781                	sext.w	a5,a5
    80000e6e:	079e                	slli	a5,a5,0x7
    80000e70:	00008717          	auipc	a4,0x8
    80000e74:	a7070713          	addi	a4,a4,-1424 # 800088e0 <pid_lock>
    80000e78:	97ba                	add	a5,a5,a4
    80000e7a:	7b84                	ld	s1,48(a5)
  pop_off();
    80000e7c:	00005097          	auipc	ra,0x5
    80000e80:	2f4080e7          	jalr	756(ra) # 80006170 <pop_off>
  return p;
}
    80000e84:	8526                	mv	a0,s1
    80000e86:	60e2                	ld	ra,24(sp)
    80000e88:	6442                	ld	s0,16(sp)
    80000e8a:	64a2                	ld	s1,8(sp)
    80000e8c:	6105                	addi	sp,sp,32
    80000e8e:	8082                	ret

0000000080000e90 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000e90:	1141                	addi	sp,sp,-16
    80000e92:	e406                	sd	ra,8(sp)
    80000e94:	e022                	sd	s0,0(sp)
    80000e96:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000e98:	00000097          	auipc	ra,0x0
    80000e9c:	fc0080e7          	jalr	-64(ra) # 80000e58 <myproc>
    80000ea0:	00005097          	auipc	ra,0x5
    80000ea4:	330080e7          	jalr	816(ra) # 800061d0 <release>

  if (first) {
    80000ea8:	00008797          	auipc	a5,0x8
    80000eac:	9987a783          	lw	a5,-1640(a5) # 80008840 <first.1678>
    80000eb0:	eb89                	bnez	a5,80000ec2 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000eb2:	00001097          	auipc	ra,0x1
    80000eb6:	c56080e7          	jalr	-938(ra) # 80001b08 <usertrapret>
}
    80000eba:	60a2                	ld	ra,8(sp)
    80000ebc:	6402                	ld	s0,0(sp)
    80000ebe:	0141                	addi	sp,sp,16
    80000ec0:	8082                	ret
    first = 0;
    80000ec2:	00008797          	auipc	a5,0x8
    80000ec6:	9607af23          	sw	zero,-1666(a5) # 80008840 <first.1678>
    fsinit(ROOTDEV);
    80000eca:	4505                	li	a0,1
    80000ecc:	00002097          	auipc	ra,0x2
    80000ed0:	98c080e7          	jalr	-1652(ra) # 80002858 <fsinit>
    80000ed4:	bff9                	j	80000eb2 <forkret+0x22>

0000000080000ed6 <allocpid>:
{
    80000ed6:	1101                	addi	sp,sp,-32
    80000ed8:	ec06                	sd	ra,24(sp)
    80000eda:	e822                	sd	s0,16(sp)
    80000edc:	e426                	sd	s1,8(sp)
    80000ede:	e04a                	sd	s2,0(sp)
    80000ee0:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000ee2:	00008917          	auipc	s2,0x8
    80000ee6:	9fe90913          	addi	s2,s2,-1538 # 800088e0 <pid_lock>
    80000eea:	854a                	mv	a0,s2
    80000eec:	00005097          	auipc	ra,0x5
    80000ef0:	230080e7          	jalr	560(ra) # 8000611c <acquire>
  pid = nextpid;
    80000ef4:	00008797          	auipc	a5,0x8
    80000ef8:	95078793          	addi	a5,a5,-1712 # 80008844 <nextpid>
    80000efc:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000efe:	0014871b          	addiw	a4,s1,1
    80000f02:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000f04:	854a                	mv	a0,s2
    80000f06:	00005097          	auipc	ra,0x5
    80000f0a:	2ca080e7          	jalr	714(ra) # 800061d0 <release>
}
    80000f0e:	8526                	mv	a0,s1
    80000f10:	60e2                	ld	ra,24(sp)
    80000f12:	6442                	ld	s0,16(sp)
    80000f14:	64a2                	ld	s1,8(sp)
    80000f16:	6902                	ld	s2,0(sp)
    80000f18:	6105                	addi	sp,sp,32
    80000f1a:	8082                	ret

0000000080000f1c <proc_pagetable>:
{
    80000f1c:	1101                	addi	sp,sp,-32
    80000f1e:	ec06                	sd	ra,24(sp)
    80000f20:	e822                	sd	s0,16(sp)
    80000f22:	e426                	sd	s1,8(sp)
    80000f24:	e04a                	sd	s2,0(sp)
    80000f26:	1000                	addi	s0,sp,32
    80000f28:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000f2a:	00000097          	auipc	ra,0x0
    80000f2e:	8ac080e7          	jalr	-1876(ra) # 800007d6 <uvmcreate>
    80000f32:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000f34:	c121                	beqz	a0,80000f74 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000f36:	4729                	li	a4,10
    80000f38:	00006697          	auipc	a3,0x6
    80000f3c:	0c868693          	addi	a3,a3,200 # 80007000 <_trampoline>
    80000f40:	6605                	lui	a2,0x1
    80000f42:	040005b7          	lui	a1,0x4000
    80000f46:	15fd                	addi	a1,a1,-1
    80000f48:	05b2                	slli	a1,a1,0xc
    80000f4a:	fffff097          	auipc	ra,0xfffff
    80000f4e:	602080e7          	jalr	1538(ra) # 8000054c <mappages>
    80000f52:	02054863          	bltz	a0,80000f82 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000f56:	4719                	li	a4,6
    80000f58:	05893683          	ld	a3,88(s2)
    80000f5c:	6605                	lui	a2,0x1
    80000f5e:	020005b7          	lui	a1,0x2000
    80000f62:	15fd                	addi	a1,a1,-1
    80000f64:	05b6                	slli	a1,a1,0xd
    80000f66:	8526                	mv	a0,s1
    80000f68:	fffff097          	auipc	ra,0xfffff
    80000f6c:	5e4080e7          	jalr	1508(ra) # 8000054c <mappages>
    80000f70:	02054163          	bltz	a0,80000f92 <proc_pagetable+0x76>
}
    80000f74:	8526                	mv	a0,s1
    80000f76:	60e2                	ld	ra,24(sp)
    80000f78:	6442                	ld	s0,16(sp)
    80000f7a:	64a2                	ld	s1,8(sp)
    80000f7c:	6902                	ld	s2,0(sp)
    80000f7e:	6105                	addi	sp,sp,32
    80000f80:	8082                	ret
    uvmfree(pagetable, 0);
    80000f82:	4581                	li	a1,0
    80000f84:	8526                	mv	a0,s1
    80000f86:	00000097          	auipc	ra,0x0
    80000f8a:	a54080e7          	jalr	-1452(ra) # 800009da <uvmfree>
    return 0;
    80000f8e:	4481                	li	s1,0
    80000f90:	b7d5                	j	80000f74 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000f92:	4681                	li	a3,0
    80000f94:	4605                	li	a2,1
    80000f96:	040005b7          	lui	a1,0x4000
    80000f9a:	15fd                	addi	a1,a1,-1
    80000f9c:	05b2                	slli	a1,a1,0xc
    80000f9e:	8526                	mv	a0,s1
    80000fa0:	fffff097          	auipc	ra,0xfffff
    80000fa4:	772080e7          	jalr	1906(ra) # 80000712 <uvmunmap>
    uvmfree(pagetable, 0);
    80000fa8:	4581                	li	a1,0
    80000faa:	8526                	mv	a0,s1
    80000fac:	00000097          	auipc	ra,0x0
    80000fb0:	a2e080e7          	jalr	-1490(ra) # 800009da <uvmfree>
    return 0;
    80000fb4:	4481                	li	s1,0
    80000fb6:	bf7d                	j	80000f74 <proc_pagetable+0x58>

0000000080000fb8 <proc_freepagetable>:
{
    80000fb8:	1101                	addi	sp,sp,-32
    80000fba:	ec06                	sd	ra,24(sp)
    80000fbc:	e822                	sd	s0,16(sp)
    80000fbe:	e426                	sd	s1,8(sp)
    80000fc0:	e04a                	sd	s2,0(sp)
    80000fc2:	1000                	addi	s0,sp,32
    80000fc4:	84aa                	mv	s1,a0
    80000fc6:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000fc8:	4681                	li	a3,0
    80000fca:	4605                	li	a2,1
    80000fcc:	040005b7          	lui	a1,0x4000
    80000fd0:	15fd                	addi	a1,a1,-1
    80000fd2:	05b2                	slli	a1,a1,0xc
    80000fd4:	fffff097          	auipc	ra,0xfffff
    80000fd8:	73e080e7          	jalr	1854(ra) # 80000712 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000fdc:	4681                	li	a3,0
    80000fde:	4605                	li	a2,1
    80000fe0:	020005b7          	lui	a1,0x2000
    80000fe4:	15fd                	addi	a1,a1,-1
    80000fe6:	05b6                	slli	a1,a1,0xd
    80000fe8:	8526                	mv	a0,s1
    80000fea:	fffff097          	auipc	ra,0xfffff
    80000fee:	728080e7          	jalr	1832(ra) # 80000712 <uvmunmap>
  uvmfree(pagetable, sz);
    80000ff2:	85ca                	mv	a1,s2
    80000ff4:	8526                	mv	a0,s1
    80000ff6:	00000097          	auipc	ra,0x0
    80000ffa:	9e4080e7          	jalr	-1564(ra) # 800009da <uvmfree>
}
    80000ffe:	60e2                	ld	ra,24(sp)
    80001000:	6442                	ld	s0,16(sp)
    80001002:	64a2                	ld	s1,8(sp)
    80001004:	6902                	ld	s2,0(sp)
    80001006:	6105                	addi	sp,sp,32
    80001008:	8082                	ret

000000008000100a <freeproc>:
{
    8000100a:	1101                	addi	sp,sp,-32
    8000100c:	ec06                	sd	ra,24(sp)
    8000100e:	e822                	sd	s0,16(sp)
    80001010:	e426                	sd	s1,8(sp)
    80001012:	1000                	addi	s0,sp,32
    80001014:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001016:	6d28                	ld	a0,88(a0)
    80001018:	c509                	beqz	a0,80001022 <freeproc+0x18>
    kfree((void*)p->trapframe);
    8000101a:	fffff097          	auipc	ra,0xfffff
    8000101e:	002080e7          	jalr	2(ra) # 8000001c <kfree>
  p->trapframe = 0;
    80001022:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001026:	68a8                	ld	a0,80(s1)
    80001028:	c511                	beqz	a0,80001034 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    8000102a:	64ac                	ld	a1,72(s1)
    8000102c:	00000097          	auipc	ra,0x0
    80001030:	f8c080e7          	jalr	-116(ra) # 80000fb8 <proc_freepagetable>
  p->pagetable = 0;
    80001034:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001038:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    8000103c:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001040:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001044:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001048:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    8000104c:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001050:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001054:	0004ac23          	sw	zero,24(s1)
}
    80001058:	60e2                	ld	ra,24(sp)
    8000105a:	6442                	ld	s0,16(sp)
    8000105c:	64a2                	ld	s1,8(sp)
    8000105e:	6105                	addi	sp,sp,32
    80001060:	8082                	ret

0000000080001062 <allocproc>:
{
    80001062:	1101                	addi	sp,sp,-32
    80001064:	ec06                	sd	ra,24(sp)
    80001066:	e822                	sd	s0,16(sp)
    80001068:	e426                	sd	s1,8(sp)
    8000106a:	e04a                	sd	s2,0(sp)
    8000106c:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    8000106e:	00008497          	auipc	s1,0x8
    80001072:	ca248493          	addi	s1,s1,-862 # 80008d10 <proc>
    80001076:	0000d917          	auipc	s2,0xd
    8000107a:	69a90913          	addi	s2,s2,1690 # 8000e710 <tickslock>
    acquire(&p->lock);
    8000107e:	8526                	mv	a0,s1
    80001080:	00005097          	auipc	ra,0x5
    80001084:	09c080e7          	jalr	156(ra) # 8000611c <acquire>
    if(p->state == UNUSED) {
    80001088:	4c9c                	lw	a5,24(s1)
    8000108a:	cf81                	beqz	a5,800010a2 <allocproc+0x40>
      release(&p->lock);
    8000108c:	8526                	mv	a0,s1
    8000108e:	00005097          	auipc	ra,0x5
    80001092:	142080e7          	jalr	322(ra) # 800061d0 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001096:	16848493          	addi	s1,s1,360
    8000109a:	ff2492e3          	bne	s1,s2,8000107e <allocproc+0x1c>
  return 0;
    8000109e:	4481                	li	s1,0
    800010a0:	a889                	j	800010f2 <allocproc+0x90>
  p->pid = allocpid();
    800010a2:	00000097          	auipc	ra,0x0
    800010a6:	e34080e7          	jalr	-460(ra) # 80000ed6 <allocpid>
    800010aa:	d888                	sw	a0,48(s1)
  p->state = USED;
    800010ac:	4785                	li	a5,1
    800010ae:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    800010b0:	fffff097          	auipc	ra,0xfffff
    800010b4:	068080e7          	jalr	104(ra) # 80000118 <kalloc>
    800010b8:	892a                	mv	s2,a0
    800010ba:	eca8                	sd	a0,88(s1)
    800010bc:	c131                	beqz	a0,80001100 <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    800010be:	8526                	mv	a0,s1
    800010c0:	00000097          	auipc	ra,0x0
    800010c4:	e5c080e7          	jalr	-420(ra) # 80000f1c <proc_pagetable>
    800010c8:	892a                	mv	s2,a0
    800010ca:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800010cc:	c531                	beqz	a0,80001118 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    800010ce:	07000613          	li	a2,112
    800010d2:	4581                	li	a1,0
    800010d4:	06048513          	addi	a0,s1,96
    800010d8:	fffff097          	auipc	ra,0xfffff
    800010dc:	0a0080e7          	jalr	160(ra) # 80000178 <memset>
  p->context.ra = (uint64)forkret;
    800010e0:	00000797          	auipc	a5,0x0
    800010e4:	db078793          	addi	a5,a5,-592 # 80000e90 <forkret>
    800010e8:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800010ea:	60bc                	ld	a5,64(s1)
    800010ec:	6705                	lui	a4,0x1
    800010ee:	97ba                	add	a5,a5,a4
    800010f0:	f4bc                	sd	a5,104(s1)
}
    800010f2:	8526                	mv	a0,s1
    800010f4:	60e2                	ld	ra,24(sp)
    800010f6:	6442                	ld	s0,16(sp)
    800010f8:	64a2                	ld	s1,8(sp)
    800010fa:	6902                	ld	s2,0(sp)
    800010fc:	6105                	addi	sp,sp,32
    800010fe:	8082                	ret
    freeproc(p);
    80001100:	8526                	mv	a0,s1
    80001102:	00000097          	auipc	ra,0x0
    80001106:	f08080e7          	jalr	-248(ra) # 8000100a <freeproc>
    release(&p->lock);
    8000110a:	8526                	mv	a0,s1
    8000110c:	00005097          	auipc	ra,0x5
    80001110:	0c4080e7          	jalr	196(ra) # 800061d0 <release>
    return 0;
    80001114:	84ca                	mv	s1,s2
    80001116:	bff1                	j	800010f2 <allocproc+0x90>
    freeproc(p);
    80001118:	8526                	mv	a0,s1
    8000111a:	00000097          	auipc	ra,0x0
    8000111e:	ef0080e7          	jalr	-272(ra) # 8000100a <freeproc>
    release(&p->lock);
    80001122:	8526                	mv	a0,s1
    80001124:	00005097          	auipc	ra,0x5
    80001128:	0ac080e7          	jalr	172(ra) # 800061d0 <release>
    return 0;
    8000112c:	84ca                	mv	s1,s2
    8000112e:	b7d1                	j	800010f2 <allocproc+0x90>

0000000080001130 <userinit>:
{
    80001130:	1101                	addi	sp,sp,-32
    80001132:	ec06                	sd	ra,24(sp)
    80001134:	e822                	sd	s0,16(sp)
    80001136:	e426                	sd	s1,8(sp)
    80001138:	1000                	addi	s0,sp,32
  p = allocproc();
    8000113a:	00000097          	auipc	ra,0x0
    8000113e:	f28080e7          	jalr	-216(ra) # 80001062 <allocproc>
    80001142:	84aa                	mv	s1,a0
  initproc = p;
    80001144:	00007797          	auipc	a5,0x7
    80001148:	74a7be23          	sd	a0,1884(a5) # 800088a0 <initproc>
  uvmfirst(p->pagetable, initcode, sizeof(initcode));
    8000114c:	03400613          	li	a2,52
    80001150:	00007597          	auipc	a1,0x7
    80001154:	70058593          	addi	a1,a1,1792 # 80008850 <initcode>
    80001158:	6928                	ld	a0,80(a0)
    8000115a:	fffff097          	auipc	ra,0xfffff
    8000115e:	6aa080e7          	jalr	1706(ra) # 80000804 <uvmfirst>
  p->sz = PGSIZE;
    80001162:	6785                	lui	a5,0x1
    80001164:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001166:	6cb8                	ld	a4,88(s1)
    80001168:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    8000116c:	6cb8                	ld	a4,88(s1)
    8000116e:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001170:	4641                	li	a2,16
    80001172:	00007597          	auipc	a1,0x7
    80001176:	00e58593          	addi	a1,a1,14 # 80008180 <etext+0x180>
    8000117a:	15848513          	addi	a0,s1,344
    8000117e:	fffff097          	auipc	ra,0xfffff
    80001182:	14c080e7          	jalr	332(ra) # 800002ca <safestrcpy>
  p->cwd = namei("/");
    80001186:	00007517          	auipc	a0,0x7
    8000118a:	00a50513          	addi	a0,a0,10 # 80008190 <etext+0x190>
    8000118e:	00002097          	auipc	ra,0x2
    80001192:	0ec080e7          	jalr	236(ra) # 8000327a <namei>
    80001196:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    8000119a:	478d                	li	a5,3
    8000119c:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000119e:	8526                	mv	a0,s1
    800011a0:	00005097          	auipc	ra,0x5
    800011a4:	030080e7          	jalr	48(ra) # 800061d0 <release>
}
    800011a8:	60e2                	ld	ra,24(sp)
    800011aa:	6442                	ld	s0,16(sp)
    800011ac:	64a2                	ld	s1,8(sp)
    800011ae:	6105                	addi	sp,sp,32
    800011b0:	8082                	ret

00000000800011b2 <growproc>:
{
    800011b2:	1101                	addi	sp,sp,-32
    800011b4:	ec06                	sd	ra,24(sp)
    800011b6:	e822                	sd	s0,16(sp)
    800011b8:	e426                	sd	s1,8(sp)
    800011ba:	e04a                	sd	s2,0(sp)
    800011bc:	1000                	addi	s0,sp,32
    800011be:	892a                	mv	s2,a0
  struct proc *p = myproc();
    800011c0:	00000097          	auipc	ra,0x0
    800011c4:	c98080e7          	jalr	-872(ra) # 80000e58 <myproc>
    800011c8:	84aa                	mv	s1,a0
  sz = p->sz;
    800011ca:	652c                	ld	a1,72(a0)
  if(n > 0){
    800011cc:	01204c63          	bgtz	s2,800011e4 <growproc+0x32>
  } else if(n < 0){
    800011d0:	02094663          	bltz	s2,800011fc <growproc+0x4a>
  p->sz = sz;
    800011d4:	e4ac                	sd	a1,72(s1)
  return 0;
    800011d6:	4501                	li	a0,0
}
    800011d8:	60e2                	ld	ra,24(sp)
    800011da:	6442                	ld	s0,16(sp)
    800011dc:	64a2                	ld	s1,8(sp)
    800011de:	6902                	ld	s2,0(sp)
    800011e0:	6105                	addi	sp,sp,32
    800011e2:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n, PTE_W)) == 0) {
    800011e4:	4691                	li	a3,4
    800011e6:	00b90633          	add	a2,s2,a1
    800011ea:	6928                	ld	a0,80(a0)
    800011ec:	fffff097          	auipc	ra,0xfffff
    800011f0:	6d2080e7          	jalr	1746(ra) # 800008be <uvmalloc>
    800011f4:	85aa                	mv	a1,a0
    800011f6:	fd79                	bnez	a0,800011d4 <growproc+0x22>
      return -1;
    800011f8:	557d                	li	a0,-1
    800011fa:	bff9                	j	800011d8 <growproc+0x26>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800011fc:	00b90633          	add	a2,s2,a1
    80001200:	6928                	ld	a0,80(a0)
    80001202:	fffff097          	auipc	ra,0xfffff
    80001206:	674080e7          	jalr	1652(ra) # 80000876 <uvmdealloc>
    8000120a:	85aa                	mv	a1,a0
    8000120c:	b7e1                	j	800011d4 <growproc+0x22>

000000008000120e <fork>:
{
    8000120e:	7179                	addi	sp,sp,-48
    80001210:	f406                	sd	ra,40(sp)
    80001212:	f022                	sd	s0,32(sp)
    80001214:	ec26                	sd	s1,24(sp)
    80001216:	e84a                	sd	s2,16(sp)
    80001218:	e44e                	sd	s3,8(sp)
    8000121a:	e052                	sd	s4,0(sp)
    8000121c:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    8000121e:	00000097          	auipc	ra,0x0
    80001222:	c3a080e7          	jalr	-966(ra) # 80000e58 <myproc>
    80001226:	892a                	mv	s2,a0
  if((np = allocproc()) == 0){
    80001228:	00000097          	auipc	ra,0x0
    8000122c:	e3a080e7          	jalr	-454(ra) # 80001062 <allocproc>
    80001230:	10050b63          	beqz	a0,80001346 <fork+0x138>
    80001234:	89aa                	mv	s3,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001236:	04893603          	ld	a2,72(s2)
    8000123a:	692c                	ld	a1,80(a0)
    8000123c:	05093503          	ld	a0,80(s2)
    80001240:	fffff097          	auipc	ra,0xfffff
    80001244:	7d2080e7          	jalr	2002(ra) # 80000a12 <uvmcopy>
    80001248:	04054663          	bltz	a0,80001294 <fork+0x86>
  np->sz = p->sz;
    8000124c:	04893783          	ld	a5,72(s2)
    80001250:	04f9b423          	sd	a5,72(s3)
  *(np->trapframe) = *(p->trapframe);
    80001254:	05893683          	ld	a3,88(s2)
    80001258:	87b6                	mv	a5,a3
    8000125a:	0589b703          	ld	a4,88(s3)
    8000125e:	12068693          	addi	a3,a3,288
    80001262:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001266:	6788                	ld	a0,8(a5)
    80001268:	6b8c                	ld	a1,16(a5)
    8000126a:	6f90                	ld	a2,24(a5)
    8000126c:	01073023          	sd	a6,0(a4)
    80001270:	e708                	sd	a0,8(a4)
    80001272:	eb0c                	sd	a1,16(a4)
    80001274:	ef10                	sd	a2,24(a4)
    80001276:	02078793          	addi	a5,a5,32
    8000127a:	02070713          	addi	a4,a4,32
    8000127e:	fed792e3          	bne	a5,a3,80001262 <fork+0x54>
  np->trapframe->a0 = 0;
    80001282:	0589b783          	ld	a5,88(s3)
    80001286:	0607b823          	sd	zero,112(a5)
    8000128a:	0d000493          	li	s1,208
  for(i = 0; i < NOFILE; i++)
    8000128e:	15000a13          	li	s4,336
    80001292:	a03d                	j	800012c0 <fork+0xb2>
    freeproc(np);
    80001294:	854e                	mv	a0,s3
    80001296:	00000097          	auipc	ra,0x0
    8000129a:	d74080e7          	jalr	-652(ra) # 8000100a <freeproc>
    release(&np->lock);
    8000129e:	854e                	mv	a0,s3
    800012a0:	00005097          	auipc	ra,0x5
    800012a4:	f30080e7          	jalr	-208(ra) # 800061d0 <release>
    return -1;
    800012a8:	5a7d                	li	s4,-1
    800012aa:	a069                	j	80001334 <fork+0x126>
      np->ofile[i] = filedup(p->ofile[i]);
    800012ac:	00002097          	auipc	ra,0x2
    800012b0:	664080e7          	jalr	1636(ra) # 80003910 <filedup>
    800012b4:	009987b3          	add	a5,s3,s1
    800012b8:	e388                	sd	a0,0(a5)
  for(i = 0; i < NOFILE; i++)
    800012ba:	04a1                	addi	s1,s1,8
    800012bc:	01448763          	beq	s1,s4,800012ca <fork+0xbc>
    if(p->ofile[i])
    800012c0:	009907b3          	add	a5,s2,s1
    800012c4:	6388                	ld	a0,0(a5)
    800012c6:	f17d                	bnez	a0,800012ac <fork+0x9e>
    800012c8:	bfcd                	j	800012ba <fork+0xac>
  np->cwd = idup(p->cwd);
    800012ca:	15093503          	ld	a0,336(s2)
    800012ce:	00001097          	auipc	ra,0x1
    800012d2:	7c8080e7          	jalr	1992(ra) # 80002a96 <idup>
    800012d6:	14a9b823          	sd	a0,336(s3)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800012da:	4641                	li	a2,16
    800012dc:	15890593          	addi	a1,s2,344
    800012e0:	15898513          	addi	a0,s3,344
    800012e4:	fffff097          	auipc	ra,0xfffff
    800012e8:	fe6080e7          	jalr	-26(ra) # 800002ca <safestrcpy>
  pid = np->pid;
    800012ec:	0309aa03          	lw	s4,48(s3)
  release(&np->lock);
    800012f0:	854e                	mv	a0,s3
    800012f2:	00005097          	auipc	ra,0x5
    800012f6:	ede080e7          	jalr	-290(ra) # 800061d0 <release>
  acquire(&wait_lock);
    800012fa:	00007497          	auipc	s1,0x7
    800012fe:	5fe48493          	addi	s1,s1,1534 # 800088f8 <wait_lock>
    80001302:	8526                	mv	a0,s1
    80001304:	00005097          	auipc	ra,0x5
    80001308:	e18080e7          	jalr	-488(ra) # 8000611c <acquire>
  np->parent = p;
    8000130c:	0329bc23          	sd	s2,56(s3)
  release(&wait_lock);
    80001310:	8526                	mv	a0,s1
    80001312:	00005097          	auipc	ra,0x5
    80001316:	ebe080e7          	jalr	-322(ra) # 800061d0 <release>
  acquire(&np->lock);
    8000131a:	854e                	mv	a0,s3
    8000131c:	00005097          	auipc	ra,0x5
    80001320:	e00080e7          	jalr	-512(ra) # 8000611c <acquire>
  np->state = RUNNABLE;
    80001324:	478d                	li	a5,3
    80001326:	00f9ac23          	sw	a5,24(s3)
  release(&np->lock);
    8000132a:	854e                	mv	a0,s3
    8000132c:	00005097          	auipc	ra,0x5
    80001330:	ea4080e7          	jalr	-348(ra) # 800061d0 <release>
}
    80001334:	8552                	mv	a0,s4
    80001336:	70a2                	ld	ra,40(sp)
    80001338:	7402                	ld	s0,32(sp)
    8000133a:	64e2                	ld	s1,24(sp)
    8000133c:	6942                	ld	s2,16(sp)
    8000133e:	69a2                	ld	s3,8(sp)
    80001340:	6a02                	ld	s4,0(sp)
    80001342:	6145                	addi	sp,sp,48
    80001344:	8082                	ret
    return -1;
    80001346:	5a7d                	li	s4,-1
    80001348:	b7f5                	j	80001334 <fork+0x126>

000000008000134a <scheduler>:
{
    8000134a:	7139                	addi	sp,sp,-64
    8000134c:	fc06                	sd	ra,56(sp)
    8000134e:	f822                	sd	s0,48(sp)
    80001350:	f426                	sd	s1,40(sp)
    80001352:	f04a                	sd	s2,32(sp)
    80001354:	ec4e                	sd	s3,24(sp)
    80001356:	e852                	sd	s4,16(sp)
    80001358:	e456                	sd	s5,8(sp)
    8000135a:	e05a                	sd	s6,0(sp)
    8000135c:	0080                	addi	s0,sp,64
    8000135e:	8792                	mv	a5,tp
  int id = r_tp();
    80001360:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001362:	00779a93          	slli	s5,a5,0x7
    80001366:	00007717          	auipc	a4,0x7
    8000136a:	57a70713          	addi	a4,a4,1402 # 800088e0 <pid_lock>
    8000136e:	9756                	add	a4,a4,s5
    80001370:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001374:	00007717          	auipc	a4,0x7
    80001378:	5a470713          	addi	a4,a4,1444 # 80008918 <cpus+0x8>
    8000137c:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    8000137e:	498d                	li	s3,3
        p->state = RUNNING;
    80001380:	4b11                	li	s6,4
        c->proc = p;
    80001382:	079e                	slli	a5,a5,0x7
    80001384:	00007a17          	auipc	s4,0x7
    80001388:	55ca0a13          	addi	s4,s4,1372 # 800088e0 <pid_lock>
    8000138c:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    8000138e:	0000d917          	auipc	s2,0xd
    80001392:	38290913          	addi	s2,s2,898 # 8000e710 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001396:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000139a:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000139e:	10079073          	csrw	sstatus,a5
    800013a2:	00008497          	auipc	s1,0x8
    800013a6:	96e48493          	addi	s1,s1,-1682 # 80008d10 <proc>
    800013aa:	a03d                	j	800013d8 <scheduler+0x8e>
        p->state = RUNNING;
    800013ac:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800013b0:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800013b4:	06048593          	addi	a1,s1,96
    800013b8:	8556                	mv	a0,s5
    800013ba:	00000097          	auipc	ra,0x0
    800013be:	6a4080e7          	jalr	1700(ra) # 80001a5e <swtch>
        c->proc = 0;
    800013c2:	020a3823          	sd	zero,48(s4)
      release(&p->lock);
    800013c6:	8526                	mv	a0,s1
    800013c8:	00005097          	auipc	ra,0x5
    800013cc:	e08080e7          	jalr	-504(ra) # 800061d0 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800013d0:	16848493          	addi	s1,s1,360
    800013d4:	fd2481e3          	beq	s1,s2,80001396 <scheduler+0x4c>
      acquire(&p->lock);
    800013d8:	8526                	mv	a0,s1
    800013da:	00005097          	auipc	ra,0x5
    800013de:	d42080e7          	jalr	-702(ra) # 8000611c <acquire>
      if(p->state == RUNNABLE) {
    800013e2:	4c9c                	lw	a5,24(s1)
    800013e4:	ff3791e3          	bne	a5,s3,800013c6 <scheduler+0x7c>
    800013e8:	b7d1                	j	800013ac <scheduler+0x62>

00000000800013ea <sched>:
{
    800013ea:	7179                	addi	sp,sp,-48
    800013ec:	f406                	sd	ra,40(sp)
    800013ee:	f022                	sd	s0,32(sp)
    800013f0:	ec26                	sd	s1,24(sp)
    800013f2:	e84a                	sd	s2,16(sp)
    800013f4:	e44e                	sd	s3,8(sp)
    800013f6:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    800013f8:	00000097          	auipc	ra,0x0
    800013fc:	a60080e7          	jalr	-1440(ra) # 80000e58 <myproc>
    80001400:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    80001402:	00005097          	auipc	ra,0x5
    80001406:	ca0080e7          	jalr	-864(ra) # 800060a2 <holding>
    8000140a:	c93d                	beqz	a0,80001480 <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    8000140c:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000140e:	2781                	sext.w	a5,a5
    80001410:	079e                	slli	a5,a5,0x7
    80001412:	00007717          	auipc	a4,0x7
    80001416:	4ce70713          	addi	a4,a4,1230 # 800088e0 <pid_lock>
    8000141a:	97ba                	add	a5,a5,a4
    8000141c:	0a87a703          	lw	a4,168(a5)
    80001420:	4785                	li	a5,1
    80001422:	06f71763          	bne	a4,a5,80001490 <sched+0xa6>
  if(p->state == RUNNING)
    80001426:	4c98                	lw	a4,24(s1)
    80001428:	4791                	li	a5,4
    8000142a:	06f70b63          	beq	a4,a5,800014a0 <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000142e:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001432:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001434:	efb5                	bnez	a5,800014b0 <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001436:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001438:	00007917          	auipc	s2,0x7
    8000143c:	4a890913          	addi	s2,s2,1192 # 800088e0 <pid_lock>
    80001440:	2781                	sext.w	a5,a5
    80001442:	079e                	slli	a5,a5,0x7
    80001444:	97ca                	add	a5,a5,s2
    80001446:	0ac7a983          	lw	s3,172(a5)
    8000144a:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    8000144c:	2781                	sext.w	a5,a5
    8000144e:	079e                	slli	a5,a5,0x7
    80001450:	00007597          	auipc	a1,0x7
    80001454:	4c858593          	addi	a1,a1,1224 # 80008918 <cpus+0x8>
    80001458:	95be                	add	a1,a1,a5
    8000145a:	06048513          	addi	a0,s1,96
    8000145e:	00000097          	auipc	ra,0x0
    80001462:	600080e7          	jalr	1536(ra) # 80001a5e <swtch>
    80001466:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001468:	2781                	sext.w	a5,a5
    8000146a:	079e                	slli	a5,a5,0x7
    8000146c:	97ca                	add	a5,a5,s2
    8000146e:	0b37a623          	sw	s3,172(a5)
}
    80001472:	70a2                	ld	ra,40(sp)
    80001474:	7402                	ld	s0,32(sp)
    80001476:	64e2                	ld	s1,24(sp)
    80001478:	6942                	ld	s2,16(sp)
    8000147a:	69a2                	ld	s3,8(sp)
    8000147c:	6145                	addi	sp,sp,48
    8000147e:	8082                	ret
    panic("sched p->lock");
    80001480:	00007517          	auipc	a0,0x7
    80001484:	d1850513          	addi	a0,a0,-744 # 80008198 <etext+0x198>
    80001488:	00004097          	auipc	ra,0x4
    8000148c:	74a080e7          	jalr	1866(ra) # 80005bd2 <panic>
    panic("sched locks");
    80001490:	00007517          	auipc	a0,0x7
    80001494:	d1850513          	addi	a0,a0,-744 # 800081a8 <etext+0x1a8>
    80001498:	00004097          	auipc	ra,0x4
    8000149c:	73a080e7          	jalr	1850(ra) # 80005bd2 <panic>
    panic("sched running");
    800014a0:	00007517          	auipc	a0,0x7
    800014a4:	d1850513          	addi	a0,a0,-744 # 800081b8 <etext+0x1b8>
    800014a8:	00004097          	auipc	ra,0x4
    800014ac:	72a080e7          	jalr	1834(ra) # 80005bd2 <panic>
    panic("sched interruptible");
    800014b0:	00007517          	auipc	a0,0x7
    800014b4:	d1850513          	addi	a0,a0,-744 # 800081c8 <etext+0x1c8>
    800014b8:	00004097          	auipc	ra,0x4
    800014bc:	71a080e7          	jalr	1818(ra) # 80005bd2 <panic>

00000000800014c0 <yield>:
{
    800014c0:	1101                	addi	sp,sp,-32
    800014c2:	ec06                	sd	ra,24(sp)
    800014c4:	e822                	sd	s0,16(sp)
    800014c6:	e426                	sd	s1,8(sp)
    800014c8:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800014ca:	00000097          	auipc	ra,0x0
    800014ce:	98e080e7          	jalr	-1650(ra) # 80000e58 <myproc>
    800014d2:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800014d4:	00005097          	auipc	ra,0x5
    800014d8:	c48080e7          	jalr	-952(ra) # 8000611c <acquire>
  p->state = RUNNABLE;
    800014dc:	478d                	li	a5,3
    800014de:	cc9c                	sw	a5,24(s1)
  sched();
    800014e0:	00000097          	auipc	ra,0x0
    800014e4:	f0a080e7          	jalr	-246(ra) # 800013ea <sched>
  release(&p->lock);
    800014e8:	8526                	mv	a0,s1
    800014ea:	00005097          	auipc	ra,0x5
    800014ee:	ce6080e7          	jalr	-794(ra) # 800061d0 <release>
}
    800014f2:	60e2                	ld	ra,24(sp)
    800014f4:	6442                	ld	s0,16(sp)
    800014f6:	64a2                	ld	s1,8(sp)
    800014f8:	6105                	addi	sp,sp,32
    800014fa:	8082                	ret

00000000800014fc <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    800014fc:	7179                	addi	sp,sp,-48
    800014fe:	f406                	sd	ra,40(sp)
    80001500:	f022                	sd	s0,32(sp)
    80001502:	ec26                	sd	s1,24(sp)
    80001504:	e84a                	sd	s2,16(sp)
    80001506:	e44e                	sd	s3,8(sp)
    80001508:	1800                	addi	s0,sp,48
    8000150a:	89aa                	mv	s3,a0
    8000150c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000150e:	00000097          	auipc	ra,0x0
    80001512:	94a080e7          	jalr	-1718(ra) # 80000e58 <myproc>
    80001516:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001518:	00005097          	auipc	ra,0x5
    8000151c:	c04080e7          	jalr	-1020(ra) # 8000611c <acquire>
  release(lk);
    80001520:	854a                	mv	a0,s2
    80001522:	00005097          	auipc	ra,0x5
    80001526:	cae080e7          	jalr	-850(ra) # 800061d0 <release>

  // Go to sleep.
  p->chan = chan;
    8000152a:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000152e:	4789                	li	a5,2
    80001530:	cc9c                	sw	a5,24(s1)

  sched();
    80001532:	00000097          	auipc	ra,0x0
    80001536:	eb8080e7          	jalr	-328(ra) # 800013ea <sched>

  // Tidy up.
  p->chan = 0;
    8000153a:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000153e:	8526                	mv	a0,s1
    80001540:	00005097          	auipc	ra,0x5
    80001544:	c90080e7          	jalr	-880(ra) # 800061d0 <release>
  acquire(lk);
    80001548:	854a                	mv	a0,s2
    8000154a:	00005097          	auipc	ra,0x5
    8000154e:	bd2080e7          	jalr	-1070(ra) # 8000611c <acquire>
}
    80001552:	70a2                	ld	ra,40(sp)
    80001554:	7402                	ld	s0,32(sp)
    80001556:	64e2                	ld	s1,24(sp)
    80001558:	6942                	ld	s2,16(sp)
    8000155a:	69a2                	ld	s3,8(sp)
    8000155c:	6145                	addi	sp,sp,48
    8000155e:	8082                	ret

0000000080001560 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001560:	7139                	addi	sp,sp,-64
    80001562:	fc06                	sd	ra,56(sp)
    80001564:	f822                	sd	s0,48(sp)
    80001566:	f426                	sd	s1,40(sp)
    80001568:	f04a                	sd	s2,32(sp)
    8000156a:	ec4e                	sd	s3,24(sp)
    8000156c:	e852                	sd	s4,16(sp)
    8000156e:	e456                	sd	s5,8(sp)
    80001570:	0080                	addi	s0,sp,64
    80001572:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    80001574:	00007497          	auipc	s1,0x7
    80001578:	79c48493          	addi	s1,s1,1948 # 80008d10 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    8000157c:	4989                	li	s3,2
        p->state = RUNNABLE;
    8000157e:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    80001580:	0000d917          	auipc	s2,0xd
    80001584:	19090913          	addi	s2,s2,400 # 8000e710 <tickslock>
    80001588:	a821                	j	800015a0 <wakeup+0x40>
        p->state = RUNNABLE;
    8000158a:	0154ac23          	sw	s5,24(s1)
      }
      release(&p->lock);
    8000158e:	8526                	mv	a0,s1
    80001590:	00005097          	auipc	ra,0x5
    80001594:	c40080e7          	jalr	-960(ra) # 800061d0 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001598:	16848493          	addi	s1,s1,360
    8000159c:	03248463          	beq	s1,s2,800015c4 <wakeup+0x64>
    if(p != myproc()){
    800015a0:	00000097          	auipc	ra,0x0
    800015a4:	8b8080e7          	jalr	-1864(ra) # 80000e58 <myproc>
    800015a8:	fea488e3          	beq	s1,a0,80001598 <wakeup+0x38>
      acquire(&p->lock);
    800015ac:	8526                	mv	a0,s1
    800015ae:	00005097          	auipc	ra,0x5
    800015b2:	b6e080e7          	jalr	-1170(ra) # 8000611c <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800015b6:	4c9c                	lw	a5,24(s1)
    800015b8:	fd379be3          	bne	a5,s3,8000158e <wakeup+0x2e>
    800015bc:	709c                	ld	a5,32(s1)
    800015be:	fd4798e3          	bne	a5,s4,8000158e <wakeup+0x2e>
    800015c2:	b7e1                	j	8000158a <wakeup+0x2a>
    }
  }
}
    800015c4:	70e2                	ld	ra,56(sp)
    800015c6:	7442                	ld	s0,48(sp)
    800015c8:	74a2                	ld	s1,40(sp)
    800015ca:	7902                	ld	s2,32(sp)
    800015cc:	69e2                	ld	s3,24(sp)
    800015ce:	6a42                	ld	s4,16(sp)
    800015d0:	6aa2                	ld	s5,8(sp)
    800015d2:	6121                	addi	sp,sp,64
    800015d4:	8082                	ret

00000000800015d6 <reparent>:
{
    800015d6:	7179                	addi	sp,sp,-48
    800015d8:	f406                	sd	ra,40(sp)
    800015da:	f022                	sd	s0,32(sp)
    800015dc:	ec26                	sd	s1,24(sp)
    800015de:	e84a                	sd	s2,16(sp)
    800015e0:	e44e                	sd	s3,8(sp)
    800015e2:	e052                	sd	s4,0(sp)
    800015e4:	1800                	addi	s0,sp,48
    800015e6:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800015e8:	00007497          	auipc	s1,0x7
    800015ec:	72848493          	addi	s1,s1,1832 # 80008d10 <proc>
      pp->parent = initproc;
    800015f0:	00007a17          	auipc	s4,0x7
    800015f4:	2b0a0a13          	addi	s4,s4,688 # 800088a0 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    800015f8:	0000d997          	auipc	s3,0xd
    800015fc:	11898993          	addi	s3,s3,280 # 8000e710 <tickslock>
    80001600:	a029                	j	8000160a <reparent+0x34>
    80001602:	16848493          	addi	s1,s1,360
    80001606:	01348d63          	beq	s1,s3,80001620 <reparent+0x4a>
    if(pp->parent == p){
    8000160a:	7c9c                	ld	a5,56(s1)
    8000160c:	ff279be3          	bne	a5,s2,80001602 <reparent+0x2c>
      pp->parent = initproc;
    80001610:	000a3503          	ld	a0,0(s4)
    80001614:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80001616:	00000097          	auipc	ra,0x0
    8000161a:	f4a080e7          	jalr	-182(ra) # 80001560 <wakeup>
    8000161e:	b7d5                	j	80001602 <reparent+0x2c>
}
    80001620:	70a2                	ld	ra,40(sp)
    80001622:	7402                	ld	s0,32(sp)
    80001624:	64e2                	ld	s1,24(sp)
    80001626:	6942                	ld	s2,16(sp)
    80001628:	69a2                	ld	s3,8(sp)
    8000162a:	6a02                	ld	s4,0(sp)
    8000162c:	6145                	addi	sp,sp,48
    8000162e:	8082                	ret

0000000080001630 <exit>:
{
    80001630:	7179                	addi	sp,sp,-48
    80001632:	f406                	sd	ra,40(sp)
    80001634:	f022                	sd	s0,32(sp)
    80001636:	ec26                	sd	s1,24(sp)
    80001638:	e84a                	sd	s2,16(sp)
    8000163a:	e44e                	sd	s3,8(sp)
    8000163c:	e052                	sd	s4,0(sp)
    8000163e:	1800                	addi	s0,sp,48
    80001640:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001642:	00000097          	auipc	ra,0x0
    80001646:	816080e7          	jalr	-2026(ra) # 80000e58 <myproc>
    8000164a:	89aa                	mv	s3,a0
  if(p == initproc)
    8000164c:	00007797          	auipc	a5,0x7
    80001650:	2547b783          	ld	a5,596(a5) # 800088a0 <initproc>
    80001654:	0d050493          	addi	s1,a0,208
    80001658:	15050913          	addi	s2,a0,336
    8000165c:	02a79363          	bne	a5,a0,80001682 <exit+0x52>
    panic("init exiting");
    80001660:	00007517          	auipc	a0,0x7
    80001664:	b8050513          	addi	a0,a0,-1152 # 800081e0 <etext+0x1e0>
    80001668:	00004097          	auipc	ra,0x4
    8000166c:	56a080e7          	jalr	1386(ra) # 80005bd2 <panic>
      fileclose(f);
    80001670:	00002097          	auipc	ra,0x2
    80001674:	2f2080e7          	jalr	754(ra) # 80003962 <fileclose>
      p->ofile[fd] = 0;
    80001678:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    8000167c:	04a1                	addi	s1,s1,8
    8000167e:	01248563          	beq	s1,s2,80001688 <exit+0x58>
    if(p->ofile[fd]){
    80001682:	6088                	ld	a0,0(s1)
    80001684:	f575                	bnez	a0,80001670 <exit+0x40>
    80001686:	bfdd                	j	8000167c <exit+0x4c>
  begin_op();
    80001688:	00002097          	auipc	ra,0x2
    8000168c:	e0e080e7          	jalr	-498(ra) # 80003496 <begin_op>
  iput(p->cwd);
    80001690:	1509b503          	ld	a0,336(s3)
    80001694:	00001097          	auipc	ra,0x1
    80001698:	5fa080e7          	jalr	1530(ra) # 80002c8e <iput>
  end_op();
    8000169c:	00002097          	auipc	ra,0x2
    800016a0:	e7a080e7          	jalr	-390(ra) # 80003516 <end_op>
  p->cwd = 0;
    800016a4:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800016a8:	00007497          	auipc	s1,0x7
    800016ac:	25048493          	addi	s1,s1,592 # 800088f8 <wait_lock>
    800016b0:	8526                	mv	a0,s1
    800016b2:	00005097          	auipc	ra,0x5
    800016b6:	a6a080e7          	jalr	-1430(ra) # 8000611c <acquire>
  reparent(p);
    800016ba:	854e                	mv	a0,s3
    800016bc:	00000097          	auipc	ra,0x0
    800016c0:	f1a080e7          	jalr	-230(ra) # 800015d6 <reparent>
  wakeup(p->parent);
    800016c4:	0389b503          	ld	a0,56(s3)
    800016c8:	00000097          	auipc	ra,0x0
    800016cc:	e98080e7          	jalr	-360(ra) # 80001560 <wakeup>
  acquire(&p->lock);
    800016d0:	854e                	mv	a0,s3
    800016d2:	00005097          	auipc	ra,0x5
    800016d6:	a4a080e7          	jalr	-1462(ra) # 8000611c <acquire>
  p->xstate = status;
    800016da:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    800016de:	4795                	li	a5,5
    800016e0:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    800016e4:	8526                	mv	a0,s1
    800016e6:	00005097          	auipc	ra,0x5
    800016ea:	aea080e7          	jalr	-1302(ra) # 800061d0 <release>
  sched();
    800016ee:	00000097          	auipc	ra,0x0
    800016f2:	cfc080e7          	jalr	-772(ra) # 800013ea <sched>
  panic("zombie exit");
    800016f6:	00007517          	auipc	a0,0x7
    800016fa:	afa50513          	addi	a0,a0,-1286 # 800081f0 <etext+0x1f0>
    800016fe:	00004097          	auipc	ra,0x4
    80001702:	4d4080e7          	jalr	1236(ra) # 80005bd2 <panic>

0000000080001706 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80001706:	7179                	addi	sp,sp,-48
    80001708:	f406                	sd	ra,40(sp)
    8000170a:	f022                	sd	s0,32(sp)
    8000170c:	ec26                	sd	s1,24(sp)
    8000170e:	e84a                	sd	s2,16(sp)
    80001710:	e44e                	sd	s3,8(sp)
    80001712:	1800                	addi	s0,sp,48
    80001714:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80001716:	00007497          	auipc	s1,0x7
    8000171a:	5fa48493          	addi	s1,s1,1530 # 80008d10 <proc>
    8000171e:	0000d997          	auipc	s3,0xd
    80001722:	ff298993          	addi	s3,s3,-14 # 8000e710 <tickslock>
    acquire(&p->lock);
    80001726:	8526                	mv	a0,s1
    80001728:	00005097          	auipc	ra,0x5
    8000172c:	9f4080e7          	jalr	-1548(ra) # 8000611c <acquire>
    if(p->pid == pid){
    80001730:	589c                	lw	a5,48(s1)
    80001732:	01278d63          	beq	a5,s2,8000174c <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80001736:	8526                	mv	a0,s1
    80001738:	00005097          	auipc	ra,0x5
    8000173c:	a98080e7          	jalr	-1384(ra) # 800061d0 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001740:	16848493          	addi	s1,s1,360
    80001744:	ff3491e3          	bne	s1,s3,80001726 <kill+0x20>
  }
  return -1;
    80001748:	557d                	li	a0,-1
    8000174a:	a829                	j	80001764 <kill+0x5e>
      p->killed = 1;
    8000174c:	4785                	li	a5,1
    8000174e:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001750:	4c98                	lw	a4,24(s1)
    80001752:	4789                	li	a5,2
    80001754:	00f70f63          	beq	a4,a5,80001772 <kill+0x6c>
      release(&p->lock);
    80001758:	8526                	mv	a0,s1
    8000175a:	00005097          	auipc	ra,0x5
    8000175e:	a76080e7          	jalr	-1418(ra) # 800061d0 <release>
      return 0;
    80001762:	4501                	li	a0,0
}
    80001764:	70a2                	ld	ra,40(sp)
    80001766:	7402                	ld	s0,32(sp)
    80001768:	64e2                	ld	s1,24(sp)
    8000176a:	6942                	ld	s2,16(sp)
    8000176c:	69a2                	ld	s3,8(sp)
    8000176e:	6145                	addi	sp,sp,48
    80001770:	8082                	ret
        p->state = RUNNABLE;
    80001772:	478d                	li	a5,3
    80001774:	cc9c                	sw	a5,24(s1)
    80001776:	b7cd                	j	80001758 <kill+0x52>

0000000080001778 <setkilled>:

void
setkilled(struct proc *p)
{
    80001778:	1101                	addi	sp,sp,-32
    8000177a:	ec06                	sd	ra,24(sp)
    8000177c:	e822                	sd	s0,16(sp)
    8000177e:	e426                	sd	s1,8(sp)
    80001780:	1000                	addi	s0,sp,32
    80001782:	84aa                	mv	s1,a0
  acquire(&p->lock);
    80001784:	00005097          	auipc	ra,0x5
    80001788:	998080e7          	jalr	-1640(ra) # 8000611c <acquire>
  p->killed = 1;
    8000178c:	4785                	li	a5,1
    8000178e:	d49c                	sw	a5,40(s1)
  release(&p->lock);
    80001790:	8526                	mv	a0,s1
    80001792:	00005097          	auipc	ra,0x5
    80001796:	a3e080e7          	jalr	-1474(ra) # 800061d0 <release>
}
    8000179a:	60e2                	ld	ra,24(sp)
    8000179c:	6442                	ld	s0,16(sp)
    8000179e:	64a2                	ld	s1,8(sp)
    800017a0:	6105                	addi	sp,sp,32
    800017a2:	8082                	ret

00000000800017a4 <killed>:

int
killed(struct proc *p)
{
    800017a4:	1101                	addi	sp,sp,-32
    800017a6:	ec06                	sd	ra,24(sp)
    800017a8:	e822                	sd	s0,16(sp)
    800017aa:	e426                	sd	s1,8(sp)
    800017ac:	e04a                	sd	s2,0(sp)
    800017ae:	1000                	addi	s0,sp,32
    800017b0:	84aa                	mv	s1,a0
  int k;
  
  acquire(&p->lock);
    800017b2:	00005097          	auipc	ra,0x5
    800017b6:	96a080e7          	jalr	-1686(ra) # 8000611c <acquire>
  k = p->killed;
    800017ba:	0284a903          	lw	s2,40(s1)
  release(&p->lock);
    800017be:	8526                	mv	a0,s1
    800017c0:	00005097          	auipc	ra,0x5
    800017c4:	a10080e7          	jalr	-1520(ra) # 800061d0 <release>
  return k;
}
    800017c8:	854a                	mv	a0,s2
    800017ca:	60e2                	ld	ra,24(sp)
    800017cc:	6442                	ld	s0,16(sp)
    800017ce:	64a2                	ld	s1,8(sp)
    800017d0:	6902                	ld	s2,0(sp)
    800017d2:	6105                	addi	sp,sp,32
    800017d4:	8082                	ret

00000000800017d6 <wait>:
{
    800017d6:	715d                	addi	sp,sp,-80
    800017d8:	e486                	sd	ra,72(sp)
    800017da:	e0a2                	sd	s0,64(sp)
    800017dc:	fc26                	sd	s1,56(sp)
    800017de:	f84a                	sd	s2,48(sp)
    800017e0:	f44e                	sd	s3,40(sp)
    800017e2:	f052                	sd	s4,32(sp)
    800017e4:	ec56                	sd	s5,24(sp)
    800017e6:	e85a                	sd	s6,16(sp)
    800017e8:	e45e                	sd	s7,8(sp)
    800017ea:	e062                	sd	s8,0(sp)
    800017ec:	0880                	addi	s0,sp,80
    800017ee:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800017f0:	fffff097          	auipc	ra,0xfffff
    800017f4:	668080e7          	jalr	1640(ra) # 80000e58 <myproc>
    800017f8:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800017fa:	00007517          	auipc	a0,0x7
    800017fe:	0fe50513          	addi	a0,a0,254 # 800088f8 <wait_lock>
    80001802:	00005097          	auipc	ra,0x5
    80001806:	91a080e7          	jalr	-1766(ra) # 8000611c <acquire>
    havekids = 0;
    8000180a:	4b81                	li	s7,0
        if(pp->state == ZOMBIE){
    8000180c:	4a15                	li	s4,5
    for(pp = proc; pp < &proc[NPROC]; pp++){
    8000180e:	0000d997          	auipc	s3,0xd
    80001812:	f0298993          	addi	s3,s3,-254 # 8000e710 <tickslock>
        havekids = 1;
    80001816:	4a85                	li	s5,1
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001818:	00007c17          	auipc	s8,0x7
    8000181c:	0e0c0c13          	addi	s8,s8,224 # 800088f8 <wait_lock>
    havekids = 0;
    80001820:	875e                	mv	a4,s7
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001822:	00007497          	auipc	s1,0x7
    80001826:	4ee48493          	addi	s1,s1,1262 # 80008d10 <proc>
    8000182a:	a0bd                	j	80001898 <wait+0xc2>
          pid = pp->pid;
    8000182c:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&pp->xstate,
    80001830:	000b0e63          	beqz	s6,8000184c <wait+0x76>
    80001834:	4691                	li	a3,4
    80001836:	02c48613          	addi	a2,s1,44
    8000183a:	85da                	mv	a1,s6
    8000183c:	05093503          	ld	a0,80(s2)
    80001840:	fffff097          	auipc	ra,0xfffff
    80001844:	2d6080e7          	jalr	726(ra) # 80000b16 <copyout>
    80001848:	02054563          	bltz	a0,80001872 <wait+0x9c>
          freeproc(pp);
    8000184c:	8526                	mv	a0,s1
    8000184e:	fffff097          	auipc	ra,0xfffff
    80001852:	7bc080e7          	jalr	1980(ra) # 8000100a <freeproc>
          release(&pp->lock);
    80001856:	8526                	mv	a0,s1
    80001858:	00005097          	auipc	ra,0x5
    8000185c:	978080e7          	jalr	-1672(ra) # 800061d0 <release>
          release(&wait_lock);
    80001860:	00007517          	auipc	a0,0x7
    80001864:	09850513          	addi	a0,a0,152 # 800088f8 <wait_lock>
    80001868:	00005097          	auipc	ra,0x5
    8000186c:	968080e7          	jalr	-1688(ra) # 800061d0 <release>
          return pid;
    80001870:	a0b5                	j	800018dc <wait+0x106>
            release(&pp->lock);
    80001872:	8526                	mv	a0,s1
    80001874:	00005097          	auipc	ra,0x5
    80001878:	95c080e7          	jalr	-1700(ra) # 800061d0 <release>
            release(&wait_lock);
    8000187c:	00007517          	auipc	a0,0x7
    80001880:	07c50513          	addi	a0,a0,124 # 800088f8 <wait_lock>
    80001884:	00005097          	auipc	ra,0x5
    80001888:	94c080e7          	jalr	-1716(ra) # 800061d0 <release>
            return -1;
    8000188c:	59fd                	li	s3,-1
    8000188e:	a0b9                	j	800018dc <wait+0x106>
    for(pp = proc; pp < &proc[NPROC]; pp++){
    80001890:	16848493          	addi	s1,s1,360
    80001894:	03348463          	beq	s1,s3,800018bc <wait+0xe6>
      if(pp->parent == p){
    80001898:	7c9c                	ld	a5,56(s1)
    8000189a:	ff279be3          	bne	a5,s2,80001890 <wait+0xba>
        acquire(&pp->lock);
    8000189e:	8526                	mv	a0,s1
    800018a0:	00005097          	auipc	ra,0x5
    800018a4:	87c080e7          	jalr	-1924(ra) # 8000611c <acquire>
        if(pp->state == ZOMBIE){
    800018a8:	4c9c                	lw	a5,24(s1)
    800018aa:	f94781e3          	beq	a5,s4,8000182c <wait+0x56>
        release(&pp->lock);
    800018ae:	8526                	mv	a0,s1
    800018b0:	00005097          	auipc	ra,0x5
    800018b4:	920080e7          	jalr	-1760(ra) # 800061d0 <release>
        havekids = 1;
    800018b8:	8756                	mv	a4,s5
    800018ba:	bfd9                	j	80001890 <wait+0xba>
    if(!havekids || killed(p)){
    800018bc:	c719                	beqz	a4,800018ca <wait+0xf4>
    800018be:	854a                	mv	a0,s2
    800018c0:	00000097          	auipc	ra,0x0
    800018c4:	ee4080e7          	jalr	-284(ra) # 800017a4 <killed>
    800018c8:	c51d                	beqz	a0,800018f6 <wait+0x120>
      release(&wait_lock);
    800018ca:	00007517          	auipc	a0,0x7
    800018ce:	02e50513          	addi	a0,a0,46 # 800088f8 <wait_lock>
    800018d2:	00005097          	auipc	ra,0x5
    800018d6:	8fe080e7          	jalr	-1794(ra) # 800061d0 <release>
      return -1;
    800018da:	59fd                	li	s3,-1
}
    800018dc:	854e                	mv	a0,s3
    800018de:	60a6                	ld	ra,72(sp)
    800018e0:	6406                	ld	s0,64(sp)
    800018e2:	74e2                	ld	s1,56(sp)
    800018e4:	7942                	ld	s2,48(sp)
    800018e6:	79a2                	ld	s3,40(sp)
    800018e8:	7a02                	ld	s4,32(sp)
    800018ea:	6ae2                	ld	s5,24(sp)
    800018ec:	6b42                	ld	s6,16(sp)
    800018ee:	6ba2                	ld	s7,8(sp)
    800018f0:	6c02                	ld	s8,0(sp)
    800018f2:	6161                	addi	sp,sp,80
    800018f4:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800018f6:	85e2                	mv	a1,s8
    800018f8:	854a                	mv	a0,s2
    800018fa:	00000097          	auipc	ra,0x0
    800018fe:	c02080e7          	jalr	-1022(ra) # 800014fc <sleep>
    havekids = 0;
    80001902:	bf39                	j	80001820 <wait+0x4a>

0000000080001904 <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    80001904:	7179                	addi	sp,sp,-48
    80001906:	f406                	sd	ra,40(sp)
    80001908:	f022                	sd	s0,32(sp)
    8000190a:	ec26                	sd	s1,24(sp)
    8000190c:	e84a                	sd	s2,16(sp)
    8000190e:	e44e                	sd	s3,8(sp)
    80001910:	e052                	sd	s4,0(sp)
    80001912:	1800                	addi	s0,sp,48
    80001914:	84aa                	mv	s1,a0
    80001916:	892e                	mv	s2,a1
    80001918:	89b2                	mv	s3,a2
    8000191a:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000191c:	fffff097          	auipc	ra,0xfffff
    80001920:	53c080e7          	jalr	1340(ra) # 80000e58 <myproc>
  if(user_dst){
    80001924:	c08d                	beqz	s1,80001946 <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    80001926:	86d2                	mv	a3,s4
    80001928:	864e                	mv	a2,s3
    8000192a:	85ca                	mv	a1,s2
    8000192c:	6928                	ld	a0,80(a0)
    8000192e:	fffff097          	auipc	ra,0xfffff
    80001932:	1e8080e7          	jalr	488(ra) # 80000b16 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    80001936:	70a2                	ld	ra,40(sp)
    80001938:	7402                	ld	s0,32(sp)
    8000193a:	64e2                	ld	s1,24(sp)
    8000193c:	6942                	ld	s2,16(sp)
    8000193e:	69a2                	ld	s3,8(sp)
    80001940:	6a02                	ld	s4,0(sp)
    80001942:	6145                	addi	sp,sp,48
    80001944:	8082                	ret
    memmove((char *)dst, src, len);
    80001946:	000a061b          	sext.w	a2,s4
    8000194a:	85ce                	mv	a1,s3
    8000194c:	854a                	mv	a0,s2
    8000194e:	fffff097          	auipc	ra,0xfffff
    80001952:	88a080e7          	jalr	-1910(ra) # 800001d8 <memmove>
    return 0;
    80001956:	8526                	mv	a0,s1
    80001958:	bff9                	j	80001936 <either_copyout+0x32>

000000008000195a <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    8000195a:	7179                	addi	sp,sp,-48
    8000195c:	f406                	sd	ra,40(sp)
    8000195e:	f022                	sd	s0,32(sp)
    80001960:	ec26                	sd	s1,24(sp)
    80001962:	e84a                	sd	s2,16(sp)
    80001964:	e44e                	sd	s3,8(sp)
    80001966:	e052                	sd	s4,0(sp)
    80001968:	1800                	addi	s0,sp,48
    8000196a:	892a                	mv	s2,a0
    8000196c:	84ae                	mv	s1,a1
    8000196e:	89b2                	mv	s3,a2
    80001970:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80001972:	fffff097          	auipc	ra,0xfffff
    80001976:	4e6080e7          	jalr	1254(ra) # 80000e58 <myproc>
  if(user_src){
    8000197a:	c08d                	beqz	s1,8000199c <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    8000197c:	86d2                	mv	a3,s4
    8000197e:	864e                	mv	a2,s3
    80001980:	85ca                	mv	a1,s2
    80001982:	6928                	ld	a0,80(a0)
    80001984:	fffff097          	auipc	ra,0xfffff
    80001988:	21e080e7          	jalr	542(ra) # 80000ba2 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    8000198c:	70a2                	ld	ra,40(sp)
    8000198e:	7402                	ld	s0,32(sp)
    80001990:	64e2                	ld	s1,24(sp)
    80001992:	6942                	ld	s2,16(sp)
    80001994:	69a2                	ld	s3,8(sp)
    80001996:	6a02                	ld	s4,0(sp)
    80001998:	6145                	addi	sp,sp,48
    8000199a:	8082                	ret
    memmove(dst, (char*)src, len);
    8000199c:	000a061b          	sext.w	a2,s4
    800019a0:	85ce                	mv	a1,s3
    800019a2:	854a                	mv	a0,s2
    800019a4:	fffff097          	auipc	ra,0xfffff
    800019a8:	834080e7          	jalr	-1996(ra) # 800001d8 <memmove>
    return 0;
    800019ac:	8526                	mv	a0,s1
    800019ae:	bff9                	j	8000198c <either_copyin+0x32>

00000000800019b0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    800019b0:	715d                	addi	sp,sp,-80
    800019b2:	e486                	sd	ra,72(sp)
    800019b4:	e0a2                	sd	s0,64(sp)
    800019b6:	fc26                	sd	s1,56(sp)
    800019b8:	f84a                	sd	s2,48(sp)
    800019ba:	f44e                	sd	s3,40(sp)
    800019bc:	f052                	sd	s4,32(sp)
    800019be:	ec56                	sd	s5,24(sp)
    800019c0:	e85a                	sd	s6,16(sp)
    800019c2:	e45e                	sd	s7,8(sp)
    800019c4:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    800019c6:	00006517          	auipc	a0,0x6
    800019ca:	68250513          	addi	a0,a0,1666 # 80008048 <etext+0x48>
    800019ce:	00004097          	auipc	ra,0x4
    800019d2:	24e080e7          	jalr	590(ra) # 80005c1c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800019d6:	00007497          	auipc	s1,0x7
    800019da:	49248493          	addi	s1,s1,1170 # 80008e68 <proc+0x158>
    800019de:	0000d917          	auipc	s2,0xd
    800019e2:	e8a90913          	addi	s2,s2,-374 # 8000e868 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800019e6:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    800019e8:	00007997          	auipc	s3,0x7
    800019ec:	81898993          	addi	s3,s3,-2024 # 80008200 <etext+0x200>
    printf("%d %s %s", p->pid, state, p->name);
    800019f0:	00007a97          	auipc	s5,0x7
    800019f4:	818a8a93          	addi	s5,s5,-2024 # 80008208 <etext+0x208>
    printf("\n");
    800019f8:	00006a17          	auipc	s4,0x6
    800019fc:	650a0a13          	addi	s4,s4,1616 # 80008048 <etext+0x48>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a00:	00007b97          	auipc	s7,0x7
    80001a04:	848b8b93          	addi	s7,s7,-1976 # 80008248 <states.1722>
    80001a08:	a00d                	j	80001a2a <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    80001a0a:	ed86a583          	lw	a1,-296(a3)
    80001a0e:	8556                	mv	a0,s5
    80001a10:	00004097          	auipc	ra,0x4
    80001a14:	20c080e7          	jalr	524(ra) # 80005c1c <printf>
    printf("\n");
    80001a18:	8552                	mv	a0,s4
    80001a1a:	00004097          	auipc	ra,0x4
    80001a1e:	202080e7          	jalr	514(ra) # 80005c1c <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    80001a22:	16848493          	addi	s1,s1,360
    80001a26:	03248163          	beq	s1,s2,80001a48 <procdump+0x98>
    if(p->state == UNUSED)
    80001a2a:	86a6                	mv	a3,s1
    80001a2c:	ec04a783          	lw	a5,-320(s1)
    80001a30:	dbed                	beqz	a5,80001a22 <procdump+0x72>
      state = "???";
    80001a32:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    80001a34:	fcfb6be3          	bltu	s6,a5,80001a0a <procdump+0x5a>
    80001a38:	1782                	slli	a5,a5,0x20
    80001a3a:	9381                	srli	a5,a5,0x20
    80001a3c:	078e                	slli	a5,a5,0x3
    80001a3e:	97de                	add	a5,a5,s7
    80001a40:	6390                	ld	a2,0(a5)
    80001a42:	f661                	bnez	a2,80001a0a <procdump+0x5a>
      state = "???";
    80001a44:	864e                	mv	a2,s3
    80001a46:	b7d1                	j	80001a0a <procdump+0x5a>
  }
}
    80001a48:	60a6                	ld	ra,72(sp)
    80001a4a:	6406                	ld	s0,64(sp)
    80001a4c:	74e2                	ld	s1,56(sp)
    80001a4e:	7942                	ld	s2,48(sp)
    80001a50:	79a2                	ld	s3,40(sp)
    80001a52:	7a02                	ld	s4,32(sp)
    80001a54:	6ae2                	ld	s5,24(sp)
    80001a56:	6b42                	ld	s6,16(sp)
    80001a58:	6ba2                	ld	s7,8(sp)
    80001a5a:	6161                	addi	sp,sp,80
    80001a5c:	8082                	ret

0000000080001a5e <swtch>:
    80001a5e:	00153023          	sd	ra,0(a0)
    80001a62:	00253423          	sd	sp,8(a0)
    80001a66:	e900                	sd	s0,16(a0)
    80001a68:	ed04                	sd	s1,24(a0)
    80001a6a:	03253023          	sd	s2,32(a0)
    80001a6e:	03353423          	sd	s3,40(a0)
    80001a72:	03453823          	sd	s4,48(a0)
    80001a76:	03553c23          	sd	s5,56(a0)
    80001a7a:	05653023          	sd	s6,64(a0)
    80001a7e:	05753423          	sd	s7,72(a0)
    80001a82:	05853823          	sd	s8,80(a0)
    80001a86:	05953c23          	sd	s9,88(a0)
    80001a8a:	07a53023          	sd	s10,96(a0)
    80001a8e:	07b53423          	sd	s11,104(a0)
    80001a92:	0005b083          	ld	ra,0(a1)
    80001a96:	0085b103          	ld	sp,8(a1)
    80001a9a:	6980                	ld	s0,16(a1)
    80001a9c:	6d84                	ld	s1,24(a1)
    80001a9e:	0205b903          	ld	s2,32(a1)
    80001aa2:	0285b983          	ld	s3,40(a1)
    80001aa6:	0305ba03          	ld	s4,48(a1)
    80001aaa:	0385ba83          	ld	s5,56(a1)
    80001aae:	0405bb03          	ld	s6,64(a1)
    80001ab2:	0485bb83          	ld	s7,72(a1)
    80001ab6:	0505bc03          	ld	s8,80(a1)
    80001aba:	0585bc83          	ld	s9,88(a1)
    80001abe:	0605bd03          	ld	s10,96(a1)
    80001ac2:	0685bd83          	ld	s11,104(a1)
    80001ac6:	8082                	ret

0000000080001ac8 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001ac8:	1141                	addi	sp,sp,-16
    80001aca:	e406                	sd	ra,8(sp)
    80001acc:	e022                	sd	s0,0(sp)
    80001ace:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001ad0:	00006597          	auipc	a1,0x6
    80001ad4:	7a858593          	addi	a1,a1,1960 # 80008278 <states.1722+0x30>
    80001ad8:	0000d517          	auipc	a0,0xd
    80001adc:	c3850513          	addi	a0,a0,-968 # 8000e710 <tickslock>
    80001ae0:	00004097          	auipc	ra,0x4
    80001ae4:	5ac080e7          	jalr	1452(ra) # 8000608c <initlock>
}
    80001ae8:	60a2                	ld	ra,8(sp)
    80001aea:	6402                	ld	s0,0(sp)
    80001aec:	0141                	addi	sp,sp,16
    80001aee:	8082                	ret

0000000080001af0 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001af0:	1141                	addi	sp,sp,-16
    80001af2:	e422                	sd	s0,8(sp)
    80001af4:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001af6:	00003797          	auipc	a5,0x3
    80001afa:	4aa78793          	addi	a5,a5,1194 # 80004fa0 <kernelvec>
    80001afe:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001b02:	6422                	ld	s0,8(sp)
    80001b04:	0141                	addi	sp,sp,16
    80001b06:	8082                	ret

0000000080001b08 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001b08:	1141                	addi	sp,sp,-16
    80001b0a:	e406                	sd	ra,8(sp)
    80001b0c:	e022                	sd	s0,0(sp)
    80001b0e:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001b10:	fffff097          	auipc	ra,0xfffff
    80001b14:	348080e7          	jalr	840(ra) # 80000e58 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b18:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001b1c:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b1e:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to uservec in trampoline.S
  uint64 trampoline_uservec = TRAMPOLINE + (uservec - trampoline);
    80001b22:	00005617          	auipc	a2,0x5
    80001b26:	4de60613          	addi	a2,a2,1246 # 80007000 <_trampoline>
    80001b2a:	00005697          	auipc	a3,0x5
    80001b2e:	4d668693          	addi	a3,a3,1238 # 80007000 <_trampoline>
    80001b32:	8e91                	sub	a3,a3,a2
    80001b34:	040007b7          	lui	a5,0x4000
    80001b38:	17fd                	addi	a5,a5,-1
    80001b3a:	07b2                	slli	a5,a5,0xc
    80001b3c:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001b3e:	10569073          	csrw	stvec,a3
  w_stvec(trampoline_uservec);

  // set up trapframe values that uservec will need when
  // the process next traps into the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001b42:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001b44:	180026f3          	csrr	a3,satp
    80001b48:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001b4a:	6d38                	ld	a4,88(a0)
    80001b4c:	6134                	ld	a3,64(a0)
    80001b4e:	6585                	lui	a1,0x1
    80001b50:	96ae                	add	a3,a3,a1
    80001b52:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001b54:	6d38                	ld	a4,88(a0)
    80001b56:	00000697          	auipc	a3,0x0
    80001b5a:	13068693          	addi	a3,a3,304 # 80001c86 <usertrap>
    80001b5e:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001b60:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001b62:	8692                	mv	a3,tp
    80001b64:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b66:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001b6a:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001b6e:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b72:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001b76:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001b78:	6f18                	ld	a4,24(a4)
    80001b7a:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001b7e:	6928                	ld	a0,80(a0)
    80001b80:	8131                	srli	a0,a0,0xc

  // jump to userret in trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 trampoline_userret = TRAMPOLINE + (userret - trampoline);
    80001b82:	00005717          	auipc	a4,0x5
    80001b86:	51a70713          	addi	a4,a4,1306 # 8000709c <userret>
    80001b8a:	8f11                	sub	a4,a4,a2
    80001b8c:	97ba                	add	a5,a5,a4
  ((void (*)(uint64))trampoline_userret)(satp);
    80001b8e:	577d                	li	a4,-1
    80001b90:	177e                	slli	a4,a4,0x3f
    80001b92:	8d59                	or	a0,a0,a4
    80001b94:	9782                	jalr	a5
}
    80001b96:	60a2                	ld	ra,8(sp)
    80001b98:	6402                	ld	s0,0(sp)
    80001b9a:	0141                	addi	sp,sp,16
    80001b9c:	8082                	ret

0000000080001b9e <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001b9e:	1101                	addi	sp,sp,-32
    80001ba0:	ec06                	sd	ra,24(sp)
    80001ba2:	e822                	sd	s0,16(sp)
    80001ba4:	e426                	sd	s1,8(sp)
    80001ba6:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001ba8:	0000d497          	auipc	s1,0xd
    80001bac:	b6848493          	addi	s1,s1,-1176 # 8000e710 <tickslock>
    80001bb0:	8526                	mv	a0,s1
    80001bb2:	00004097          	auipc	ra,0x4
    80001bb6:	56a080e7          	jalr	1386(ra) # 8000611c <acquire>
  ticks++;
    80001bba:	00007517          	auipc	a0,0x7
    80001bbe:	cee50513          	addi	a0,a0,-786 # 800088a8 <ticks>
    80001bc2:	411c                	lw	a5,0(a0)
    80001bc4:	2785                	addiw	a5,a5,1
    80001bc6:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001bc8:	00000097          	auipc	ra,0x0
    80001bcc:	998080e7          	jalr	-1640(ra) # 80001560 <wakeup>
  release(&tickslock);
    80001bd0:	8526                	mv	a0,s1
    80001bd2:	00004097          	auipc	ra,0x4
    80001bd6:	5fe080e7          	jalr	1534(ra) # 800061d0 <release>
}
    80001bda:	60e2                	ld	ra,24(sp)
    80001bdc:	6442                	ld	s0,16(sp)
    80001bde:	64a2                	ld	s1,8(sp)
    80001be0:	6105                	addi	sp,sp,32
    80001be2:	8082                	ret

0000000080001be4 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001be4:	1101                	addi	sp,sp,-32
    80001be6:	ec06                	sd	ra,24(sp)
    80001be8:	e822                	sd	s0,16(sp)
    80001bea:	e426                	sd	s1,8(sp)
    80001bec:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001bee:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001bf2:	00074d63          	bltz	a4,80001c0c <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001bf6:	57fd                	li	a5,-1
    80001bf8:	17fe                	slli	a5,a5,0x3f
    80001bfa:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001bfc:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001bfe:	06f70363          	beq	a4,a5,80001c64 <devintr+0x80>
  }
}
    80001c02:	60e2                	ld	ra,24(sp)
    80001c04:	6442                	ld	s0,16(sp)
    80001c06:	64a2                	ld	s1,8(sp)
    80001c08:	6105                	addi	sp,sp,32
    80001c0a:	8082                	ret
     (scause & 0xff) == 9){
    80001c0c:	0ff77793          	andi	a5,a4,255
  if((scause & 0x8000000000000000L) &&
    80001c10:	46a5                	li	a3,9
    80001c12:	fed792e3          	bne	a5,a3,80001bf6 <devintr+0x12>
    int irq = plic_claim();
    80001c16:	00003097          	auipc	ra,0x3
    80001c1a:	492080e7          	jalr	1170(ra) # 800050a8 <plic_claim>
    80001c1e:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001c20:	47a9                	li	a5,10
    80001c22:	02f50763          	beq	a0,a5,80001c50 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001c26:	4785                	li	a5,1
    80001c28:	02f50963          	beq	a0,a5,80001c5a <devintr+0x76>
    return 1;
    80001c2c:	4505                	li	a0,1
    } else if(irq){
    80001c2e:	d8f1                	beqz	s1,80001c02 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001c30:	85a6                	mv	a1,s1
    80001c32:	00006517          	auipc	a0,0x6
    80001c36:	64e50513          	addi	a0,a0,1614 # 80008280 <states.1722+0x38>
    80001c3a:	00004097          	auipc	ra,0x4
    80001c3e:	fe2080e7          	jalr	-30(ra) # 80005c1c <printf>
      plic_complete(irq);
    80001c42:	8526                	mv	a0,s1
    80001c44:	00003097          	auipc	ra,0x3
    80001c48:	488080e7          	jalr	1160(ra) # 800050cc <plic_complete>
    return 1;
    80001c4c:	4505                	li	a0,1
    80001c4e:	bf55                	j	80001c02 <devintr+0x1e>
      uartintr();
    80001c50:	00004097          	auipc	ra,0x4
    80001c54:	3ec080e7          	jalr	1004(ra) # 8000603c <uartintr>
    80001c58:	b7ed                	j	80001c42 <devintr+0x5e>
      virtio_disk_intr();
    80001c5a:	00004097          	auipc	ra,0x4
    80001c5e:	99c080e7          	jalr	-1636(ra) # 800055f6 <virtio_disk_intr>
    80001c62:	b7c5                	j	80001c42 <devintr+0x5e>
    if(cpuid() == 0){
    80001c64:	fffff097          	auipc	ra,0xfffff
    80001c68:	1c8080e7          	jalr	456(ra) # 80000e2c <cpuid>
    80001c6c:	c901                	beqz	a0,80001c7c <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001c6e:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001c72:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001c74:	14479073          	csrw	sip,a5
    return 2;
    80001c78:	4509                	li	a0,2
    80001c7a:	b761                	j	80001c02 <devintr+0x1e>
      clockintr();
    80001c7c:	00000097          	auipc	ra,0x0
    80001c80:	f22080e7          	jalr	-222(ra) # 80001b9e <clockintr>
    80001c84:	b7ed                	j	80001c6e <devintr+0x8a>

0000000080001c86 <usertrap>:
{
    80001c86:	1101                	addi	sp,sp,-32
    80001c88:	ec06                	sd	ra,24(sp)
    80001c8a:	e822                	sd	s0,16(sp)
    80001c8c:	e426                	sd	s1,8(sp)
    80001c8e:	e04a                	sd	s2,0(sp)
    80001c90:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c92:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001c96:	1007f793          	andi	a5,a5,256
    80001c9a:	e3b1                	bnez	a5,80001cde <usertrap+0x58>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001c9c:	00003797          	auipc	a5,0x3
    80001ca0:	30478793          	addi	a5,a5,772 # 80004fa0 <kernelvec>
    80001ca4:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001ca8:	fffff097          	auipc	ra,0xfffff
    80001cac:	1b0080e7          	jalr	432(ra) # 80000e58 <myproc>
    80001cb0:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001cb2:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001cb4:	14102773          	csrr	a4,sepc
    80001cb8:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001cba:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001cbe:	47a1                	li	a5,8
    80001cc0:	02f70763          	beq	a4,a5,80001cee <usertrap+0x68>
  } else if((which_dev = devintr()) != 0){
    80001cc4:	00000097          	auipc	ra,0x0
    80001cc8:	f20080e7          	jalr	-224(ra) # 80001be4 <devintr>
    80001ccc:	892a                	mv	s2,a0
    80001cce:	c151                	beqz	a0,80001d52 <usertrap+0xcc>
  if(killed(p))
    80001cd0:	8526                	mv	a0,s1
    80001cd2:	00000097          	auipc	ra,0x0
    80001cd6:	ad2080e7          	jalr	-1326(ra) # 800017a4 <killed>
    80001cda:	c929                	beqz	a0,80001d2c <usertrap+0xa6>
    80001cdc:	a099                	j	80001d22 <usertrap+0x9c>
    panic("usertrap: not from user mode");
    80001cde:	00006517          	auipc	a0,0x6
    80001ce2:	5c250513          	addi	a0,a0,1474 # 800082a0 <states.1722+0x58>
    80001ce6:	00004097          	auipc	ra,0x4
    80001cea:	eec080e7          	jalr	-276(ra) # 80005bd2 <panic>
    if(killed(p))
    80001cee:	00000097          	auipc	ra,0x0
    80001cf2:	ab6080e7          	jalr	-1354(ra) # 800017a4 <killed>
    80001cf6:	e921                	bnez	a0,80001d46 <usertrap+0xc0>
    p->trapframe->epc += 4;
    80001cf8:	6cb8                	ld	a4,88(s1)
    80001cfa:	6f1c                	ld	a5,24(a4)
    80001cfc:	0791                	addi	a5,a5,4
    80001cfe:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d00:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001d04:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d08:	10079073          	csrw	sstatus,a5
    syscall();
    80001d0c:	00000097          	auipc	ra,0x0
    80001d10:	2d4080e7          	jalr	724(ra) # 80001fe0 <syscall>
  if(killed(p))
    80001d14:	8526                	mv	a0,s1
    80001d16:	00000097          	auipc	ra,0x0
    80001d1a:	a8e080e7          	jalr	-1394(ra) # 800017a4 <killed>
    80001d1e:	c911                	beqz	a0,80001d32 <usertrap+0xac>
    80001d20:	4901                	li	s2,0
    exit(-1);
    80001d22:	557d                	li	a0,-1
    80001d24:	00000097          	auipc	ra,0x0
    80001d28:	90c080e7          	jalr	-1780(ra) # 80001630 <exit>
  if(which_dev == 2)
    80001d2c:	4789                	li	a5,2
    80001d2e:	04f90f63          	beq	s2,a5,80001d8c <usertrap+0x106>
  usertrapret();
    80001d32:	00000097          	auipc	ra,0x0
    80001d36:	dd6080e7          	jalr	-554(ra) # 80001b08 <usertrapret>
}
    80001d3a:	60e2                	ld	ra,24(sp)
    80001d3c:	6442                	ld	s0,16(sp)
    80001d3e:	64a2                	ld	s1,8(sp)
    80001d40:	6902                	ld	s2,0(sp)
    80001d42:	6105                	addi	sp,sp,32
    80001d44:	8082                	ret
      exit(-1);
    80001d46:	557d                	li	a0,-1
    80001d48:	00000097          	auipc	ra,0x0
    80001d4c:	8e8080e7          	jalr	-1816(ra) # 80001630 <exit>
    80001d50:	b765                	j	80001cf8 <usertrap+0x72>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d52:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001d56:	5890                	lw	a2,48(s1)
    80001d58:	00006517          	auipc	a0,0x6
    80001d5c:	56850513          	addi	a0,a0,1384 # 800082c0 <states.1722+0x78>
    80001d60:	00004097          	auipc	ra,0x4
    80001d64:	ebc080e7          	jalr	-324(ra) # 80005c1c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d68:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001d6c:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001d70:	00006517          	auipc	a0,0x6
    80001d74:	58050513          	addi	a0,a0,1408 # 800082f0 <states.1722+0xa8>
    80001d78:	00004097          	auipc	ra,0x4
    80001d7c:	ea4080e7          	jalr	-348(ra) # 80005c1c <printf>
    setkilled(p);
    80001d80:	8526                	mv	a0,s1
    80001d82:	00000097          	auipc	ra,0x0
    80001d86:	9f6080e7          	jalr	-1546(ra) # 80001778 <setkilled>
    80001d8a:	b769                	j	80001d14 <usertrap+0x8e>
    yield();
    80001d8c:	fffff097          	auipc	ra,0xfffff
    80001d90:	734080e7          	jalr	1844(ra) # 800014c0 <yield>
    80001d94:	bf79                	j	80001d32 <usertrap+0xac>

0000000080001d96 <kerneltrap>:
{
    80001d96:	7179                	addi	sp,sp,-48
    80001d98:	f406                	sd	ra,40(sp)
    80001d9a:	f022                	sd	s0,32(sp)
    80001d9c:	ec26                	sd	s1,24(sp)
    80001d9e:	e84a                	sd	s2,16(sp)
    80001da0:	e44e                	sd	s3,8(sp)
    80001da2:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001da4:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001da8:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001dac:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001db0:	1004f793          	andi	a5,s1,256
    80001db4:	cb85                	beqz	a5,80001de4 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001db6:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001dba:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001dbc:	ef85                	bnez	a5,80001df4 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001dbe:	00000097          	auipc	ra,0x0
    80001dc2:	e26080e7          	jalr	-474(ra) # 80001be4 <devintr>
    80001dc6:	cd1d                	beqz	a0,80001e04 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001dc8:	4789                	li	a5,2
    80001dca:	06f50a63          	beq	a0,a5,80001e3e <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001dce:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001dd2:	10049073          	csrw	sstatus,s1
}
    80001dd6:	70a2                	ld	ra,40(sp)
    80001dd8:	7402                	ld	s0,32(sp)
    80001dda:	64e2                	ld	s1,24(sp)
    80001ddc:	6942                	ld	s2,16(sp)
    80001dde:	69a2                	ld	s3,8(sp)
    80001de0:	6145                	addi	sp,sp,48
    80001de2:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001de4:	00006517          	auipc	a0,0x6
    80001de8:	52c50513          	addi	a0,a0,1324 # 80008310 <states.1722+0xc8>
    80001dec:	00004097          	auipc	ra,0x4
    80001df0:	de6080e7          	jalr	-538(ra) # 80005bd2 <panic>
    panic("kerneltrap: interrupts enabled");
    80001df4:	00006517          	auipc	a0,0x6
    80001df8:	54450513          	addi	a0,a0,1348 # 80008338 <states.1722+0xf0>
    80001dfc:	00004097          	auipc	ra,0x4
    80001e00:	dd6080e7          	jalr	-554(ra) # 80005bd2 <panic>
    printf("scause %p\n", scause);
    80001e04:	85ce                	mv	a1,s3
    80001e06:	00006517          	auipc	a0,0x6
    80001e0a:	55250513          	addi	a0,a0,1362 # 80008358 <states.1722+0x110>
    80001e0e:	00004097          	auipc	ra,0x4
    80001e12:	e0e080e7          	jalr	-498(ra) # 80005c1c <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001e16:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001e1a:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001e1e:	00006517          	auipc	a0,0x6
    80001e22:	54a50513          	addi	a0,a0,1354 # 80008368 <states.1722+0x120>
    80001e26:	00004097          	auipc	ra,0x4
    80001e2a:	df6080e7          	jalr	-522(ra) # 80005c1c <printf>
    panic("kerneltrap");
    80001e2e:	00006517          	auipc	a0,0x6
    80001e32:	55250513          	addi	a0,a0,1362 # 80008380 <states.1722+0x138>
    80001e36:	00004097          	auipc	ra,0x4
    80001e3a:	d9c080e7          	jalr	-612(ra) # 80005bd2 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001e3e:	fffff097          	auipc	ra,0xfffff
    80001e42:	01a080e7          	jalr	26(ra) # 80000e58 <myproc>
    80001e46:	d541                	beqz	a0,80001dce <kerneltrap+0x38>
    80001e48:	fffff097          	auipc	ra,0xfffff
    80001e4c:	010080e7          	jalr	16(ra) # 80000e58 <myproc>
    80001e50:	4d18                	lw	a4,24(a0)
    80001e52:	4791                	li	a5,4
    80001e54:	f6f71de3          	bne	a4,a5,80001dce <kerneltrap+0x38>
    yield();
    80001e58:	fffff097          	auipc	ra,0xfffff
    80001e5c:	668080e7          	jalr	1640(ra) # 800014c0 <yield>
    80001e60:	b7bd                	j	80001dce <kerneltrap+0x38>

0000000080001e62 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001e62:	1101                	addi	sp,sp,-32
    80001e64:	ec06                	sd	ra,24(sp)
    80001e66:	e822                	sd	s0,16(sp)
    80001e68:	e426                	sd	s1,8(sp)
    80001e6a:	1000                	addi	s0,sp,32
    80001e6c:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001e6e:	fffff097          	auipc	ra,0xfffff
    80001e72:	fea080e7          	jalr	-22(ra) # 80000e58 <myproc>
  switch (n) {
    80001e76:	4795                	li	a5,5
    80001e78:	0497e163          	bltu	a5,s1,80001eba <argraw+0x58>
    80001e7c:	048a                	slli	s1,s1,0x2
    80001e7e:	00006717          	auipc	a4,0x6
    80001e82:	53a70713          	addi	a4,a4,1338 # 800083b8 <states.1722+0x170>
    80001e86:	94ba                	add	s1,s1,a4
    80001e88:	409c                	lw	a5,0(s1)
    80001e8a:	97ba                	add	a5,a5,a4
    80001e8c:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001e8e:	6d3c                	ld	a5,88(a0)
    80001e90:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001e92:	60e2                	ld	ra,24(sp)
    80001e94:	6442                	ld	s0,16(sp)
    80001e96:	64a2                	ld	s1,8(sp)
    80001e98:	6105                	addi	sp,sp,32
    80001e9a:	8082                	ret
    return p->trapframe->a1;
    80001e9c:	6d3c                	ld	a5,88(a0)
    80001e9e:	7fa8                	ld	a0,120(a5)
    80001ea0:	bfcd                	j	80001e92 <argraw+0x30>
    return p->trapframe->a2;
    80001ea2:	6d3c                	ld	a5,88(a0)
    80001ea4:	63c8                	ld	a0,128(a5)
    80001ea6:	b7f5                	j	80001e92 <argraw+0x30>
    return p->trapframe->a3;
    80001ea8:	6d3c                	ld	a5,88(a0)
    80001eaa:	67c8                	ld	a0,136(a5)
    80001eac:	b7dd                	j	80001e92 <argraw+0x30>
    return p->trapframe->a4;
    80001eae:	6d3c                	ld	a5,88(a0)
    80001eb0:	6bc8                	ld	a0,144(a5)
    80001eb2:	b7c5                	j	80001e92 <argraw+0x30>
    return p->trapframe->a5;
    80001eb4:	6d3c                	ld	a5,88(a0)
    80001eb6:	6fc8                	ld	a0,152(a5)
    80001eb8:	bfe9                	j	80001e92 <argraw+0x30>
  panic("argraw");
    80001eba:	00006517          	auipc	a0,0x6
    80001ebe:	4d650513          	addi	a0,a0,1238 # 80008390 <states.1722+0x148>
    80001ec2:	00004097          	auipc	ra,0x4
    80001ec6:	d10080e7          	jalr	-752(ra) # 80005bd2 <panic>

0000000080001eca <fetchaddr>:
{
    80001eca:	1101                	addi	sp,sp,-32
    80001ecc:	ec06                	sd	ra,24(sp)
    80001ece:	e822                	sd	s0,16(sp)
    80001ed0:	e426                	sd	s1,8(sp)
    80001ed2:	e04a                	sd	s2,0(sp)
    80001ed4:	1000                	addi	s0,sp,32
    80001ed6:	84aa                	mv	s1,a0
    80001ed8:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001eda:	fffff097          	auipc	ra,0xfffff
    80001ede:	f7e080e7          	jalr	-130(ra) # 80000e58 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz) // both tests needed, in case of overflow
    80001ee2:	653c                	ld	a5,72(a0)
    80001ee4:	02f4f863          	bgeu	s1,a5,80001f14 <fetchaddr+0x4a>
    80001ee8:	00848713          	addi	a4,s1,8
    80001eec:	02e7e663          	bltu	a5,a4,80001f18 <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001ef0:	46a1                	li	a3,8
    80001ef2:	8626                	mv	a2,s1
    80001ef4:	85ca                	mv	a1,s2
    80001ef6:	6928                	ld	a0,80(a0)
    80001ef8:	fffff097          	auipc	ra,0xfffff
    80001efc:	caa080e7          	jalr	-854(ra) # 80000ba2 <copyin>
    80001f00:	00a03533          	snez	a0,a0
    80001f04:	40a00533          	neg	a0,a0
}
    80001f08:	60e2                	ld	ra,24(sp)
    80001f0a:	6442                	ld	s0,16(sp)
    80001f0c:	64a2                	ld	s1,8(sp)
    80001f0e:	6902                	ld	s2,0(sp)
    80001f10:	6105                	addi	sp,sp,32
    80001f12:	8082                	ret
    return -1;
    80001f14:	557d                	li	a0,-1
    80001f16:	bfcd                	j	80001f08 <fetchaddr+0x3e>
    80001f18:	557d                	li	a0,-1
    80001f1a:	b7fd                	j	80001f08 <fetchaddr+0x3e>

0000000080001f1c <fetchstr>:
{
    80001f1c:	7179                	addi	sp,sp,-48
    80001f1e:	f406                	sd	ra,40(sp)
    80001f20:	f022                	sd	s0,32(sp)
    80001f22:	ec26                	sd	s1,24(sp)
    80001f24:	e84a                	sd	s2,16(sp)
    80001f26:	e44e                	sd	s3,8(sp)
    80001f28:	1800                	addi	s0,sp,48
    80001f2a:	892a                	mv	s2,a0
    80001f2c:	84ae                	mv	s1,a1
    80001f2e:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001f30:	fffff097          	auipc	ra,0xfffff
    80001f34:	f28080e7          	jalr	-216(ra) # 80000e58 <myproc>
  if(copyinstr(p->pagetable, buf, addr, max) < 0)
    80001f38:	86ce                	mv	a3,s3
    80001f3a:	864a                	mv	a2,s2
    80001f3c:	85a6                	mv	a1,s1
    80001f3e:	6928                	ld	a0,80(a0)
    80001f40:	fffff097          	auipc	ra,0xfffff
    80001f44:	cee080e7          	jalr	-786(ra) # 80000c2e <copyinstr>
    80001f48:	00054e63          	bltz	a0,80001f64 <fetchstr+0x48>
  return strlen(buf);
    80001f4c:	8526                	mv	a0,s1
    80001f4e:	ffffe097          	auipc	ra,0xffffe
    80001f52:	3ae080e7          	jalr	942(ra) # 800002fc <strlen>
}
    80001f56:	70a2                	ld	ra,40(sp)
    80001f58:	7402                	ld	s0,32(sp)
    80001f5a:	64e2                	ld	s1,24(sp)
    80001f5c:	6942                	ld	s2,16(sp)
    80001f5e:	69a2                	ld	s3,8(sp)
    80001f60:	6145                	addi	sp,sp,48
    80001f62:	8082                	ret
    return -1;
    80001f64:	557d                	li	a0,-1
    80001f66:	bfc5                	j	80001f56 <fetchstr+0x3a>

0000000080001f68 <argint>:

// Fetch the nth 32-bit system call argument.
void
argint(int n, int *ip)
{
    80001f68:	1101                	addi	sp,sp,-32
    80001f6a:	ec06                	sd	ra,24(sp)
    80001f6c:	e822                	sd	s0,16(sp)
    80001f6e:	e426                	sd	s1,8(sp)
    80001f70:	1000                	addi	s0,sp,32
    80001f72:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f74:	00000097          	auipc	ra,0x0
    80001f78:	eee080e7          	jalr	-274(ra) # 80001e62 <argraw>
    80001f7c:	c088                	sw	a0,0(s1)
}
    80001f7e:	60e2                	ld	ra,24(sp)
    80001f80:	6442                	ld	s0,16(sp)
    80001f82:	64a2                	ld	s1,8(sp)
    80001f84:	6105                	addi	sp,sp,32
    80001f86:	8082                	ret

0000000080001f88 <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
void
argaddr(int n, uint64 *ip)
{
    80001f88:	1101                	addi	sp,sp,-32
    80001f8a:	ec06                	sd	ra,24(sp)
    80001f8c:	e822                	sd	s0,16(sp)
    80001f8e:	e426                	sd	s1,8(sp)
    80001f90:	1000                	addi	s0,sp,32
    80001f92:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f94:	00000097          	auipc	ra,0x0
    80001f98:	ece080e7          	jalr	-306(ra) # 80001e62 <argraw>
    80001f9c:	e088                	sd	a0,0(s1)
}
    80001f9e:	60e2                	ld	ra,24(sp)
    80001fa0:	6442                	ld	s0,16(sp)
    80001fa2:	64a2                	ld	s1,8(sp)
    80001fa4:	6105                	addi	sp,sp,32
    80001fa6:	8082                	ret

0000000080001fa8 <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001fa8:	7179                	addi	sp,sp,-48
    80001faa:	f406                	sd	ra,40(sp)
    80001fac:	f022                	sd	s0,32(sp)
    80001fae:	ec26                	sd	s1,24(sp)
    80001fb0:	e84a                	sd	s2,16(sp)
    80001fb2:	1800                	addi	s0,sp,48
    80001fb4:	84ae                	mv	s1,a1
    80001fb6:	8932                	mv	s2,a2
  uint64 addr;
  argaddr(n, &addr);
    80001fb8:	fd840593          	addi	a1,s0,-40
    80001fbc:	00000097          	auipc	ra,0x0
    80001fc0:	fcc080e7          	jalr	-52(ra) # 80001f88 <argaddr>
  return fetchstr(addr, buf, max);
    80001fc4:	864a                	mv	a2,s2
    80001fc6:	85a6                	mv	a1,s1
    80001fc8:	fd843503          	ld	a0,-40(s0)
    80001fcc:	00000097          	auipc	ra,0x0
    80001fd0:	f50080e7          	jalr	-176(ra) # 80001f1c <fetchstr>
}
    80001fd4:	70a2                	ld	ra,40(sp)
    80001fd6:	7402                	ld	s0,32(sp)
    80001fd8:	64e2                	ld	s1,24(sp)
    80001fda:	6942                	ld	s2,16(sp)
    80001fdc:	6145                	addi	sp,sp,48
    80001fde:	8082                	ret

0000000080001fe0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80001fe0:	1101                	addi	sp,sp,-32
    80001fe2:	ec06                	sd	ra,24(sp)
    80001fe4:	e822                	sd	s0,16(sp)
    80001fe6:	e426                	sd	s1,8(sp)
    80001fe8:	e04a                	sd	s2,0(sp)
    80001fea:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001fec:	fffff097          	auipc	ra,0xfffff
    80001ff0:	e6c080e7          	jalr	-404(ra) # 80000e58 <myproc>
    80001ff4:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001ff6:	05853903          	ld	s2,88(a0)
    80001ffa:	0a893783          	ld	a5,168(s2)
    80001ffe:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002002:	37fd                	addiw	a5,a5,-1
    80002004:	4751                	li	a4,20
    80002006:	00f76f63          	bltu	a4,a5,80002024 <syscall+0x44>
    8000200a:	00369713          	slli	a4,a3,0x3
    8000200e:	00006797          	auipc	a5,0x6
    80002012:	3c278793          	addi	a5,a5,962 # 800083d0 <syscalls>
    80002016:	97ba                	add	a5,a5,a4
    80002018:	639c                	ld	a5,0(a5)
    8000201a:	c789                	beqz	a5,80002024 <syscall+0x44>
    // Use num to lookup the system call function for num, call it,
    // and store its return value in p->trapframe->a0
    p->trapframe->a0 = syscalls[num]();
    8000201c:	9782                	jalr	a5
    8000201e:	06a93823          	sd	a0,112(s2)
    80002022:	a839                	j	80002040 <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002024:	15848613          	addi	a2,s1,344
    80002028:	588c                	lw	a1,48(s1)
    8000202a:	00006517          	auipc	a0,0x6
    8000202e:	36e50513          	addi	a0,a0,878 # 80008398 <states.1722+0x150>
    80002032:	00004097          	auipc	ra,0x4
    80002036:	bea080e7          	jalr	-1046(ra) # 80005c1c <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    8000203a:	6cbc                	ld	a5,88(s1)
    8000203c:	577d                	li	a4,-1
    8000203e:	fbb8                	sd	a4,112(a5)
  }
}
    80002040:	60e2                	ld	ra,24(sp)
    80002042:	6442                	ld	s0,16(sp)
    80002044:	64a2                	ld	s1,8(sp)
    80002046:	6902                	ld	s2,0(sp)
    80002048:	6105                	addi	sp,sp,32
    8000204a:	8082                	ret

000000008000204c <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    8000204c:	1101                	addi	sp,sp,-32
    8000204e:	ec06                	sd	ra,24(sp)
    80002050:	e822                	sd	s0,16(sp)
    80002052:	1000                	addi	s0,sp,32
  int n;
  argint(0, &n);
    80002054:	fec40593          	addi	a1,s0,-20
    80002058:	4501                	li	a0,0
    8000205a:	00000097          	auipc	ra,0x0
    8000205e:	f0e080e7          	jalr	-242(ra) # 80001f68 <argint>
  exit(n);
    80002062:	fec42503          	lw	a0,-20(s0)
    80002066:	fffff097          	auipc	ra,0xfffff
    8000206a:	5ca080e7          	jalr	1482(ra) # 80001630 <exit>
  return 0;  // not reached
}
    8000206e:	4501                	li	a0,0
    80002070:	60e2                	ld	ra,24(sp)
    80002072:	6442                	ld	s0,16(sp)
    80002074:	6105                	addi	sp,sp,32
    80002076:	8082                	ret

0000000080002078 <sys_getpid>:

uint64
sys_getpid(void)
{
    80002078:	1141                	addi	sp,sp,-16
    8000207a:	e406                	sd	ra,8(sp)
    8000207c:	e022                	sd	s0,0(sp)
    8000207e:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002080:	fffff097          	auipc	ra,0xfffff
    80002084:	dd8080e7          	jalr	-552(ra) # 80000e58 <myproc>
}
    80002088:	5908                	lw	a0,48(a0)
    8000208a:	60a2                	ld	ra,8(sp)
    8000208c:	6402                	ld	s0,0(sp)
    8000208e:	0141                	addi	sp,sp,16
    80002090:	8082                	ret

0000000080002092 <sys_fork>:

uint64
sys_fork(void)
{
    80002092:	1141                	addi	sp,sp,-16
    80002094:	e406                	sd	ra,8(sp)
    80002096:	e022                	sd	s0,0(sp)
    80002098:	0800                	addi	s0,sp,16
  return fork();
    8000209a:	fffff097          	auipc	ra,0xfffff
    8000209e:	174080e7          	jalr	372(ra) # 8000120e <fork>
}
    800020a2:	60a2                	ld	ra,8(sp)
    800020a4:	6402                	ld	s0,0(sp)
    800020a6:	0141                	addi	sp,sp,16
    800020a8:	8082                	ret

00000000800020aa <sys_wait>:

uint64
sys_wait(void)
{
    800020aa:	1101                	addi	sp,sp,-32
    800020ac:	ec06                	sd	ra,24(sp)
    800020ae:	e822                	sd	s0,16(sp)
    800020b0:	1000                	addi	s0,sp,32
  uint64 p;
  argaddr(0, &p);
    800020b2:	fe840593          	addi	a1,s0,-24
    800020b6:	4501                	li	a0,0
    800020b8:	00000097          	auipc	ra,0x0
    800020bc:	ed0080e7          	jalr	-304(ra) # 80001f88 <argaddr>
  return wait(p);
    800020c0:	fe843503          	ld	a0,-24(s0)
    800020c4:	fffff097          	auipc	ra,0xfffff
    800020c8:	712080e7          	jalr	1810(ra) # 800017d6 <wait>
}
    800020cc:	60e2                	ld	ra,24(sp)
    800020ce:	6442                	ld	s0,16(sp)
    800020d0:	6105                	addi	sp,sp,32
    800020d2:	8082                	ret

00000000800020d4 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    800020d4:	7179                	addi	sp,sp,-48
    800020d6:	f406                	sd	ra,40(sp)
    800020d8:	f022                	sd	s0,32(sp)
    800020da:	ec26                	sd	s1,24(sp)
    800020dc:	1800                	addi	s0,sp,48
  uint64 addr;
  int n;

  argint(0, &n);
    800020de:	fdc40593          	addi	a1,s0,-36
    800020e2:	4501                	li	a0,0
    800020e4:	00000097          	auipc	ra,0x0
    800020e8:	e84080e7          	jalr	-380(ra) # 80001f68 <argint>
  addr = myproc()->sz;
    800020ec:	fffff097          	auipc	ra,0xfffff
    800020f0:	d6c080e7          	jalr	-660(ra) # 80000e58 <myproc>
    800020f4:	6524                	ld	s1,72(a0)
  if(growproc(n) < 0)
    800020f6:	fdc42503          	lw	a0,-36(s0)
    800020fa:	fffff097          	auipc	ra,0xfffff
    800020fe:	0b8080e7          	jalr	184(ra) # 800011b2 <growproc>
    80002102:	00054863          	bltz	a0,80002112 <sys_sbrk+0x3e>
    return -1;
  return addr;
}
    80002106:	8526                	mv	a0,s1
    80002108:	70a2                	ld	ra,40(sp)
    8000210a:	7402                	ld	s0,32(sp)
    8000210c:	64e2                	ld	s1,24(sp)
    8000210e:	6145                	addi	sp,sp,48
    80002110:	8082                	ret
    return -1;
    80002112:	54fd                	li	s1,-1
    80002114:	bfcd                	j	80002106 <sys_sbrk+0x32>

0000000080002116 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002116:	7139                	addi	sp,sp,-64
    80002118:	fc06                	sd	ra,56(sp)
    8000211a:	f822                	sd	s0,48(sp)
    8000211c:	f426                	sd	s1,40(sp)
    8000211e:	f04a                	sd	s2,32(sp)
    80002120:	ec4e                	sd	s3,24(sp)
    80002122:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  argint(0, &n);
    80002124:	fcc40593          	addi	a1,s0,-52
    80002128:	4501                	li	a0,0
    8000212a:	00000097          	auipc	ra,0x0
    8000212e:	e3e080e7          	jalr	-450(ra) # 80001f68 <argint>
  acquire(&tickslock);
    80002132:	0000c517          	auipc	a0,0xc
    80002136:	5de50513          	addi	a0,a0,1502 # 8000e710 <tickslock>
    8000213a:	00004097          	auipc	ra,0x4
    8000213e:	fe2080e7          	jalr	-30(ra) # 8000611c <acquire>
  ticks0 = ticks;
    80002142:	00006917          	auipc	s2,0x6
    80002146:	76692903          	lw	s2,1894(s2) # 800088a8 <ticks>
  while(ticks - ticks0 < n){
    8000214a:	fcc42783          	lw	a5,-52(s0)
    8000214e:	cf9d                	beqz	a5,8000218c <sys_sleep+0x76>
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002150:	0000c997          	auipc	s3,0xc
    80002154:	5c098993          	addi	s3,s3,1472 # 8000e710 <tickslock>
    80002158:	00006497          	auipc	s1,0x6
    8000215c:	75048493          	addi	s1,s1,1872 # 800088a8 <ticks>
    if(killed(myproc())){
    80002160:	fffff097          	auipc	ra,0xfffff
    80002164:	cf8080e7          	jalr	-776(ra) # 80000e58 <myproc>
    80002168:	fffff097          	auipc	ra,0xfffff
    8000216c:	63c080e7          	jalr	1596(ra) # 800017a4 <killed>
    80002170:	ed15                	bnez	a0,800021ac <sys_sleep+0x96>
    sleep(&ticks, &tickslock);
    80002172:	85ce                	mv	a1,s3
    80002174:	8526                	mv	a0,s1
    80002176:	fffff097          	auipc	ra,0xfffff
    8000217a:	386080e7          	jalr	902(ra) # 800014fc <sleep>
  while(ticks - ticks0 < n){
    8000217e:	409c                	lw	a5,0(s1)
    80002180:	412787bb          	subw	a5,a5,s2
    80002184:	fcc42703          	lw	a4,-52(s0)
    80002188:	fce7ece3          	bltu	a5,a4,80002160 <sys_sleep+0x4a>
  }
  release(&tickslock);
    8000218c:	0000c517          	auipc	a0,0xc
    80002190:	58450513          	addi	a0,a0,1412 # 8000e710 <tickslock>
    80002194:	00004097          	auipc	ra,0x4
    80002198:	03c080e7          	jalr	60(ra) # 800061d0 <release>
  return 0;
    8000219c:	4501                	li	a0,0
}
    8000219e:	70e2                	ld	ra,56(sp)
    800021a0:	7442                	ld	s0,48(sp)
    800021a2:	74a2                	ld	s1,40(sp)
    800021a4:	7902                	ld	s2,32(sp)
    800021a6:	69e2                	ld	s3,24(sp)
    800021a8:	6121                	addi	sp,sp,64
    800021aa:	8082                	ret
      release(&tickslock);
    800021ac:	0000c517          	auipc	a0,0xc
    800021b0:	56450513          	addi	a0,a0,1380 # 8000e710 <tickslock>
    800021b4:	00004097          	auipc	ra,0x4
    800021b8:	01c080e7          	jalr	28(ra) # 800061d0 <release>
      return -1;
    800021bc:	557d                	li	a0,-1
    800021be:	b7c5                	j	8000219e <sys_sleep+0x88>

00000000800021c0 <sys_kill>:

uint64
sys_kill(void)
{
    800021c0:	1101                	addi	sp,sp,-32
    800021c2:	ec06                	sd	ra,24(sp)
    800021c4:	e822                	sd	s0,16(sp)
    800021c6:	1000                	addi	s0,sp,32
  int pid;

  argint(0, &pid);
    800021c8:	fec40593          	addi	a1,s0,-20
    800021cc:	4501                	li	a0,0
    800021ce:	00000097          	auipc	ra,0x0
    800021d2:	d9a080e7          	jalr	-614(ra) # 80001f68 <argint>
  return kill(pid);
    800021d6:	fec42503          	lw	a0,-20(s0)
    800021da:	fffff097          	auipc	ra,0xfffff
    800021de:	52c080e7          	jalr	1324(ra) # 80001706 <kill>
}
    800021e2:	60e2                	ld	ra,24(sp)
    800021e4:	6442                	ld	s0,16(sp)
    800021e6:	6105                	addi	sp,sp,32
    800021e8:	8082                	ret

00000000800021ea <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    800021ea:	1101                	addi	sp,sp,-32
    800021ec:	ec06                	sd	ra,24(sp)
    800021ee:	e822                	sd	s0,16(sp)
    800021f0:	e426                	sd	s1,8(sp)
    800021f2:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800021f4:	0000c517          	auipc	a0,0xc
    800021f8:	51c50513          	addi	a0,a0,1308 # 8000e710 <tickslock>
    800021fc:	00004097          	auipc	ra,0x4
    80002200:	f20080e7          	jalr	-224(ra) # 8000611c <acquire>
  xticks = ticks;
    80002204:	00006497          	auipc	s1,0x6
    80002208:	6a44a483          	lw	s1,1700(s1) # 800088a8 <ticks>
  release(&tickslock);
    8000220c:	0000c517          	auipc	a0,0xc
    80002210:	50450513          	addi	a0,a0,1284 # 8000e710 <tickslock>
    80002214:	00004097          	auipc	ra,0x4
    80002218:	fbc080e7          	jalr	-68(ra) # 800061d0 <release>
  return xticks;
}
    8000221c:	02049513          	slli	a0,s1,0x20
    80002220:	9101                	srli	a0,a0,0x20
    80002222:	60e2                	ld	ra,24(sp)
    80002224:	6442                	ld	s0,16(sp)
    80002226:	64a2                	ld	s1,8(sp)
    80002228:	6105                	addi	sp,sp,32
    8000222a:	8082                	ret

000000008000222c <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    8000222c:	7179                	addi	sp,sp,-48
    8000222e:	f406                	sd	ra,40(sp)
    80002230:	f022                	sd	s0,32(sp)
    80002232:	ec26                	sd	s1,24(sp)
    80002234:	e84a                	sd	s2,16(sp)
    80002236:	e44e                	sd	s3,8(sp)
    80002238:	e052                	sd	s4,0(sp)
    8000223a:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    8000223c:	00006597          	auipc	a1,0x6
    80002240:	24458593          	addi	a1,a1,580 # 80008480 <syscalls+0xb0>
    80002244:	0000c517          	auipc	a0,0xc
    80002248:	4e450513          	addi	a0,a0,1252 # 8000e728 <bcache>
    8000224c:	00004097          	auipc	ra,0x4
    80002250:	e40080e7          	jalr	-448(ra) # 8000608c <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002254:	00014797          	auipc	a5,0x14
    80002258:	4d478793          	addi	a5,a5,1236 # 80016728 <bcache+0x8000>
    8000225c:	00014717          	auipc	a4,0x14
    80002260:	73470713          	addi	a4,a4,1844 # 80016990 <bcache+0x8268>
    80002264:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002268:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000226c:	0000c497          	auipc	s1,0xc
    80002270:	4d448493          	addi	s1,s1,1236 # 8000e740 <bcache+0x18>
    b->next = bcache.head.next;
    80002274:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002276:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002278:	00006a17          	auipc	s4,0x6
    8000227c:	210a0a13          	addi	s4,s4,528 # 80008488 <syscalls+0xb8>
    b->next = bcache.head.next;
    80002280:	2b893783          	ld	a5,696(s2)
    80002284:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002286:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8000228a:	85d2                	mv	a1,s4
    8000228c:	01048513          	addi	a0,s1,16
    80002290:	00001097          	auipc	ra,0x1
    80002294:	4c4080e7          	jalr	1220(ra) # 80003754 <initsleeplock>
    bcache.head.next->prev = b;
    80002298:	2b893783          	ld	a5,696(s2)
    8000229c:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    8000229e:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    800022a2:	45848493          	addi	s1,s1,1112
    800022a6:	fd349de3          	bne	s1,s3,80002280 <binit+0x54>
  }
}
    800022aa:	70a2                	ld	ra,40(sp)
    800022ac:	7402                	ld	s0,32(sp)
    800022ae:	64e2                	ld	s1,24(sp)
    800022b0:	6942                	ld	s2,16(sp)
    800022b2:	69a2                	ld	s3,8(sp)
    800022b4:	6a02                	ld	s4,0(sp)
    800022b6:	6145                	addi	sp,sp,48
    800022b8:	8082                	ret

00000000800022ba <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    800022ba:	7179                	addi	sp,sp,-48
    800022bc:	f406                	sd	ra,40(sp)
    800022be:	f022                	sd	s0,32(sp)
    800022c0:	ec26                	sd	s1,24(sp)
    800022c2:	e84a                	sd	s2,16(sp)
    800022c4:	e44e                	sd	s3,8(sp)
    800022c6:	1800                	addi	s0,sp,48
    800022c8:	89aa                	mv	s3,a0
    800022ca:	892e                	mv	s2,a1
  acquire(&bcache.lock);
    800022cc:	0000c517          	auipc	a0,0xc
    800022d0:	45c50513          	addi	a0,a0,1116 # 8000e728 <bcache>
    800022d4:	00004097          	auipc	ra,0x4
    800022d8:	e48080e7          	jalr	-440(ra) # 8000611c <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    800022dc:	00014497          	auipc	s1,0x14
    800022e0:	7044b483          	ld	s1,1796(s1) # 800169e0 <bcache+0x82b8>
    800022e4:	00014797          	auipc	a5,0x14
    800022e8:	6ac78793          	addi	a5,a5,1708 # 80016990 <bcache+0x8268>
    800022ec:	02f48f63          	beq	s1,a5,8000232a <bread+0x70>
    800022f0:	873e                	mv	a4,a5
    800022f2:	a021                	j	800022fa <bread+0x40>
    800022f4:	68a4                	ld	s1,80(s1)
    800022f6:	02e48a63          	beq	s1,a4,8000232a <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    800022fa:	449c                	lw	a5,8(s1)
    800022fc:	ff379ce3          	bne	a5,s3,800022f4 <bread+0x3a>
    80002300:	44dc                	lw	a5,12(s1)
    80002302:	ff2799e3          	bne	a5,s2,800022f4 <bread+0x3a>
      b->refcnt++;
    80002306:	40bc                	lw	a5,64(s1)
    80002308:	2785                	addiw	a5,a5,1
    8000230a:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000230c:	0000c517          	auipc	a0,0xc
    80002310:	41c50513          	addi	a0,a0,1052 # 8000e728 <bcache>
    80002314:	00004097          	auipc	ra,0x4
    80002318:	ebc080e7          	jalr	-324(ra) # 800061d0 <release>
      acquiresleep(&b->lock);
    8000231c:	01048513          	addi	a0,s1,16
    80002320:	00001097          	auipc	ra,0x1
    80002324:	46e080e7          	jalr	1134(ra) # 8000378e <acquiresleep>
      return b;
    80002328:	a8b9                	j	80002386 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    8000232a:	00014497          	auipc	s1,0x14
    8000232e:	6ae4b483          	ld	s1,1710(s1) # 800169d8 <bcache+0x82b0>
    80002332:	00014797          	auipc	a5,0x14
    80002336:	65e78793          	addi	a5,a5,1630 # 80016990 <bcache+0x8268>
    8000233a:	00f48863          	beq	s1,a5,8000234a <bread+0x90>
    8000233e:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002340:	40bc                	lw	a5,64(s1)
    80002342:	cf81                	beqz	a5,8000235a <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002344:	64a4                	ld	s1,72(s1)
    80002346:	fee49de3          	bne	s1,a4,80002340 <bread+0x86>
  panic("bget: no buffers");
    8000234a:	00006517          	auipc	a0,0x6
    8000234e:	14650513          	addi	a0,a0,326 # 80008490 <syscalls+0xc0>
    80002352:	00004097          	auipc	ra,0x4
    80002356:	880080e7          	jalr	-1920(ra) # 80005bd2 <panic>
      b->dev = dev;
    8000235a:	0134a423          	sw	s3,8(s1)
      b->blockno = blockno;
    8000235e:	0124a623          	sw	s2,12(s1)
      b->valid = 0;
    80002362:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002366:	4785                	li	a5,1
    80002368:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000236a:	0000c517          	auipc	a0,0xc
    8000236e:	3be50513          	addi	a0,a0,958 # 8000e728 <bcache>
    80002372:	00004097          	auipc	ra,0x4
    80002376:	e5e080e7          	jalr	-418(ra) # 800061d0 <release>
      acquiresleep(&b->lock);
    8000237a:	01048513          	addi	a0,s1,16
    8000237e:	00001097          	auipc	ra,0x1
    80002382:	410080e7          	jalr	1040(ra) # 8000378e <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002386:	409c                	lw	a5,0(s1)
    80002388:	cb89                	beqz	a5,8000239a <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000238a:	8526                	mv	a0,s1
    8000238c:	70a2                	ld	ra,40(sp)
    8000238e:	7402                	ld	s0,32(sp)
    80002390:	64e2                	ld	s1,24(sp)
    80002392:	6942                	ld	s2,16(sp)
    80002394:	69a2                	ld	s3,8(sp)
    80002396:	6145                	addi	sp,sp,48
    80002398:	8082                	ret
    virtio_disk_rw(b, 0);
    8000239a:	4581                	li	a1,0
    8000239c:	8526                	mv	a0,s1
    8000239e:	00003097          	auipc	ra,0x3
    800023a2:	fca080e7          	jalr	-54(ra) # 80005368 <virtio_disk_rw>
    b->valid = 1;
    800023a6:	4785                	li	a5,1
    800023a8:	c09c                	sw	a5,0(s1)
  return b;
    800023aa:	b7c5                	j	8000238a <bread+0xd0>

00000000800023ac <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    800023ac:	1101                	addi	sp,sp,-32
    800023ae:	ec06                	sd	ra,24(sp)
    800023b0:	e822                	sd	s0,16(sp)
    800023b2:	e426                	sd	s1,8(sp)
    800023b4:	1000                	addi	s0,sp,32
    800023b6:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800023b8:	0541                	addi	a0,a0,16
    800023ba:	00001097          	auipc	ra,0x1
    800023be:	46e080e7          	jalr	1134(ra) # 80003828 <holdingsleep>
    800023c2:	cd01                	beqz	a0,800023da <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    800023c4:	4585                	li	a1,1
    800023c6:	8526                	mv	a0,s1
    800023c8:	00003097          	auipc	ra,0x3
    800023cc:	fa0080e7          	jalr	-96(ra) # 80005368 <virtio_disk_rw>
}
    800023d0:	60e2                	ld	ra,24(sp)
    800023d2:	6442                	ld	s0,16(sp)
    800023d4:	64a2                	ld	s1,8(sp)
    800023d6:	6105                	addi	sp,sp,32
    800023d8:	8082                	ret
    panic("bwrite");
    800023da:	00006517          	auipc	a0,0x6
    800023de:	0ce50513          	addi	a0,a0,206 # 800084a8 <syscalls+0xd8>
    800023e2:	00003097          	auipc	ra,0x3
    800023e6:	7f0080e7          	jalr	2032(ra) # 80005bd2 <panic>

00000000800023ea <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    800023ea:	1101                	addi	sp,sp,-32
    800023ec:	ec06                	sd	ra,24(sp)
    800023ee:	e822                	sd	s0,16(sp)
    800023f0:	e426                	sd	s1,8(sp)
    800023f2:	e04a                	sd	s2,0(sp)
    800023f4:	1000                	addi	s0,sp,32
    800023f6:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800023f8:	01050913          	addi	s2,a0,16
    800023fc:	854a                	mv	a0,s2
    800023fe:	00001097          	auipc	ra,0x1
    80002402:	42a080e7          	jalr	1066(ra) # 80003828 <holdingsleep>
    80002406:	c92d                	beqz	a0,80002478 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002408:	854a                	mv	a0,s2
    8000240a:	00001097          	auipc	ra,0x1
    8000240e:	3da080e7          	jalr	986(ra) # 800037e4 <releasesleep>

  acquire(&bcache.lock);
    80002412:	0000c517          	auipc	a0,0xc
    80002416:	31650513          	addi	a0,a0,790 # 8000e728 <bcache>
    8000241a:	00004097          	auipc	ra,0x4
    8000241e:	d02080e7          	jalr	-766(ra) # 8000611c <acquire>
  b->refcnt--;
    80002422:	40bc                	lw	a5,64(s1)
    80002424:	37fd                	addiw	a5,a5,-1
    80002426:	0007871b          	sext.w	a4,a5
    8000242a:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    8000242c:	eb05                	bnez	a4,8000245c <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    8000242e:	68bc                	ld	a5,80(s1)
    80002430:	64b8                	ld	a4,72(s1)
    80002432:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80002434:	64bc                	ld	a5,72(s1)
    80002436:	68b8                	ld	a4,80(s1)
    80002438:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    8000243a:	00014797          	auipc	a5,0x14
    8000243e:	2ee78793          	addi	a5,a5,750 # 80016728 <bcache+0x8000>
    80002442:	2b87b703          	ld	a4,696(a5)
    80002446:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80002448:	00014717          	auipc	a4,0x14
    8000244c:	54870713          	addi	a4,a4,1352 # 80016990 <bcache+0x8268>
    80002450:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002452:	2b87b703          	ld	a4,696(a5)
    80002456:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002458:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000245c:	0000c517          	auipc	a0,0xc
    80002460:	2cc50513          	addi	a0,a0,716 # 8000e728 <bcache>
    80002464:	00004097          	auipc	ra,0x4
    80002468:	d6c080e7          	jalr	-660(ra) # 800061d0 <release>
}
    8000246c:	60e2                	ld	ra,24(sp)
    8000246e:	6442                	ld	s0,16(sp)
    80002470:	64a2                	ld	s1,8(sp)
    80002472:	6902                	ld	s2,0(sp)
    80002474:	6105                	addi	sp,sp,32
    80002476:	8082                	ret
    panic("brelse");
    80002478:	00006517          	auipc	a0,0x6
    8000247c:	03850513          	addi	a0,a0,56 # 800084b0 <syscalls+0xe0>
    80002480:	00003097          	auipc	ra,0x3
    80002484:	752080e7          	jalr	1874(ra) # 80005bd2 <panic>

0000000080002488 <bpin>:

void
bpin(struct buf *b) {
    80002488:	1101                	addi	sp,sp,-32
    8000248a:	ec06                	sd	ra,24(sp)
    8000248c:	e822                	sd	s0,16(sp)
    8000248e:	e426                	sd	s1,8(sp)
    80002490:	1000                	addi	s0,sp,32
    80002492:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002494:	0000c517          	auipc	a0,0xc
    80002498:	29450513          	addi	a0,a0,660 # 8000e728 <bcache>
    8000249c:	00004097          	auipc	ra,0x4
    800024a0:	c80080e7          	jalr	-896(ra) # 8000611c <acquire>
  b->refcnt++;
    800024a4:	40bc                	lw	a5,64(s1)
    800024a6:	2785                	addiw	a5,a5,1
    800024a8:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800024aa:	0000c517          	auipc	a0,0xc
    800024ae:	27e50513          	addi	a0,a0,638 # 8000e728 <bcache>
    800024b2:	00004097          	auipc	ra,0x4
    800024b6:	d1e080e7          	jalr	-738(ra) # 800061d0 <release>
}
    800024ba:	60e2                	ld	ra,24(sp)
    800024bc:	6442                	ld	s0,16(sp)
    800024be:	64a2                	ld	s1,8(sp)
    800024c0:	6105                	addi	sp,sp,32
    800024c2:	8082                	ret

00000000800024c4 <bunpin>:

void
bunpin(struct buf *b) {
    800024c4:	1101                	addi	sp,sp,-32
    800024c6:	ec06                	sd	ra,24(sp)
    800024c8:	e822                	sd	s0,16(sp)
    800024ca:	e426                	sd	s1,8(sp)
    800024cc:	1000                	addi	s0,sp,32
    800024ce:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    800024d0:	0000c517          	auipc	a0,0xc
    800024d4:	25850513          	addi	a0,a0,600 # 8000e728 <bcache>
    800024d8:	00004097          	auipc	ra,0x4
    800024dc:	c44080e7          	jalr	-956(ra) # 8000611c <acquire>
  b->refcnt--;
    800024e0:	40bc                	lw	a5,64(s1)
    800024e2:	37fd                	addiw	a5,a5,-1
    800024e4:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800024e6:	0000c517          	auipc	a0,0xc
    800024ea:	24250513          	addi	a0,a0,578 # 8000e728 <bcache>
    800024ee:	00004097          	auipc	ra,0x4
    800024f2:	ce2080e7          	jalr	-798(ra) # 800061d0 <release>
}
    800024f6:	60e2                	ld	ra,24(sp)
    800024f8:	6442                	ld	s0,16(sp)
    800024fa:	64a2                	ld	s1,8(sp)
    800024fc:	6105                	addi	sp,sp,32
    800024fe:	8082                	ret

0000000080002500 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    80002500:	1101                	addi	sp,sp,-32
    80002502:	ec06                	sd	ra,24(sp)
    80002504:	e822                	sd	s0,16(sp)
    80002506:	e426                	sd	s1,8(sp)
    80002508:	e04a                	sd	s2,0(sp)
    8000250a:	1000                	addi	s0,sp,32
    8000250c:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    8000250e:	00d5d59b          	srliw	a1,a1,0xd
    80002512:	00015797          	auipc	a5,0x15
    80002516:	8f27a783          	lw	a5,-1806(a5) # 80016e04 <sb+0x1c>
    8000251a:	9dbd                	addw	a1,a1,a5
    8000251c:	00000097          	auipc	ra,0x0
    80002520:	d9e080e7          	jalr	-610(ra) # 800022ba <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    80002524:	0074f713          	andi	a4,s1,7
    80002528:	4785                	li	a5,1
    8000252a:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    8000252e:	14ce                	slli	s1,s1,0x33
    80002530:	90d9                	srli	s1,s1,0x36
    80002532:	00950733          	add	a4,a0,s1
    80002536:	05874703          	lbu	a4,88(a4)
    8000253a:	00e7f6b3          	and	a3,a5,a4
    8000253e:	c69d                	beqz	a3,8000256c <bfree+0x6c>
    80002540:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    80002542:	94aa                	add	s1,s1,a0
    80002544:	fff7c793          	not	a5,a5
    80002548:	8ff9                	and	a5,a5,a4
    8000254a:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    8000254e:	00001097          	auipc	ra,0x1
    80002552:	120080e7          	jalr	288(ra) # 8000366e <log_write>
  brelse(bp);
    80002556:	854a                	mv	a0,s2
    80002558:	00000097          	auipc	ra,0x0
    8000255c:	e92080e7          	jalr	-366(ra) # 800023ea <brelse>
}
    80002560:	60e2                	ld	ra,24(sp)
    80002562:	6442                	ld	s0,16(sp)
    80002564:	64a2                	ld	s1,8(sp)
    80002566:	6902                	ld	s2,0(sp)
    80002568:	6105                	addi	sp,sp,32
    8000256a:	8082                	ret
    panic("freeing free block");
    8000256c:	00006517          	auipc	a0,0x6
    80002570:	f4c50513          	addi	a0,a0,-180 # 800084b8 <syscalls+0xe8>
    80002574:	00003097          	auipc	ra,0x3
    80002578:	65e080e7          	jalr	1630(ra) # 80005bd2 <panic>

000000008000257c <balloc>:
{
    8000257c:	711d                	addi	sp,sp,-96
    8000257e:	ec86                	sd	ra,88(sp)
    80002580:	e8a2                	sd	s0,80(sp)
    80002582:	e4a6                	sd	s1,72(sp)
    80002584:	e0ca                	sd	s2,64(sp)
    80002586:	fc4e                	sd	s3,56(sp)
    80002588:	f852                	sd	s4,48(sp)
    8000258a:	f456                	sd	s5,40(sp)
    8000258c:	f05a                	sd	s6,32(sp)
    8000258e:	ec5e                	sd	s7,24(sp)
    80002590:	e862                	sd	s8,16(sp)
    80002592:	e466                	sd	s9,8(sp)
    80002594:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80002596:	00015797          	auipc	a5,0x15
    8000259a:	8567a783          	lw	a5,-1962(a5) # 80016dec <sb+0x4>
    8000259e:	10078163          	beqz	a5,800026a0 <balloc+0x124>
    800025a2:	8baa                	mv	s7,a0
    800025a4:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    800025a6:	00015b17          	auipc	s6,0x15
    800025aa:	842b0b13          	addi	s6,s6,-1982 # 80016de8 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800025ae:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    800025b0:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800025b2:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    800025b4:	6c89                	lui	s9,0x2
    800025b6:	a061                	j	8000263e <balloc+0xc2>
        bp->data[bi/8] |= m;  // Mark block in use.
    800025b8:	974a                	add	a4,a4,s2
    800025ba:	8fd5                	or	a5,a5,a3
    800025bc:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    800025c0:	854a                	mv	a0,s2
    800025c2:	00001097          	auipc	ra,0x1
    800025c6:	0ac080e7          	jalr	172(ra) # 8000366e <log_write>
        brelse(bp);
    800025ca:	854a                	mv	a0,s2
    800025cc:	00000097          	auipc	ra,0x0
    800025d0:	e1e080e7          	jalr	-482(ra) # 800023ea <brelse>
  bp = bread(dev, bno);
    800025d4:	85a6                	mv	a1,s1
    800025d6:	855e                	mv	a0,s7
    800025d8:	00000097          	auipc	ra,0x0
    800025dc:	ce2080e7          	jalr	-798(ra) # 800022ba <bread>
    800025e0:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    800025e2:	40000613          	li	a2,1024
    800025e6:	4581                	li	a1,0
    800025e8:	05850513          	addi	a0,a0,88
    800025ec:	ffffe097          	auipc	ra,0xffffe
    800025f0:	b8c080e7          	jalr	-1140(ra) # 80000178 <memset>
  log_write(bp);
    800025f4:	854a                	mv	a0,s2
    800025f6:	00001097          	auipc	ra,0x1
    800025fa:	078080e7          	jalr	120(ra) # 8000366e <log_write>
  brelse(bp);
    800025fe:	854a                	mv	a0,s2
    80002600:	00000097          	auipc	ra,0x0
    80002604:	dea080e7          	jalr	-534(ra) # 800023ea <brelse>
}
    80002608:	8526                	mv	a0,s1
    8000260a:	60e6                	ld	ra,88(sp)
    8000260c:	6446                	ld	s0,80(sp)
    8000260e:	64a6                	ld	s1,72(sp)
    80002610:	6906                	ld	s2,64(sp)
    80002612:	79e2                	ld	s3,56(sp)
    80002614:	7a42                	ld	s4,48(sp)
    80002616:	7aa2                	ld	s5,40(sp)
    80002618:	7b02                	ld	s6,32(sp)
    8000261a:	6be2                	ld	s7,24(sp)
    8000261c:	6c42                	ld	s8,16(sp)
    8000261e:	6ca2                	ld	s9,8(sp)
    80002620:	6125                	addi	sp,sp,96
    80002622:	8082                	ret
    brelse(bp);
    80002624:	854a                	mv	a0,s2
    80002626:	00000097          	auipc	ra,0x0
    8000262a:	dc4080e7          	jalr	-572(ra) # 800023ea <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000262e:	015c87bb          	addw	a5,s9,s5
    80002632:	00078a9b          	sext.w	s5,a5
    80002636:	004b2703          	lw	a4,4(s6)
    8000263a:	06eaf363          	bgeu	s5,a4,800026a0 <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
    8000263e:	41fad79b          	sraiw	a5,s5,0x1f
    80002642:	0137d79b          	srliw	a5,a5,0x13
    80002646:	015787bb          	addw	a5,a5,s5
    8000264a:	40d7d79b          	sraiw	a5,a5,0xd
    8000264e:	01cb2583          	lw	a1,28(s6)
    80002652:	9dbd                	addw	a1,a1,a5
    80002654:	855e                	mv	a0,s7
    80002656:	00000097          	auipc	ra,0x0
    8000265a:	c64080e7          	jalr	-924(ra) # 800022ba <bread>
    8000265e:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002660:	004b2503          	lw	a0,4(s6)
    80002664:	000a849b          	sext.w	s1,s5
    80002668:	8662                	mv	a2,s8
    8000266a:	faa4fde3          	bgeu	s1,a0,80002624 <balloc+0xa8>
      m = 1 << (bi % 8);
    8000266e:	41f6579b          	sraiw	a5,a2,0x1f
    80002672:	01d7d69b          	srliw	a3,a5,0x1d
    80002676:	00c6873b          	addw	a4,a3,a2
    8000267a:	00777793          	andi	a5,a4,7
    8000267e:	9f95                	subw	a5,a5,a3
    80002680:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    80002684:	4037571b          	sraiw	a4,a4,0x3
    80002688:	00e906b3          	add	a3,s2,a4
    8000268c:	0586c683          	lbu	a3,88(a3)
    80002690:	00d7f5b3          	and	a1,a5,a3
    80002694:	d195                	beqz	a1,800025b8 <balloc+0x3c>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80002696:	2605                	addiw	a2,a2,1
    80002698:	2485                	addiw	s1,s1,1
    8000269a:	fd4618e3          	bne	a2,s4,8000266a <balloc+0xee>
    8000269e:	b759                	j	80002624 <balloc+0xa8>
  printf("balloc: out of blocks\n");
    800026a0:	00006517          	auipc	a0,0x6
    800026a4:	e3050513          	addi	a0,a0,-464 # 800084d0 <syscalls+0x100>
    800026a8:	00003097          	auipc	ra,0x3
    800026ac:	574080e7          	jalr	1396(ra) # 80005c1c <printf>
  return 0;
    800026b0:	4481                	li	s1,0
    800026b2:	bf99                	j	80002608 <balloc+0x8c>

00000000800026b4 <bmap>:
// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
// returns 0 if out of disk space.
static uint
bmap(struct inode *ip, uint bn)
{
    800026b4:	7179                	addi	sp,sp,-48
    800026b6:	f406                	sd	ra,40(sp)
    800026b8:	f022                	sd	s0,32(sp)
    800026ba:	ec26                	sd	s1,24(sp)
    800026bc:	e84a                	sd	s2,16(sp)
    800026be:	e44e                	sd	s3,8(sp)
    800026c0:	e052                	sd	s4,0(sp)
    800026c2:	1800                	addi	s0,sp,48
    800026c4:	89aa                	mv	s3,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    800026c6:	47ad                	li	a5,11
    800026c8:	02b7e763          	bltu	a5,a1,800026f6 <bmap+0x42>
    if((addr = ip->addrs[bn]) == 0){
    800026cc:	02059493          	slli	s1,a1,0x20
    800026d0:	9081                	srli	s1,s1,0x20
    800026d2:	048a                	slli	s1,s1,0x2
    800026d4:	94aa                	add	s1,s1,a0
    800026d6:	0504a903          	lw	s2,80(s1)
    800026da:	06091e63          	bnez	s2,80002756 <bmap+0xa2>
      addr = balloc(ip->dev);
    800026de:	4108                	lw	a0,0(a0)
    800026e0:	00000097          	auipc	ra,0x0
    800026e4:	e9c080e7          	jalr	-356(ra) # 8000257c <balloc>
    800026e8:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    800026ec:	06090563          	beqz	s2,80002756 <bmap+0xa2>
        return 0;
      ip->addrs[bn] = addr;
    800026f0:	0524a823          	sw	s2,80(s1)
    800026f4:	a08d                	j	80002756 <bmap+0xa2>
    }
    return addr;
  }
  bn -= NDIRECT;
    800026f6:	ff45849b          	addiw	s1,a1,-12
    800026fa:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    800026fe:	0ff00793          	li	a5,255
    80002702:	08e7e563          	bltu	a5,a4,8000278c <bmap+0xd8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0){
    80002706:	08052903          	lw	s2,128(a0)
    8000270a:	00091d63          	bnez	s2,80002724 <bmap+0x70>
      addr = balloc(ip->dev);
    8000270e:	4108                	lw	a0,0(a0)
    80002710:	00000097          	auipc	ra,0x0
    80002714:	e6c080e7          	jalr	-404(ra) # 8000257c <balloc>
    80002718:	0005091b          	sext.w	s2,a0
      if(addr == 0)
    8000271c:	02090d63          	beqz	s2,80002756 <bmap+0xa2>
        return 0;
      ip->addrs[NDIRECT] = addr;
    80002720:	0929a023          	sw	s2,128(s3)
    }
    bp = bread(ip->dev, addr);
    80002724:	85ca                	mv	a1,s2
    80002726:	0009a503          	lw	a0,0(s3)
    8000272a:	00000097          	auipc	ra,0x0
    8000272e:	b90080e7          	jalr	-1136(ra) # 800022ba <bread>
    80002732:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    80002734:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    80002738:	02049593          	slli	a1,s1,0x20
    8000273c:	9181                	srli	a1,a1,0x20
    8000273e:	058a                	slli	a1,a1,0x2
    80002740:	00b784b3          	add	s1,a5,a1
    80002744:	0004a903          	lw	s2,0(s1)
    80002748:	02090063          	beqz	s2,80002768 <bmap+0xb4>
      if(addr){
        a[bn] = addr;
        log_write(bp);
      }
    }
    brelse(bp);
    8000274c:	8552                	mv	a0,s4
    8000274e:	00000097          	auipc	ra,0x0
    80002752:	c9c080e7          	jalr	-868(ra) # 800023ea <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    80002756:	854a                	mv	a0,s2
    80002758:	70a2                	ld	ra,40(sp)
    8000275a:	7402                	ld	s0,32(sp)
    8000275c:	64e2                	ld	s1,24(sp)
    8000275e:	6942                	ld	s2,16(sp)
    80002760:	69a2                	ld	s3,8(sp)
    80002762:	6a02                	ld	s4,0(sp)
    80002764:	6145                	addi	sp,sp,48
    80002766:	8082                	ret
      addr = balloc(ip->dev);
    80002768:	0009a503          	lw	a0,0(s3)
    8000276c:	00000097          	auipc	ra,0x0
    80002770:	e10080e7          	jalr	-496(ra) # 8000257c <balloc>
    80002774:	0005091b          	sext.w	s2,a0
      if(addr){
    80002778:	fc090ae3          	beqz	s2,8000274c <bmap+0x98>
        a[bn] = addr;
    8000277c:	0124a023          	sw	s2,0(s1)
        log_write(bp);
    80002780:	8552                	mv	a0,s4
    80002782:	00001097          	auipc	ra,0x1
    80002786:	eec080e7          	jalr	-276(ra) # 8000366e <log_write>
    8000278a:	b7c9                	j	8000274c <bmap+0x98>
  panic("bmap: out of range");
    8000278c:	00006517          	auipc	a0,0x6
    80002790:	d5c50513          	addi	a0,a0,-676 # 800084e8 <syscalls+0x118>
    80002794:	00003097          	auipc	ra,0x3
    80002798:	43e080e7          	jalr	1086(ra) # 80005bd2 <panic>

000000008000279c <iget>:
{
    8000279c:	7179                	addi	sp,sp,-48
    8000279e:	f406                	sd	ra,40(sp)
    800027a0:	f022                	sd	s0,32(sp)
    800027a2:	ec26                	sd	s1,24(sp)
    800027a4:	e84a                	sd	s2,16(sp)
    800027a6:	e44e                	sd	s3,8(sp)
    800027a8:	e052                	sd	s4,0(sp)
    800027aa:	1800                	addi	s0,sp,48
    800027ac:	89aa                	mv	s3,a0
    800027ae:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    800027b0:	00014517          	auipc	a0,0x14
    800027b4:	65850513          	addi	a0,a0,1624 # 80016e08 <itable>
    800027b8:	00004097          	auipc	ra,0x4
    800027bc:	964080e7          	jalr	-1692(ra) # 8000611c <acquire>
  empty = 0;
    800027c0:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800027c2:	00014497          	auipc	s1,0x14
    800027c6:	65e48493          	addi	s1,s1,1630 # 80016e20 <itable+0x18>
    800027ca:	00016697          	auipc	a3,0x16
    800027ce:	0e668693          	addi	a3,a3,230 # 800188b0 <log>
    800027d2:	a039                	j	800027e0 <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800027d4:	02090b63          	beqz	s2,8000280a <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    800027d8:	08848493          	addi	s1,s1,136
    800027dc:	02d48a63          	beq	s1,a3,80002810 <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    800027e0:	449c                	lw	a5,8(s1)
    800027e2:	fef059e3          	blez	a5,800027d4 <iget+0x38>
    800027e6:	4098                	lw	a4,0(s1)
    800027e8:	ff3716e3          	bne	a4,s3,800027d4 <iget+0x38>
    800027ec:	40d8                	lw	a4,4(s1)
    800027ee:	ff4713e3          	bne	a4,s4,800027d4 <iget+0x38>
      ip->ref++;
    800027f2:	2785                	addiw	a5,a5,1
    800027f4:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800027f6:	00014517          	auipc	a0,0x14
    800027fa:	61250513          	addi	a0,a0,1554 # 80016e08 <itable>
    800027fe:	00004097          	auipc	ra,0x4
    80002802:	9d2080e7          	jalr	-1582(ra) # 800061d0 <release>
      return ip;
    80002806:	8926                	mv	s2,s1
    80002808:	a03d                	j	80002836 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    8000280a:	f7f9                	bnez	a5,800027d8 <iget+0x3c>
    8000280c:	8926                	mv	s2,s1
    8000280e:	b7e9                	j	800027d8 <iget+0x3c>
  if(empty == 0)
    80002810:	02090c63          	beqz	s2,80002848 <iget+0xac>
  ip->dev = dev;
    80002814:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    80002818:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    8000281c:	4785                	li	a5,1
    8000281e:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002822:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    80002826:	00014517          	auipc	a0,0x14
    8000282a:	5e250513          	addi	a0,a0,1506 # 80016e08 <itable>
    8000282e:	00004097          	auipc	ra,0x4
    80002832:	9a2080e7          	jalr	-1630(ra) # 800061d0 <release>
}
    80002836:	854a                	mv	a0,s2
    80002838:	70a2                	ld	ra,40(sp)
    8000283a:	7402                	ld	s0,32(sp)
    8000283c:	64e2                	ld	s1,24(sp)
    8000283e:	6942                	ld	s2,16(sp)
    80002840:	69a2                	ld	s3,8(sp)
    80002842:	6a02                	ld	s4,0(sp)
    80002844:	6145                	addi	sp,sp,48
    80002846:	8082                	ret
    panic("iget: no inodes");
    80002848:	00006517          	auipc	a0,0x6
    8000284c:	cb850513          	addi	a0,a0,-840 # 80008500 <syscalls+0x130>
    80002850:	00003097          	auipc	ra,0x3
    80002854:	382080e7          	jalr	898(ra) # 80005bd2 <panic>

0000000080002858 <fsinit>:
fsinit(int dev) {
    80002858:	7179                	addi	sp,sp,-48
    8000285a:	f406                	sd	ra,40(sp)
    8000285c:	f022                	sd	s0,32(sp)
    8000285e:	ec26                	sd	s1,24(sp)
    80002860:	e84a                	sd	s2,16(sp)
    80002862:	e44e                	sd	s3,8(sp)
    80002864:	1800                	addi	s0,sp,48
    80002866:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80002868:	4585                	li	a1,1
    8000286a:	00000097          	auipc	ra,0x0
    8000286e:	a50080e7          	jalr	-1456(ra) # 800022ba <bread>
    80002872:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    80002874:	00014997          	auipc	s3,0x14
    80002878:	57498993          	addi	s3,s3,1396 # 80016de8 <sb>
    8000287c:	02000613          	li	a2,32
    80002880:	05850593          	addi	a1,a0,88
    80002884:	854e                	mv	a0,s3
    80002886:	ffffe097          	auipc	ra,0xffffe
    8000288a:	952080e7          	jalr	-1710(ra) # 800001d8 <memmove>
  brelse(bp);
    8000288e:	8526                	mv	a0,s1
    80002890:	00000097          	auipc	ra,0x0
    80002894:	b5a080e7          	jalr	-1190(ra) # 800023ea <brelse>
  if(sb.magic != FSMAGIC)
    80002898:	0009a703          	lw	a4,0(s3)
    8000289c:	102037b7          	lui	a5,0x10203
    800028a0:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    800028a4:	02f71263          	bne	a4,a5,800028c8 <fsinit+0x70>
  initlog(dev, &sb);
    800028a8:	00014597          	auipc	a1,0x14
    800028ac:	54058593          	addi	a1,a1,1344 # 80016de8 <sb>
    800028b0:	854a                	mv	a0,s2
    800028b2:	00001097          	auipc	ra,0x1
    800028b6:	b40080e7          	jalr	-1216(ra) # 800033f2 <initlog>
}
    800028ba:	70a2                	ld	ra,40(sp)
    800028bc:	7402                	ld	s0,32(sp)
    800028be:	64e2                	ld	s1,24(sp)
    800028c0:	6942                	ld	s2,16(sp)
    800028c2:	69a2                	ld	s3,8(sp)
    800028c4:	6145                	addi	sp,sp,48
    800028c6:	8082                	ret
    panic("invalid file system");
    800028c8:	00006517          	auipc	a0,0x6
    800028cc:	c4850513          	addi	a0,a0,-952 # 80008510 <syscalls+0x140>
    800028d0:	00003097          	auipc	ra,0x3
    800028d4:	302080e7          	jalr	770(ra) # 80005bd2 <panic>

00000000800028d8 <iinit>:
{
    800028d8:	7179                	addi	sp,sp,-48
    800028da:	f406                	sd	ra,40(sp)
    800028dc:	f022                	sd	s0,32(sp)
    800028de:	ec26                	sd	s1,24(sp)
    800028e0:	e84a                	sd	s2,16(sp)
    800028e2:	e44e                	sd	s3,8(sp)
    800028e4:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800028e6:	00006597          	auipc	a1,0x6
    800028ea:	c4258593          	addi	a1,a1,-958 # 80008528 <syscalls+0x158>
    800028ee:	00014517          	auipc	a0,0x14
    800028f2:	51a50513          	addi	a0,a0,1306 # 80016e08 <itable>
    800028f6:	00003097          	auipc	ra,0x3
    800028fa:	796080e7          	jalr	1942(ra) # 8000608c <initlock>
  for(i = 0; i < NINODE; i++) {
    800028fe:	00014497          	auipc	s1,0x14
    80002902:	53248493          	addi	s1,s1,1330 # 80016e30 <itable+0x28>
    80002906:	00016997          	auipc	s3,0x16
    8000290a:	fba98993          	addi	s3,s3,-70 # 800188c0 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    8000290e:	00006917          	auipc	s2,0x6
    80002912:	c2290913          	addi	s2,s2,-990 # 80008530 <syscalls+0x160>
    80002916:	85ca                	mv	a1,s2
    80002918:	8526                	mv	a0,s1
    8000291a:	00001097          	auipc	ra,0x1
    8000291e:	e3a080e7          	jalr	-454(ra) # 80003754 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    80002922:	08848493          	addi	s1,s1,136
    80002926:	ff3498e3          	bne	s1,s3,80002916 <iinit+0x3e>
}
    8000292a:	70a2                	ld	ra,40(sp)
    8000292c:	7402                	ld	s0,32(sp)
    8000292e:	64e2                	ld	s1,24(sp)
    80002930:	6942                	ld	s2,16(sp)
    80002932:	69a2                	ld	s3,8(sp)
    80002934:	6145                	addi	sp,sp,48
    80002936:	8082                	ret

0000000080002938 <ialloc>:
{
    80002938:	715d                	addi	sp,sp,-80
    8000293a:	e486                	sd	ra,72(sp)
    8000293c:	e0a2                	sd	s0,64(sp)
    8000293e:	fc26                	sd	s1,56(sp)
    80002940:	f84a                	sd	s2,48(sp)
    80002942:	f44e                	sd	s3,40(sp)
    80002944:	f052                	sd	s4,32(sp)
    80002946:	ec56                	sd	s5,24(sp)
    80002948:	e85a                	sd	s6,16(sp)
    8000294a:	e45e                	sd	s7,8(sp)
    8000294c:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    8000294e:	00014717          	auipc	a4,0x14
    80002952:	4a672703          	lw	a4,1190(a4) # 80016df4 <sb+0xc>
    80002956:	4785                	li	a5,1
    80002958:	04e7fa63          	bgeu	a5,a4,800029ac <ialloc+0x74>
    8000295c:	8aaa                	mv	s5,a0
    8000295e:	8bae                	mv	s7,a1
    80002960:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    80002962:	00014a17          	auipc	s4,0x14
    80002966:	486a0a13          	addi	s4,s4,1158 # 80016de8 <sb>
    8000296a:	00048b1b          	sext.w	s6,s1
    8000296e:	0044d593          	srli	a1,s1,0x4
    80002972:	018a2783          	lw	a5,24(s4)
    80002976:	9dbd                	addw	a1,a1,a5
    80002978:	8556                	mv	a0,s5
    8000297a:	00000097          	auipc	ra,0x0
    8000297e:	940080e7          	jalr	-1728(ra) # 800022ba <bread>
    80002982:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    80002984:	05850993          	addi	s3,a0,88
    80002988:	00f4f793          	andi	a5,s1,15
    8000298c:	079a                	slli	a5,a5,0x6
    8000298e:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    80002990:	00099783          	lh	a5,0(s3)
    80002994:	c3a1                	beqz	a5,800029d4 <ialloc+0x9c>
    brelse(bp);
    80002996:	00000097          	auipc	ra,0x0
    8000299a:	a54080e7          	jalr	-1452(ra) # 800023ea <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    8000299e:	0485                	addi	s1,s1,1
    800029a0:	00ca2703          	lw	a4,12(s4)
    800029a4:	0004879b          	sext.w	a5,s1
    800029a8:	fce7e1e3          	bltu	a5,a4,8000296a <ialloc+0x32>
  printf("ialloc: no inodes\n");
    800029ac:	00006517          	auipc	a0,0x6
    800029b0:	b8c50513          	addi	a0,a0,-1140 # 80008538 <syscalls+0x168>
    800029b4:	00003097          	auipc	ra,0x3
    800029b8:	268080e7          	jalr	616(ra) # 80005c1c <printf>
  return 0;
    800029bc:	4501                	li	a0,0
}
    800029be:	60a6                	ld	ra,72(sp)
    800029c0:	6406                	ld	s0,64(sp)
    800029c2:	74e2                	ld	s1,56(sp)
    800029c4:	7942                	ld	s2,48(sp)
    800029c6:	79a2                	ld	s3,40(sp)
    800029c8:	7a02                	ld	s4,32(sp)
    800029ca:	6ae2                	ld	s5,24(sp)
    800029cc:	6b42                	ld	s6,16(sp)
    800029ce:	6ba2                	ld	s7,8(sp)
    800029d0:	6161                	addi	sp,sp,80
    800029d2:	8082                	ret
      memset(dip, 0, sizeof(*dip));
    800029d4:	04000613          	li	a2,64
    800029d8:	4581                	li	a1,0
    800029da:	854e                	mv	a0,s3
    800029dc:	ffffd097          	auipc	ra,0xffffd
    800029e0:	79c080e7          	jalr	1948(ra) # 80000178 <memset>
      dip->type = type;
    800029e4:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    800029e8:	854a                	mv	a0,s2
    800029ea:	00001097          	auipc	ra,0x1
    800029ee:	c84080e7          	jalr	-892(ra) # 8000366e <log_write>
      brelse(bp);
    800029f2:	854a                	mv	a0,s2
    800029f4:	00000097          	auipc	ra,0x0
    800029f8:	9f6080e7          	jalr	-1546(ra) # 800023ea <brelse>
      return iget(dev, inum);
    800029fc:	85da                	mv	a1,s6
    800029fe:	8556                	mv	a0,s5
    80002a00:	00000097          	auipc	ra,0x0
    80002a04:	d9c080e7          	jalr	-612(ra) # 8000279c <iget>
    80002a08:	bf5d                	j	800029be <ialloc+0x86>

0000000080002a0a <iupdate>:
{
    80002a0a:	1101                	addi	sp,sp,-32
    80002a0c:	ec06                	sd	ra,24(sp)
    80002a0e:	e822                	sd	s0,16(sp)
    80002a10:	e426                	sd	s1,8(sp)
    80002a12:	e04a                	sd	s2,0(sp)
    80002a14:	1000                	addi	s0,sp,32
    80002a16:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002a18:	415c                	lw	a5,4(a0)
    80002a1a:	0047d79b          	srliw	a5,a5,0x4
    80002a1e:	00014597          	auipc	a1,0x14
    80002a22:	3e25a583          	lw	a1,994(a1) # 80016e00 <sb+0x18>
    80002a26:	9dbd                	addw	a1,a1,a5
    80002a28:	4108                	lw	a0,0(a0)
    80002a2a:	00000097          	auipc	ra,0x0
    80002a2e:	890080e7          	jalr	-1904(ra) # 800022ba <bread>
    80002a32:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002a34:	05850793          	addi	a5,a0,88
    80002a38:	40c8                	lw	a0,4(s1)
    80002a3a:	893d                	andi	a0,a0,15
    80002a3c:	051a                	slli	a0,a0,0x6
    80002a3e:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    80002a40:	04449703          	lh	a4,68(s1)
    80002a44:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    80002a48:	04649703          	lh	a4,70(s1)
    80002a4c:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    80002a50:	04849703          	lh	a4,72(s1)
    80002a54:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    80002a58:	04a49703          	lh	a4,74(s1)
    80002a5c:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    80002a60:	44f8                	lw	a4,76(s1)
    80002a62:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    80002a64:	03400613          	li	a2,52
    80002a68:	05048593          	addi	a1,s1,80
    80002a6c:	0531                	addi	a0,a0,12
    80002a6e:	ffffd097          	auipc	ra,0xffffd
    80002a72:	76a080e7          	jalr	1898(ra) # 800001d8 <memmove>
  log_write(bp);
    80002a76:	854a                	mv	a0,s2
    80002a78:	00001097          	auipc	ra,0x1
    80002a7c:	bf6080e7          	jalr	-1034(ra) # 8000366e <log_write>
  brelse(bp);
    80002a80:	854a                	mv	a0,s2
    80002a82:	00000097          	auipc	ra,0x0
    80002a86:	968080e7          	jalr	-1688(ra) # 800023ea <brelse>
}
    80002a8a:	60e2                	ld	ra,24(sp)
    80002a8c:	6442                	ld	s0,16(sp)
    80002a8e:	64a2                	ld	s1,8(sp)
    80002a90:	6902                	ld	s2,0(sp)
    80002a92:	6105                	addi	sp,sp,32
    80002a94:	8082                	ret

0000000080002a96 <idup>:
{
    80002a96:	1101                	addi	sp,sp,-32
    80002a98:	ec06                	sd	ra,24(sp)
    80002a9a:	e822                	sd	s0,16(sp)
    80002a9c:	e426                	sd	s1,8(sp)
    80002a9e:	1000                	addi	s0,sp,32
    80002aa0:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002aa2:	00014517          	auipc	a0,0x14
    80002aa6:	36650513          	addi	a0,a0,870 # 80016e08 <itable>
    80002aaa:	00003097          	auipc	ra,0x3
    80002aae:	672080e7          	jalr	1650(ra) # 8000611c <acquire>
  ip->ref++;
    80002ab2:	449c                	lw	a5,8(s1)
    80002ab4:	2785                	addiw	a5,a5,1
    80002ab6:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002ab8:	00014517          	auipc	a0,0x14
    80002abc:	35050513          	addi	a0,a0,848 # 80016e08 <itable>
    80002ac0:	00003097          	auipc	ra,0x3
    80002ac4:	710080e7          	jalr	1808(ra) # 800061d0 <release>
}
    80002ac8:	8526                	mv	a0,s1
    80002aca:	60e2                	ld	ra,24(sp)
    80002acc:	6442                	ld	s0,16(sp)
    80002ace:	64a2                	ld	s1,8(sp)
    80002ad0:	6105                	addi	sp,sp,32
    80002ad2:	8082                	ret

0000000080002ad4 <ilock>:
{
    80002ad4:	1101                	addi	sp,sp,-32
    80002ad6:	ec06                	sd	ra,24(sp)
    80002ad8:	e822                	sd	s0,16(sp)
    80002ada:	e426                	sd	s1,8(sp)
    80002adc:	e04a                	sd	s2,0(sp)
    80002ade:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80002ae0:	c115                	beqz	a0,80002b04 <ilock+0x30>
    80002ae2:	84aa                	mv	s1,a0
    80002ae4:	451c                	lw	a5,8(a0)
    80002ae6:	00f05f63          	blez	a5,80002b04 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002aea:	0541                	addi	a0,a0,16
    80002aec:	00001097          	auipc	ra,0x1
    80002af0:	ca2080e7          	jalr	-862(ra) # 8000378e <acquiresleep>
  if(ip->valid == 0){
    80002af4:	40bc                	lw	a5,64(s1)
    80002af6:	cf99                	beqz	a5,80002b14 <ilock+0x40>
}
    80002af8:	60e2                	ld	ra,24(sp)
    80002afa:	6442                	ld	s0,16(sp)
    80002afc:	64a2                	ld	s1,8(sp)
    80002afe:	6902                	ld	s2,0(sp)
    80002b00:	6105                	addi	sp,sp,32
    80002b02:	8082                	ret
    panic("ilock");
    80002b04:	00006517          	auipc	a0,0x6
    80002b08:	a4c50513          	addi	a0,a0,-1460 # 80008550 <syscalls+0x180>
    80002b0c:	00003097          	auipc	ra,0x3
    80002b10:	0c6080e7          	jalr	198(ra) # 80005bd2 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002b14:	40dc                	lw	a5,4(s1)
    80002b16:	0047d79b          	srliw	a5,a5,0x4
    80002b1a:	00014597          	auipc	a1,0x14
    80002b1e:	2e65a583          	lw	a1,742(a1) # 80016e00 <sb+0x18>
    80002b22:	9dbd                	addw	a1,a1,a5
    80002b24:	4088                	lw	a0,0(s1)
    80002b26:	fffff097          	auipc	ra,0xfffff
    80002b2a:	794080e7          	jalr	1940(ra) # 800022ba <bread>
    80002b2e:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    80002b30:	05850593          	addi	a1,a0,88
    80002b34:	40dc                	lw	a5,4(s1)
    80002b36:	8bbd                	andi	a5,a5,15
    80002b38:	079a                	slli	a5,a5,0x6
    80002b3a:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002b3c:	00059783          	lh	a5,0(a1)
    80002b40:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002b44:	00259783          	lh	a5,2(a1)
    80002b48:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002b4c:	00459783          	lh	a5,4(a1)
    80002b50:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002b54:	00659783          	lh	a5,6(a1)
    80002b58:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002b5c:	459c                	lw	a5,8(a1)
    80002b5e:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002b60:	03400613          	li	a2,52
    80002b64:	05b1                	addi	a1,a1,12
    80002b66:	05048513          	addi	a0,s1,80
    80002b6a:	ffffd097          	auipc	ra,0xffffd
    80002b6e:	66e080e7          	jalr	1646(ra) # 800001d8 <memmove>
    brelse(bp);
    80002b72:	854a                	mv	a0,s2
    80002b74:	00000097          	auipc	ra,0x0
    80002b78:	876080e7          	jalr	-1930(ra) # 800023ea <brelse>
    ip->valid = 1;
    80002b7c:	4785                	li	a5,1
    80002b7e:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80002b80:	04449783          	lh	a5,68(s1)
    80002b84:	fbb5                	bnez	a5,80002af8 <ilock+0x24>
      panic("ilock: no type");
    80002b86:	00006517          	auipc	a0,0x6
    80002b8a:	9d250513          	addi	a0,a0,-1582 # 80008558 <syscalls+0x188>
    80002b8e:	00003097          	auipc	ra,0x3
    80002b92:	044080e7          	jalr	68(ra) # 80005bd2 <panic>

0000000080002b96 <iunlock>:
{
    80002b96:	1101                	addi	sp,sp,-32
    80002b98:	ec06                	sd	ra,24(sp)
    80002b9a:	e822                	sd	s0,16(sp)
    80002b9c:	e426                	sd	s1,8(sp)
    80002b9e:	e04a                	sd	s2,0(sp)
    80002ba0:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002ba2:	c905                	beqz	a0,80002bd2 <iunlock+0x3c>
    80002ba4:	84aa                	mv	s1,a0
    80002ba6:	01050913          	addi	s2,a0,16
    80002baa:	854a                	mv	a0,s2
    80002bac:	00001097          	auipc	ra,0x1
    80002bb0:	c7c080e7          	jalr	-900(ra) # 80003828 <holdingsleep>
    80002bb4:	cd19                	beqz	a0,80002bd2 <iunlock+0x3c>
    80002bb6:	449c                	lw	a5,8(s1)
    80002bb8:	00f05d63          	blez	a5,80002bd2 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002bbc:	854a                	mv	a0,s2
    80002bbe:	00001097          	auipc	ra,0x1
    80002bc2:	c26080e7          	jalr	-986(ra) # 800037e4 <releasesleep>
}
    80002bc6:	60e2                	ld	ra,24(sp)
    80002bc8:	6442                	ld	s0,16(sp)
    80002bca:	64a2                	ld	s1,8(sp)
    80002bcc:	6902                	ld	s2,0(sp)
    80002bce:	6105                	addi	sp,sp,32
    80002bd0:	8082                	ret
    panic("iunlock");
    80002bd2:	00006517          	auipc	a0,0x6
    80002bd6:	99650513          	addi	a0,a0,-1642 # 80008568 <syscalls+0x198>
    80002bda:	00003097          	auipc	ra,0x3
    80002bde:	ff8080e7          	jalr	-8(ra) # 80005bd2 <panic>

0000000080002be2 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80002be2:	7179                	addi	sp,sp,-48
    80002be4:	f406                	sd	ra,40(sp)
    80002be6:	f022                	sd	s0,32(sp)
    80002be8:	ec26                	sd	s1,24(sp)
    80002bea:	e84a                	sd	s2,16(sp)
    80002bec:	e44e                	sd	s3,8(sp)
    80002bee:	e052                	sd	s4,0(sp)
    80002bf0:	1800                	addi	s0,sp,48
    80002bf2:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    80002bf4:	05050493          	addi	s1,a0,80
    80002bf8:	08050913          	addi	s2,a0,128
    80002bfc:	a021                	j	80002c04 <itrunc+0x22>
    80002bfe:	0491                	addi	s1,s1,4
    80002c00:	01248d63          	beq	s1,s2,80002c1a <itrunc+0x38>
    if(ip->addrs[i]){
    80002c04:	408c                	lw	a1,0(s1)
    80002c06:	dde5                	beqz	a1,80002bfe <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    80002c08:	0009a503          	lw	a0,0(s3)
    80002c0c:	00000097          	auipc	ra,0x0
    80002c10:	8f4080e7          	jalr	-1804(ra) # 80002500 <bfree>
      ip->addrs[i] = 0;
    80002c14:	0004a023          	sw	zero,0(s1)
    80002c18:	b7dd                	j	80002bfe <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    80002c1a:	0809a583          	lw	a1,128(s3)
    80002c1e:	e185                	bnez	a1,80002c3e <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    80002c20:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002c24:	854e                	mv	a0,s3
    80002c26:	00000097          	auipc	ra,0x0
    80002c2a:	de4080e7          	jalr	-540(ra) # 80002a0a <iupdate>
}
    80002c2e:	70a2                	ld	ra,40(sp)
    80002c30:	7402                	ld	s0,32(sp)
    80002c32:	64e2                	ld	s1,24(sp)
    80002c34:	6942                	ld	s2,16(sp)
    80002c36:	69a2                	ld	s3,8(sp)
    80002c38:	6a02                	ld	s4,0(sp)
    80002c3a:	6145                	addi	sp,sp,48
    80002c3c:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    80002c3e:	0009a503          	lw	a0,0(s3)
    80002c42:	fffff097          	auipc	ra,0xfffff
    80002c46:	678080e7          	jalr	1656(ra) # 800022ba <bread>
    80002c4a:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80002c4c:	05850493          	addi	s1,a0,88
    80002c50:	45850913          	addi	s2,a0,1112
    80002c54:	a811                	j	80002c68 <itrunc+0x86>
        bfree(ip->dev, a[j]);
    80002c56:	0009a503          	lw	a0,0(s3)
    80002c5a:	00000097          	auipc	ra,0x0
    80002c5e:	8a6080e7          	jalr	-1882(ra) # 80002500 <bfree>
    for(j = 0; j < NINDIRECT; j++){
    80002c62:	0491                	addi	s1,s1,4
    80002c64:	01248563          	beq	s1,s2,80002c6e <itrunc+0x8c>
      if(a[j])
    80002c68:	408c                	lw	a1,0(s1)
    80002c6a:	dde5                	beqz	a1,80002c62 <itrunc+0x80>
    80002c6c:	b7ed                	j	80002c56 <itrunc+0x74>
    brelse(bp);
    80002c6e:	8552                	mv	a0,s4
    80002c70:	fffff097          	auipc	ra,0xfffff
    80002c74:	77a080e7          	jalr	1914(ra) # 800023ea <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    80002c78:	0809a583          	lw	a1,128(s3)
    80002c7c:	0009a503          	lw	a0,0(s3)
    80002c80:	00000097          	auipc	ra,0x0
    80002c84:	880080e7          	jalr	-1920(ra) # 80002500 <bfree>
    ip->addrs[NDIRECT] = 0;
    80002c88:	0809a023          	sw	zero,128(s3)
    80002c8c:	bf51                	j	80002c20 <itrunc+0x3e>

0000000080002c8e <iput>:
{
    80002c8e:	1101                	addi	sp,sp,-32
    80002c90:	ec06                	sd	ra,24(sp)
    80002c92:	e822                	sd	s0,16(sp)
    80002c94:	e426                	sd	s1,8(sp)
    80002c96:	e04a                	sd	s2,0(sp)
    80002c98:	1000                	addi	s0,sp,32
    80002c9a:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002c9c:	00014517          	auipc	a0,0x14
    80002ca0:	16c50513          	addi	a0,a0,364 # 80016e08 <itable>
    80002ca4:	00003097          	auipc	ra,0x3
    80002ca8:	478080e7          	jalr	1144(ra) # 8000611c <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002cac:	4498                	lw	a4,8(s1)
    80002cae:	4785                	li	a5,1
    80002cb0:	02f70363          	beq	a4,a5,80002cd6 <iput+0x48>
  ip->ref--;
    80002cb4:	449c                	lw	a5,8(s1)
    80002cb6:	37fd                	addiw	a5,a5,-1
    80002cb8:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002cba:	00014517          	auipc	a0,0x14
    80002cbe:	14e50513          	addi	a0,a0,334 # 80016e08 <itable>
    80002cc2:	00003097          	auipc	ra,0x3
    80002cc6:	50e080e7          	jalr	1294(ra) # 800061d0 <release>
}
    80002cca:	60e2                	ld	ra,24(sp)
    80002ccc:	6442                	ld	s0,16(sp)
    80002cce:	64a2                	ld	s1,8(sp)
    80002cd0:	6902                	ld	s2,0(sp)
    80002cd2:	6105                	addi	sp,sp,32
    80002cd4:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80002cd6:	40bc                	lw	a5,64(s1)
    80002cd8:	dff1                	beqz	a5,80002cb4 <iput+0x26>
    80002cda:	04a49783          	lh	a5,74(s1)
    80002cde:	fbf9                	bnez	a5,80002cb4 <iput+0x26>
    acquiresleep(&ip->lock);
    80002ce0:	01048913          	addi	s2,s1,16
    80002ce4:	854a                	mv	a0,s2
    80002ce6:	00001097          	auipc	ra,0x1
    80002cea:	aa8080e7          	jalr	-1368(ra) # 8000378e <acquiresleep>
    release(&itable.lock);
    80002cee:	00014517          	auipc	a0,0x14
    80002cf2:	11a50513          	addi	a0,a0,282 # 80016e08 <itable>
    80002cf6:	00003097          	auipc	ra,0x3
    80002cfa:	4da080e7          	jalr	1242(ra) # 800061d0 <release>
    itrunc(ip);
    80002cfe:	8526                	mv	a0,s1
    80002d00:	00000097          	auipc	ra,0x0
    80002d04:	ee2080e7          	jalr	-286(ra) # 80002be2 <itrunc>
    ip->type = 0;
    80002d08:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002d0c:	8526                	mv	a0,s1
    80002d0e:	00000097          	auipc	ra,0x0
    80002d12:	cfc080e7          	jalr	-772(ra) # 80002a0a <iupdate>
    ip->valid = 0;
    80002d16:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002d1a:	854a                	mv	a0,s2
    80002d1c:	00001097          	auipc	ra,0x1
    80002d20:	ac8080e7          	jalr	-1336(ra) # 800037e4 <releasesleep>
    acquire(&itable.lock);
    80002d24:	00014517          	auipc	a0,0x14
    80002d28:	0e450513          	addi	a0,a0,228 # 80016e08 <itable>
    80002d2c:	00003097          	auipc	ra,0x3
    80002d30:	3f0080e7          	jalr	1008(ra) # 8000611c <acquire>
    80002d34:	b741                	j	80002cb4 <iput+0x26>

0000000080002d36 <iunlockput>:
{
    80002d36:	1101                	addi	sp,sp,-32
    80002d38:	ec06                	sd	ra,24(sp)
    80002d3a:	e822                	sd	s0,16(sp)
    80002d3c:	e426                	sd	s1,8(sp)
    80002d3e:	1000                	addi	s0,sp,32
    80002d40:	84aa                	mv	s1,a0
  iunlock(ip);
    80002d42:	00000097          	auipc	ra,0x0
    80002d46:	e54080e7          	jalr	-428(ra) # 80002b96 <iunlock>
  iput(ip);
    80002d4a:	8526                	mv	a0,s1
    80002d4c:	00000097          	auipc	ra,0x0
    80002d50:	f42080e7          	jalr	-190(ra) # 80002c8e <iput>
}
    80002d54:	60e2                	ld	ra,24(sp)
    80002d56:	6442                	ld	s0,16(sp)
    80002d58:	64a2                	ld	s1,8(sp)
    80002d5a:	6105                	addi	sp,sp,32
    80002d5c:	8082                	ret

0000000080002d5e <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80002d5e:	1141                	addi	sp,sp,-16
    80002d60:	e422                	sd	s0,8(sp)
    80002d62:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002d64:	411c                	lw	a5,0(a0)
    80002d66:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002d68:	415c                	lw	a5,4(a0)
    80002d6a:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002d6c:	04451783          	lh	a5,68(a0)
    80002d70:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002d74:	04a51783          	lh	a5,74(a0)
    80002d78:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002d7c:	04c56783          	lwu	a5,76(a0)
    80002d80:	e99c                	sd	a5,16(a1)
}
    80002d82:	6422                	ld	s0,8(sp)
    80002d84:	0141                	addi	sp,sp,16
    80002d86:	8082                	ret

0000000080002d88 <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002d88:	457c                	lw	a5,76(a0)
    80002d8a:	0ed7e963          	bltu	a5,a3,80002e7c <readi+0xf4>
{
    80002d8e:	7159                	addi	sp,sp,-112
    80002d90:	f486                	sd	ra,104(sp)
    80002d92:	f0a2                	sd	s0,96(sp)
    80002d94:	eca6                	sd	s1,88(sp)
    80002d96:	e8ca                	sd	s2,80(sp)
    80002d98:	e4ce                	sd	s3,72(sp)
    80002d9a:	e0d2                	sd	s4,64(sp)
    80002d9c:	fc56                	sd	s5,56(sp)
    80002d9e:	f85a                	sd	s6,48(sp)
    80002da0:	f45e                	sd	s7,40(sp)
    80002da2:	f062                	sd	s8,32(sp)
    80002da4:	ec66                	sd	s9,24(sp)
    80002da6:	e86a                	sd	s10,16(sp)
    80002da8:	e46e                	sd	s11,8(sp)
    80002daa:	1880                	addi	s0,sp,112
    80002dac:	8b2a                	mv	s6,a0
    80002dae:	8bae                	mv	s7,a1
    80002db0:	8a32                	mv	s4,a2
    80002db2:	84b6                	mv	s1,a3
    80002db4:	8aba                	mv	s5,a4
  if(off > ip->size || off + n < off)
    80002db6:	9f35                	addw	a4,a4,a3
    return 0;
    80002db8:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80002dba:	0ad76063          	bltu	a4,a3,80002e5a <readi+0xd2>
  if(off + n > ip->size)
    80002dbe:	00e7f463          	bgeu	a5,a4,80002dc6 <readi+0x3e>
    n = ip->size - off;
    80002dc2:	40d78abb          	subw	s5,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002dc6:	0a0a8963          	beqz	s5,80002e78 <readi+0xf0>
    80002dca:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002dcc:	40000c93          	li	s9,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80002dd0:	5c7d                	li	s8,-1
    80002dd2:	a82d                	j	80002e0c <readi+0x84>
    80002dd4:	020d1d93          	slli	s11,s10,0x20
    80002dd8:	020ddd93          	srli	s11,s11,0x20
    80002ddc:	05890613          	addi	a2,s2,88
    80002de0:	86ee                	mv	a3,s11
    80002de2:	963a                	add	a2,a2,a4
    80002de4:	85d2                	mv	a1,s4
    80002de6:	855e                	mv	a0,s7
    80002de8:	fffff097          	auipc	ra,0xfffff
    80002dec:	b1c080e7          	jalr	-1252(ra) # 80001904 <either_copyout>
    80002df0:	05850d63          	beq	a0,s8,80002e4a <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002df4:	854a                	mv	a0,s2
    80002df6:	fffff097          	auipc	ra,0xfffff
    80002dfa:	5f4080e7          	jalr	1524(ra) # 800023ea <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002dfe:	013d09bb          	addw	s3,s10,s3
    80002e02:	009d04bb          	addw	s1,s10,s1
    80002e06:	9a6e                	add	s4,s4,s11
    80002e08:	0559f763          	bgeu	s3,s5,80002e56 <readi+0xce>
    uint addr = bmap(ip, off/BSIZE);
    80002e0c:	00a4d59b          	srliw	a1,s1,0xa
    80002e10:	855a                	mv	a0,s6
    80002e12:	00000097          	auipc	ra,0x0
    80002e16:	8a2080e7          	jalr	-1886(ra) # 800026b4 <bmap>
    80002e1a:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80002e1e:	cd85                	beqz	a1,80002e56 <readi+0xce>
    bp = bread(ip->dev, addr);
    80002e20:	000b2503          	lw	a0,0(s6)
    80002e24:	fffff097          	auipc	ra,0xfffff
    80002e28:	496080e7          	jalr	1174(ra) # 800022ba <bread>
    80002e2c:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002e2e:	3ff4f713          	andi	a4,s1,1023
    80002e32:	40ec87bb          	subw	a5,s9,a4
    80002e36:	413a86bb          	subw	a3,s5,s3
    80002e3a:	8d3e                	mv	s10,a5
    80002e3c:	2781                	sext.w	a5,a5
    80002e3e:	0006861b          	sext.w	a2,a3
    80002e42:	f8f679e3          	bgeu	a2,a5,80002dd4 <readi+0x4c>
    80002e46:	8d36                	mv	s10,a3
    80002e48:	b771                	j	80002dd4 <readi+0x4c>
      brelse(bp);
    80002e4a:	854a                	mv	a0,s2
    80002e4c:	fffff097          	auipc	ra,0xfffff
    80002e50:	59e080e7          	jalr	1438(ra) # 800023ea <brelse>
      tot = -1;
    80002e54:	59fd                	li	s3,-1
  }
  return tot;
    80002e56:	0009851b          	sext.w	a0,s3
}
    80002e5a:	70a6                	ld	ra,104(sp)
    80002e5c:	7406                	ld	s0,96(sp)
    80002e5e:	64e6                	ld	s1,88(sp)
    80002e60:	6946                	ld	s2,80(sp)
    80002e62:	69a6                	ld	s3,72(sp)
    80002e64:	6a06                	ld	s4,64(sp)
    80002e66:	7ae2                	ld	s5,56(sp)
    80002e68:	7b42                	ld	s6,48(sp)
    80002e6a:	7ba2                	ld	s7,40(sp)
    80002e6c:	7c02                	ld	s8,32(sp)
    80002e6e:	6ce2                	ld	s9,24(sp)
    80002e70:	6d42                	ld	s10,16(sp)
    80002e72:	6da2                	ld	s11,8(sp)
    80002e74:	6165                	addi	sp,sp,112
    80002e76:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80002e78:	89d6                	mv	s3,s5
    80002e7a:	bff1                	j	80002e56 <readi+0xce>
    return 0;
    80002e7c:	4501                	li	a0,0
}
    80002e7e:	8082                	ret

0000000080002e80 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80002e80:	457c                	lw	a5,76(a0)
    80002e82:	10d7e863          	bltu	a5,a3,80002f92 <writei+0x112>
{
    80002e86:	7159                	addi	sp,sp,-112
    80002e88:	f486                	sd	ra,104(sp)
    80002e8a:	f0a2                	sd	s0,96(sp)
    80002e8c:	eca6                	sd	s1,88(sp)
    80002e8e:	e8ca                	sd	s2,80(sp)
    80002e90:	e4ce                	sd	s3,72(sp)
    80002e92:	e0d2                	sd	s4,64(sp)
    80002e94:	fc56                	sd	s5,56(sp)
    80002e96:	f85a                	sd	s6,48(sp)
    80002e98:	f45e                	sd	s7,40(sp)
    80002e9a:	f062                	sd	s8,32(sp)
    80002e9c:	ec66                	sd	s9,24(sp)
    80002e9e:	e86a                	sd	s10,16(sp)
    80002ea0:	e46e                	sd	s11,8(sp)
    80002ea2:	1880                	addi	s0,sp,112
    80002ea4:	8aaa                	mv	s5,a0
    80002ea6:	8bae                	mv	s7,a1
    80002ea8:	8a32                	mv	s4,a2
    80002eaa:	8936                	mv	s2,a3
    80002eac:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    80002eae:	00e687bb          	addw	a5,a3,a4
    80002eb2:	0ed7e263          	bltu	a5,a3,80002f96 <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80002eb6:	00043737          	lui	a4,0x43
    80002eba:	0ef76063          	bltu	a4,a5,80002f9a <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002ebe:	0c0b0863          	beqz	s6,80002f8e <writei+0x10e>
    80002ec2:	4981                	li	s3,0
    uint addr = bmap(ip, off/BSIZE);
    if(addr == 0)
      break;
    bp = bread(ip->dev, addr);
    m = min(n - tot, BSIZE - off%BSIZE);
    80002ec4:	40000c93          	li	s9,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002ec8:	5c7d                	li	s8,-1
    80002eca:	a091                	j	80002f0e <writei+0x8e>
    80002ecc:	020d1d93          	slli	s11,s10,0x20
    80002ed0:	020ddd93          	srli	s11,s11,0x20
    80002ed4:	05848513          	addi	a0,s1,88
    80002ed8:	86ee                	mv	a3,s11
    80002eda:	8652                	mv	a2,s4
    80002edc:	85de                	mv	a1,s7
    80002ede:	953a                	add	a0,a0,a4
    80002ee0:	fffff097          	auipc	ra,0xfffff
    80002ee4:	a7a080e7          	jalr	-1414(ra) # 8000195a <either_copyin>
    80002ee8:	07850263          	beq	a0,s8,80002f4c <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80002eec:	8526                	mv	a0,s1
    80002eee:	00000097          	auipc	ra,0x0
    80002ef2:	780080e7          	jalr	1920(ra) # 8000366e <log_write>
    brelse(bp);
    80002ef6:	8526                	mv	a0,s1
    80002ef8:	fffff097          	auipc	ra,0xfffff
    80002efc:	4f2080e7          	jalr	1266(ra) # 800023ea <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002f00:	013d09bb          	addw	s3,s10,s3
    80002f04:	012d093b          	addw	s2,s10,s2
    80002f08:	9a6e                	add	s4,s4,s11
    80002f0a:	0569f663          	bgeu	s3,s6,80002f56 <writei+0xd6>
    uint addr = bmap(ip, off/BSIZE);
    80002f0e:	00a9559b          	srliw	a1,s2,0xa
    80002f12:	8556                	mv	a0,s5
    80002f14:	fffff097          	auipc	ra,0xfffff
    80002f18:	7a0080e7          	jalr	1952(ra) # 800026b4 <bmap>
    80002f1c:	0005059b          	sext.w	a1,a0
    if(addr == 0)
    80002f20:	c99d                	beqz	a1,80002f56 <writei+0xd6>
    bp = bread(ip->dev, addr);
    80002f22:	000aa503          	lw	a0,0(s5)
    80002f26:	fffff097          	auipc	ra,0xfffff
    80002f2a:	394080e7          	jalr	916(ra) # 800022ba <bread>
    80002f2e:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80002f30:	3ff97713          	andi	a4,s2,1023
    80002f34:	40ec87bb          	subw	a5,s9,a4
    80002f38:	413b06bb          	subw	a3,s6,s3
    80002f3c:	8d3e                	mv	s10,a5
    80002f3e:	2781                	sext.w	a5,a5
    80002f40:	0006861b          	sext.w	a2,a3
    80002f44:	f8f674e3          	bgeu	a2,a5,80002ecc <writei+0x4c>
    80002f48:	8d36                	mv	s10,a3
    80002f4a:	b749                	j	80002ecc <writei+0x4c>
      brelse(bp);
    80002f4c:	8526                	mv	a0,s1
    80002f4e:	fffff097          	auipc	ra,0xfffff
    80002f52:	49c080e7          	jalr	1180(ra) # 800023ea <brelse>
  }

  if(off > ip->size)
    80002f56:	04caa783          	lw	a5,76(s5)
    80002f5a:	0127f463          	bgeu	a5,s2,80002f62 <writei+0xe2>
    ip->size = off;
    80002f5e:	052aa623          	sw	s2,76(s5)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80002f62:	8556                	mv	a0,s5
    80002f64:	00000097          	auipc	ra,0x0
    80002f68:	aa6080e7          	jalr	-1370(ra) # 80002a0a <iupdate>

  return tot;
    80002f6c:	0009851b          	sext.w	a0,s3
}
    80002f70:	70a6                	ld	ra,104(sp)
    80002f72:	7406                	ld	s0,96(sp)
    80002f74:	64e6                	ld	s1,88(sp)
    80002f76:	6946                	ld	s2,80(sp)
    80002f78:	69a6                	ld	s3,72(sp)
    80002f7a:	6a06                	ld	s4,64(sp)
    80002f7c:	7ae2                	ld	s5,56(sp)
    80002f7e:	7b42                	ld	s6,48(sp)
    80002f80:	7ba2                	ld	s7,40(sp)
    80002f82:	7c02                	ld	s8,32(sp)
    80002f84:	6ce2                	ld	s9,24(sp)
    80002f86:	6d42                	ld	s10,16(sp)
    80002f88:	6da2                	ld	s11,8(sp)
    80002f8a:	6165                	addi	sp,sp,112
    80002f8c:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80002f8e:	89da                	mv	s3,s6
    80002f90:	bfc9                	j	80002f62 <writei+0xe2>
    return -1;
    80002f92:	557d                	li	a0,-1
}
    80002f94:	8082                	ret
    return -1;
    80002f96:	557d                	li	a0,-1
    80002f98:	bfe1                	j	80002f70 <writei+0xf0>
    return -1;
    80002f9a:	557d                	li	a0,-1
    80002f9c:	bfd1                	j	80002f70 <writei+0xf0>

0000000080002f9e <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80002f9e:	1141                	addi	sp,sp,-16
    80002fa0:	e406                	sd	ra,8(sp)
    80002fa2:	e022                	sd	s0,0(sp)
    80002fa4:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80002fa6:	4639                	li	a2,14
    80002fa8:	ffffd097          	auipc	ra,0xffffd
    80002fac:	2a8080e7          	jalr	680(ra) # 80000250 <strncmp>
}
    80002fb0:	60a2                	ld	ra,8(sp)
    80002fb2:	6402                	ld	s0,0(sp)
    80002fb4:	0141                	addi	sp,sp,16
    80002fb6:	8082                	ret

0000000080002fb8 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80002fb8:	7139                	addi	sp,sp,-64
    80002fba:	fc06                	sd	ra,56(sp)
    80002fbc:	f822                	sd	s0,48(sp)
    80002fbe:	f426                	sd	s1,40(sp)
    80002fc0:	f04a                	sd	s2,32(sp)
    80002fc2:	ec4e                	sd	s3,24(sp)
    80002fc4:	e852                	sd	s4,16(sp)
    80002fc6:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80002fc8:	04451703          	lh	a4,68(a0)
    80002fcc:	4785                	li	a5,1
    80002fce:	00f71a63          	bne	a4,a5,80002fe2 <dirlookup+0x2a>
    80002fd2:	892a                	mv	s2,a0
    80002fd4:	89ae                	mv	s3,a1
    80002fd6:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80002fd8:	457c                	lw	a5,76(a0)
    80002fda:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80002fdc:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80002fde:	e79d                	bnez	a5,8000300c <dirlookup+0x54>
    80002fe0:	a8a5                	j	80003058 <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80002fe2:	00005517          	auipc	a0,0x5
    80002fe6:	58e50513          	addi	a0,a0,1422 # 80008570 <syscalls+0x1a0>
    80002fea:	00003097          	auipc	ra,0x3
    80002fee:	be8080e7          	jalr	-1048(ra) # 80005bd2 <panic>
      panic("dirlookup read");
    80002ff2:	00005517          	auipc	a0,0x5
    80002ff6:	59650513          	addi	a0,a0,1430 # 80008588 <syscalls+0x1b8>
    80002ffa:	00003097          	auipc	ra,0x3
    80002ffe:	bd8080e7          	jalr	-1064(ra) # 80005bd2 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003002:	24c1                	addiw	s1,s1,16
    80003004:	04c92783          	lw	a5,76(s2)
    80003008:	04f4f763          	bgeu	s1,a5,80003056 <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000300c:	4741                	li	a4,16
    8000300e:	86a6                	mv	a3,s1
    80003010:	fc040613          	addi	a2,s0,-64
    80003014:	4581                	li	a1,0
    80003016:	854a                	mv	a0,s2
    80003018:	00000097          	auipc	ra,0x0
    8000301c:	d70080e7          	jalr	-656(ra) # 80002d88 <readi>
    80003020:	47c1                	li	a5,16
    80003022:	fcf518e3          	bne	a0,a5,80002ff2 <dirlookup+0x3a>
    if(de.inum == 0)
    80003026:	fc045783          	lhu	a5,-64(s0)
    8000302a:	dfe1                	beqz	a5,80003002 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    8000302c:	fc240593          	addi	a1,s0,-62
    80003030:	854e                	mv	a0,s3
    80003032:	00000097          	auipc	ra,0x0
    80003036:	f6c080e7          	jalr	-148(ra) # 80002f9e <namecmp>
    8000303a:	f561                	bnez	a0,80003002 <dirlookup+0x4a>
      if(poff)
    8000303c:	000a0463          	beqz	s4,80003044 <dirlookup+0x8c>
        *poff = off;
    80003040:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003044:	fc045583          	lhu	a1,-64(s0)
    80003048:	00092503          	lw	a0,0(s2)
    8000304c:	fffff097          	auipc	ra,0xfffff
    80003050:	750080e7          	jalr	1872(ra) # 8000279c <iget>
    80003054:	a011                	j	80003058 <dirlookup+0xa0>
  return 0;
    80003056:	4501                	li	a0,0
}
    80003058:	70e2                	ld	ra,56(sp)
    8000305a:	7442                	ld	s0,48(sp)
    8000305c:	74a2                	ld	s1,40(sp)
    8000305e:	7902                	ld	s2,32(sp)
    80003060:	69e2                	ld	s3,24(sp)
    80003062:	6a42                	ld	s4,16(sp)
    80003064:	6121                	addi	sp,sp,64
    80003066:	8082                	ret

0000000080003068 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003068:	711d                	addi	sp,sp,-96
    8000306a:	ec86                	sd	ra,88(sp)
    8000306c:	e8a2                	sd	s0,80(sp)
    8000306e:	e4a6                	sd	s1,72(sp)
    80003070:	e0ca                	sd	s2,64(sp)
    80003072:	fc4e                	sd	s3,56(sp)
    80003074:	f852                	sd	s4,48(sp)
    80003076:	f456                	sd	s5,40(sp)
    80003078:	f05a                	sd	s6,32(sp)
    8000307a:	ec5e                	sd	s7,24(sp)
    8000307c:	e862                	sd	s8,16(sp)
    8000307e:	e466                	sd	s9,8(sp)
    80003080:	1080                	addi	s0,sp,96
    80003082:	84aa                	mv	s1,a0
    80003084:	8b2e                	mv	s6,a1
    80003086:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003088:	00054703          	lbu	a4,0(a0)
    8000308c:	02f00793          	li	a5,47
    80003090:	02f70363          	beq	a4,a5,800030b6 <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003094:	ffffe097          	auipc	ra,0xffffe
    80003098:	dc4080e7          	jalr	-572(ra) # 80000e58 <myproc>
    8000309c:	15053503          	ld	a0,336(a0)
    800030a0:	00000097          	auipc	ra,0x0
    800030a4:	9f6080e7          	jalr	-1546(ra) # 80002a96 <idup>
    800030a8:	89aa                	mv	s3,a0
  while(*path == '/')
    800030aa:	02f00913          	li	s2,47
  len = path - s;
    800030ae:	4b81                	li	s7,0
  if(len >= DIRSIZ)
    800030b0:	4cb5                	li	s9,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    800030b2:	4c05                	li	s8,1
    800030b4:	a865                	j	8000316c <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    800030b6:	4585                	li	a1,1
    800030b8:	4505                	li	a0,1
    800030ba:	fffff097          	auipc	ra,0xfffff
    800030be:	6e2080e7          	jalr	1762(ra) # 8000279c <iget>
    800030c2:	89aa                	mv	s3,a0
    800030c4:	b7dd                	j	800030aa <namex+0x42>
      iunlockput(ip);
    800030c6:	854e                	mv	a0,s3
    800030c8:	00000097          	auipc	ra,0x0
    800030cc:	c6e080e7          	jalr	-914(ra) # 80002d36 <iunlockput>
      return 0;
    800030d0:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    800030d2:	854e                	mv	a0,s3
    800030d4:	60e6                	ld	ra,88(sp)
    800030d6:	6446                	ld	s0,80(sp)
    800030d8:	64a6                	ld	s1,72(sp)
    800030da:	6906                	ld	s2,64(sp)
    800030dc:	79e2                	ld	s3,56(sp)
    800030de:	7a42                	ld	s4,48(sp)
    800030e0:	7aa2                	ld	s5,40(sp)
    800030e2:	7b02                	ld	s6,32(sp)
    800030e4:	6be2                	ld	s7,24(sp)
    800030e6:	6c42                	ld	s8,16(sp)
    800030e8:	6ca2                	ld	s9,8(sp)
    800030ea:	6125                	addi	sp,sp,96
    800030ec:	8082                	ret
      iunlock(ip);
    800030ee:	854e                	mv	a0,s3
    800030f0:	00000097          	auipc	ra,0x0
    800030f4:	aa6080e7          	jalr	-1370(ra) # 80002b96 <iunlock>
      return ip;
    800030f8:	bfe9                	j	800030d2 <namex+0x6a>
      iunlockput(ip);
    800030fa:	854e                	mv	a0,s3
    800030fc:	00000097          	auipc	ra,0x0
    80003100:	c3a080e7          	jalr	-966(ra) # 80002d36 <iunlockput>
      return 0;
    80003104:	89d2                	mv	s3,s4
    80003106:	b7f1                	j	800030d2 <namex+0x6a>
  len = path - s;
    80003108:	40b48633          	sub	a2,s1,a1
    8000310c:	00060a1b          	sext.w	s4,a2
  if(len >= DIRSIZ)
    80003110:	094cd463          	bge	s9,s4,80003198 <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003114:	4639                	li	a2,14
    80003116:	8556                	mv	a0,s5
    80003118:	ffffd097          	auipc	ra,0xffffd
    8000311c:	0c0080e7          	jalr	192(ra) # 800001d8 <memmove>
  while(*path == '/')
    80003120:	0004c783          	lbu	a5,0(s1)
    80003124:	01279763          	bne	a5,s2,80003132 <namex+0xca>
    path++;
    80003128:	0485                	addi	s1,s1,1
  while(*path == '/')
    8000312a:	0004c783          	lbu	a5,0(s1)
    8000312e:	ff278de3          	beq	a5,s2,80003128 <namex+0xc0>
    ilock(ip);
    80003132:	854e                	mv	a0,s3
    80003134:	00000097          	auipc	ra,0x0
    80003138:	9a0080e7          	jalr	-1632(ra) # 80002ad4 <ilock>
    if(ip->type != T_DIR){
    8000313c:	04499783          	lh	a5,68(s3)
    80003140:	f98793e3          	bne	a5,s8,800030c6 <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003144:	000b0563          	beqz	s6,8000314e <namex+0xe6>
    80003148:	0004c783          	lbu	a5,0(s1)
    8000314c:	d3cd                	beqz	a5,800030ee <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    8000314e:	865e                	mv	a2,s7
    80003150:	85d6                	mv	a1,s5
    80003152:	854e                	mv	a0,s3
    80003154:	00000097          	auipc	ra,0x0
    80003158:	e64080e7          	jalr	-412(ra) # 80002fb8 <dirlookup>
    8000315c:	8a2a                	mv	s4,a0
    8000315e:	dd51                	beqz	a0,800030fa <namex+0x92>
    iunlockput(ip);
    80003160:	854e                	mv	a0,s3
    80003162:	00000097          	auipc	ra,0x0
    80003166:	bd4080e7          	jalr	-1068(ra) # 80002d36 <iunlockput>
    ip = next;
    8000316a:	89d2                	mv	s3,s4
  while(*path == '/')
    8000316c:	0004c783          	lbu	a5,0(s1)
    80003170:	05279763          	bne	a5,s2,800031be <namex+0x156>
    path++;
    80003174:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003176:	0004c783          	lbu	a5,0(s1)
    8000317a:	ff278de3          	beq	a5,s2,80003174 <namex+0x10c>
  if(*path == 0)
    8000317e:	c79d                	beqz	a5,800031ac <namex+0x144>
    path++;
    80003180:	85a6                	mv	a1,s1
  len = path - s;
    80003182:	8a5e                	mv	s4,s7
    80003184:	865e                	mv	a2,s7
  while(*path != '/' && *path != 0)
    80003186:	01278963          	beq	a5,s2,80003198 <namex+0x130>
    8000318a:	dfbd                	beqz	a5,80003108 <namex+0xa0>
    path++;
    8000318c:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    8000318e:	0004c783          	lbu	a5,0(s1)
    80003192:	ff279ce3          	bne	a5,s2,8000318a <namex+0x122>
    80003196:	bf8d                	j	80003108 <namex+0xa0>
    memmove(name, s, len);
    80003198:	2601                	sext.w	a2,a2
    8000319a:	8556                	mv	a0,s5
    8000319c:	ffffd097          	auipc	ra,0xffffd
    800031a0:	03c080e7          	jalr	60(ra) # 800001d8 <memmove>
    name[len] = 0;
    800031a4:	9a56                	add	s4,s4,s5
    800031a6:	000a0023          	sb	zero,0(s4)
    800031aa:	bf9d                	j	80003120 <namex+0xb8>
  if(nameiparent){
    800031ac:	f20b03e3          	beqz	s6,800030d2 <namex+0x6a>
    iput(ip);
    800031b0:	854e                	mv	a0,s3
    800031b2:	00000097          	auipc	ra,0x0
    800031b6:	adc080e7          	jalr	-1316(ra) # 80002c8e <iput>
    return 0;
    800031ba:	4981                	li	s3,0
    800031bc:	bf19                	j	800030d2 <namex+0x6a>
  if(*path == 0)
    800031be:	d7fd                	beqz	a5,800031ac <namex+0x144>
  while(*path != '/' && *path != 0)
    800031c0:	0004c783          	lbu	a5,0(s1)
    800031c4:	85a6                	mv	a1,s1
    800031c6:	b7d1                	j	8000318a <namex+0x122>

00000000800031c8 <dirlink>:
{
    800031c8:	7139                	addi	sp,sp,-64
    800031ca:	fc06                	sd	ra,56(sp)
    800031cc:	f822                	sd	s0,48(sp)
    800031ce:	f426                	sd	s1,40(sp)
    800031d0:	f04a                	sd	s2,32(sp)
    800031d2:	ec4e                	sd	s3,24(sp)
    800031d4:	e852                	sd	s4,16(sp)
    800031d6:	0080                	addi	s0,sp,64
    800031d8:	892a                	mv	s2,a0
    800031da:	8a2e                	mv	s4,a1
    800031dc:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    800031de:	4601                	li	a2,0
    800031e0:	00000097          	auipc	ra,0x0
    800031e4:	dd8080e7          	jalr	-552(ra) # 80002fb8 <dirlookup>
    800031e8:	e93d                	bnez	a0,8000325e <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    800031ea:	04c92483          	lw	s1,76(s2)
    800031ee:	c49d                	beqz	s1,8000321c <dirlink+0x54>
    800031f0:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800031f2:	4741                	li	a4,16
    800031f4:	86a6                	mv	a3,s1
    800031f6:	fc040613          	addi	a2,s0,-64
    800031fa:	4581                	li	a1,0
    800031fc:	854a                	mv	a0,s2
    800031fe:	00000097          	auipc	ra,0x0
    80003202:	b8a080e7          	jalr	-1142(ra) # 80002d88 <readi>
    80003206:	47c1                	li	a5,16
    80003208:	06f51163          	bne	a0,a5,8000326a <dirlink+0xa2>
    if(de.inum == 0)
    8000320c:	fc045783          	lhu	a5,-64(s0)
    80003210:	c791                	beqz	a5,8000321c <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003212:	24c1                	addiw	s1,s1,16
    80003214:	04c92783          	lw	a5,76(s2)
    80003218:	fcf4ede3          	bltu	s1,a5,800031f2 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    8000321c:	4639                	li	a2,14
    8000321e:	85d2                	mv	a1,s4
    80003220:	fc240513          	addi	a0,s0,-62
    80003224:	ffffd097          	auipc	ra,0xffffd
    80003228:	068080e7          	jalr	104(ra) # 8000028c <strncpy>
  de.inum = inum;
    8000322c:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003230:	4741                	li	a4,16
    80003232:	86a6                	mv	a3,s1
    80003234:	fc040613          	addi	a2,s0,-64
    80003238:	4581                	li	a1,0
    8000323a:	854a                	mv	a0,s2
    8000323c:	00000097          	auipc	ra,0x0
    80003240:	c44080e7          	jalr	-956(ra) # 80002e80 <writei>
    80003244:	1541                	addi	a0,a0,-16
    80003246:	00a03533          	snez	a0,a0
    8000324a:	40a00533          	neg	a0,a0
}
    8000324e:	70e2                	ld	ra,56(sp)
    80003250:	7442                	ld	s0,48(sp)
    80003252:	74a2                	ld	s1,40(sp)
    80003254:	7902                	ld	s2,32(sp)
    80003256:	69e2                	ld	s3,24(sp)
    80003258:	6a42                	ld	s4,16(sp)
    8000325a:	6121                	addi	sp,sp,64
    8000325c:	8082                	ret
    iput(ip);
    8000325e:	00000097          	auipc	ra,0x0
    80003262:	a30080e7          	jalr	-1488(ra) # 80002c8e <iput>
    return -1;
    80003266:	557d                	li	a0,-1
    80003268:	b7dd                	j	8000324e <dirlink+0x86>
      panic("dirlink read");
    8000326a:	00005517          	auipc	a0,0x5
    8000326e:	32e50513          	addi	a0,a0,814 # 80008598 <syscalls+0x1c8>
    80003272:	00003097          	auipc	ra,0x3
    80003276:	960080e7          	jalr	-1696(ra) # 80005bd2 <panic>

000000008000327a <namei>:

struct inode*
namei(char *path)
{
    8000327a:	1101                	addi	sp,sp,-32
    8000327c:	ec06                	sd	ra,24(sp)
    8000327e:	e822                	sd	s0,16(sp)
    80003280:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003282:	fe040613          	addi	a2,s0,-32
    80003286:	4581                	li	a1,0
    80003288:	00000097          	auipc	ra,0x0
    8000328c:	de0080e7          	jalr	-544(ra) # 80003068 <namex>
}
    80003290:	60e2                	ld	ra,24(sp)
    80003292:	6442                	ld	s0,16(sp)
    80003294:	6105                	addi	sp,sp,32
    80003296:	8082                	ret

0000000080003298 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003298:	1141                	addi	sp,sp,-16
    8000329a:	e406                	sd	ra,8(sp)
    8000329c:	e022                	sd	s0,0(sp)
    8000329e:	0800                	addi	s0,sp,16
    800032a0:	862e                	mv	a2,a1
  return namex(path, 1, name);
    800032a2:	4585                	li	a1,1
    800032a4:	00000097          	auipc	ra,0x0
    800032a8:	dc4080e7          	jalr	-572(ra) # 80003068 <namex>
}
    800032ac:	60a2                	ld	ra,8(sp)
    800032ae:	6402                	ld	s0,0(sp)
    800032b0:	0141                	addi	sp,sp,16
    800032b2:	8082                	ret

00000000800032b4 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800032b4:	1101                	addi	sp,sp,-32
    800032b6:	ec06                	sd	ra,24(sp)
    800032b8:	e822                	sd	s0,16(sp)
    800032ba:	e426                	sd	s1,8(sp)
    800032bc:	e04a                	sd	s2,0(sp)
    800032be:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    800032c0:	00015917          	auipc	s2,0x15
    800032c4:	5f090913          	addi	s2,s2,1520 # 800188b0 <log>
    800032c8:	01892583          	lw	a1,24(s2)
    800032cc:	02892503          	lw	a0,40(s2)
    800032d0:	fffff097          	auipc	ra,0xfffff
    800032d4:	fea080e7          	jalr	-22(ra) # 800022ba <bread>
    800032d8:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800032da:	02c92683          	lw	a3,44(s2)
    800032de:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800032e0:	02d05763          	blez	a3,8000330e <write_head+0x5a>
    800032e4:	00015797          	auipc	a5,0x15
    800032e8:	5fc78793          	addi	a5,a5,1532 # 800188e0 <log+0x30>
    800032ec:	05c50713          	addi	a4,a0,92
    800032f0:	36fd                	addiw	a3,a3,-1
    800032f2:	1682                	slli	a3,a3,0x20
    800032f4:	9281                	srli	a3,a3,0x20
    800032f6:	068a                	slli	a3,a3,0x2
    800032f8:	00015617          	auipc	a2,0x15
    800032fc:	5ec60613          	addi	a2,a2,1516 # 800188e4 <log+0x34>
    80003300:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003302:	4390                	lw	a2,0(a5)
    80003304:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003306:	0791                	addi	a5,a5,4
    80003308:	0711                	addi	a4,a4,4
    8000330a:	fed79ce3          	bne	a5,a3,80003302 <write_head+0x4e>
  }
  bwrite(buf);
    8000330e:	8526                	mv	a0,s1
    80003310:	fffff097          	auipc	ra,0xfffff
    80003314:	09c080e7          	jalr	156(ra) # 800023ac <bwrite>
  brelse(buf);
    80003318:	8526                	mv	a0,s1
    8000331a:	fffff097          	auipc	ra,0xfffff
    8000331e:	0d0080e7          	jalr	208(ra) # 800023ea <brelse>
}
    80003322:	60e2                	ld	ra,24(sp)
    80003324:	6442                	ld	s0,16(sp)
    80003326:	64a2                	ld	s1,8(sp)
    80003328:	6902                	ld	s2,0(sp)
    8000332a:	6105                	addi	sp,sp,32
    8000332c:	8082                	ret

000000008000332e <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    8000332e:	00015797          	auipc	a5,0x15
    80003332:	5ae7a783          	lw	a5,1454(a5) # 800188dc <log+0x2c>
    80003336:	0af05d63          	blez	a5,800033f0 <install_trans+0xc2>
{
    8000333a:	7139                	addi	sp,sp,-64
    8000333c:	fc06                	sd	ra,56(sp)
    8000333e:	f822                	sd	s0,48(sp)
    80003340:	f426                	sd	s1,40(sp)
    80003342:	f04a                	sd	s2,32(sp)
    80003344:	ec4e                	sd	s3,24(sp)
    80003346:	e852                	sd	s4,16(sp)
    80003348:	e456                	sd	s5,8(sp)
    8000334a:	e05a                	sd	s6,0(sp)
    8000334c:	0080                	addi	s0,sp,64
    8000334e:	8b2a                	mv	s6,a0
    80003350:	00015a97          	auipc	s5,0x15
    80003354:	590a8a93          	addi	s5,s5,1424 # 800188e0 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003358:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000335a:	00015997          	auipc	s3,0x15
    8000335e:	55698993          	addi	s3,s3,1366 # 800188b0 <log>
    80003362:	a035                	j	8000338e <install_trans+0x60>
      bunpin(dbuf);
    80003364:	8526                	mv	a0,s1
    80003366:	fffff097          	auipc	ra,0xfffff
    8000336a:	15e080e7          	jalr	350(ra) # 800024c4 <bunpin>
    brelse(lbuf);
    8000336e:	854a                	mv	a0,s2
    80003370:	fffff097          	auipc	ra,0xfffff
    80003374:	07a080e7          	jalr	122(ra) # 800023ea <brelse>
    brelse(dbuf);
    80003378:	8526                	mv	a0,s1
    8000337a:	fffff097          	auipc	ra,0xfffff
    8000337e:	070080e7          	jalr	112(ra) # 800023ea <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003382:	2a05                	addiw	s4,s4,1
    80003384:	0a91                	addi	s5,s5,4
    80003386:	02c9a783          	lw	a5,44(s3)
    8000338a:	04fa5963          	bge	s4,a5,800033dc <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    8000338e:	0189a583          	lw	a1,24(s3)
    80003392:	014585bb          	addw	a1,a1,s4
    80003396:	2585                	addiw	a1,a1,1
    80003398:	0289a503          	lw	a0,40(s3)
    8000339c:	fffff097          	auipc	ra,0xfffff
    800033a0:	f1e080e7          	jalr	-226(ra) # 800022ba <bread>
    800033a4:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    800033a6:	000aa583          	lw	a1,0(s5)
    800033aa:	0289a503          	lw	a0,40(s3)
    800033ae:	fffff097          	auipc	ra,0xfffff
    800033b2:	f0c080e7          	jalr	-244(ra) # 800022ba <bread>
    800033b6:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800033b8:	40000613          	li	a2,1024
    800033bc:	05890593          	addi	a1,s2,88
    800033c0:	05850513          	addi	a0,a0,88
    800033c4:	ffffd097          	auipc	ra,0xffffd
    800033c8:	e14080e7          	jalr	-492(ra) # 800001d8 <memmove>
    bwrite(dbuf);  // write dst to disk
    800033cc:	8526                	mv	a0,s1
    800033ce:	fffff097          	auipc	ra,0xfffff
    800033d2:	fde080e7          	jalr	-34(ra) # 800023ac <bwrite>
    if(recovering == 0)
    800033d6:	f80b1ce3          	bnez	s6,8000336e <install_trans+0x40>
    800033da:	b769                	j	80003364 <install_trans+0x36>
}
    800033dc:	70e2                	ld	ra,56(sp)
    800033de:	7442                	ld	s0,48(sp)
    800033e0:	74a2                	ld	s1,40(sp)
    800033e2:	7902                	ld	s2,32(sp)
    800033e4:	69e2                	ld	s3,24(sp)
    800033e6:	6a42                	ld	s4,16(sp)
    800033e8:	6aa2                	ld	s5,8(sp)
    800033ea:	6b02                	ld	s6,0(sp)
    800033ec:	6121                	addi	sp,sp,64
    800033ee:	8082                	ret
    800033f0:	8082                	ret

00000000800033f2 <initlog>:
{
    800033f2:	7179                	addi	sp,sp,-48
    800033f4:	f406                	sd	ra,40(sp)
    800033f6:	f022                	sd	s0,32(sp)
    800033f8:	ec26                	sd	s1,24(sp)
    800033fa:	e84a                	sd	s2,16(sp)
    800033fc:	e44e                	sd	s3,8(sp)
    800033fe:	1800                	addi	s0,sp,48
    80003400:	892a                	mv	s2,a0
    80003402:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003404:	00015497          	auipc	s1,0x15
    80003408:	4ac48493          	addi	s1,s1,1196 # 800188b0 <log>
    8000340c:	00005597          	auipc	a1,0x5
    80003410:	19c58593          	addi	a1,a1,412 # 800085a8 <syscalls+0x1d8>
    80003414:	8526                	mv	a0,s1
    80003416:	00003097          	auipc	ra,0x3
    8000341a:	c76080e7          	jalr	-906(ra) # 8000608c <initlock>
  log.start = sb->logstart;
    8000341e:	0149a583          	lw	a1,20(s3)
    80003422:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003424:	0109a783          	lw	a5,16(s3)
    80003428:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    8000342a:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    8000342e:	854a                	mv	a0,s2
    80003430:	fffff097          	auipc	ra,0xfffff
    80003434:	e8a080e7          	jalr	-374(ra) # 800022ba <bread>
  log.lh.n = lh->n;
    80003438:	4d3c                	lw	a5,88(a0)
    8000343a:	d4dc                	sw	a5,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    8000343c:	02f05563          	blez	a5,80003466 <initlog+0x74>
    80003440:	05c50713          	addi	a4,a0,92
    80003444:	00015697          	auipc	a3,0x15
    80003448:	49c68693          	addi	a3,a3,1180 # 800188e0 <log+0x30>
    8000344c:	37fd                	addiw	a5,a5,-1
    8000344e:	1782                	slli	a5,a5,0x20
    80003450:	9381                	srli	a5,a5,0x20
    80003452:	078a                	slli	a5,a5,0x2
    80003454:	06050613          	addi	a2,a0,96
    80003458:	97b2                	add	a5,a5,a2
    log.lh.block[i] = lh->block[i];
    8000345a:	4310                	lw	a2,0(a4)
    8000345c:	c290                	sw	a2,0(a3)
  for (i = 0; i < log.lh.n; i++) {
    8000345e:	0711                	addi	a4,a4,4
    80003460:	0691                	addi	a3,a3,4
    80003462:	fef71ce3          	bne	a4,a5,8000345a <initlog+0x68>
  brelse(buf);
    80003466:	fffff097          	auipc	ra,0xfffff
    8000346a:	f84080e7          	jalr	-124(ra) # 800023ea <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    8000346e:	4505                	li	a0,1
    80003470:	00000097          	auipc	ra,0x0
    80003474:	ebe080e7          	jalr	-322(ra) # 8000332e <install_trans>
  log.lh.n = 0;
    80003478:	00015797          	auipc	a5,0x15
    8000347c:	4607a223          	sw	zero,1124(a5) # 800188dc <log+0x2c>
  write_head(); // clear the log
    80003480:	00000097          	auipc	ra,0x0
    80003484:	e34080e7          	jalr	-460(ra) # 800032b4 <write_head>
}
    80003488:	70a2                	ld	ra,40(sp)
    8000348a:	7402                	ld	s0,32(sp)
    8000348c:	64e2                	ld	s1,24(sp)
    8000348e:	6942                	ld	s2,16(sp)
    80003490:	69a2                	ld	s3,8(sp)
    80003492:	6145                	addi	sp,sp,48
    80003494:	8082                	ret

0000000080003496 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003496:	1101                	addi	sp,sp,-32
    80003498:	ec06                	sd	ra,24(sp)
    8000349a:	e822                	sd	s0,16(sp)
    8000349c:	e426                	sd	s1,8(sp)
    8000349e:	e04a                	sd	s2,0(sp)
    800034a0:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800034a2:	00015517          	auipc	a0,0x15
    800034a6:	40e50513          	addi	a0,a0,1038 # 800188b0 <log>
    800034aa:	00003097          	auipc	ra,0x3
    800034ae:	c72080e7          	jalr	-910(ra) # 8000611c <acquire>
  while(1){
    if(log.committing){
    800034b2:	00015497          	auipc	s1,0x15
    800034b6:	3fe48493          	addi	s1,s1,1022 # 800188b0 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800034ba:	4979                	li	s2,30
    800034bc:	a039                	j	800034ca <begin_op+0x34>
      sleep(&log, &log.lock);
    800034be:	85a6                	mv	a1,s1
    800034c0:	8526                	mv	a0,s1
    800034c2:	ffffe097          	auipc	ra,0xffffe
    800034c6:	03a080e7          	jalr	58(ra) # 800014fc <sleep>
    if(log.committing){
    800034ca:	50dc                	lw	a5,36(s1)
    800034cc:	fbed                	bnez	a5,800034be <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800034ce:	509c                	lw	a5,32(s1)
    800034d0:	0017871b          	addiw	a4,a5,1
    800034d4:	0007069b          	sext.w	a3,a4
    800034d8:	0027179b          	slliw	a5,a4,0x2
    800034dc:	9fb9                	addw	a5,a5,a4
    800034de:	0017979b          	slliw	a5,a5,0x1
    800034e2:	54d8                	lw	a4,44(s1)
    800034e4:	9fb9                	addw	a5,a5,a4
    800034e6:	00f95963          	bge	s2,a5,800034f8 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800034ea:	85a6                	mv	a1,s1
    800034ec:	8526                	mv	a0,s1
    800034ee:	ffffe097          	auipc	ra,0xffffe
    800034f2:	00e080e7          	jalr	14(ra) # 800014fc <sleep>
    800034f6:	bfd1                	j	800034ca <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800034f8:	00015517          	auipc	a0,0x15
    800034fc:	3b850513          	addi	a0,a0,952 # 800188b0 <log>
    80003500:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80003502:	00003097          	auipc	ra,0x3
    80003506:	cce080e7          	jalr	-818(ra) # 800061d0 <release>
      break;
    }
  }
}
    8000350a:	60e2                	ld	ra,24(sp)
    8000350c:	6442                	ld	s0,16(sp)
    8000350e:	64a2                	ld	s1,8(sp)
    80003510:	6902                	ld	s2,0(sp)
    80003512:	6105                	addi	sp,sp,32
    80003514:	8082                	ret

0000000080003516 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003516:	7139                	addi	sp,sp,-64
    80003518:	fc06                	sd	ra,56(sp)
    8000351a:	f822                	sd	s0,48(sp)
    8000351c:	f426                	sd	s1,40(sp)
    8000351e:	f04a                	sd	s2,32(sp)
    80003520:	ec4e                	sd	s3,24(sp)
    80003522:	e852                	sd	s4,16(sp)
    80003524:	e456                	sd	s5,8(sp)
    80003526:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003528:	00015497          	auipc	s1,0x15
    8000352c:	38848493          	addi	s1,s1,904 # 800188b0 <log>
    80003530:	8526                	mv	a0,s1
    80003532:	00003097          	auipc	ra,0x3
    80003536:	bea080e7          	jalr	-1046(ra) # 8000611c <acquire>
  log.outstanding -= 1;
    8000353a:	509c                	lw	a5,32(s1)
    8000353c:	37fd                	addiw	a5,a5,-1
    8000353e:	0007891b          	sext.w	s2,a5
    80003542:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003544:	50dc                	lw	a5,36(s1)
    80003546:	efb9                	bnez	a5,800035a4 <end_op+0x8e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003548:	06091663          	bnez	s2,800035b4 <end_op+0x9e>
    do_commit = 1;
    log.committing = 1;
    8000354c:	00015497          	auipc	s1,0x15
    80003550:	36448493          	addi	s1,s1,868 # 800188b0 <log>
    80003554:	4785                	li	a5,1
    80003556:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003558:	8526                	mv	a0,s1
    8000355a:	00003097          	auipc	ra,0x3
    8000355e:	c76080e7          	jalr	-906(ra) # 800061d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003562:	54dc                	lw	a5,44(s1)
    80003564:	06f04763          	bgtz	a5,800035d2 <end_op+0xbc>
    acquire(&log.lock);
    80003568:	00015497          	auipc	s1,0x15
    8000356c:	34848493          	addi	s1,s1,840 # 800188b0 <log>
    80003570:	8526                	mv	a0,s1
    80003572:	00003097          	auipc	ra,0x3
    80003576:	baa080e7          	jalr	-1110(ra) # 8000611c <acquire>
    log.committing = 0;
    8000357a:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    8000357e:	8526                	mv	a0,s1
    80003580:	ffffe097          	auipc	ra,0xffffe
    80003584:	fe0080e7          	jalr	-32(ra) # 80001560 <wakeup>
    release(&log.lock);
    80003588:	8526                	mv	a0,s1
    8000358a:	00003097          	auipc	ra,0x3
    8000358e:	c46080e7          	jalr	-954(ra) # 800061d0 <release>
}
    80003592:	70e2                	ld	ra,56(sp)
    80003594:	7442                	ld	s0,48(sp)
    80003596:	74a2                	ld	s1,40(sp)
    80003598:	7902                	ld	s2,32(sp)
    8000359a:	69e2                	ld	s3,24(sp)
    8000359c:	6a42                	ld	s4,16(sp)
    8000359e:	6aa2                	ld	s5,8(sp)
    800035a0:	6121                	addi	sp,sp,64
    800035a2:	8082                	ret
    panic("log.committing");
    800035a4:	00005517          	auipc	a0,0x5
    800035a8:	00c50513          	addi	a0,a0,12 # 800085b0 <syscalls+0x1e0>
    800035ac:	00002097          	auipc	ra,0x2
    800035b0:	626080e7          	jalr	1574(ra) # 80005bd2 <panic>
    wakeup(&log);
    800035b4:	00015497          	auipc	s1,0x15
    800035b8:	2fc48493          	addi	s1,s1,764 # 800188b0 <log>
    800035bc:	8526                	mv	a0,s1
    800035be:	ffffe097          	auipc	ra,0xffffe
    800035c2:	fa2080e7          	jalr	-94(ra) # 80001560 <wakeup>
  release(&log.lock);
    800035c6:	8526                	mv	a0,s1
    800035c8:	00003097          	auipc	ra,0x3
    800035cc:	c08080e7          	jalr	-1016(ra) # 800061d0 <release>
  if(do_commit){
    800035d0:	b7c9                	j	80003592 <end_op+0x7c>
  for (tail = 0; tail < log.lh.n; tail++) {
    800035d2:	00015a97          	auipc	s5,0x15
    800035d6:	30ea8a93          	addi	s5,s5,782 # 800188e0 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800035da:	00015a17          	auipc	s4,0x15
    800035de:	2d6a0a13          	addi	s4,s4,726 # 800188b0 <log>
    800035e2:	018a2583          	lw	a1,24(s4)
    800035e6:	012585bb          	addw	a1,a1,s2
    800035ea:	2585                	addiw	a1,a1,1
    800035ec:	028a2503          	lw	a0,40(s4)
    800035f0:	fffff097          	auipc	ra,0xfffff
    800035f4:	cca080e7          	jalr	-822(ra) # 800022ba <bread>
    800035f8:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800035fa:	000aa583          	lw	a1,0(s5)
    800035fe:	028a2503          	lw	a0,40(s4)
    80003602:	fffff097          	auipc	ra,0xfffff
    80003606:	cb8080e7          	jalr	-840(ra) # 800022ba <bread>
    8000360a:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000360c:	40000613          	li	a2,1024
    80003610:	05850593          	addi	a1,a0,88
    80003614:	05848513          	addi	a0,s1,88
    80003618:	ffffd097          	auipc	ra,0xffffd
    8000361c:	bc0080e7          	jalr	-1088(ra) # 800001d8 <memmove>
    bwrite(to);  // write the log
    80003620:	8526                	mv	a0,s1
    80003622:	fffff097          	auipc	ra,0xfffff
    80003626:	d8a080e7          	jalr	-630(ra) # 800023ac <bwrite>
    brelse(from);
    8000362a:	854e                	mv	a0,s3
    8000362c:	fffff097          	auipc	ra,0xfffff
    80003630:	dbe080e7          	jalr	-578(ra) # 800023ea <brelse>
    brelse(to);
    80003634:	8526                	mv	a0,s1
    80003636:	fffff097          	auipc	ra,0xfffff
    8000363a:	db4080e7          	jalr	-588(ra) # 800023ea <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000363e:	2905                	addiw	s2,s2,1
    80003640:	0a91                	addi	s5,s5,4
    80003642:	02ca2783          	lw	a5,44(s4)
    80003646:	f8f94ee3          	blt	s2,a5,800035e2 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    8000364a:	00000097          	auipc	ra,0x0
    8000364e:	c6a080e7          	jalr	-918(ra) # 800032b4 <write_head>
    install_trans(0); // Now install writes to home locations
    80003652:	4501                	li	a0,0
    80003654:	00000097          	auipc	ra,0x0
    80003658:	cda080e7          	jalr	-806(ra) # 8000332e <install_trans>
    log.lh.n = 0;
    8000365c:	00015797          	auipc	a5,0x15
    80003660:	2807a023          	sw	zero,640(a5) # 800188dc <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003664:	00000097          	auipc	ra,0x0
    80003668:	c50080e7          	jalr	-944(ra) # 800032b4 <write_head>
    8000366c:	bdf5                	j	80003568 <end_op+0x52>

000000008000366e <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000366e:	1101                	addi	sp,sp,-32
    80003670:	ec06                	sd	ra,24(sp)
    80003672:	e822                	sd	s0,16(sp)
    80003674:	e426                	sd	s1,8(sp)
    80003676:	e04a                	sd	s2,0(sp)
    80003678:	1000                	addi	s0,sp,32
    8000367a:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000367c:	00015917          	auipc	s2,0x15
    80003680:	23490913          	addi	s2,s2,564 # 800188b0 <log>
    80003684:	854a                	mv	a0,s2
    80003686:	00003097          	auipc	ra,0x3
    8000368a:	a96080e7          	jalr	-1386(ra) # 8000611c <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000368e:	02c92603          	lw	a2,44(s2)
    80003692:	47f5                	li	a5,29
    80003694:	06c7c563          	blt	a5,a2,800036fe <log_write+0x90>
    80003698:	00015797          	auipc	a5,0x15
    8000369c:	2347a783          	lw	a5,564(a5) # 800188cc <log+0x1c>
    800036a0:	37fd                	addiw	a5,a5,-1
    800036a2:	04f65e63          	bge	a2,a5,800036fe <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800036a6:	00015797          	auipc	a5,0x15
    800036aa:	22a7a783          	lw	a5,554(a5) # 800188d0 <log+0x20>
    800036ae:	06f05063          	blez	a5,8000370e <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800036b2:	4781                	li	a5,0
    800036b4:	06c05563          	blez	a2,8000371e <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800036b8:	44cc                	lw	a1,12(s1)
    800036ba:	00015717          	auipc	a4,0x15
    800036be:	22670713          	addi	a4,a4,550 # 800188e0 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    800036c2:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    800036c4:	4314                	lw	a3,0(a4)
    800036c6:	04b68c63          	beq	a3,a1,8000371e <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    800036ca:	2785                	addiw	a5,a5,1
    800036cc:	0711                	addi	a4,a4,4
    800036ce:	fef61be3          	bne	a2,a5,800036c4 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    800036d2:	0621                	addi	a2,a2,8
    800036d4:	060a                	slli	a2,a2,0x2
    800036d6:	00015797          	auipc	a5,0x15
    800036da:	1da78793          	addi	a5,a5,474 # 800188b0 <log>
    800036de:	963e                	add	a2,a2,a5
    800036e0:	44dc                	lw	a5,12(s1)
    800036e2:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800036e4:	8526                	mv	a0,s1
    800036e6:	fffff097          	auipc	ra,0xfffff
    800036ea:	da2080e7          	jalr	-606(ra) # 80002488 <bpin>
    log.lh.n++;
    800036ee:	00015717          	auipc	a4,0x15
    800036f2:	1c270713          	addi	a4,a4,450 # 800188b0 <log>
    800036f6:	575c                	lw	a5,44(a4)
    800036f8:	2785                	addiw	a5,a5,1
    800036fa:	d75c                	sw	a5,44(a4)
    800036fc:	a835                	j	80003738 <log_write+0xca>
    panic("too big a transaction");
    800036fe:	00005517          	auipc	a0,0x5
    80003702:	ec250513          	addi	a0,a0,-318 # 800085c0 <syscalls+0x1f0>
    80003706:	00002097          	auipc	ra,0x2
    8000370a:	4cc080e7          	jalr	1228(ra) # 80005bd2 <panic>
    panic("log_write outside of trans");
    8000370e:	00005517          	auipc	a0,0x5
    80003712:	eca50513          	addi	a0,a0,-310 # 800085d8 <syscalls+0x208>
    80003716:	00002097          	auipc	ra,0x2
    8000371a:	4bc080e7          	jalr	1212(ra) # 80005bd2 <panic>
  log.lh.block[i] = b->blockno;
    8000371e:	00878713          	addi	a4,a5,8
    80003722:	00271693          	slli	a3,a4,0x2
    80003726:	00015717          	auipc	a4,0x15
    8000372a:	18a70713          	addi	a4,a4,394 # 800188b0 <log>
    8000372e:	9736                	add	a4,a4,a3
    80003730:	44d4                	lw	a3,12(s1)
    80003732:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003734:	faf608e3          	beq	a2,a5,800036e4 <log_write+0x76>
  }
  release(&log.lock);
    80003738:	00015517          	auipc	a0,0x15
    8000373c:	17850513          	addi	a0,a0,376 # 800188b0 <log>
    80003740:	00003097          	auipc	ra,0x3
    80003744:	a90080e7          	jalr	-1392(ra) # 800061d0 <release>
}
    80003748:	60e2                	ld	ra,24(sp)
    8000374a:	6442                	ld	s0,16(sp)
    8000374c:	64a2                	ld	s1,8(sp)
    8000374e:	6902                	ld	s2,0(sp)
    80003750:	6105                	addi	sp,sp,32
    80003752:	8082                	ret

0000000080003754 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003754:	1101                	addi	sp,sp,-32
    80003756:	ec06                	sd	ra,24(sp)
    80003758:	e822                	sd	s0,16(sp)
    8000375a:	e426                	sd	s1,8(sp)
    8000375c:	e04a                	sd	s2,0(sp)
    8000375e:	1000                	addi	s0,sp,32
    80003760:	84aa                	mv	s1,a0
    80003762:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003764:	00005597          	auipc	a1,0x5
    80003768:	e9458593          	addi	a1,a1,-364 # 800085f8 <syscalls+0x228>
    8000376c:	0521                	addi	a0,a0,8
    8000376e:	00003097          	auipc	ra,0x3
    80003772:	91e080e7          	jalr	-1762(ra) # 8000608c <initlock>
  lk->name = name;
    80003776:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    8000377a:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000377e:	0204a423          	sw	zero,40(s1)
}
    80003782:	60e2                	ld	ra,24(sp)
    80003784:	6442                	ld	s0,16(sp)
    80003786:	64a2                	ld	s1,8(sp)
    80003788:	6902                	ld	s2,0(sp)
    8000378a:	6105                	addi	sp,sp,32
    8000378c:	8082                	ret

000000008000378e <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8000378e:	1101                	addi	sp,sp,-32
    80003790:	ec06                	sd	ra,24(sp)
    80003792:	e822                	sd	s0,16(sp)
    80003794:	e426                	sd	s1,8(sp)
    80003796:	e04a                	sd	s2,0(sp)
    80003798:	1000                	addi	s0,sp,32
    8000379a:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    8000379c:	00850913          	addi	s2,a0,8
    800037a0:	854a                	mv	a0,s2
    800037a2:	00003097          	auipc	ra,0x3
    800037a6:	97a080e7          	jalr	-1670(ra) # 8000611c <acquire>
  while (lk->locked) {
    800037aa:	409c                	lw	a5,0(s1)
    800037ac:	cb89                	beqz	a5,800037be <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    800037ae:	85ca                	mv	a1,s2
    800037b0:	8526                	mv	a0,s1
    800037b2:	ffffe097          	auipc	ra,0xffffe
    800037b6:	d4a080e7          	jalr	-694(ra) # 800014fc <sleep>
  while (lk->locked) {
    800037ba:	409c                	lw	a5,0(s1)
    800037bc:	fbed                	bnez	a5,800037ae <acquiresleep+0x20>
  }
  lk->locked = 1;
    800037be:	4785                	li	a5,1
    800037c0:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800037c2:	ffffd097          	auipc	ra,0xffffd
    800037c6:	696080e7          	jalr	1686(ra) # 80000e58 <myproc>
    800037ca:	591c                	lw	a5,48(a0)
    800037cc:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800037ce:	854a                	mv	a0,s2
    800037d0:	00003097          	auipc	ra,0x3
    800037d4:	a00080e7          	jalr	-1536(ra) # 800061d0 <release>
}
    800037d8:	60e2                	ld	ra,24(sp)
    800037da:	6442                	ld	s0,16(sp)
    800037dc:	64a2                	ld	s1,8(sp)
    800037de:	6902                	ld	s2,0(sp)
    800037e0:	6105                	addi	sp,sp,32
    800037e2:	8082                	ret

00000000800037e4 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800037e4:	1101                	addi	sp,sp,-32
    800037e6:	ec06                	sd	ra,24(sp)
    800037e8:	e822                	sd	s0,16(sp)
    800037ea:	e426                	sd	s1,8(sp)
    800037ec:	e04a                	sd	s2,0(sp)
    800037ee:	1000                	addi	s0,sp,32
    800037f0:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800037f2:	00850913          	addi	s2,a0,8
    800037f6:	854a                	mv	a0,s2
    800037f8:	00003097          	auipc	ra,0x3
    800037fc:	924080e7          	jalr	-1756(ra) # 8000611c <acquire>
  lk->locked = 0;
    80003800:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003804:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003808:	8526                	mv	a0,s1
    8000380a:	ffffe097          	auipc	ra,0xffffe
    8000380e:	d56080e7          	jalr	-682(ra) # 80001560 <wakeup>
  release(&lk->lk);
    80003812:	854a                	mv	a0,s2
    80003814:	00003097          	auipc	ra,0x3
    80003818:	9bc080e7          	jalr	-1604(ra) # 800061d0 <release>
}
    8000381c:	60e2                	ld	ra,24(sp)
    8000381e:	6442                	ld	s0,16(sp)
    80003820:	64a2                	ld	s1,8(sp)
    80003822:	6902                	ld	s2,0(sp)
    80003824:	6105                	addi	sp,sp,32
    80003826:	8082                	ret

0000000080003828 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003828:	7179                	addi	sp,sp,-48
    8000382a:	f406                	sd	ra,40(sp)
    8000382c:	f022                	sd	s0,32(sp)
    8000382e:	ec26                	sd	s1,24(sp)
    80003830:	e84a                	sd	s2,16(sp)
    80003832:	e44e                	sd	s3,8(sp)
    80003834:	1800                	addi	s0,sp,48
    80003836:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003838:	00850913          	addi	s2,a0,8
    8000383c:	854a                	mv	a0,s2
    8000383e:	00003097          	auipc	ra,0x3
    80003842:	8de080e7          	jalr	-1826(ra) # 8000611c <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003846:	409c                	lw	a5,0(s1)
    80003848:	ef99                	bnez	a5,80003866 <holdingsleep+0x3e>
    8000384a:	4481                	li	s1,0
  release(&lk->lk);
    8000384c:	854a                	mv	a0,s2
    8000384e:	00003097          	auipc	ra,0x3
    80003852:	982080e7          	jalr	-1662(ra) # 800061d0 <release>
  return r;
}
    80003856:	8526                	mv	a0,s1
    80003858:	70a2                	ld	ra,40(sp)
    8000385a:	7402                	ld	s0,32(sp)
    8000385c:	64e2                	ld	s1,24(sp)
    8000385e:	6942                	ld	s2,16(sp)
    80003860:	69a2                	ld	s3,8(sp)
    80003862:	6145                	addi	sp,sp,48
    80003864:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003866:	0284a983          	lw	s3,40(s1)
    8000386a:	ffffd097          	auipc	ra,0xffffd
    8000386e:	5ee080e7          	jalr	1518(ra) # 80000e58 <myproc>
    80003872:	5904                	lw	s1,48(a0)
    80003874:	413484b3          	sub	s1,s1,s3
    80003878:	0014b493          	seqz	s1,s1
    8000387c:	bfc1                	j	8000384c <holdingsleep+0x24>

000000008000387e <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000387e:	1141                	addi	sp,sp,-16
    80003880:	e406                	sd	ra,8(sp)
    80003882:	e022                	sd	s0,0(sp)
    80003884:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003886:	00005597          	auipc	a1,0x5
    8000388a:	d8258593          	addi	a1,a1,-638 # 80008608 <syscalls+0x238>
    8000388e:	00015517          	auipc	a0,0x15
    80003892:	16a50513          	addi	a0,a0,362 # 800189f8 <ftable>
    80003896:	00002097          	auipc	ra,0x2
    8000389a:	7f6080e7          	jalr	2038(ra) # 8000608c <initlock>
}
    8000389e:	60a2                	ld	ra,8(sp)
    800038a0:	6402                	ld	s0,0(sp)
    800038a2:	0141                	addi	sp,sp,16
    800038a4:	8082                	ret

00000000800038a6 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800038a6:	1101                	addi	sp,sp,-32
    800038a8:	ec06                	sd	ra,24(sp)
    800038aa:	e822                	sd	s0,16(sp)
    800038ac:	e426                	sd	s1,8(sp)
    800038ae:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800038b0:	00015517          	auipc	a0,0x15
    800038b4:	14850513          	addi	a0,a0,328 # 800189f8 <ftable>
    800038b8:	00003097          	auipc	ra,0x3
    800038bc:	864080e7          	jalr	-1948(ra) # 8000611c <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800038c0:	00015497          	auipc	s1,0x15
    800038c4:	15048493          	addi	s1,s1,336 # 80018a10 <ftable+0x18>
    800038c8:	00016717          	auipc	a4,0x16
    800038cc:	0e870713          	addi	a4,a4,232 # 800199b0 <disk>
    if(f->ref == 0){
    800038d0:	40dc                	lw	a5,4(s1)
    800038d2:	cf99                	beqz	a5,800038f0 <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800038d4:	02848493          	addi	s1,s1,40
    800038d8:	fee49ce3          	bne	s1,a4,800038d0 <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800038dc:	00015517          	auipc	a0,0x15
    800038e0:	11c50513          	addi	a0,a0,284 # 800189f8 <ftable>
    800038e4:	00003097          	auipc	ra,0x3
    800038e8:	8ec080e7          	jalr	-1812(ra) # 800061d0 <release>
  return 0;
    800038ec:	4481                	li	s1,0
    800038ee:	a819                	j	80003904 <filealloc+0x5e>
      f->ref = 1;
    800038f0:	4785                	li	a5,1
    800038f2:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800038f4:	00015517          	auipc	a0,0x15
    800038f8:	10450513          	addi	a0,a0,260 # 800189f8 <ftable>
    800038fc:	00003097          	auipc	ra,0x3
    80003900:	8d4080e7          	jalr	-1836(ra) # 800061d0 <release>
}
    80003904:	8526                	mv	a0,s1
    80003906:	60e2                	ld	ra,24(sp)
    80003908:	6442                	ld	s0,16(sp)
    8000390a:	64a2                	ld	s1,8(sp)
    8000390c:	6105                	addi	sp,sp,32
    8000390e:	8082                	ret

0000000080003910 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003910:	1101                	addi	sp,sp,-32
    80003912:	ec06                	sd	ra,24(sp)
    80003914:	e822                	sd	s0,16(sp)
    80003916:	e426                	sd	s1,8(sp)
    80003918:	1000                	addi	s0,sp,32
    8000391a:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    8000391c:	00015517          	auipc	a0,0x15
    80003920:	0dc50513          	addi	a0,a0,220 # 800189f8 <ftable>
    80003924:	00002097          	auipc	ra,0x2
    80003928:	7f8080e7          	jalr	2040(ra) # 8000611c <acquire>
  if(f->ref < 1)
    8000392c:	40dc                	lw	a5,4(s1)
    8000392e:	02f05263          	blez	a5,80003952 <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003932:	2785                	addiw	a5,a5,1
    80003934:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003936:	00015517          	auipc	a0,0x15
    8000393a:	0c250513          	addi	a0,a0,194 # 800189f8 <ftable>
    8000393e:	00003097          	auipc	ra,0x3
    80003942:	892080e7          	jalr	-1902(ra) # 800061d0 <release>
  return f;
}
    80003946:	8526                	mv	a0,s1
    80003948:	60e2                	ld	ra,24(sp)
    8000394a:	6442                	ld	s0,16(sp)
    8000394c:	64a2                	ld	s1,8(sp)
    8000394e:	6105                	addi	sp,sp,32
    80003950:	8082                	ret
    panic("filedup");
    80003952:	00005517          	auipc	a0,0x5
    80003956:	cbe50513          	addi	a0,a0,-834 # 80008610 <syscalls+0x240>
    8000395a:	00002097          	auipc	ra,0x2
    8000395e:	278080e7          	jalr	632(ra) # 80005bd2 <panic>

0000000080003962 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003962:	7139                	addi	sp,sp,-64
    80003964:	fc06                	sd	ra,56(sp)
    80003966:	f822                	sd	s0,48(sp)
    80003968:	f426                	sd	s1,40(sp)
    8000396a:	f04a                	sd	s2,32(sp)
    8000396c:	ec4e                	sd	s3,24(sp)
    8000396e:	e852                	sd	s4,16(sp)
    80003970:	e456                	sd	s5,8(sp)
    80003972:	0080                	addi	s0,sp,64
    80003974:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003976:	00015517          	auipc	a0,0x15
    8000397a:	08250513          	addi	a0,a0,130 # 800189f8 <ftable>
    8000397e:	00002097          	auipc	ra,0x2
    80003982:	79e080e7          	jalr	1950(ra) # 8000611c <acquire>
  if(f->ref < 1)
    80003986:	40dc                	lw	a5,4(s1)
    80003988:	06f05163          	blez	a5,800039ea <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    8000398c:	37fd                	addiw	a5,a5,-1
    8000398e:	0007871b          	sext.w	a4,a5
    80003992:	c0dc                	sw	a5,4(s1)
    80003994:	06e04363          	bgtz	a4,800039fa <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003998:	0004a903          	lw	s2,0(s1)
    8000399c:	0094ca83          	lbu	s5,9(s1)
    800039a0:	0104ba03          	ld	s4,16(s1)
    800039a4:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    800039a8:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    800039ac:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    800039b0:	00015517          	auipc	a0,0x15
    800039b4:	04850513          	addi	a0,a0,72 # 800189f8 <ftable>
    800039b8:	00003097          	auipc	ra,0x3
    800039bc:	818080e7          	jalr	-2024(ra) # 800061d0 <release>

  if(ff.type == FD_PIPE){
    800039c0:	4785                	li	a5,1
    800039c2:	04f90d63          	beq	s2,a5,80003a1c <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    800039c6:	3979                	addiw	s2,s2,-2
    800039c8:	4785                	li	a5,1
    800039ca:	0527e063          	bltu	a5,s2,80003a0a <fileclose+0xa8>
    begin_op();
    800039ce:	00000097          	auipc	ra,0x0
    800039d2:	ac8080e7          	jalr	-1336(ra) # 80003496 <begin_op>
    iput(ff.ip);
    800039d6:	854e                	mv	a0,s3
    800039d8:	fffff097          	auipc	ra,0xfffff
    800039dc:	2b6080e7          	jalr	694(ra) # 80002c8e <iput>
    end_op();
    800039e0:	00000097          	auipc	ra,0x0
    800039e4:	b36080e7          	jalr	-1226(ra) # 80003516 <end_op>
    800039e8:	a00d                	j	80003a0a <fileclose+0xa8>
    panic("fileclose");
    800039ea:	00005517          	auipc	a0,0x5
    800039ee:	c2e50513          	addi	a0,a0,-978 # 80008618 <syscalls+0x248>
    800039f2:	00002097          	auipc	ra,0x2
    800039f6:	1e0080e7          	jalr	480(ra) # 80005bd2 <panic>
    release(&ftable.lock);
    800039fa:	00015517          	auipc	a0,0x15
    800039fe:	ffe50513          	addi	a0,a0,-2 # 800189f8 <ftable>
    80003a02:	00002097          	auipc	ra,0x2
    80003a06:	7ce080e7          	jalr	1998(ra) # 800061d0 <release>
  }
}
    80003a0a:	70e2                	ld	ra,56(sp)
    80003a0c:	7442                	ld	s0,48(sp)
    80003a0e:	74a2                	ld	s1,40(sp)
    80003a10:	7902                	ld	s2,32(sp)
    80003a12:	69e2                	ld	s3,24(sp)
    80003a14:	6a42                	ld	s4,16(sp)
    80003a16:	6aa2                	ld	s5,8(sp)
    80003a18:	6121                	addi	sp,sp,64
    80003a1a:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003a1c:	85d6                	mv	a1,s5
    80003a1e:	8552                	mv	a0,s4
    80003a20:	00000097          	auipc	ra,0x0
    80003a24:	34c080e7          	jalr	844(ra) # 80003d6c <pipeclose>
    80003a28:	b7cd                	j	80003a0a <fileclose+0xa8>

0000000080003a2a <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003a2a:	715d                	addi	sp,sp,-80
    80003a2c:	e486                	sd	ra,72(sp)
    80003a2e:	e0a2                	sd	s0,64(sp)
    80003a30:	fc26                	sd	s1,56(sp)
    80003a32:	f84a                	sd	s2,48(sp)
    80003a34:	f44e                	sd	s3,40(sp)
    80003a36:	0880                	addi	s0,sp,80
    80003a38:	84aa                	mv	s1,a0
    80003a3a:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003a3c:	ffffd097          	auipc	ra,0xffffd
    80003a40:	41c080e7          	jalr	1052(ra) # 80000e58 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003a44:	409c                	lw	a5,0(s1)
    80003a46:	37f9                	addiw	a5,a5,-2
    80003a48:	4705                	li	a4,1
    80003a4a:	04f76763          	bltu	a4,a5,80003a98 <filestat+0x6e>
    80003a4e:	892a                	mv	s2,a0
    ilock(f->ip);
    80003a50:	6c88                	ld	a0,24(s1)
    80003a52:	fffff097          	auipc	ra,0xfffff
    80003a56:	082080e7          	jalr	130(ra) # 80002ad4 <ilock>
    stati(f->ip, &st);
    80003a5a:	fb840593          	addi	a1,s0,-72
    80003a5e:	6c88                	ld	a0,24(s1)
    80003a60:	fffff097          	auipc	ra,0xfffff
    80003a64:	2fe080e7          	jalr	766(ra) # 80002d5e <stati>
    iunlock(f->ip);
    80003a68:	6c88                	ld	a0,24(s1)
    80003a6a:	fffff097          	auipc	ra,0xfffff
    80003a6e:	12c080e7          	jalr	300(ra) # 80002b96 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003a72:	46e1                	li	a3,24
    80003a74:	fb840613          	addi	a2,s0,-72
    80003a78:	85ce                	mv	a1,s3
    80003a7a:	05093503          	ld	a0,80(s2)
    80003a7e:	ffffd097          	auipc	ra,0xffffd
    80003a82:	098080e7          	jalr	152(ra) # 80000b16 <copyout>
    80003a86:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003a8a:	60a6                	ld	ra,72(sp)
    80003a8c:	6406                	ld	s0,64(sp)
    80003a8e:	74e2                	ld	s1,56(sp)
    80003a90:	7942                	ld	s2,48(sp)
    80003a92:	79a2                	ld	s3,40(sp)
    80003a94:	6161                	addi	sp,sp,80
    80003a96:	8082                	ret
  return -1;
    80003a98:	557d                	li	a0,-1
    80003a9a:	bfc5                	j	80003a8a <filestat+0x60>

0000000080003a9c <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003a9c:	7179                	addi	sp,sp,-48
    80003a9e:	f406                	sd	ra,40(sp)
    80003aa0:	f022                	sd	s0,32(sp)
    80003aa2:	ec26                	sd	s1,24(sp)
    80003aa4:	e84a                	sd	s2,16(sp)
    80003aa6:	e44e                	sd	s3,8(sp)
    80003aa8:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003aaa:	00854783          	lbu	a5,8(a0)
    80003aae:	c3d5                	beqz	a5,80003b52 <fileread+0xb6>
    80003ab0:	84aa                	mv	s1,a0
    80003ab2:	89ae                	mv	s3,a1
    80003ab4:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003ab6:	411c                	lw	a5,0(a0)
    80003ab8:	4705                	li	a4,1
    80003aba:	04e78963          	beq	a5,a4,80003b0c <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003abe:	470d                	li	a4,3
    80003ac0:	04e78d63          	beq	a5,a4,80003b1a <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003ac4:	4709                	li	a4,2
    80003ac6:	06e79e63          	bne	a5,a4,80003b42 <fileread+0xa6>
    ilock(f->ip);
    80003aca:	6d08                	ld	a0,24(a0)
    80003acc:	fffff097          	auipc	ra,0xfffff
    80003ad0:	008080e7          	jalr	8(ra) # 80002ad4 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003ad4:	874a                	mv	a4,s2
    80003ad6:	5094                	lw	a3,32(s1)
    80003ad8:	864e                	mv	a2,s3
    80003ada:	4585                	li	a1,1
    80003adc:	6c88                	ld	a0,24(s1)
    80003ade:	fffff097          	auipc	ra,0xfffff
    80003ae2:	2aa080e7          	jalr	682(ra) # 80002d88 <readi>
    80003ae6:	892a                	mv	s2,a0
    80003ae8:	00a05563          	blez	a0,80003af2 <fileread+0x56>
      f->off += r;
    80003aec:	509c                	lw	a5,32(s1)
    80003aee:	9fa9                	addw	a5,a5,a0
    80003af0:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003af2:	6c88                	ld	a0,24(s1)
    80003af4:	fffff097          	auipc	ra,0xfffff
    80003af8:	0a2080e7          	jalr	162(ra) # 80002b96 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003afc:	854a                	mv	a0,s2
    80003afe:	70a2                	ld	ra,40(sp)
    80003b00:	7402                	ld	s0,32(sp)
    80003b02:	64e2                	ld	s1,24(sp)
    80003b04:	6942                	ld	s2,16(sp)
    80003b06:	69a2                	ld	s3,8(sp)
    80003b08:	6145                	addi	sp,sp,48
    80003b0a:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003b0c:	6908                	ld	a0,16(a0)
    80003b0e:	00000097          	auipc	ra,0x0
    80003b12:	3ce080e7          	jalr	974(ra) # 80003edc <piperead>
    80003b16:	892a                	mv	s2,a0
    80003b18:	b7d5                	j	80003afc <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003b1a:	02451783          	lh	a5,36(a0)
    80003b1e:	03079693          	slli	a3,a5,0x30
    80003b22:	92c1                	srli	a3,a3,0x30
    80003b24:	4725                	li	a4,9
    80003b26:	02d76863          	bltu	a4,a3,80003b56 <fileread+0xba>
    80003b2a:	0792                	slli	a5,a5,0x4
    80003b2c:	00015717          	auipc	a4,0x15
    80003b30:	e2c70713          	addi	a4,a4,-468 # 80018958 <devsw>
    80003b34:	97ba                	add	a5,a5,a4
    80003b36:	639c                	ld	a5,0(a5)
    80003b38:	c38d                	beqz	a5,80003b5a <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003b3a:	4505                	li	a0,1
    80003b3c:	9782                	jalr	a5
    80003b3e:	892a                	mv	s2,a0
    80003b40:	bf75                	j	80003afc <fileread+0x60>
    panic("fileread");
    80003b42:	00005517          	auipc	a0,0x5
    80003b46:	ae650513          	addi	a0,a0,-1306 # 80008628 <syscalls+0x258>
    80003b4a:	00002097          	auipc	ra,0x2
    80003b4e:	088080e7          	jalr	136(ra) # 80005bd2 <panic>
    return -1;
    80003b52:	597d                	li	s2,-1
    80003b54:	b765                	j	80003afc <fileread+0x60>
      return -1;
    80003b56:	597d                	li	s2,-1
    80003b58:	b755                	j	80003afc <fileread+0x60>
    80003b5a:	597d                	li	s2,-1
    80003b5c:	b745                	j	80003afc <fileread+0x60>

0000000080003b5e <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003b5e:	715d                	addi	sp,sp,-80
    80003b60:	e486                	sd	ra,72(sp)
    80003b62:	e0a2                	sd	s0,64(sp)
    80003b64:	fc26                	sd	s1,56(sp)
    80003b66:	f84a                	sd	s2,48(sp)
    80003b68:	f44e                	sd	s3,40(sp)
    80003b6a:	f052                	sd	s4,32(sp)
    80003b6c:	ec56                	sd	s5,24(sp)
    80003b6e:	e85a                	sd	s6,16(sp)
    80003b70:	e45e                	sd	s7,8(sp)
    80003b72:	e062                	sd	s8,0(sp)
    80003b74:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80003b76:	00954783          	lbu	a5,9(a0)
    80003b7a:	10078663          	beqz	a5,80003c86 <filewrite+0x128>
    80003b7e:	892a                	mv	s2,a0
    80003b80:	8aae                	mv	s5,a1
    80003b82:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    80003b84:	411c                	lw	a5,0(a0)
    80003b86:	4705                	li	a4,1
    80003b88:	02e78263          	beq	a5,a4,80003bac <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003b8c:	470d                	li	a4,3
    80003b8e:	02e78663          	beq	a5,a4,80003bba <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003b92:	4709                	li	a4,2
    80003b94:	0ee79163          	bne	a5,a4,80003c76 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003b98:	0ac05d63          	blez	a2,80003c52 <filewrite+0xf4>
    int i = 0;
    80003b9c:	4981                	li	s3,0
    80003b9e:	6b05                	lui	s6,0x1
    80003ba0:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    80003ba4:	6b85                	lui	s7,0x1
    80003ba6:	c00b8b9b          	addiw	s7,s7,-1024
    80003baa:	a861                	j	80003c42 <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80003bac:	6908                	ld	a0,16(a0)
    80003bae:	00000097          	auipc	ra,0x0
    80003bb2:	22e080e7          	jalr	558(ra) # 80003ddc <pipewrite>
    80003bb6:	8a2a                	mv	s4,a0
    80003bb8:	a045                	j	80003c58 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80003bba:	02451783          	lh	a5,36(a0)
    80003bbe:	03079693          	slli	a3,a5,0x30
    80003bc2:	92c1                	srli	a3,a3,0x30
    80003bc4:	4725                	li	a4,9
    80003bc6:	0cd76263          	bltu	a4,a3,80003c8a <filewrite+0x12c>
    80003bca:	0792                	slli	a5,a5,0x4
    80003bcc:	00015717          	auipc	a4,0x15
    80003bd0:	d8c70713          	addi	a4,a4,-628 # 80018958 <devsw>
    80003bd4:	97ba                	add	a5,a5,a4
    80003bd6:	679c                	ld	a5,8(a5)
    80003bd8:	cbdd                	beqz	a5,80003c8e <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    80003bda:	4505                	li	a0,1
    80003bdc:	9782                	jalr	a5
    80003bde:	8a2a                	mv	s4,a0
    80003be0:	a8a5                	j	80003c58 <filewrite+0xfa>
    80003be2:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003be6:	00000097          	auipc	ra,0x0
    80003bea:	8b0080e7          	jalr	-1872(ra) # 80003496 <begin_op>
      ilock(f->ip);
    80003bee:	01893503          	ld	a0,24(s2)
    80003bf2:	fffff097          	auipc	ra,0xfffff
    80003bf6:	ee2080e7          	jalr	-286(ra) # 80002ad4 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003bfa:	8762                	mv	a4,s8
    80003bfc:	02092683          	lw	a3,32(s2)
    80003c00:	01598633          	add	a2,s3,s5
    80003c04:	4585                	li	a1,1
    80003c06:	01893503          	ld	a0,24(s2)
    80003c0a:	fffff097          	auipc	ra,0xfffff
    80003c0e:	276080e7          	jalr	630(ra) # 80002e80 <writei>
    80003c12:	84aa                	mv	s1,a0
    80003c14:	00a05763          	blez	a0,80003c22 <filewrite+0xc4>
        f->off += r;
    80003c18:	02092783          	lw	a5,32(s2)
    80003c1c:	9fa9                	addw	a5,a5,a0
    80003c1e:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003c22:	01893503          	ld	a0,24(s2)
    80003c26:	fffff097          	auipc	ra,0xfffff
    80003c2a:	f70080e7          	jalr	-144(ra) # 80002b96 <iunlock>
      end_op();
    80003c2e:	00000097          	auipc	ra,0x0
    80003c32:	8e8080e7          	jalr	-1816(ra) # 80003516 <end_op>

      if(r != n1){
    80003c36:	009c1f63          	bne	s8,s1,80003c54 <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80003c3a:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003c3e:	0149db63          	bge	s3,s4,80003c54 <filewrite+0xf6>
      int n1 = n - i;
    80003c42:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80003c46:	84be                	mv	s1,a5
    80003c48:	2781                	sext.w	a5,a5
    80003c4a:	f8fb5ce3          	bge	s6,a5,80003be2 <filewrite+0x84>
    80003c4e:	84de                	mv	s1,s7
    80003c50:	bf49                	j	80003be2 <filewrite+0x84>
    int i = 0;
    80003c52:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    80003c54:	013a1f63          	bne	s4,s3,80003c72 <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80003c58:	8552                	mv	a0,s4
    80003c5a:	60a6                	ld	ra,72(sp)
    80003c5c:	6406                	ld	s0,64(sp)
    80003c5e:	74e2                	ld	s1,56(sp)
    80003c60:	7942                	ld	s2,48(sp)
    80003c62:	79a2                	ld	s3,40(sp)
    80003c64:	7a02                	ld	s4,32(sp)
    80003c66:	6ae2                	ld	s5,24(sp)
    80003c68:	6b42                	ld	s6,16(sp)
    80003c6a:	6ba2                	ld	s7,8(sp)
    80003c6c:	6c02                	ld	s8,0(sp)
    80003c6e:	6161                	addi	sp,sp,80
    80003c70:	8082                	ret
    ret = (i == n ? n : -1);
    80003c72:	5a7d                	li	s4,-1
    80003c74:	b7d5                	j	80003c58 <filewrite+0xfa>
    panic("filewrite");
    80003c76:	00005517          	auipc	a0,0x5
    80003c7a:	9c250513          	addi	a0,a0,-1598 # 80008638 <syscalls+0x268>
    80003c7e:	00002097          	auipc	ra,0x2
    80003c82:	f54080e7          	jalr	-172(ra) # 80005bd2 <panic>
    return -1;
    80003c86:	5a7d                	li	s4,-1
    80003c88:	bfc1                	j	80003c58 <filewrite+0xfa>
      return -1;
    80003c8a:	5a7d                	li	s4,-1
    80003c8c:	b7f1                	j	80003c58 <filewrite+0xfa>
    80003c8e:	5a7d                	li	s4,-1
    80003c90:	b7e1                	j	80003c58 <filewrite+0xfa>

0000000080003c92 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003c92:	7179                	addi	sp,sp,-48
    80003c94:	f406                	sd	ra,40(sp)
    80003c96:	f022                	sd	s0,32(sp)
    80003c98:	ec26                	sd	s1,24(sp)
    80003c9a:	e84a                	sd	s2,16(sp)
    80003c9c:	e44e                	sd	s3,8(sp)
    80003c9e:	e052                	sd	s4,0(sp)
    80003ca0:	1800                	addi	s0,sp,48
    80003ca2:	84aa                	mv	s1,a0
    80003ca4:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003ca6:	0005b023          	sd	zero,0(a1)
    80003caa:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003cae:	00000097          	auipc	ra,0x0
    80003cb2:	bf8080e7          	jalr	-1032(ra) # 800038a6 <filealloc>
    80003cb6:	e088                	sd	a0,0(s1)
    80003cb8:	c551                	beqz	a0,80003d44 <pipealloc+0xb2>
    80003cba:	00000097          	auipc	ra,0x0
    80003cbe:	bec080e7          	jalr	-1044(ra) # 800038a6 <filealloc>
    80003cc2:	00aa3023          	sd	a0,0(s4)
    80003cc6:	c92d                	beqz	a0,80003d38 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003cc8:	ffffc097          	auipc	ra,0xffffc
    80003ccc:	450080e7          	jalr	1104(ra) # 80000118 <kalloc>
    80003cd0:	892a                	mv	s2,a0
    80003cd2:	c125                	beqz	a0,80003d32 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003cd4:	4985                	li	s3,1
    80003cd6:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003cda:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003cde:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003ce2:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003ce6:	00005597          	auipc	a1,0x5
    80003cea:	96258593          	addi	a1,a1,-1694 # 80008648 <syscalls+0x278>
    80003cee:	00002097          	auipc	ra,0x2
    80003cf2:	39e080e7          	jalr	926(ra) # 8000608c <initlock>
  (*f0)->type = FD_PIPE;
    80003cf6:	609c                	ld	a5,0(s1)
    80003cf8:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003cfc:	609c                	ld	a5,0(s1)
    80003cfe:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003d02:	609c                	ld	a5,0(s1)
    80003d04:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003d08:	609c                	ld	a5,0(s1)
    80003d0a:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003d0e:	000a3783          	ld	a5,0(s4)
    80003d12:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003d16:	000a3783          	ld	a5,0(s4)
    80003d1a:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003d1e:	000a3783          	ld	a5,0(s4)
    80003d22:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003d26:	000a3783          	ld	a5,0(s4)
    80003d2a:	0127b823          	sd	s2,16(a5)
  return 0;
    80003d2e:	4501                	li	a0,0
    80003d30:	a025                	j	80003d58 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003d32:	6088                	ld	a0,0(s1)
    80003d34:	e501                	bnez	a0,80003d3c <pipealloc+0xaa>
    80003d36:	a039                	j	80003d44 <pipealloc+0xb2>
    80003d38:	6088                	ld	a0,0(s1)
    80003d3a:	c51d                	beqz	a0,80003d68 <pipealloc+0xd6>
    fileclose(*f0);
    80003d3c:	00000097          	auipc	ra,0x0
    80003d40:	c26080e7          	jalr	-986(ra) # 80003962 <fileclose>
  if(*f1)
    80003d44:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003d48:	557d                	li	a0,-1
  if(*f1)
    80003d4a:	c799                	beqz	a5,80003d58 <pipealloc+0xc6>
    fileclose(*f1);
    80003d4c:	853e                	mv	a0,a5
    80003d4e:	00000097          	auipc	ra,0x0
    80003d52:	c14080e7          	jalr	-1004(ra) # 80003962 <fileclose>
  return -1;
    80003d56:	557d                	li	a0,-1
}
    80003d58:	70a2                	ld	ra,40(sp)
    80003d5a:	7402                	ld	s0,32(sp)
    80003d5c:	64e2                	ld	s1,24(sp)
    80003d5e:	6942                	ld	s2,16(sp)
    80003d60:	69a2                	ld	s3,8(sp)
    80003d62:	6a02                	ld	s4,0(sp)
    80003d64:	6145                	addi	sp,sp,48
    80003d66:	8082                	ret
  return -1;
    80003d68:	557d                	li	a0,-1
    80003d6a:	b7fd                	j	80003d58 <pipealloc+0xc6>

0000000080003d6c <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003d6c:	1101                	addi	sp,sp,-32
    80003d6e:	ec06                	sd	ra,24(sp)
    80003d70:	e822                	sd	s0,16(sp)
    80003d72:	e426                	sd	s1,8(sp)
    80003d74:	e04a                	sd	s2,0(sp)
    80003d76:	1000                	addi	s0,sp,32
    80003d78:	84aa                	mv	s1,a0
    80003d7a:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003d7c:	00002097          	auipc	ra,0x2
    80003d80:	3a0080e7          	jalr	928(ra) # 8000611c <acquire>
  if(writable){
    80003d84:	02090d63          	beqz	s2,80003dbe <pipeclose+0x52>
    pi->writeopen = 0;
    80003d88:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003d8c:	21848513          	addi	a0,s1,536
    80003d90:	ffffd097          	auipc	ra,0xffffd
    80003d94:	7d0080e7          	jalr	2000(ra) # 80001560 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003d98:	2204b783          	ld	a5,544(s1)
    80003d9c:	eb95                	bnez	a5,80003dd0 <pipeclose+0x64>
    release(&pi->lock);
    80003d9e:	8526                	mv	a0,s1
    80003da0:	00002097          	auipc	ra,0x2
    80003da4:	430080e7          	jalr	1072(ra) # 800061d0 <release>
    kfree((char*)pi);
    80003da8:	8526                	mv	a0,s1
    80003daa:	ffffc097          	auipc	ra,0xffffc
    80003dae:	272080e7          	jalr	626(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80003db2:	60e2                	ld	ra,24(sp)
    80003db4:	6442                	ld	s0,16(sp)
    80003db6:	64a2                	ld	s1,8(sp)
    80003db8:	6902                	ld	s2,0(sp)
    80003dba:	6105                	addi	sp,sp,32
    80003dbc:	8082                	ret
    pi->readopen = 0;
    80003dbe:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003dc2:	21c48513          	addi	a0,s1,540
    80003dc6:	ffffd097          	auipc	ra,0xffffd
    80003dca:	79a080e7          	jalr	1946(ra) # 80001560 <wakeup>
    80003dce:	b7e9                	j	80003d98 <pipeclose+0x2c>
    release(&pi->lock);
    80003dd0:	8526                	mv	a0,s1
    80003dd2:	00002097          	auipc	ra,0x2
    80003dd6:	3fe080e7          	jalr	1022(ra) # 800061d0 <release>
}
    80003dda:	bfe1                	j	80003db2 <pipeclose+0x46>

0000000080003ddc <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003ddc:	7159                	addi	sp,sp,-112
    80003dde:	f486                	sd	ra,104(sp)
    80003de0:	f0a2                	sd	s0,96(sp)
    80003de2:	eca6                	sd	s1,88(sp)
    80003de4:	e8ca                	sd	s2,80(sp)
    80003de6:	e4ce                	sd	s3,72(sp)
    80003de8:	e0d2                	sd	s4,64(sp)
    80003dea:	fc56                	sd	s5,56(sp)
    80003dec:	f85a                	sd	s6,48(sp)
    80003dee:	f45e                	sd	s7,40(sp)
    80003df0:	f062                	sd	s8,32(sp)
    80003df2:	ec66                	sd	s9,24(sp)
    80003df4:	1880                	addi	s0,sp,112
    80003df6:	84aa                	mv	s1,a0
    80003df8:	8aae                	mv	s5,a1
    80003dfa:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003dfc:	ffffd097          	auipc	ra,0xffffd
    80003e00:	05c080e7          	jalr	92(ra) # 80000e58 <myproc>
    80003e04:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003e06:	8526                	mv	a0,s1
    80003e08:	00002097          	auipc	ra,0x2
    80003e0c:	314080e7          	jalr	788(ra) # 8000611c <acquire>
  while(i < n){
    80003e10:	0d405463          	blez	s4,80003ed8 <pipewrite+0xfc>
    80003e14:	8ba6                	mv	s7,s1
  int i = 0;
    80003e16:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003e18:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003e1a:	21848c93          	addi	s9,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003e1e:	21c48c13          	addi	s8,s1,540
    80003e22:	a08d                	j	80003e84 <pipewrite+0xa8>
      release(&pi->lock);
    80003e24:	8526                	mv	a0,s1
    80003e26:	00002097          	auipc	ra,0x2
    80003e2a:	3aa080e7          	jalr	938(ra) # 800061d0 <release>
      return -1;
    80003e2e:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003e30:	854a                	mv	a0,s2
    80003e32:	70a6                	ld	ra,104(sp)
    80003e34:	7406                	ld	s0,96(sp)
    80003e36:	64e6                	ld	s1,88(sp)
    80003e38:	6946                	ld	s2,80(sp)
    80003e3a:	69a6                	ld	s3,72(sp)
    80003e3c:	6a06                	ld	s4,64(sp)
    80003e3e:	7ae2                	ld	s5,56(sp)
    80003e40:	7b42                	ld	s6,48(sp)
    80003e42:	7ba2                	ld	s7,40(sp)
    80003e44:	7c02                	ld	s8,32(sp)
    80003e46:	6ce2                	ld	s9,24(sp)
    80003e48:	6165                	addi	sp,sp,112
    80003e4a:	8082                	ret
      wakeup(&pi->nread);
    80003e4c:	8566                	mv	a0,s9
    80003e4e:	ffffd097          	auipc	ra,0xffffd
    80003e52:	712080e7          	jalr	1810(ra) # 80001560 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003e56:	85de                	mv	a1,s7
    80003e58:	8562                	mv	a0,s8
    80003e5a:	ffffd097          	auipc	ra,0xffffd
    80003e5e:	6a2080e7          	jalr	1698(ra) # 800014fc <sleep>
    80003e62:	a839                	j	80003e80 <pipewrite+0xa4>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003e64:	21c4a783          	lw	a5,540(s1)
    80003e68:	0017871b          	addiw	a4,a5,1
    80003e6c:	20e4ae23          	sw	a4,540(s1)
    80003e70:	1ff7f793          	andi	a5,a5,511
    80003e74:	97a6                	add	a5,a5,s1
    80003e76:	f9f44703          	lbu	a4,-97(s0)
    80003e7a:	00e78c23          	sb	a4,24(a5)
      i++;
    80003e7e:	2905                	addiw	s2,s2,1
  while(i < n){
    80003e80:	05495063          	bge	s2,s4,80003ec0 <pipewrite+0xe4>
    if(pi->readopen == 0 || killed(pr)){
    80003e84:	2204a783          	lw	a5,544(s1)
    80003e88:	dfd1                	beqz	a5,80003e24 <pipewrite+0x48>
    80003e8a:	854e                	mv	a0,s3
    80003e8c:	ffffe097          	auipc	ra,0xffffe
    80003e90:	918080e7          	jalr	-1768(ra) # 800017a4 <killed>
    80003e94:	f941                	bnez	a0,80003e24 <pipewrite+0x48>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80003e96:	2184a783          	lw	a5,536(s1)
    80003e9a:	21c4a703          	lw	a4,540(s1)
    80003e9e:	2007879b          	addiw	a5,a5,512
    80003ea2:	faf705e3          	beq	a4,a5,80003e4c <pipewrite+0x70>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003ea6:	4685                	li	a3,1
    80003ea8:	01590633          	add	a2,s2,s5
    80003eac:	f9f40593          	addi	a1,s0,-97
    80003eb0:	0509b503          	ld	a0,80(s3)
    80003eb4:	ffffd097          	auipc	ra,0xffffd
    80003eb8:	cee080e7          	jalr	-786(ra) # 80000ba2 <copyin>
    80003ebc:	fb6514e3          	bne	a0,s6,80003e64 <pipewrite+0x88>
  wakeup(&pi->nread);
    80003ec0:	21848513          	addi	a0,s1,536
    80003ec4:	ffffd097          	auipc	ra,0xffffd
    80003ec8:	69c080e7          	jalr	1692(ra) # 80001560 <wakeup>
  release(&pi->lock);
    80003ecc:	8526                	mv	a0,s1
    80003ece:	00002097          	auipc	ra,0x2
    80003ed2:	302080e7          	jalr	770(ra) # 800061d0 <release>
  return i;
    80003ed6:	bfa9                	j	80003e30 <pipewrite+0x54>
  int i = 0;
    80003ed8:	4901                	li	s2,0
    80003eda:	b7dd                	j	80003ec0 <pipewrite+0xe4>

0000000080003edc <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80003edc:	715d                	addi	sp,sp,-80
    80003ede:	e486                	sd	ra,72(sp)
    80003ee0:	e0a2                	sd	s0,64(sp)
    80003ee2:	fc26                	sd	s1,56(sp)
    80003ee4:	f84a                	sd	s2,48(sp)
    80003ee6:	f44e                	sd	s3,40(sp)
    80003ee8:	f052                	sd	s4,32(sp)
    80003eea:	ec56                	sd	s5,24(sp)
    80003eec:	e85a                	sd	s6,16(sp)
    80003eee:	0880                	addi	s0,sp,80
    80003ef0:	84aa                	mv	s1,a0
    80003ef2:	892e                	mv	s2,a1
    80003ef4:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80003ef6:	ffffd097          	auipc	ra,0xffffd
    80003efa:	f62080e7          	jalr	-158(ra) # 80000e58 <myproc>
    80003efe:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80003f00:	8b26                	mv	s6,s1
    80003f02:	8526                	mv	a0,s1
    80003f04:	00002097          	auipc	ra,0x2
    80003f08:	218080e7          	jalr	536(ra) # 8000611c <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003f0c:	2184a703          	lw	a4,536(s1)
    80003f10:	21c4a783          	lw	a5,540(s1)
    if(killed(pr)){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003f14:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003f18:	02f71763          	bne	a4,a5,80003f46 <piperead+0x6a>
    80003f1c:	2244a783          	lw	a5,548(s1)
    80003f20:	c39d                	beqz	a5,80003f46 <piperead+0x6a>
    if(killed(pr)){
    80003f22:	8552                	mv	a0,s4
    80003f24:	ffffe097          	auipc	ra,0xffffe
    80003f28:	880080e7          	jalr	-1920(ra) # 800017a4 <killed>
    80003f2c:	e941                	bnez	a0,80003fbc <piperead+0xe0>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80003f2e:	85da                	mv	a1,s6
    80003f30:	854e                	mv	a0,s3
    80003f32:	ffffd097          	auipc	ra,0xffffd
    80003f36:	5ca080e7          	jalr	1482(ra) # 800014fc <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80003f3a:	2184a703          	lw	a4,536(s1)
    80003f3e:	21c4a783          	lw	a5,540(s1)
    80003f42:	fcf70de3          	beq	a4,a5,80003f1c <piperead+0x40>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003f46:	09505263          	blez	s5,80003fca <piperead+0xee>
    80003f4a:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003f4c:	5b7d                	li	s6,-1
    if(pi->nread == pi->nwrite)
    80003f4e:	2184a783          	lw	a5,536(s1)
    80003f52:	21c4a703          	lw	a4,540(s1)
    80003f56:	02f70d63          	beq	a4,a5,80003f90 <piperead+0xb4>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80003f5a:	0017871b          	addiw	a4,a5,1
    80003f5e:	20e4ac23          	sw	a4,536(s1)
    80003f62:	1ff7f793          	andi	a5,a5,511
    80003f66:	97a6                	add	a5,a5,s1
    80003f68:	0187c783          	lbu	a5,24(a5)
    80003f6c:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80003f70:	4685                	li	a3,1
    80003f72:	fbf40613          	addi	a2,s0,-65
    80003f76:	85ca                	mv	a1,s2
    80003f78:	050a3503          	ld	a0,80(s4)
    80003f7c:	ffffd097          	auipc	ra,0xffffd
    80003f80:	b9a080e7          	jalr	-1126(ra) # 80000b16 <copyout>
    80003f84:	01650663          	beq	a0,s6,80003f90 <piperead+0xb4>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003f88:	2985                	addiw	s3,s3,1
    80003f8a:	0905                	addi	s2,s2,1
    80003f8c:	fd3a91e3          	bne	s5,s3,80003f4e <piperead+0x72>
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80003f90:	21c48513          	addi	a0,s1,540
    80003f94:	ffffd097          	auipc	ra,0xffffd
    80003f98:	5cc080e7          	jalr	1484(ra) # 80001560 <wakeup>
  release(&pi->lock);
    80003f9c:	8526                	mv	a0,s1
    80003f9e:	00002097          	auipc	ra,0x2
    80003fa2:	232080e7          	jalr	562(ra) # 800061d0 <release>
  return i;
}
    80003fa6:	854e                	mv	a0,s3
    80003fa8:	60a6                	ld	ra,72(sp)
    80003faa:	6406                	ld	s0,64(sp)
    80003fac:	74e2                	ld	s1,56(sp)
    80003fae:	7942                	ld	s2,48(sp)
    80003fb0:	79a2                	ld	s3,40(sp)
    80003fb2:	7a02                	ld	s4,32(sp)
    80003fb4:	6ae2                	ld	s5,24(sp)
    80003fb6:	6b42                	ld	s6,16(sp)
    80003fb8:	6161                	addi	sp,sp,80
    80003fba:	8082                	ret
      release(&pi->lock);
    80003fbc:	8526                	mv	a0,s1
    80003fbe:	00002097          	auipc	ra,0x2
    80003fc2:	212080e7          	jalr	530(ra) # 800061d0 <release>
      return -1;
    80003fc6:	59fd                	li	s3,-1
    80003fc8:	bff9                	j	80003fa6 <piperead+0xca>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80003fca:	4981                	li	s3,0
    80003fcc:	b7d1                	j	80003f90 <piperead+0xb4>

0000000080003fce <flags2perm>:
#include "elf.h"

static int loadseg(pde_t *, uint64, struct inode *, uint, uint);

int flags2perm(int flags)
{
    80003fce:	1141                	addi	sp,sp,-16
    80003fd0:	e422                	sd	s0,8(sp)
    80003fd2:	0800                	addi	s0,sp,16
    80003fd4:	87aa                	mv	a5,a0
    int perm = 0;
    if(flags & 0x1)
    80003fd6:	8905                	andi	a0,a0,1
    80003fd8:	c111                	beqz	a0,80003fdc <flags2perm+0xe>
      perm = PTE_X;
    80003fda:	4521                	li	a0,8
    if(flags & 0x2)
    80003fdc:	8b89                	andi	a5,a5,2
    80003fde:	c399                	beqz	a5,80003fe4 <flags2perm+0x16>
      perm |= PTE_W;
    80003fe0:	00456513          	ori	a0,a0,4
    return perm;
}
    80003fe4:	6422                	ld	s0,8(sp)
    80003fe6:	0141                	addi	sp,sp,16
    80003fe8:	8082                	ret

0000000080003fea <exec>:

int
exec(char *path, char **argv)
{
    80003fea:	df010113          	addi	sp,sp,-528
    80003fee:	20113423          	sd	ra,520(sp)
    80003ff2:	20813023          	sd	s0,512(sp)
    80003ff6:	ffa6                	sd	s1,504(sp)
    80003ff8:	fbca                	sd	s2,496(sp)
    80003ffa:	f7ce                	sd	s3,488(sp)
    80003ffc:	f3d2                	sd	s4,480(sp)
    80003ffe:	efd6                	sd	s5,472(sp)
    80004000:	ebda                	sd	s6,464(sp)
    80004002:	e7de                	sd	s7,456(sp)
    80004004:	e3e2                	sd	s8,448(sp)
    80004006:	ff66                	sd	s9,440(sp)
    80004008:	fb6a                	sd	s10,432(sp)
    8000400a:	f76e                	sd	s11,424(sp)
    8000400c:	0c00                	addi	s0,sp,528
    8000400e:	84aa                	mv	s1,a0
    80004010:	dea43c23          	sd	a0,-520(s0)
    80004014:	e0b43023          	sd	a1,-512(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004018:	ffffd097          	auipc	ra,0xffffd
    8000401c:	e40080e7          	jalr	-448(ra) # 80000e58 <myproc>
    80004020:	892a                	mv	s2,a0

  begin_op();
    80004022:	fffff097          	auipc	ra,0xfffff
    80004026:	474080e7          	jalr	1140(ra) # 80003496 <begin_op>

  if((ip = namei(path)) == 0){
    8000402a:	8526                	mv	a0,s1
    8000402c:	fffff097          	auipc	ra,0xfffff
    80004030:	24e080e7          	jalr	590(ra) # 8000327a <namei>
    80004034:	c92d                	beqz	a0,800040a6 <exec+0xbc>
    80004036:	84aa                	mv	s1,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004038:	fffff097          	auipc	ra,0xfffff
    8000403c:	a9c080e7          	jalr	-1380(ra) # 80002ad4 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004040:	04000713          	li	a4,64
    80004044:	4681                	li	a3,0
    80004046:	e5040613          	addi	a2,s0,-432
    8000404a:	4581                	li	a1,0
    8000404c:	8526                	mv	a0,s1
    8000404e:	fffff097          	auipc	ra,0xfffff
    80004052:	d3a080e7          	jalr	-710(ra) # 80002d88 <readi>
    80004056:	04000793          	li	a5,64
    8000405a:	00f51a63          	bne	a0,a5,8000406e <exec+0x84>
    goto bad;

  if(elf.magic != ELF_MAGIC)
    8000405e:	e5042703          	lw	a4,-432(s0)
    80004062:	464c47b7          	lui	a5,0x464c4
    80004066:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    8000406a:	04f70463          	beq	a4,a5,800040b2 <exec+0xc8>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000406e:	8526                	mv	a0,s1
    80004070:	fffff097          	auipc	ra,0xfffff
    80004074:	cc6080e7          	jalr	-826(ra) # 80002d36 <iunlockput>
    end_op();
    80004078:	fffff097          	auipc	ra,0xfffff
    8000407c:	49e080e7          	jalr	1182(ra) # 80003516 <end_op>
  }
  return -1;
    80004080:	557d                	li	a0,-1
}
    80004082:	20813083          	ld	ra,520(sp)
    80004086:	20013403          	ld	s0,512(sp)
    8000408a:	74fe                	ld	s1,504(sp)
    8000408c:	795e                	ld	s2,496(sp)
    8000408e:	79be                	ld	s3,488(sp)
    80004090:	7a1e                	ld	s4,480(sp)
    80004092:	6afe                	ld	s5,472(sp)
    80004094:	6b5e                	ld	s6,464(sp)
    80004096:	6bbe                	ld	s7,456(sp)
    80004098:	6c1e                	ld	s8,448(sp)
    8000409a:	7cfa                	ld	s9,440(sp)
    8000409c:	7d5a                	ld	s10,432(sp)
    8000409e:	7dba                	ld	s11,424(sp)
    800040a0:	21010113          	addi	sp,sp,528
    800040a4:	8082                	ret
    end_op();
    800040a6:	fffff097          	auipc	ra,0xfffff
    800040aa:	470080e7          	jalr	1136(ra) # 80003516 <end_op>
    return -1;
    800040ae:	557d                	li	a0,-1
    800040b0:	bfc9                	j	80004082 <exec+0x98>
  if((pagetable = proc_pagetable(p)) == 0)
    800040b2:	854a                	mv	a0,s2
    800040b4:	ffffd097          	auipc	ra,0xffffd
    800040b8:	e68080e7          	jalr	-408(ra) # 80000f1c <proc_pagetable>
    800040bc:	8baa                	mv	s7,a0
    800040be:	d945                	beqz	a0,8000406e <exec+0x84>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800040c0:	e7042983          	lw	s3,-400(s0)
    800040c4:	e8845783          	lhu	a5,-376(s0)
    800040c8:	c7ad                	beqz	a5,80004132 <exec+0x148>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800040ca:	4a01                	li	s4,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800040cc:	4b01                	li	s6,0
    if(ph.vaddr % PGSIZE != 0)
    800040ce:	6c85                	lui	s9,0x1
    800040d0:	fffc8793          	addi	a5,s9,-1 # fff <_entry-0x7ffff001>
    800040d4:	def43823          	sd	a5,-528(s0)
    800040d8:	ac0d                	j	8000430a <exec+0x320>
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    800040da:	00004517          	auipc	a0,0x4
    800040de:	57650513          	addi	a0,a0,1398 # 80008650 <syscalls+0x280>
    800040e2:	00002097          	auipc	ra,0x2
    800040e6:	af0080e7          	jalr	-1296(ra) # 80005bd2 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    800040ea:	8756                	mv	a4,s5
    800040ec:	012d86bb          	addw	a3,s11,s2
    800040f0:	4581                	li	a1,0
    800040f2:	8526                	mv	a0,s1
    800040f4:	fffff097          	auipc	ra,0xfffff
    800040f8:	c94080e7          	jalr	-876(ra) # 80002d88 <readi>
    800040fc:	2501                	sext.w	a0,a0
    800040fe:	1aaa9a63          	bne	s5,a0,800042b2 <exec+0x2c8>
  for(i = 0; i < sz; i += PGSIZE){
    80004102:	6785                	lui	a5,0x1
    80004104:	0127893b          	addw	s2,a5,s2
    80004108:	77fd                	lui	a5,0xfffff
    8000410a:	01478a3b          	addw	s4,a5,s4
    8000410e:	1f897563          	bgeu	s2,s8,800042f8 <exec+0x30e>
    pa = walkaddr(pagetable, va + i);
    80004112:	02091593          	slli	a1,s2,0x20
    80004116:	9181                	srli	a1,a1,0x20
    80004118:	95ea                	add	a1,a1,s10
    8000411a:	855e                	mv	a0,s7
    8000411c:	ffffc097          	auipc	ra,0xffffc
    80004120:	3ee080e7          	jalr	1006(ra) # 8000050a <walkaddr>
    80004124:	862a                	mv	a2,a0
    if(pa == 0)
    80004126:	d955                	beqz	a0,800040da <exec+0xf0>
      n = PGSIZE;
    80004128:	8ae6                	mv	s5,s9
    if(sz - i < PGSIZE)
    8000412a:	fd9a70e3          	bgeu	s4,s9,800040ea <exec+0x100>
      n = sz - i;
    8000412e:	8ad2                	mv	s5,s4
    80004130:	bf6d                	j	800040ea <exec+0x100>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004132:	4a01                	li	s4,0
  iunlockput(ip);
    80004134:	8526                	mv	a0,s1
    80004136:	fffff097          	auipc	ra,0xfffff
    8000413a:	c00080e7          	jalr	-1024(ra) # 80002d36 <iunlockput>
  end_op();
    8000413e:	fffff097          	auipc	ra,0xfffff
    80004142:	3d8080e7          	jalr	984(ra) # 80003516 <end_op>
  p = myproc();
    80004146:	ffffd097          	auipc	ra,0xffffd
    8000414a:	d12080e7          	jalr	-750(ra) # 80000e58 <myproc>
    8000414e:	8aaa                	mv	s5,a0
  uint64 oldsz = p->sz;
    80004150:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004154:	6785                	lui	a5,0x1
    80004156:	17fd                	addi	a5,a5,-1
    80004158:	9a3e                	add	s4,s4,a5
    8000415a:	757d                	lui	a0,0xfffff
    8000415c:	00aa77b3          	and	a5,s4,a0
    80004160:	e0f43423          	sd	a5,-504(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    80004164:	4691                	li	a3,4
    80004166:	6609                	lui	a2,0x2
    80004168:	963e                	add	a2,a2,a5
    8000416a:	85be                	mv	a1,a5
    8000416c:	855e                	mv	a0,s7
    8000416e:	ffffc097          	auipc	ra,0xffffc
    80004172:	750080e7          	jalr	1872(ra) # 800008be <uvmalloc>
    80004176:	8b2a                	mv	s6,a0
  ip = 0;
    80004178:	4481                	li	s1,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE, PTE_W)) == 0)
    8000417a:	12050c63          	beqz	a0,800042b2 <exec+0x2c8>
  uvmclear(pagetable, sz-2*PGSIZE);
    8000417e:	75f9                	lui	a1,0xffffe
    80004180:	95aa                	add	a1,a1,a0
    80004182:	855e                	mv	a0,s7
    80004184:	ffffd097          	auipc	ra,0xffffd
    80004188:	960080e7          	jalr	-1696(ra) # 80000ae4 <uvmclear>
  stackbase = sp - PGSIZE;
    8000418c:	7c7d                	lui	s8,0xfffff
    8000418e:	9c5a                	add	s8,s8,s6
  for(argc = 0; argv[argc]; argc++) {
    80004190:	e0043783          	ld	a5,-512(s0)
    80004194:	6388                	ld	a0,0(a5)
    80004196:	c535                	beqz	a0,80004202 <exec+0x218>
    80004198:	e9040993          	addi	s3,s0,-368
    8000419c:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    800041a0:	895a                	mv	s2,s6
    sp -= strlen(argv[argc]) + 1;
    800041a2:	ffffc097          	auipc	ra,0xffffc
    800041a6:	15a080e7          	jalr	346(ra) # 800002fc <strlen>
    800041aa:	2505                	addiw	a0,a0,1
    800041ac:	40a90933          	sub	s2,s2,a0
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800041b0:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    800041b4:	13896663          	bltu	s2,s8,800042e0 <exec+0x2f6>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800041b8:	e0043d83          	ld	s11,-512(s0)
    800041bc:	000dba03          	ld	s4,0(s11)
    800041c0:	8552                	mv	a0,s4
    800041c2:	ffffc097          	auipc	ra,0xffffc
    800041c6:	13a080e7          	jalr	314(ra) # 800002fc <strlen>
    800041ca:	0015069b          	addiw	a3,a0,1
    800041ce:	8652                	mv	a2,s4
    800041d0:	85ca                	mv	a1,s2
    800041d2:	855e                	mv	a0,s7
    800041d4:	ffffd097          	auipc	ra,0xffffd
    800041d8:	942080e7          	jalr	-1726(ra) # 80000b16 <copyout>
    800041dc:	10054663          	bltz	a0,800042e8 <exec+0x2fe>
    ustack[argc] = sp;
    800041e0:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    800041e4:	0485                	addi	s1,s1,1
    800041e6:	008d8793          	addi	a5,s11,8
    800041ea:	e0f43023          	sd	a5,-512(s0)
    800041ee:	008db503          	ld	a0,8(s11)
    800041f2:	c911                	beqz	a0,80004206 <exec+0x21c>
    if(argc >= MAXARG)
    800041f4:	09a1                	addi	s3,s3,8
    800041f6:	fb3c96e3          	bne	s9,s3,800041a2 <exec+0x1b8>
  sz = sz1;
    800041fa:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800041fe:	4481                	li	s1,0
    80004200:	a84d                	j	800042b2 <exec+0x2c8>
  sp = sz;
    80004202:	895a                	mv	s2,s6
  for(argc = 0; argv[argc]; argc++) {
    80004204:	4481                	li	s1,0
  ustack[argc] = 0;
    80004206:	00349793          	slli	a5,s1,0x3
    8000420a:	f9040713          	addi	a4,s0,-112
    8000420e:	97ba                	add	a5,a5,a4
    80004210:	f007b023          	sd	zero,-256(a5) # f00 <_entry-0x7ffff100>
  sp -= (argc+1) * sizeof(uint64);
    80004214:	00148693          	addi	a3,s1,1
    80004218:	068e                	slli	a3,a3,0x3
    8000421a:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    8000421e:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004222:	01897663          	bgeu	s2,s8,8000422e <exec+0x244>
  sz = sz1;
    80004226:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    8000422a:	4481                	li	s1,0
    8000422c:	a059                	j	800042b2 <exec+0x2c8>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    8000422e:	e9040613          	addi	a2,s0,-368
    80004232:	85ca                	mv	a1,s2
    80004234:	855e                	mv	a0,s7
    80004236:	ffffd097          	auipc	ra,0xffffd
    8000423a:	8e0080e7          	jalr	-1824(ra) # 80000b16 <copyout>
    8000423e:	0a054963          	bltz	a0,800042f0 <exec+0x306>
  p->trapframe->a1 = sp;
    80004242:	058ab783          	ld	a5,88(s5)
    80004246:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8000424a:	df843783          	ld	a5,-520(s0)
    8000424e:	0007c703          	lbu	a4,0(a5)
    80004252:	cf11                	beqz	a4,8000426e <exec+0x284>
    80004254:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004256:	02f00693          	li	a3,47
    8000425a:	a039                	j	80004268 <exec+0x27e>
      last = s+1;
    8000425c:	def43c23          	sd	a5,-520(s0)
  for(last=s=path; *s; s++)
    80004260:	0785                	addi	a5,a5,1
    80004262:	fff7c703          	lbu	a4,-1(a5)
    80004266:	c701                	beqz	a4,8000426e <exec+0x284>
    if(*s == '/')
    80004268:	fed71ce3          	bne	a4,a3,80004260 <exec+0x276>
    8000426c:	bfc5                	j	8000425c <exec+0x272>
  safestrcpy(p->name, last, sizeof(p->name));
    8000426e:	4641                	li	a2,16
    80004270:	df843583          	ld	a1,-520(s0)
    80004274:	158a8513          	addi	a0,s5,344
    80004278:	ffffc097          	auipc	ra,0xffffc
    8000427c:	052080e7          	jalr	82(ra) # 800002ca <safestrcpy>
  oldpagetable = p->pagetable;
    80004280:	050ab503          	ld	a0,80(s5)
  p->pagetable = pagetable;
    80004284:	057ab823          	sd	s7,80(s5)
  p->sz = sz;
    80004288:	056ab423          	sd	s6,72(s5)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    8000428c:	058ab783          	ld	a5,88(s5)
    80004290:	e6843703          	ld	a4,-408(s0)
    80004294:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004296:	058ab783          	ld	a5,88(s5)
    8000429a:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    8000429e:	85ea                	mv	a1,s10
    800042a0:	ffffd097          	auipc	ra,0xffffd
    800042a4:	d18080e7          	jalr	-744(ra) # 80000fb8 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800042a8:	0004851b          	sext.w	a0,s1
    800042ac:	bbd9                	j	80004082 <exec+0x98>
    800042ae:	e1443423          	sd	s4,-504(s0)
    proc_freepagetable(pagetable, sz);
    800042b2:	e0843583          	ld	a1,-504(s0)
    800042b6:	855e                	mv	a0,s7
    800042b8:	ffffd097          	auipc	ra,0xffffd
    800042bc:	d00080e7          	jalr	-768(ra) # 80000fb8 <proc_freepagetable>
  if(ip){
    800042c0:	da0497e3          	bnez	s1,8000406e <exec+0x84>
  return -1;
    800042c4:	557d                	li	a0,-1
    800042c6:	bb75                	j	80004082 <exec+0x98>
    800042c8:	e1443423          	sd	s4,-504(s0)
    800042cc:	b7dd                	j	800042b2 <exec+0x2c8>
    800042ce:	e1443423          	sd	s4,-504(s0)
    800042d2:	b7c5                	j	800042b2 <exec+0x2c8>
    800042d4:	e1443423          	sd	s4,-504(s0)
    800042d8:	bfe9                	j	800042b2 <exec+0x2c8>
    800042da:	e1443423          	sd	s4,-504(s0)
    800042de:	bfd1                	j	800042b2 <exec+0x2c8>
  sz = sz1;
    800042e0:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800042e4:	4481                	li	s1,0
    800042e6:	b7f1                	j	800042b2 <exec+0x2c8>
  sz = sz1;
    800042e8:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800042ec:	4481                	li	s1,0
    800042ee:	b7d1                	j	800042b2 <exec+0x2c8>
  sz = sz1;
    800042f0:	e1643423          	sd	s6,-504(s0)
  ip = 0;
    800042f4:	4481                	li	s1,0
    800042f6:	bf75                	j	800042b2 <exec+0x2c8>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    800042f8:	e0843a03          	ld	s4,-504(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800042fc:	2b05                	addiw	s6,s6,1
    800042fe:	0389899b          	addiw	s3,s3,56
    80004302:	e8845783          	lhu	a5,-376(s0)
    80004306:	e2fb57e3          	bge	s6,a5,80004134 <exec+0x14a>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    8000430a:	2981                	sext.w	s3,s3
    8000430c:	03800713          	li	a4,56
    80004310:	86ce                	mv	a3,s3
    80004312:	e1840613          	addi	a2,s0,-488
    80004316:	4581                	li	a1,0
    80004318:	8526                	mv	a0,s1
    8000431a:	fffff097          	auipc	ra,0xfffff
    8000431e:	a6e080e7          	jalr	-1426(ra) # 80002d88 <readi>
    80004322:	03800793          	li	a5,56
    80004326:	f8f514e3          	bne	a0,a5,800042ae <exec+0x2c4>
    if(ph.type != ELF_PROG_LOAD)
    8000432a:	e1842783          	lw	a5,-488(s0)
    8000432e:	4705                	li	a4,1
    80004330:	fce796e3          	bne	a5,a4,800042fc <exec+0x312>
    if(ph.memsz < ph.filesz)
    80004334:	e4043903          	ld	s2,-448(s0)
    80004338:	e3843783          	ld	a5,-456(s0)
    8000433c:	f8f966e3          	bltu	s2,a5,800042c8 <exec+0x2de>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004340:	e2843783          	ld	a5,-472(s0)
    80004344:	993e                	add	s2,s2,a5
    80004346:	f8f964e3          	bltu	s2,a5,800042ce <exec+0x2e4>
    if(ph.vaddr % PGSIZE != 0)
    8000434a:	df043703          	ld	a4,-528(s0)
    8000434e:	8ff9                	and	a5,a5,a4
    80004350:	f3d1                	bnez	a5,800042d4 <exec+0x2ea>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz, flags2perm(ph.flags))) == 0)
    80004352:	e1c42503          	lw	a0,-484(s0)
    80004356:	00000097          	auipc	ra,0x0
    8000435a:	c78080e7          	jalr	-904(ra) # 80003fce <flags2perm>
    8000435e:	86aa                	mv	a3,a0
    80004360:	864a                	mv	a2,s2
    80004362:	85d2                	mv	a1,s4
    80004364:	855e                	mv	a0,s7
    80004366:	ffffc097          	auipc	ra,0xffffc
    8000436a:	558080e7          	jalr	1368(ra) # 800008be <uvmalloc>
    8000436e:	e0a43423          	sd	a0,-504(s0)
    80004372:	d525                	beqz	a0,800042da <exec+0x2f0>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    80004374:	e2843d03          	ld	s10,-472(s0)
    80004378:	e2042d83          	lw	s11,-480(s0)
    8000437c:	e3842c03          	lw	s8,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004380:	f60c0ce3          	beqz	s8,800042f8 <exec+0x30e>
    80004384:	8a62                	mv	s4,s8
    80004386:	4901                	li	s2,0
    80004388:	b369                	j	80004112 <exec+0x128>

000000008000438a <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000438a:	7179                	addi	sp,sp,-48
    8000438c:	f406                	sd	ra,40(sp)
    8000438e:	f022                	sd	s0,32(sp)
    80004390:	ec26                	sd	s1,24(sp)
    80004392:	e84a                	sd	s2,16(sp)
    80004394:	1800                	addi	s0,sp,48
    80004396:	892e                	mv	s2,a1
    80004398:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  argint(n, &fd);
    8000439a:	fdc40593          	addi	a1,s0,-36
    8000439e:	ffffe097          	auipc	ra,0xffffe
    800043a2:	bca080e7          	jalr	-1078(ra) # 80001f68 <argint>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800043a6:	fdc42703          	lw	a4,-36(s0)
    800043aa:	47bd                	li	a5,15
    800043ac:	02e7eb63          	bltu	a5,a4,800043e2 <argfd+0x58>
    800043b0:	ffffd097          	auipc	ra,0xffffd
    800043b4:	aa8080e7          	jalr	-1368(ra) # 80000e58 <myproc>
    800043b8:	fdc42703          	lw	a4,-36(s0)
    800043bc:	01a70793          	addi	a5,a4,26
    800043c0:	078e                	slli	a5,a5,0x3
    800043c2:	953e                	add	a0,a0,a5
    800043c4:	611c                	ld	a5,0(a0)
    800043c6:	c385                	beqz	a5,800043e6 <argfd+0x5c>
    return -1;
  if(pfd)
    800043c8:	00090463          	beqz	s2,800043d0 <argfd+0x46>
    *pfd = fd;
    800043cc:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800043d0:	4501                	li	a0,0
  if(pf)
    800043d2:	c091                	beqz	s1,800043d6 <argfd+0x4c>
    *pf = f;
    800043d4:	e09c                	sd	a5,0(s1)
}
    800043d6:	70a2                	ld	ra,40(sp)
    800043d8:	7402                	ld	s0,32(sp)
    800043da:	64e2                	ld	s1,24(sp)
    800043dc:	6942                	ld	s2,16(sp)
    800043de:	6145                	addi	sp,sp,48
    800043e0:	8082                	ret
    return -1;
    800043e2:	557d                	li	a0,-1
    800043e4:	bfcd                	j	800043d6 <argfd+0x4c>
    800043e6:	557d                	li	a0,-1
    800043e8:	b7fd                	j	800043d6 <argfd+0x4c>

00000000800043ea <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    800043ea:	1101                	addi	sp,sp,-32
    800043ec:	ec06                	sd	ra,24(sp)
    800043ee:	e822                	sd	s0,16(sp)
    800043f0:	e426                	sd	s1,8(sp)
    800043f2:	1000                	addi	s0,sp,32
    800043f4:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    800043f6:	ffffd097          	auipc	ra,0xffffd
    800043fa:	a62080e7          	jalr	-1438(ra) # 80000e58 <myproc>
    800043fe:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    80004400:	0d050793          	addi	a5,a0,208 # fffffffffffff0d0 <end+0xffffffff7ffdd3a0>
    80004404:	4501                	li	a0,0
    80004406:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004408:	6398                	ld	a4,0(a5)
    8000440a:	cb19                	beqz	a4,80004420 <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    8000440c:	2505                	addiw	a0,a0,1
    8000440e:	07a1                	addi	a5,a5,8
    80004410:	fed51ce3          	bne	a0,a3,80004408 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    80004414:	557d                	li	a0,-1
}
    80004416:	60e2                	ld	ra,24(sp)
    80004418:	6442                	ld	s0,16(sp)
    8000441a:	64a2                	ld	s1,8(sp)
    8000441c:	6105                	addi	sp,sp,32
    8000441e:	8082                	ret
      p->ofile[fd] = f;
    80004420:	01a50793          	addi	a5,a0,26
    80004424:	078e                	slli	a5,a5,0x3
    80004426:	963e                	add	a2,a2,a5
    80004428:	e204                	sd	s1,0(a2)
      return fd;
    8000442a:	b7f5                	j	80004416 <fdalloc+0x2c>

000000008000442c <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    8000442c:	715d                	addi	sp,sp,-80
    8000442e:	e486                	sd	ra,72(sp)
    80004430:	e0a2                	sd	s0,64(sp)
    80004432:	fc26                	sd	s1,56(sp)
    80004434:	f84a                	sd	s2,48(sp)
    80004436:	f44e                	sd	s3,40(sp)
    80004438:	f052                	sd	s4,32(sp)
    8000443a:	ec56                	sd	s5,24(sp)
    8000443c:	e85a                	sd	s6,16(sp)
    8000443e:	0880                	addi	s0,sp,80
    80004440:	8b2e                	mv	s6,a1
    80004442:	89b2                	mv	s3,a2
    80004444:	8936                	mv	s2,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    80004446:	fb040593          	addi	a1,s0,-80
    8000444a:	fffff097          	auipc	ra,0xfffff
    8000444e:	e4e080e7          	jalr	-434(ra) # 80003298 <nameiparent>
    80004452:	84aa                	mv	s1,a0
    80004454:	16050063          	beqz	a0,800045b4 <create+0x188>
    return 0;

  ilock(dp);
    80004458:	ffffe097          	auipc	ra,0xffffe
    8000445c:	67c080e7          	jalr	1660(ra) # 80002ad4 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004460:	4601                	li	a2,0
    80004462:	fb040593          	addi	a1,s0,-80
    80004466:	8526                	mv	a0,s1
    80004468:	fffff097          	auipc	ra,0xfffff
    8000446c:	b50080e7          	jalr	-1200(ra) # 80002fb8 <dirlookup>
    80004470:	8aaa                	mv	s5,a0
    80004472:	c931                	beqz	a0,800044c6 <create+0x9a>
    iunlockput(dp);
    80004474:	8526                	mv	a0,s1
    80004476:	fffff097          	auipc	ra,0xfffff
    8000447a:	8c0080e7          	jalr	-1856(ra) # 80002d36 <iunlockput>
    ilock(ip);
    8000447e:	8556                	mv	a0,s5
    80004480:	ffffe097          	auipc	ra,0xffffe
    80004484:	654080e7          	jalr	1620(ra) # 80002ad4 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80004488:	000b059b          	sext.w	a1,s6
    8000448c:	4789                	li	a5,2
    8000448e:	02f59563          	bne	a1,a5,800044b8 <create+0x8c>
    80004492:	044ad783          	lhu	a5,68(s5)
    80004496:	37f9                	addiw	a5,a5,-2
    80004498:	17c2                	slli	a5,a5,0x30
    8000449a:	93c1                	srli	a5,a5,0x30
    8000449c:	4705                	li	a4,1
    8000449e:	00f76d63          	bltu	a4,a5,800044b8 <create+0x8c>
  ip->nlink = 0;
  iupdate(ip);
  iunlockput(ip);
  iunlockput(dp);
  return 0;
}
    800044a2:	8556                	mv	a0,s5
    800044a4:	60a6                	ld	ra,72(sp)
    800044a6:	6406                	ld	s0,64(sp)
    800044a8:	74e2                	ld	s1,56(sp)
    800044aa:	7942                	ld	s2,48(sp)
    800044ac:	79a2                	ld	s3,40(sp)
    800044ae:	7a02                	ld	s4,32(sp)
    800044b0:	6ae2                	ld	s5,24(sp)
    800044b2:	6b42                	ld	s6,16(sp)
    800044b4:	6161                	addi	sp,sp,80
    800044b6:	8082                	ret
    iunlockput(ip);
    800044b8:	8556                	mv	a0,s5
    800044ba:	fffff097          	auipc	ra,0xfffff
    800044be:	87c080e7          	jalr	-1924(ra) # 80002d36 <iunlockput>
    return 0;
    800044c2:	4a81                	li	s5,0
    800044c4:	bff9                	j	800044a2 <create+0x76>
  if((ip = ialloc(dp->dev, type)) == 0){
    800044c6:	85da                	mv	a1,s6
    800044c8:	4088                	lw	a0,0(s1)
    800044ca:	ffffe097          	auipc	ra,0xffffe
    800044ce:	46e080e7          	jalr	1134(ra) # 80002938 <ialloc>
    800044d2:	8a2a                	mv	s4,a0
    800044d4:	c921                	beqz	a0,80004524 <create+0xf8>
  ilock(ip);
    800044d6:	ffffe097          	auipc	ra,0xffffe
    800044da:	5fe080e7          	jalr	1534(ra) # 80002ad4 <ilock>
  ip->major = major;
    800044de:	053a1323          	sh	s3,70(s4)
  ip->minor = minor;
    800044e2:	052a1423          	sh	s2,72(s4)
  ip->nlink = 1;
    800044e6:	4785                	li	a5,1
    800044e8:	04fa1523          	sh	a5,74(s4)
  iupdate(ip);
    800044ec:	8552                	mv	a0,s4
    800044ee:	ffffe097          	auipc	ra,0xffffe
    800044f2:	51c080e7          	jalr	1308(ra) # 80002a0a <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    800044f6:	000b059b          	sext.w	a1,s6
    800044fa:	4785                	li	a5,1
    800044fc:	02f58b63          	beq	a1,a5,80004532 <create+0x106>
  if(dirlink(dp, name, ip->inum) < 0)
    80004500:	004a2603          	lw	a2,4(s4)
    80004504:	fb040593          	addi	a1,s0,-80
    80004508:	8526                	mv	a0,s1
    8000450a:	fffff097          	auipc	ra,0xfffff
    8000450e:	cbe080e7          	jalr	-834(ra) # 800031c8 <dirlink>
    80004512:	06054f63          	bltz	a0,80004590 <create+0x164>
  iunlockput(dp);
    80004516:	8526                	mv	a0,s1
    80004518:	fffff097          	auipc	ra,0xfffff
    8000451c:	81e080e7          	jalr	-2018(ra) # 80002d36 <iunlockput>
  return ip;
    80004520:	8ad2                	mv	s5,s4
    80004522:	b741                	j	800044a2 <create+0x76>
    iunlockput(dp);
    80004524:	8526                	mv	a0,s1
    80004526:	fffff097          	auipc	ra,0xfffff
    8000452a:	810080e7          	jalr	-2032(ra) # 80002d36 <iunlockput>
    return 0;
    8000452e:	8ad2                	mv	s5,s4
    80004530:	bf8d                	j	800044a2 <create+0x76>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004532:	004a2603          	lw	a2,4(s4)
    80004536:	00004597          	auipc	a1,0x4
    8000453a:	13a58593          	addi	a1,a1,314 # 80008670 <syscalls+0x2a0>
    8000453e:	8552                	mv	a0,s4
    80004540:	fffff097          	auipc	ra,0xfffff
    80004544:	c88080e7          	jalr	-888(ra) # 800031c8 <dirlink>
    80004548:	04054463          	bltz	a0,80004590 <create+0x164>
    8000454c:	40d0                	lw	a2,4(s1)
    8000454e:	00004597          	auipc	a1,0x4
    80004552:	12a58593          	addi	a1,a1,298 # 80008678 <syscalls+0x2a8>
    80004556:	8552                	mv	a0,s4
    80004558:	fffff097          	auipc	ra,0xfffff
    8000455c:	c70080e7          	jalr	-912(ra) # 800031c8 <dirlink>
    80004560:	02054863          	bltz	a0,80004590 <create+0x164>
  if(dirlink(dp, name, ip->inum) < 0)
    80004564:	004a2603          	lw	a2,4(s4)
    80004568:	fb040593          	addi	a1,s0,-80
    8000456c:	8526                	mv	a0,s1
    8000456e:	fffff097          	auipc	ra,0xfffff
    80004572:	c5a080e7          	jalr	-934(ra) # 800031c8 <dirlink>
    80004576:	00054d63          	bltz	a0,80004590 <create+0x164>
    dp->nlink++;  // for ".."
    8000457a:	04a4d783          	lhu	a5,74(s1)
    8000457e:	2785                	addiw	a5,a5,1
    80004580:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004584:	8526                	mv	a0,s1
    80004586:	ffffe097          	auipc	ra,0xffffe
    8000458a:	484080e7          	jalr	1156(ra) # 80002a0a <iupdate>
    8000458e:	b761                	j	80004516 <create+0xea>
  ip->nlink = 0;
    80004590:	040a1523          	sh	zero,74(s4)
  iupdate(ip);
    80004594:	8552                	mv	a0,s4
    80004596:	ffffe097          	auipc	ra,0xffffe
    8000459a:	474080e7          	jalr	1140(ra) # 80002a0a <iupdate>
  iunlockput(ip);
    8000459e:	8552                	mv	a0,s4
    800045a0:	ffffe097          	auipc	ra,0xffffe
    800045a4:	796080e7          	jalr	1942(ra) # 80002d36 <iunlockput>
  iunlockput(dp);
    800045a8:	8526                	mv	a0,s1
    800045aa:	ffffe097          	auipc	ra,0xffffe
    800045ae:	78c080e7          	jalr	1932(ra) # 80002d36 <iunlockput>
  return 0;
    800045b2:	bdc5                	j	800044a2 <create+0x76>
    return 0;
    800045b4:	8aaa                	mv	s5,a0
    800045b6:	b5f5                	j	800044a2 <create+0x76>

00000000800045b8 <sys_dup>:
{
    800045b8:	7179                	addi	sp,sp,-48
    800045ba:	f406                	sd	ra,40(sp)
    800045bc:	f022                	sd	s0,32(sp)
    800045be:	ec26                	sd	s1,24(sp)
    800045c0:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800045c2:	fd840613          	addi	a2,s0,-40
    800045c6:	4581                	li	a1,0
    800045c8:	4501                	li	a0,0
    800045ca:	00000097          	auipc	ra,0x0
    800045ce:	dc0080e7          	jalr	-576(ra) # 8000438a <argfd>
    return -1;
    800045d2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800045d4:	02054363          	bltz	a0,800045fa <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    800045d8:	fd843503          	ld	a0,-40(s0)
    800045dc:	00000097          	auipc	ra,0x0
    800045e0:	e0e080e7          	jalr	-498(ra) # 800043ea <fdalloc>
    800045e4:	84aa                	mv	s1,a0
    return -1;
    800045e6:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800045e8:	00054963          	bltz	a0,800045fa <sys_dup+0x42>
  filedup(f);
    800045ec:	fd843503          	ld	a0,-40(s0)
    800045f0:	fffff097          	auipc	ra,0xfffff
    800045f4:	320080e7          	jalr	800(ra) # 80003910 <filedup>
  return fd;
    800045f8:	87a6                	mv	a5,s1
}
    800045fa:	853e                	mv	a0,a5
    800045fc:	70a2                	ld	ra,40(sp)
    800045fe:	7402                	ld	s0,32(sp)
    80004600:	64e2                	ld	s1,24(sp)
    80004602:	6145                	addi	sp,sp,48
    80004604:	8082                	ret

0000000080004606 <sys_read>:
{
    80004606:	7179                	addi	sp,sp,-48
    80004608:	f406                	sd	ra,40(sp)
    8000460a:	f022                	sd	s0,32(sp)
    8000460c:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    8000460e:	fd840593          	addi	a1,s0,-40
    80004612:	4505                	li	a0,1
    80004614:	ffffe097          	auipc	ra,0xffffe
    80004618:	974080e7          	jalr	-1676(ra) # 80001f88 <argaddr>
  argint(2, &n);
    8000461c:	fe440593          	addi	a1,s0,-28
    80004620:	4509                	li	a0,2
    80004622:	ffffe097          	auipc	ra,0xffffe
    80004626:	946080e7          	jalr	-1722(ra) # 80001f68 <argint>
  if(argfd(0, 0, &f) < 0)
    8000462a:	fe840613          	addi	a2,s0,-24
    8000462e:	4581                	li	a1,0
    80004630:	4501                	li	a0,0
    80004632:	00000097          	auipc	ra,0x0
    80004636:	d58080e7          	jalr	-680(ra) # 8000438a <argfd>
    8000463a:	87aa                	mv	a5,a0
    return -1;
    8000463c:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000463e:	0007cc63          	bltz	a5,80004656 <sys_read+0x50>
  return fileread(f, p, n);
    80004642:	fe442603          	lw	a2,-28(s0)
    80004646:	fd843583          	ld	a1,-40(s0)
    8000464a:	fe843503          	ld	a0,-24(s0)
    8000464e:	fffff097          	auipc	ra,0xfffff
    80004652:	44e080e7          	jalr	1102(ra) # 80003a9c <fileread>
}
    80004656:	70a2                	ld	ra,40(sp)
    80004658:	7402                	ld	s0,32(sp)
    8000465a:	6145                	addi	sp,sp,48
    8000465c:	8082                	ret

000000008000465e <sys_write>:
{
    8000465e:	7179                	addi	sp,sp,-48
    80004660:	f406                	sd	ra,40(sp)
    80004662:	f022                	sd	s0,32(sp)
    80004664:	1800                	addi	s0,sp,48
  argaddr(1, &p);
    80004666:	fd840593          	addi	a1,s0,-40
    8000466a:	4505                	li	a0,1
    8000466c:	ffffe097          	auipc	ra,0xffffe
    80004670:	91c080e7          	jalr	-1764(ra) # 80001f88 <argaddr>
  argint(2, &n);
    80004674:	fe440593          	addi	a1,s0,-28
    80004678:	4509                	li	a0,2
    8000467a:	ffffe097          	auipc	ra,0xffffe
    8000467e:	8ee080e7          	jalr	-1810(ra) # 80001f68 <argint>
  if(argfd(0, 0, &f) < 0)
    80004682:	fe840613          	addi	a2,s0,-24
    80004686:	4581                	li	a1,0
    80004688:	4501                	li	a0,0
    8000468a:	00000097          	auipc	ra,0x0
    8000468e:	d00080e7          	jalr	-768(ra) # 8000438a <argfd>
    80004692:	87aa                	mv	a5,a0
    return -1;
    80004694:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    80004696:	0007cc63          	bltz	a5,800046ae <sys_write+0x50>
  return filewrite(f, p, n);
    8000469a:	fe442603          	lw	a2,-28(s0)
    8000469e:	fd843583          	ld	a1,-40(s0)
    800046a2:	fe843503          	ld	a0,-24(s0)
    800046a6:	fffff097          	auipc	ra,0xfffff
    800046aa:	4b8080e7          	jalr	1208(ra) # 80003b5e <filewrite>
}
    800046ae:	70a2                	ld	ra,40(sp)
    800046b0:	7402                	ld	s0,32(sp)
    800046b2:	6145                	addi	sp,sp,48
    800046b4:	8082                	ret

00000000800046b6 <sys_close>:
{
    800046b6:	1101                	addi	sp,sp,-32
    800046b8:	ec06                	sd	ra,24(sp)
    800046ba:	e822                	sd	s0,16(sp)
    800046bc:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800046be:	fe040613          	addi	a2,s0,-32
    800046c2:	fec40593          	addi	a1,s0,-20
    800046c6:	4501                	li	a0,0
    800046c8:	00000097          	auipc	ra,0x0
    800046cc:	cc2080e7          	jalr	-830(ra) # 8000438a <argfd>
    return -1;
    800046d0:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800046d2:	02054463          	bltz	a0,800046fa <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800046d6:	ffffc097          	auipc	ra,0xffffc
    800046da:	782080e7          	jalr	1922(ra) # 80000e58 <myproc>
    800046de:	fec42783          	lw	a5,-20(s0)
    800046e2:	07e9                	addi	a5,a5,26
    800046e4:	078e                	slli	a5,a5,0x3
    800046e6:	97aa                	add	a5,a5,a0
    800046e8:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    800046ec:	fe043503          	ld	a0,-32(s0)
    800046f0:	fffff097          	auipc	ra,0xfffff
    800046f4:	272080e7          	jalr	626(ra) # 80003962 <fileclose>
  return 0;
    800046f8:	4781                	li	a5,0
}
    800046fa:	853e                	mv	a0,a5
    800046fc:	60e2                	ld	ra,24(sp)
    800046fe:	6442                	ld	s0,16(sp)
    80004700:	6105                	addi	sp,sp,32
    80004702:	8082                	ret

0000000080004704 <sys_fstat>:
{
    80004704:	1101                	addi	sp,sp,-32
    80004706:	ec06                	sd	ra,24(sp)
    80004708:	e822                	sd	s0,16(sp)
    8000470a:	1000                	addi	s0,sp,32
  argaddr(1, &st);
    8000470c:	fe040593          	addi	a1,s0,-32
    80004710:	4505                	li	a0,1
    80004712:	ffffe097          	auipc	ra,0xffffe
    80004716:	876080e7          	jalr	-1930(ra) # 80001f88 <argaddr>
  if(argfd(0, 0, &f) < 0)
    8000471a:	fe840613          	addi	a2,s0,-24
    8000471e:	4581                	li	a1,0
    80004720:	4501                	li	a0,0
    80004722:	00000097          	auipc	ra,0x0
    80004726:	c68080e7          	jalr	-920(ra) # 8000438a <argfd>
    8000472a:	87aa                	mv	a5,a0
    return -1;
    8000472c:	557d                	li	a0,-1
  if(argfd(0, 0, &f) < 0)
    8000472e:	0007ca63          	bltz	a5,80004742 <sys_fstat+0x3e>
  return filestat(f, st);
    80004732:	fe043583          	ld	a1,-32(s0)
    80004736:	fe843503          	ld	a0,-24(s0)
    8000473a:	fffff097          	auipc	ra,0xfffff
    8000473e:	2f0080e7          	jalr	752(ra) # 80003a2a <filestat>
}
    80004742:	60e2                	ld	ra,24(sp)
    80004744:	6442                	ld	s0,16(sp)
    80004746:	6105                	addi	sp,sp,32
    80004748:	8082                	ret

000000008000474a <sys_link>:
{
    8000474a:	7169                	addi	sp,sp,-304
    8000474c:	f606                	sd	ra,296(sp)
    8000474e:	f222                	sd	s0,288(sp)
    80004750:	ee26                	sd	s1,280(sp)
    80004752:	ea4a                	sd	s2,272(sp)
    80004754:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004756:	08000613          	li	a2,128
    8000475a:	ed040593          	addi	a1,s0,-304
    8000475e:	4501                	li	a0,0
    80004760:	ffffe097          	auipc	ra,0xffffe
    80004764:	848080e7          	jalr	-1976(ra) # 80001fa8 <argstr>
    return -1;
    80004768:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000476a:	10054e63          	bltz	a0,80004886 <sys_link+0x13c>
    8000476e:	08000613          	li	a2,128
    80004772:	f5040593          	addi	a1,s0,-176
    80004776:	4505                	li	a0,1
    80004778:	ffffe097          	auipc	ra,0xffffe
    8000477c:	830080e7          	jalr	-2000(ra) # 80001fa8 <argstr>
    return -1;
    80004780:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004782:	10054263          	bltz	a0,80004886 <sys_link+0x13c>
  begin_op();
    80004786:	fffff097          	auipc	ra,0xfffff
    8000478a:	d10080e7          	jalr	-752(ra) # 80003496 <begin_op>
  if((ip = namei(old)) == 0){
    8000478e:	ed040513          	addi	a0,s0,-304
    80004792:	fffff097          	auipc	ra,0xfffff
    80004796:	ae8080e7          	jalr	-1304(ra) # 8000327a <namei>
    8000479a:	84aa                	mv	s1,a0
    8000479c:	c551                	beqz	a0,80004828 <sys_link+0xde>
  ilock(ip);
    8000479e:	ffffe097          	auipc	ra,0xffffe
    800047a2:	336080e7          	jalr	822(ra) # 80002ad4 <ilock>
  if(ip->type == T_DIR){
    800047a6:	04449703          	lh	a4,68(s1)
    800047aa:	4785                	li	a5,1
    800047ac:	08f70463          	beq	a4,a5,80004834 <sys_link+0xea>
  ip->nlink++;
    800047b0:	04a4d783          	lhu	a5,74(s1)
    800047b4:	2785                	addiw	a5,a5,1
    800047b6:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800047ba:	8526                	mv	a0,s1
    800047bc:	ffffe097          	auipc	ra,0xffffe
    800047c0:	24e080e7          	jalr	590(ra) # 80002a0a <iupdate>
  iunlock(ip);
    800047c4:	8526                	mv	a0,s1
    800047c6:	ffffe097          	auipc	ra,0xffffe
    800047ca:	3d0080e7          	jalr	976(ra) # 80002b96 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800047ce:	fd040593          	addi	a1,s0,-48
    800047d2:	f5040513          	addi	a0,s0,-176
    800047d6:	fffff097          	auipc	ra,0xfffff
    800047da:	ac2080e7          	jalr	-1342(ra) # 80003298 <nameiparent>
    800047de:	892a                	mv	s2,a0
    800047e0:	c935                	beqz	a0,80004854 <sys_link+0x10a>
  ilock(dp);
    800047e2:	ffffe097          	auipc	ra,0xffffe
    800047e6:	2f2080e7          	jalr	754(ra) # 80002ad4 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    800047ea:	00092703          	lw	a4,0(s2)
    800047ee:	409c                	lw	a5,0(s1)
    800047f0:	04f71d63          	bne	a4,a5,8000484a <sys_link+0x100>
    800047f4:	40d0                	lw	a2,4(s1)
    800047f6:	fd040593          	addi	a1,s0,-48
    800047fa:	854a                	mv	a0,s2
    800047fc:	fffff097          	auipc	ra,0xfffff
    80004800:	9cc080e7          	jalr	-1588(ra) # 800031c8 <dirlink>
    80004804:	04054363          	bltz	a0,8000484a <sys_link+0x100>
  iunlockput(dp);
    80004808:	854a                	mv	a0,s2
    8000480a:	ffffe097          	auipc	ra,0xffffe
    8000480e:	52c080e7          	jalr	1324(ra) # 80002d36 <iunlockput>
  iput(ip);
    80004812:	8526                	mv	a0,s1
    80004814:	ffffe097          	auipc	ra,0xffffe
    80004818:	47a080e7          	jalr	1146(ra) # 80002c8e <iput>
  end_op();
    8000481c:	fffff097          	auipc	ra,0xfffff
    80004820:	cfa080e7          	jalr	-774(ra) # 80003516 <end_op>
  return 0;
    80004824:	4781                	li	a5,0
    80004826:	a085                	j	80004886 <sys_link+0x13c>
    end_op();
    80004828:	fffff097          	auipc	ra,0xfffff
    8000482c:	cee080e7          	jalr	-786(ra) # 80003516 <end_op>
    return -1;
    80004830:	57fd                	li	a5,-1
    80004832:	a891                	j	80004886 <sys_link+0x13c>
    iunlockput(ip);
    80004834:	8526                	mv	a0,s1
    80004836:	ffffe097          	auipc	ra,0xffffe
    8000483a:	500080e7          	jalr	1280(ra) # 80002d36 <iunlockput>
    end_op();
    8000483e:	fffff097          	auipc	ra,0xfffff
    80004842:	cd8080e7          	jalr	-808(ra) # 80003516 <end_op>
    return -1;
    80004846:	57fd                	li	a5,-1
    80004848:	a83d                	j	80004886 <sys_link+0x13c>
    iunlockput(dp);
    8000484a:	854a                	mv	a0,s2
    8000484c:	ffffe097          	auipc	ra,0xffffe
    80004850:	4ea080e7          	jalr	1258(ra) # 80002d36 <iunlockput>
  ilock(ip);
    80004854:	8526                	mv	a0,s1
    80004856:	ffffe097          	auipc	ra,0xffffe
    8000485a:	27e080e7          	jalr	638(ra) # 80002ad4 <ilock>
  ip->nlink--;
    8000485e:	04a4d783          	lhu	a5,74(s1)
    80004862:	37fd                	addiw	a5,a5,-1
    80004864:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004868:	8526                	mv	a0,s1
    8000486a:	ffffe097          	auipc	ra,0xffffe
    8000486e:	1a0080e7          	jalr	416(ra) # 80002a0a <iupdate>
  iunlockput(ip);
    80004872:	8526                	mv	a0,s1
    80004874:	ffffe097          	auipc	ra,0xffffe
    80004878:	4c2080e7          	jalr	1218(ra) # 80002d36 <iunlockput>
  end_op();
    8000487c:	fffff097          	auipc	ra,0xfffff
    80004880:	c9a080e7          	jalr	-870(ra) # 80003516 <end_op>
  return -1;
    80004884:	57fd                	li	a5,-1
}
    80004886:	853e                	mv	a0,a5
    80004888:	70b2                	ld	ra,296(sp)
    8000488a:	7412                	ld	s0,288(sp)
    8000488c:	64f2                	ld	s1,280(sp)
    8000488e:	6952                	ld	s2,272(sp)
    80004890:	6155                	addi	sp,sp,304
    80004892:	8082                	ret

0000000080004894 <sys_unlink>:
{
    80004894:	7151                	addi	sp,sp,-240
    80004896:	f586                	sd	ra,232(sp)
    80004898:	f1a2                	sd	s0,224(sp)
    8000489a:	eda6                	sd	s1,216(sp)
    8000489c:	e9ca                	sd	s2,208(sp)
    8000489e:	e5ce                	sd	s3,200(sp)
    800048a0:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800048a2:	08000613          	li	a2,128
    800048a6:	f3040593          	addi	a1,s0,-208
    800048aa:	4501                	li	a0,0
    800048ac:	ffffd097          	auipc	ra,0xffffd
    800048b0:	6fc080e7          	jalr	1788(ra) # 80001fa8 <argstr>
    800048b4:	18054163          	bltz	a0,80004a36 <sys_unlink+0x1a2>
  begin_op();
    800048b8:	fffff097          	auipc	ra,0xfffff
    800048bc:	bde080e7          	jalr	-1058(ra) # 80003496 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800048c0:	fb040593          	addi	a1,s0,-80
    800048c4:	f3040513          	addi	a0,s0,-208
    800048c8:	fffff097          	auipc	ra,0xfffff
    800048cc:	9d0080e7          	jalr	-1584(ra) # 80003298 <nameiparent>
    800048d0:	84aa                	mv	s1,a0
    800048d2:	c979                	beqz	a0,800049a8 <sys_unlink+0x114>
  ilock(dp);
    800048d4:	ffffe097          	auipc	ra,0xffffe
    800048d8:	200080e7          	jalr	512(ra) # 80002ad4 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800048dc:	00004597          	auipc	a1,0x4
    800048e0:	d9458593          	addi	a1,a1,-620 # 80008670 <syscalls+0x2a0>
    800048e4:	fb040513          	addi	a0,s0,-80
    800048e8:	ffffe097          	auipc	ra,0xffffe
    800048ec:	6b6080e7          	jalr	1718(ra) # 80002f9e <namecmp>
    800048f0:	14050a63          	beqz	a0,80004a44 <sys_unlink+0x1b0>
    800048f4:	00004597          	auipc	a1,0x4
    800048f8:	d8458593          	addi	a1,a1,-636 # 80008678 <syscalls+0x2a8>
    800048fc:	fb040513          	addi	a0,s0,-80
    80004900:	ffffe097          	auipc	ra,0xffffe
    80004904:	69e080e7          	jalr	1694(ra) # 80002f9e <namecmp>
    80004908:	12050e63          	beqz	a0,80004a44 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    8000490c:	f2c40613          	addi	a2,s0,-212
    80004910:	fb040593          	addi	a1,s0,-80
    80004914:	8526                	mv	a0,s1
    80004916:	ffffe097          	auipc	ra,0xffffe
    8000491a:	6a2080e7          	jalr	1698(ra) # 80002fb8 <dirlookup>
    8000491e:	892a                	mv	s2,a0
    80004920:	12050263          	beqz	a0,80004a44 <sys_unlink+0x1b0>
  ilock(ip);
    80004924:	ffffe097          	auipc	ra,0xffffe
    80004928:	1b0080e7          	jalr	432(ra) # 80002ad4 <ilock>
  if(ip->nlink < 1)
    8000492c:	04a91783          	lh	a5,74(s2)
    80004930:	08f05263          	blez	a5,800049b4 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004934:	04491703          	lh	a4,68(s2)
    80004938:	4785                	li	a5,1
    8000493a:	08f70563          	beq	a4,a5,800049c4 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    8000493e:	4641                	li	a2,16
    80004940:	4581                	li	a1,0
    80004942:	fc040513          	addi	a0,s0,-64
    80004946:	ffffc097          	auipc	ra,0xffffc
    8000494a:	832080e7          	jalr	-1998(ra) # 80000178 <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000494e:	4741                	li	a4,16
    80004950:	f2c42683          	lw	a3,-212(s0)
    80004954:	fc040613          	addi	a2,s0,-64
    80004958:	4581                	li	a1,0
    8000495a:	8526                	mv	a0,s1
    8000495c:	ffffe097          	auipc	ra,0xffffe
    80004960:	524080e7          	jalr	1316(ra) # 80002e80 <writei>
    80004964:	47c1                	li	a5,16
    80004966:	0af51563          	bne	a0,a5,80004a10 <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    8000496a:	04491703          	lh	a4,68(s2)
    8000496e:	4785                	li	a5,1
    80004970:	0af70863          	beq	a4,a5,80004a20 <sys_unlink+0x18c>
  iunlockput(dp);
    80004974:	8526                	mv	a0,s1
    80004976:	ffffe097          	auipc	ra,0xffffe
    8000497a:	3c0080e7          	jalr	960(ra) # 80002d36 <iunlockput>
  ip->nlink--;
    8000497e:	04a95783          	lhu	a5,74(s2)
    80004982:	37fd                	addiw	a5,a5,-1
    80004984:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004988:	854a                	mv	a0,s2
    8000498a:	ffffe097          	auipc	ra,0xffffe
    8000498e:	080080e7          	jalr	128(ra) # 80002a0a <iupdate>
  iunlockput(ip);
    80004992:	854a                	mv	a0,s2
    80004994:	ffffe097          	auipc	ra,0xffffe
    80004998:	3a2080e7          	jalr	930(ra) # 80002d36 <iunlockput>
  end_op();
    8000499c:	fffff097          	auipc	ra,0xfffff
    800049a0:	b7a080e7          	jalr	-1158(ra) # 80003516 <end_op>
  return 0;
    800049a4:	4501                	li	a0,0
    800049a6:	a84d                	j	80004a58 <sys_unlink+0x1c4>
    end_op();
    800049a8:	fffff097          	auipc	ra,0xfffff
    800049ac:	b6e080e7          	jalr	-1170(ra) # 80003516 <end_op>
    return -1;
    800049b0:	557d                	li	a0,-1
    800049b2:	a05d                	j	80004a58 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    800049b4:	00004517          	auipc	a0,0x4
    800049b8:	ccc50513          	addi	a0,a0,-820 # 80008680 <syscalls+0x2b0>
    800049bc:	00001097          	auipc	ra,0x1
    800049c0:	216080e7          	jalr	534(ra) # 80005bd2 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800049c4:	04c92703          	lw	a4,76(s2)
    800049c8:	02000793          	li	a5,32
    800049cc:	f6e7f9e3          	bgeu	a5,a4,8000493e <sys_unlink+0xaa>
    800049d0:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800049d4:	4741                	li	a4,16
    800049d6:	86ce                	mv	a3,s3
    800049d8:	f1840613          	addi	a2,s0,-232
    800049dc:	4581                	li	a1,0
    800049de:	854a                	mv	a0,s2
    800049e0:	ffffe097          	auipc	ra,0xffffe
    800049e4:	3a8080e7          	jalr	936(ra) # 80002d88 <readi>
    800049e8:	47c1                	li	a5,16
    800049ea:	00f51b63          	bne	a0,a5,80004a00 <sys_unlink+0x16c>
    if(de.inum != 0)
    800049ee:	f1845783          	lhu	a5,-232(s0)
    800049f2:	e7a1                	bnez	a5,80004a3a <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    800049f4:	29c1                	addiw	s3,s3,16
    800049f6:	04c92783          	lw	a5,76(s2)
    800049fa:	fcf9ede3          	bltu	s3,a5,800049d4 <sys_unlink+0x140>
    800049fe:	b781                	j	8000493e <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004a00:	00004517          	auipc	a0,0x4
    80004a04:	c9850513          	addi	a0,a0,-872 # 80008698 <syscalls+0x2c8>
    80004a08:	00001097          	auipc	ra,0x1
    80004a0c:	1ca080e7          	jalr	458(ra) # 80005bd2 <panic>
    panic("unlink: writei");
    80004a10:	00004517          	auipc	a0,0x4
    80004a14:	ca050513          	addi	a0,a0,-864 # 800086b0 <syscalls+0x2e0>
    80004a18:	00001097          	auipc	ra,0x1
    80004a1c:	1ba080e7          	jalr	442(ra) # 80005bd2 <panic>
    dp->nlink--;
    80004a20:	04a4d783          	lhu	a5,74(s1)
    80004a24:	37fd                	addiw	a5,a5,-1
    80004a26:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004a2a:	8526                	mv	a0,s1
    80004a2c:	ffffe097          	auipc	ra,0xffffe
    80004a30:	fde080e7          	jalr	-34(ra) # 80002a0a <iupdate>
    80004a34:	b781                	j	80004974 <sys_unlink+0xe0>
    return -1;
    80004a36:	557d                	li	a0,-1
    80004a38:	a005                	j	80004a58 <sys_unlink+0x1c4>
    iunlockput(ip);
    80004a3a:	854a                	mv	a0,s2
    80004a3c:	ffffe097          	auipc	ra,0xffffe
    80004a40:	2fa080e7          	jalr	762(ra) # 80002d36 <iunlockput>
  iunlockput(dp);
    80004a44:	8526                	mv	a0,s1
    80004a46:	ffffe097          	auipc	ra,0xffffe
    80004a4a:	2f0080e7          	jalr	752(ra) # 80002d36 <iunlockput>
  end_op();
    80004a4e:	fffff097          	auipc	ra,0xfffff
    80004a52:	ac8080e7          	jalr	-1336(ra) # 80003516 <end_op>
  return -1;
    80004a56:	557d                	li	a0,-1
}
    80004a58:	70ae                	ld	ra,232(sp)
    80004a5a:	740e                	ld	s0,224(sp)
    80004a5c:	64ee                	ld	s1,216(sp)
    80004a5e:	694e                	ld	s2,208(sp)
    80004a60:	69ae                	ld	s3,200(sp)
    80004a62:	616d                	addi	sp,sp,240
    80004a64:	8082                	ret

0000000080004a66 <sys_open>:

uint64
sys_open(void)
{
    80004a66:	7131                	addi	sp,sp,-192
    80004a68:	fd06                	sd	ra,184(sp)
    80004a6a:	f922                	sd	s0,176(sp)
    80004a6c:	f526                	sd	s1,168(sp)
    80004a6e:	f14a                	sd	s2,160(sp)
    80004a70:	ed4e                	sd	s3,152(sp)
    80004a72:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  argint(1, &omode);
    80004a74:	f4c40593          	addi	a1,s0,-180
    80004a78:	4505                	li	a0,1
    80004a7a:	ffffd097          	auipc	ra,0xffffd
    80004a7e:	4ee080e7          	jalr	1262(ra) # 80001f68 <argint>
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004a82:	08000613          	li	a2,128
    80004a86:	f5040593          	addi	a1,s0,-176
    80004a8a:	4501                	li	a0,0
    80004a8c:	ffffd097          	auipc	ra,0xffffd
    80004a90:	51c080e7          	jalr	1308(ra) # 80001fa8 <argstr>
    80004a94:	87aa                	mv	a5,a0
    return -1;
    80004a96:	557d                	li	a0,-1
  if((n = argstr(0, path, MAXPATH)) < 0)
    80004a98:	0a07c963          	bltz	a5,80004b4a <sys_open+0xe4>

  begin_op();
    80004a9c:	fffff097          	auipc	ra,0xfffff
    80004aa0:	9fa080e7          	jalr	-1542(ra) # 80003496 <begin_op>

  if(omode & O_CREATE){
    80004aa4:	f4c42783          	lw	a5,-180(s0)
    80004aa8:	2007f793          	andi	a5,a5,512
    80004aac:	cfc5                	beqz	a5,80004b64 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004aae:	4681                	li	a3,0
    80004ab0:	4601                	li	a2,0
    80004ab2:	4589                	li	a1,2
    80004ab4:	f5040513          	addi	a0,s0,-176
    80004ab8:	00000097          	auipc	ra,0x0
    80004abc:	974080e7          	jalr	-1676(ra) # 8000442c <create>
    80004ac0:	84aa                	mv	s1,a0
    if(ip == 0){
    80004ac2:	c959                	beqz	a0,80004b58 <sys_open+0xf2>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004ac4:	04449703          	lh	a4,68(s1)
    80004ac8:	478d                	li	a5,3
    80004aca:	00f71763          	bne	a4,a5,80004ad8 <sys_open+0x72>
    80004ace:	0464d703          	lhu	a4,70(s1)
    80004ad2:	47a5                	li	a5,9
    80004ad4:	0ce7ed63          	bltu	a5,a4,80004bae <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004ad8:	fffff097          	auipc	ra,0xfffff
    80004adc:	dce080e7          	jalr	-562(ra) # 800038a6 <filealloc>
    80004ae0:	89aa                	mv	s3,a0
    80004ae2:	10050363          	beqz	a0,80004be8 <sys_open+0x182>
    80004ae6:	00000097          	auipc	ra,0x0
    80004aea:	904080e7          	jalr	-1788(ra) # 800043ea <fdalloc>
    80004aee:	892a                	mv	s2,a0
    80004af0:	0e054763          	bltz	a0,80004bde <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004af4:	04449703          	lh	a4,68(s1)
    80004af8:	478d                	li	a5,3
    80004afa:	0cf70563          	beq	a4,a5,80004bc4 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004afe:	4789                	li	a5,2
    80004b00:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004b04:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004b08:	0099bc23          	sd	s1,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004b0c:	f4c42783          	lw	a5,-180(s0)
    80004b10:	0017c713          	xori	a4,a5,1
    80004b14:	8b05                	andi	a4,a4,1
    80004b16:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004b1a:	0037f713          	andi	a4,a5,3
    80004b1e:	00e03733          	snez	a4,a4
    80004b22:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004b26:	4007f793          	andi	a5,a5,1024
    80004b2a:	c791                	beqz	a5,80004b36 <sys_open+0xd0>
    80004b2c:	04449703          	lh	a4,68(s1)
    80004b30:	4789                	li	a5,2
    80004b32:	0af70063          	beq	a4,a5,80004bd2 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80004b36:	8526                	mv	a0,s1
    80004b38:	ffffe097          	auipc	ra,0xffffe
    80004b3c:	05e080e7          	jalr	94(ra) # 80002b96 <iunlock>
  end_op();
    80004b40:	fffff097          	auipc	ra,0xfffff
    80004b44:	9d6080e7          	jalr	-1578(ra) # 80003516 <end_op>

  return fd;
    80004b48:	854a                	mv	a0,s2
}
    80004b4a:	70ea                	ld	ra,184(sp)
    80004b4c:	744a                	ld	s0,176(sp)
    80004b4e:	74aa                	ld	s1,168(sp)
    80004b50:	790a                	ld	s2,160(sp)
    80004b52:	69ea                	ld	s3,152(sp)
    80004b54:	6129                	addi	sp,sp,192
    80004b56:	8082                	ret
      end_op();
    80004b58:	fffff097          	auipc	ra,0xfffff
    80004b5c:	9be080e7          	jalr	-1602(ra) # 80003516 <end_op>
      return -1;
    80004b60:	557d                	li	a0,-1
    80004b62:	b7e5                	j	80004b4a <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80004b64:	f5040513          	addi	a0,s0,-176
    80004b68:	ffffe097          	auipc	ra,0xffffe
    80004b6c:	712080e7          	jalr	1810(ra) # 8000327a <namei>
    80004b70:	84aa                	mv	s1,a0
    80004b72:	c905                	beqz	a0,80004ba2 <sys_open+0x13c>
    ilock(ip);
    80004b74:	ffffe097          	auipc	ra,0xffffe
    80004b78:	f60080e7          	jalr	-160(ra) # 80002ad4 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004b7c:	04449703          	lh	a4,68(s1)
    80004b80:	4785                	li	a5,1
    80004b82:	f4f711e3          	bne	a4,a5,80004ac4 <sys_open+0x5e>
    80004b86:	f4c42783          	lw	a5,-180(s0)
    80004b8a:	d7b9                	beqz	a5,80004ad8 <sys_open+0x72>
      iunlockput(ip);
    80004b8c:	8526                	mv	a0,s1
    80004b8e:	ffffe097          	auipc	ra,0xffffe
    80004b92:	1a8080e7          	jalr	424(ra) # 80002d36 <iunlockput>
      end_op();
    80004b96:	fffff097          	auipc	ra,0xfffff
    80004b9a:	980080e7          	jalr	-1664(ra) # 80003516 <end_op>
      return -1;
    80004b9e:	557d                	li	a0,-1
    80004ba0:	b76d                	j	80004b4a <sys_open+0xe4>
      end_op();
    80004ba2:	fffff097          	auipc	ra,0xfffff
    80004ba6:	974080e7          	jalr	-1676(ra) # 80003516 <end_op>
      return -1;
    80004baa:	557d                	li	a0,-1
    80004bac:	bf79                	j	80004b4a <sys_open+0xe4>
    iunlockput(ip);
    80004bae:	8526                	mv	a0,s1
    80004bb0:	ffffe097          	auipc	ra,0xffffe
    80004bb4:	186080e7          	jalr	390(ra) # 80002d36 <iunlockput>
    end_op();
    80004bb8:	fffff097          	auipc	ra,0xfffff
    80004bbc:	95e080e7          	jalr	-1698(ra) # 80003516 <end_op>
    return -1;
    80004bc0:	557d                	li	a0,-1
    80004bc2:	b761                	j	80004b4a <sys_open+0xe4>
    f->type = FD_DEVICE;
    80004bc4:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004bc8:	04649783          	lh	a5,70(s1)
    80004bcc:	02f99223          	sh	a5,36(s3)
    80004bd0:	bf25                	j	80004b08 <sys_open+0xa2>
    itrunc(ip);
    80004bd2:	8526                	mv	a0,s1
    80004bd4:	ffffe097          	auipc	ra,0xffffe
    80004bd8:	00e080e7          	jalr	14(ra) # 80002be2 <itrunc>
    80004bdc:	bfa9                	j	80004b36 <sys_open+0xd0>
      fileclose(f);
    80004bde:	854e                	mv	a0,s3
    80004be0:	fffff097          	auipc	ra,0xfffff
    80004be4:	d82080e7          	jalr	-638(ra) # 80003962 <fileclose>
    iunlockput(ip);
    80004be8:	8526                	mv	a0,s1
    80004bea:	ffffe097          	auipc	ra,0xffffe
    80004bee:	14c080e7          	jalr	332(ra) # 80002d36 <iunlockput>
    end_op();
    80004bf2:	fffff097          	auipc	ra,0xfffff
    80004bf6:	924080e7          	jalr	-1756(ra) # 80003516 <end_op>
    return -1;
    80004bfa:	557d                	li	a0,-1
    80004bfc:	b7b9                	j	80004b4a <sys_open+0xe4>

0000000080004bfe <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004bfe:	7175                	addi	sp,sp,-144
    80004c00:	e506                	sd	ra,136(sp)
    80004c02:	e122                	sd	s0,128(sp)
    80004c04:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004c06:	fffff097          	auipc	ra,0xfffff
    80004c0a:	890080e7          	jalr	-1904(ra) # 80003496 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004c0e:	08000613          	li	a2,128
    80004c12:	f7040593          	addi	a1,s0,-144
    80004c16:	4501                	li	a0,0
    80004c18:	ffffd097          	auipc	ra,0xffffd
    80004c1c:	390080e7          	jalr	912(ra) # 80001fa8 <argstr>
    80004c20:	02054963          	bltz	a0,80004c52 <sys_mkdir+0x54>
    80004c24:	4681                	li	a3,0
    80004c26:	4601                	li	a2,0
    80004c28:	4585                	li	a1,1
    80004c2a:	f7040513          	addi	a0,s0,-144
    80004c2e:	fffff097          	auipc	ra,0xfffff
    80004c32:	7fe080e7          	jalr	2046(ra) # 8000442c <create>
    80004c36:	cd11                	beqz	a0,80004c52 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004c38:	ffffe097          	auipc	ra,0xffffe
    80004c3c:	0fe080e7          	jalr	254(ra) # 80002d36 <iunlockput>
  end_op();
    80004c40:	fffff097          	auipc	ra,0xfffff
    80004c44:	8d6080e7          	jalr	-1834(ra) # 80003516 <end_op>
  return 0;
    80004c48:	4501                	li	a0,0
}
    80004c4a:	60aa                	ld	ra,136(sp)
    80004c4c:	640a                	ld	s0,128(sp)
    80004c4e:	6149                	addi	sp,sp,144
    80004c50:	8082                	ret
    end_op();
    80004c52:	fffff097          	auipc	ra,0xfffff
    80004c56:	8c4080e7          	jalr	-1852(ra) # 80003516 <end_op>
    return -1;
    80004c5a:	557d                	li	a0,-1
    80004c5c:	b7fd                	j	80004c4a <sys_mkdir+0x4c>

0000000080004c5e <sys_mknod>:

uint64
sys_mknod(void)
{
    80004c5e:	7135                	addi	sp,sp,-160
    80004c60:	ed06                	sd	ra,152(sp)
    80004c62:	e922                	sd	s0,144(sp)
    80004c64:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004c66:	fffff097          	auipc	ra,0xfffff
    80004c6a:	830080e7          	jalr	-2000(ra) # 80003496 <begin_op>
  argint(1, &major);
    80004c6e:	f6c40593          	addi	a1,s0,-148
    80004c72:	4505                	li	a0,1
    80004c74:	ffffd097          	auipc	ra,0xffffd
    80004c78:	2f4080e7          	jalr	756(ra) # 80001f68 <argint>
  argint(2, &minor);
    80004c7c:	f6840593          	addi	a1,s0,-152
    80004c80:	4509                	li	a0,2
    80004c82:	ffffd097          	auipc	ra,0xffffd
    80004c86:	2e6080e7          	jalr	742(ra) # 80001f68 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004c8a:	08000613          	li	a2,128
    80004c8e:	f7040593          	addi	a1,s0,-144
    80004c92:	4501                	li	a0,0
    80004c94:	ffffd097          	auipc	ra,0xffffd
    80004c98:	314080e7          	jalr	788(ra) # 80001fa8 <argstr>
    80004c9c:	02054b63          	bltz	a0,80004cd2 <sys_mknod+0x74>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004ca0:	f6841683          	lh	a3,-152(s0)
    80004ca4:	f6c41603          	lh	a2,-148(s0)
    80004ca8:	458d                	li	a1,3
    80004caa:	f7040513          	addi	a0,s0,-144
    80004cae:	fffff097          	auipc	ra,0xfffff
    80004cb2:	77e080e7          	jalr	1918(ra) # 8000442c <create>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004cb6:	cd11                	beqz	a0,80004cd2 <sys_mknod+0x74>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004cb8:	ffffe097          	auipc	ra,0xffffe
    80004cbc:	07e080e7          	jalr	126(ra) # 80002d36 <iunlockput>
  end_op();
    80004cc0:	fffff097          	auipc	ra,0xfffff
    80004cc4:	856080e7          	jalr	-1962(ra) # 80003516 <end_op>
  return 0;
    80004cc8:	4501                	li	a0,0
}
    80004cca:	60ea                	ld	ra,152(sp)
    80004ccc:	644a                	ld	s0,144(sp)
    80004cce:	610d                	addi	sp,sp,160
    80004cd0:	8082                	ret
    end_op();
    80004cd2:	fffff097          	auipc	ra,0xfffff
    80004cd6:	844080e7          	jalr	-1980(ra) # 80003516 <end_op>
    return -1;
    80004cda:	557d                	li	a0,-1
    80004cdc:	b7fd                	j	80004cca <sys_mknod+0x6c>

0000000080004cde <sys_chdir>:

uint64
sys_chdir(void)
{
    80004cde:	7135                	addi	sp,sp,-160
    80004ce0:	ed06                	sd	ra,152(sp)
    80004ce2:	e922                	sd	s0,144(sp)
    80004ce4:	e526                	sd	s1,136(sp)
    80004ce6:	e14a                	sd	s2,128(sp)
    80004ce8:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004cea:	ffffc097          	auipc	ra,0xffffc
    80004cee:	16e080e7          	jalr	366(ra) # 80000e58 <myproc>
    80004cf2:	892a                	mv	s2,a0
  
  begin_op();
    80004cf4:	ffffe097          	auipc	ra,0xffffe
    80004cf8:	7a2080e7          	jalr	1954(ra) # 80003496 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004cfc:	08000613          	li	a2,128
    80004d00:	f6040593          	addi	a1,s0,-160
    80004d04:	4501                	li	a0,0
    80004d06:	ffffd097          	auipc	ra,0xffffd
    80004d0a:	2a2080e7          	jalr	674(ra) # 80001fa8 <argstr>
    80004d0e:	04054b63          	bltz	a0,80004d64 <sys_chdir+0x86>
    80004d12:	f6040513          	addi	a0,s0,-160
    80004d16:	ffffe097          	auipc	ra,0xffffe
    80004d1a:	564080e7          	jalr	1380(ra) # 8000327a <namei>
    80004d1e:	84aa                	mv	s1,a0
    80004d20:	c131                	beqz	a0,80004d64 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004d22:	ffffe097          	auipc	ra,0xffffe
    80004d26:	db2080e7          	jalr	-590(ra) # 80002ad4 <ilock>
  if(ip->type != T_DIR){
    80004d2a:	04449703          	lh	a4,68(s1)
    80004d2e:	4785                	li	a5,1
    80004d30:	04f71063          	bne	a4,a5,80004d70 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004d34:	8526                	mv	a0,s1
    80004d36:	ffffe097          	auipc	ra,0xffffe
    80004d3a:	e60080e7          	jalr	-416(ra) # 80002b96 <iunlock>
  iput(p->cwd);
    80004d3e:	15093503          	ld	a0,336(s2)
    80004d42:	ffffe097          	auipc	ra,0xffffe
    80004d46:	f4c080e7          	jalr	-180(ra) # 80002c8e <iput>
  end_op();
    80004d4a:	ffffe097          	auipc	ra,0xffffe
    80004d4e:	7cc080e7          	jalr	1996(ra) # 80003516 <end_op>
  p->cwd = ip;
    80004d52:	14993823          	sd	s1,336(s2)
  return 0;
    80004d56:	4501                	li	a0,0
}
    80004d58:	60ea                	ld	ra,152(sp)
    80004d5a:	644a                	ld	s0,144(sp)
    80004d5c:	64aa                	ld	s1,136(sp)
    80004d5e:	690a                	ld	s2,128(sp)
    80004d60:	610d                	addi	sp,sp,160
    80004d62:	8082                	ret
    end_op();
    80004d64:	ffffe097          	auipc	ra,0xffffe
    80004d68:	7b2080e7          	jalr	1970(ra) # 80003516 <end_op>
    return -1;
    80004d6c:	557d                	li	a0,-1
    80004d6e:	b7ed                	j	80004d58 <sys_chdir+0x7a>
    iunlockput(ip);
    80004d70:	8526                	mv	a0,s1
    80004d72:	ffffe097          	auipc	ra,0xffffe
    80004d76:	fc4080e7          	jalr	-60(ra) # 80002d36 <iunlockput>
    end_op();
    80004d7a:	ffffe097          	auipc	ra,0xffffe
    80004d7e:	79c080e7          	jalr	1948(ra) # 80003516 <end_op>
    return -1;
    80004d82:	557d                	li	a0,-1
    80004d84:	bfd1                	j	80004d58 <sys_chdir+0x7a>

0000000080004d86 <sys_exec>:

uint64
sys_exec(void)
{
    80004d86:	7145                	addi	sp,sp,-464
    80004d88:	e786                	sd	ra,456(sp)
    80004d8a:	e3a2                	sd	s0,448(sp)
    80004d8c:	ff26                	sd	s1,440(sp)
    80004d8e:	fb4a                	sd	s2,432(sp)
    80004d90:	f74e                	sd	s3,424(sp)
    80004d92:	f352                	sd	s4,416(sp)
    80004d94:	ef56                	sd	s5,408(sp)
    80004d96:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  argaddr(1, &uargv);
    80004d98:	e3840593          	addi	a1,s0,-456
    80004d9c:	4505                	li	a0,1
    80004d9e:	ffffd097          	auipc	ra,0xffffd
    80004da2:	1ea080e7          	jalr	490(ra) # 80001f88 <argaddr>
  if(argstr(0, path, MAXPATH) < 0) {
    80004da6:	08000613          	li	a2,128
    80004daa:	f4040593          	addi	a1,s0,-192
    80004dae:	4501                	li	a0,0
    80004db0:	ffffd097          	auipc	ra,0xffffd
    80004db4:	1f8080e7          	jalr	504(ra) # 80001fa8 <argstr>
    80004db8:	87aa                	mv	a5,a0
    return -1;
    80004dba:	557d                	li	a0,-1
  if(argstr(0, path, MAXPATH) < 0) {
    80004dbc:	0c07c263          	bltz	a5,80004e80 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80004dc0:	10000613          	li	a2,256
    80004dc4:	4581                	li	a1,0
    80004dc6:	e4040513          	addi	a0,s0,-448
    80004dca:	ffffb097          	auipc	ra,0xffffb
    80004dce:	3ae080e7          	jalr	942(ra) # 80000178 <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004dd2:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80004dd6:	89a6                	mv	s3,s1
    80004dd8:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80004dda:	02000a13          	li	s4,32
    80004dde:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004de2:	00391513          	slli	a0,s2,0x3
    80004de6:	e3040593          	addi	a1,s0,-464
    80004dea:	e3843783          	ld	a5,-456(s0)
    80004dee:	953e                	add	a0,a0,a5
    80004df0:	ffffd097          	auipc	ra,0xffffd
    80004df4:	0da080e7          	jalr	218(ra) # 80001eca <fetchaddr>
    80004df8:	02054a63          	bltz	a0,80004e2c <sys_exec+0xa6>
      goto bad;
    }
    if(uarg == 0){
    80004dfc:	e3043783          	ld	a5,-464(s0)
    80004e00:	c3b9                	beqz	a5,80004e46 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80004e02:	ffffb097          	auipc	ra,0xffffb
    80004e06:	316080e7          	jalr	790(ra) # 80000118 <kalloc>
    80004e0a:	85aa                	mv	a1,a0
    80004e0c:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80004e10:	cd11                	beqz	a0,80004e2c <sys_exec+0xa6>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004e12:	6605                	lui	a2,0x1
    80004e14:	e3043503          	ld	a0,-464(s0)
    80004e18:	ffffd097          	auipc	ra,0xffffd
    80004e1c:	104080e7          	jalr	260(ra) # 80001f1c <fetchstr>
    80004e20:	00054663          	bltz	a0,80004e2c <sys_exec+0xa6>
    if(i >= NELEM(argv)){
    80004e24:	0905                	addi	s2,s2,1
    80004e26:	09a1                	addi	s3,s3,8
    80004e28:	fb491be3          	bne	s2,s4,80004dde <sys_exec+0x58>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004e2c:	10048913          	addi	s2,s1,256
    80004e30:	6088                	ld	a0,0(s1)
    80004e32:	c531                	beqz	a0,80004e7e <sys_exec+0xf8>
    kfree(argv[i]);
    80004e34:	ffffb097          	auipc	ra,0xffffb
    80004e38:	1e8080e7          	jalr	488(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004e3c:	04a1                	addi	s1,s1,8
    80004e3e:	ff2499e3          	bne	s1,s2,80004e30 <sys_exec+0xaa>
  return -1;
    80004e42:	557d                	li	a0,-1
    80004e44:	a835                	j	80004e80 <sys_exec+0xfa>
      argv[i] = 0;
    80004e46:	0a8e                	slli	s5,s5,0x3
    80004e48:	fc040793          	addi	a5,s0,-64
    80004e4c:	9abe                	add	s5,s5,a5
    80004e4e:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80004e52:	e4040593          	addi	a1,s0,-448
    80004e56:	f4040513          	addi	a0,s0,-192
    80004e5a:	fffff097          	auipc	ra,0xfffff
    80004e5e:	190080e7          	jalr	400(ra) # 80003fea <exec>
    80004e62:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004e64:	10048993          	addi	s3,s1,256
    80004e68:	6088                	ld	a0,0(s1)
    80004e6a:	c901                	beqz	a0,80004e7a <sys_exec+0xf4>
    kfree(argv[i]);
    80004e6c:	ffffb097          	auipc	ra,0xffffb
    80004e70:	1b0080e7          	jalr	432(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004e74:	04a1                	addi	s1,s1,8
    80004e76:	ff3499e3          	bne	s1,s3,80004e68 <sys_exec+0xe2>
  return ret;
    80004e7a:	854a                	mv	a0,s2
    80004e7c:	a011                	j	80004e80 <sys_exec+0xfa>
  return -1;
    80004e7e:	557d                	li	a0,-1
}
    80004e80:	60be                	ld	ra,456(sp)
    80004e82:	641e                	ld	s0,448(sp)
    80004e84:	74fa                	ld	s1,440(sp)
    80004e86:	795a                	ld	s2,432(sp)
    80004e88:	79ba                	ld	s3,424(sp)
    80004e8a:	7a1a                	ld	s4,416(sp)
    80004e8c:	6afa                	ld	s5,408(sp)
    80004e8e:	6179                	addi	sp,sp,464
    80004e90:	8082                	ret

0000000080004e92 <sys_pipe>:

uint64
sys_pipe(void)
{
    80004e92:	7139                	addi	sp,sp,-64
    80004e94:	fc06                	sd	ra,56(sp)
    80004e96:	f822                	sd	s0,48(sp)
    80004e98:	f426                	sd	s1,40(sp)
    80004e9a:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004e9c:	ffffc097          	auipc	ra,0xffffc
    80004ea0:	fbc080e7          	jalr	-68(ra) # 80000e58 <myproc>
    80004ea4:	84aa                	mv	s1,a0

  argaddr(0, &fdarray);
    80004ea6:	fd840593          	addi	a1,s0,-40
    80004eaa:	4501                	li	a0,0
    80004eac:	ffffd097          	auipc	ra,0xffffd
    80004eb0:	0dc080e7          	jalr	220(ra) # 80001f88 <argaddr>
  if(pipealloc(&rf, &wf) < 0)
    80004eb4:	fc840593          	addi	a1,s0,-56
    80004eb8:	fd040513          	addi	a0,s0,-48
    80004ebc:	fffff097          	auipc	ra,0xfffff
    80004ec0:	dd6080e7          	jalr	-554(ra) # 80003c92 <pipealloc>
    return -1;
    80004ec4:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80004ec6:	0c054463          	bltz	a0,80004f8e <sys_pipe+0xfc>
  fd0 = -1;
    80004eca:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80004ece:	fd043503          	ld	a0,-48(s0)
    80004ed2:	fffff097          	auipc	ra,0xfffff
    80004ed6:	518080e7          	jalr	1304(ra) # 800043ea <fdalloc>
    80004eda:	fca42223          	sw	a0,-60(s0)
    80004ede:	08054b63          	bltz	a0,80004f74 <sys_pipe+0xe2>
    80004ee2:	fc843503          	ld	a0,-56(s0)
    80004ee6:	fffff097          	auipc	ra,0xfffff
    80004eea:	504080e7          	jalr	1284(ra) # 800043ea <fdalloc>
    80004eee:	fca42023          	sw	a0,-64(s0)
    80004ef2:	06054863          	bltz	a0,80004f62 <sys_pipe+0xd0>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004ef6:	4691                	li	a3,4
    80004ef8:	fc440613          	addi	a2,s0,-60
    80004efc:	fd843583          	ld	a1,-40(s0)
    80004f00:	68a8                	ld	a0,80(s1)
    80004f02:	ffffc097          	auipc	ra,0xffffc
    80004f06:	c14080e7          	jalr	-1004(ra) # 80000b16 <copyout>
    80004f0a:	02054063          	bltz	a0,80004f2a <sys_pipe+0x98>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80004f0e:	4691                	li	a3,4
    80004f10:	fc040613          	addi	a2,s0,-64
    80004f14:	fd843583          	ld	a1,-40(s0)
    80004f18:	0591                	addi	a1,a1,4
    80004f1a:	68a8                	ld	a0,80(s1)
    80004f1c:	ffffc097          	auipc	ra,0xffffc
    80004f20:	bfa080e7          	jalr	-1030(ra) # 80000b16 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80004f24:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80004f26:	06055463          	bgez	a0,80004f8e <sys_pipe+0xfc>
    p->ofile[fd0] = 0;
    80004f2a:	fc442783          	lw	a5,-60(s0)
    80004f2e:	07e9                	addi	a5,a5,26
    80004f30:	078e                	slli	a5,a5,0x3
    80004f32:	97a6                	add	a5,a5,s1
    80004f34:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80004f38:	fc042503          	lw	a0,-64(s0)
    80004f3c:	0569                	addi	a0,a0,26
    80004f3e:	050e                	slli	a0,a0,0x3
    80004f40:	94aa                	add	s1,s1,a0
    80004f42:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80004f46:	fd043503          	ld	a0,-48(s0)
    80004f4a:	fffff097          	auipc	ra,0xfffff
    80004f4e:	a18080e7          	jalr	-1512(ra) # 80003962 <fileclose>
    fileclose(wf);
    80004f52:	fc843503          	ld	a0,-56(s0)
    80004f56:	fffff097          	auipc	ra,0xfffff
    80004f5a:	a0c080e7          	jalr	-1524(ra) # 80003962 <fileclose>
    return -1;
    80004f5e:	57fd                	li	a5,-1
    80004f60:	a03d                	j	80004f8e <sys_pipe+0xfc>
    if(fd0 >= 0)
    80004f62:	fc442783          	lw	a5,-60(s0)
    80004f66:	0007c763          	bltz	a5,80004f74 <sys_pipe+0xe2>
      p->ofile[fd0] = 0;
    80004f6a:	07e9                	addi	a5,a5,26
    80004f6c:	078e                	slli	a5,a5,0x3
    80004f6e:	94be                	add	s1,s1,a5
    80004f70:	0004b023          	sd	zero,0(s1)
    fileclose(rf);
    80004f74:	fd043503          	ld	a0,-48(s0)
    80004f78:	fffff097          	auipc	ra,0xfffff
    80004f7c:	9ea080e7          	jalr	-1558(ra) # 80003962 <fileclose>
    fileclose(wf);
    80004f80:	fc843503          	ld	a0,-56(s0)
    80004f84:	fffff097          	auipc	ra,0xfffff
    80004f88:	9de080e7          	jalr	-1570(ra) # 80003962 <fileclose>
    return -1;
    80004f8c:	57fd                	li	a5,-1
}
    80004f8e:	853e                	mv	a0,a5
    80004f90:	70e2                	ld	ra,56(sp)
    80004f92:	7442                	ld	s0,48(sp)
    80004f94:	74a2                	ld	s1,40(sp)
    80004f96:	6121                	addi	sp,sp,64
    80004f98:	8082                	ret
    80004f9a:	0000                	unimp
    80004f9c:	0000                	unimp
	...

0000000080004fa0 <kernelvec>:
    80004fa0:	7111                	addi	sp,sp,-256
    80004fa2:	e006                	sd	ra,0(sp)
    80004fa4:	e40a                	sd	sp,8(sp)
    80004fa6:	e80e                	sd	gp,16(sp)
    80004fa8:	ec12                	sd	tp,24(sp)
    80004faa:	f016                	sd	t0,32(sp)
    80004fac:	f41a                	sd	t1,40(sp)
    80004fae:	f81e                	sd	t2,48(sp)
    80004fb0:	fc22                	sd	s0,56(sp)
    80004fb2:	e0a6                	sd	s1,64(sp)
    80004fb4:	e4aa                	sd	a0,72(sp)
    80004fb6:	e8ae                	sd	a1,80(sp)
    80004fb8:	ecb2                	sd	a2,88(sp)
    80004fba:	f0b6                	sd	a3,96(sp)
    80004fbc:	f4ba                	sd	a4,104(sp)
    80004fbe:	f8be                	sd	a5,112(sp)
    80004fc0:	fcc2                	sd	a6,120(sp)
    80004fc2:	e146                	sd	a7,128(sp)
    80004fc4:	e54a                	sd	s2,136(sp)
    80004fc6:	e94e                	sd	s3,144(sp)
    80004fc8:	ed52                	sd	s4,152(sp)
    80004fca:	f156                	sd	s5,160(sp)
    80004fcc:	f55a                	sd	s6,168(sp)
    80004fce:	f95e                	sd	s7,176(sp)
    80004fd0:	fd62                	sd	s8,184(sp)
    80004fd2:	e1e6                	sd	s9,192(sp)
    80004fd4:	e5ea                	sd	s10,200(sp)
    80004fd6:	e9ee                	sd	s11,208(sp)
    80004fd8:	edf2                	sd	t3,216(sp)
    80004fda:	f1f6                	sd	t4,224(sp)
    80004fdc:	f5fa                	sd	t5,232(sp)
    80004fde:	f9fe                	sd	t6,240(sp)
    80004fe0:	db7fc0ef          	jal	ra,80001d96 <kerneltrap>
    80004fe4:	6082                	ld	ra,0(sp)
    80004fe6:	6122                	ld	sp,8(sp)
    80004fe8:	61c2                	ld	gp,16(sp)
    80004fea:	7282                	ld	t0,32(sp)
    80004fec:	7322                	ld	t1,40(sp)
    80004fee:	73c2                	ld	t2,48(sp)
    80004ff0:	7462                	ld	s0,56(sp)
    80004ff2:	6486                	ld	s1,64(sp)
    80004ff4:	6526                	ld	a0,72(sp)
    80004ff6:	65c6                	ld	a1,80(sp)
    80004ff8:	6666                	ld	a2,88(sp)
    80004ffa:	7686                	ld	a3,96(sp)
    80004ffc:	7726                	ld	a4,104(sp)
    80004ffe:	77c6                	ld	a5,112(sp)
    80005000:	7866                	ld	a6,120(sp)
    80005002:	688a                	ld	a7,128(sp)
    80005004:	692a                	ld	s2,136(sp)
    80005006:	69ca                	ld	s3,144(sp)
    80005008:	6a6a                	ld	s4,152(sp)
    8000500a:	7a8a                	ld	s5,160(sp)
    8000500c:	7b2a                	ld	s6,168(sp)
    8000500e:	7bca                	ld	s7,176(sp)
    80005010:	7c6a                	ld	s8,184(sp)
    80005012:	6c8e                	ld	s9,192(sp)
    80005014:	6d2e                	ld	s10,200(sp)
    80005016:	6dce                	ld	s11,208(sp)
    80005018:	6e6e                	ld	t3,216(sp)
    8000501a:	7e8e                	ld	t4,224(sp)
    8000501c:	7f2e                	ld	t5,232(sp)
    8000501e:	7fce                	ld	t6,240(sp)
    80005020:	6111                	addi	sp,sp,256
    80005022:	10200073          	sret
    80005026:	00000013          	nop
    8000502a:	00000013          	nop
    8000502e:	0001                	nop

0000000080005030 <timervec>:
    80005030:	34051573          	csrrw	a0,mscratch,a0
    80005034:	e10c                	sd	a1,0(a0)
    80005036:	e510                	sd	a2,8(a0)
    80005038:	e914                	sd	a3,16(a0)
    8000503a:	6d0c                	ld	a1,24(a0)
    8000503c:	7110                	ld	a2,32(a0)
    8000503e:	6194                	ld	a3,0(a1)
    80005040:	96b2                	add	a3,a3,a2
    80005042:	e194                	sd	a3,0(a1)
    80005044:	4589                	li	a1,2
    80005046:	14459073          	csrw	sip,a1
    8000504a:	6914                	ld	a3,16(a0)
    8000504c:	6510                	ld	a2,8(a0)
    8000504e:	610c                	ld	a1,0(a0)
    80005050:	34051573          	csrrw	a0,mscratch,a0
    80005054:	30200073          	mret
	...

000000008000505a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000505a:	1141                	addi	sp,sp,-16
    8000505c:	e422                	sd	s0,8(sp)
    8000505e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005060:	0c0007b7          	lui	a5,0xc000
    80005064:	4705                	li	a4,1
    80005066:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005068:	c3d8                	sw	a4,4(a5)
}
    8000506a:	6422                	ld	s0,8(sp)
    8000506c:	0141                	addi	sp,sp,16
    8000506e:	8082                	ret

0000000080005070 <plicinithart>:

void
plicinithart(void)
{
    80005070:	1141                	addi	sp,sp,-16
    80005072:	e406                	sd	ra,8(sp)
    80005074:	e022                	sd	s0,0(sp)
    80005076:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005078:	ffffc097          	auipc	ra,0xffffc
    8000507c:	db4080e7          	jalr	-588(ra) # 80000e2c <cpuid>
  
  // set enable bits for this hart's S-mode
  // for the uart and virtio disk.
  *(uint32*)PLIC_SENABLE(hart) = (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005080:	0085171b          	slliw	a4,a0,0x8
    80005084:	0c0027b7          	lui	a5,0xc002
    80005088:	97ba                	add	a5,a5,a4
    8000508a:	40200713          	li	a4,1026
    8000508e:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005092:	00d5151b          	slliw	a0,a0,0xd
    80005096:	0c2017b7          	lui	a5,0xc201
    8000509a:	953e                	add	a0,a0,a5
    8000509c:	00052023          	sw	zero,0(a0)
}
    800050a0:	60a2                	ld	ra,8(sp)
    800050a2:	6402                	ld	s0,0(sp)
    800050a4:	0141                	addi	sp,sp,16
    800050a6:	8082                	ret

00000000800050a8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800050a8:	1141                	addi	sp,sp,-16
    800050aa:	e406                	sd	ra,8(sp)
    800050ac:	e022                	sd	s0,0(sp)
    800050ae:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800050b0:	ffffc097          	auipc	ra,0xffffc
    800050b4:	d7c080e7          	jalr	-644(ra) # 80000e2c <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800050b8:	00d5179b          	slliw	a5,a0,0xd
    800050bc:	0c201537          	lui	a0,0xc201
    800050c0:	953e                	add	a0,a0,a5
  return irq;
}
    800050c2:	4148                	lw	a0,4(a0)
    800050c4:	60a2                	ld	ra,8(sp)
    800050c6:	6402                	ld	s0,0(sp)
    800050c8:	0141                	addi	sp,sp,16
    800050ca:	8082                	ret

00000000800050cc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800050cc:	1101                	addi	sp,sp,-32
    800050ce:	ec06                	sd	ra,24(sp)
    800050d0:	e822                	sd	s0,16(sp)
    800050d2:	e426                	sd	s1,8(sp)
    800050d4:	1000                	addi	s0,sp,32
    800050d6:	84aa                	mv	s1,a0
  int hart = cpuid();
    800050d8:	ffffc097          	auipc	ra,0xffffc
    800050dc:	d54080e7          	jalr	-684(ra) # 80000e2c <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    800050e0:	00d5151b          	slliw	a0,a0,0xd
    800050e4:	0c2017b7          	lui	a5,0xc201
    800050e8:	97aa                	add	a5,a5,a0
    800050ea:	c3c4                	sw	s1,4(a5)
}
    800050ec:	60e2                	ld	ra,24(sp)
    800050ee:	6442                	ld	s0,16(sp)
    800050f0:	64a2                	ld	s1,8(sp)
    800050f2:	6105                	addi	sp,sp,32
    800050f4:	8082                	ret

00000000800050f6 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    800050f6:	1141                	addi	sp,sp,-16
    800050f8:	e406                	sd	ra,8(sp)
    800050fa:	e022                	sd	s0,0(sp)
    800050fc:	0800                	addi	s0,sp,16
  if(i >= NUM)
    800050fe:	479d                	li	a5,7
    80005100:	04a7cc63          	blt	a5,a0,80005158 <free_desc+0x62>
    panic("free_desc 1");
  if(disk.free[i])
    80005104:	00015797          	auipc	a5,0x15
    80005108:	8ac78793          	addi	a5,a5,-1876 # 800199b0 <disk>
    8000510c:	97aa                	add	a5,a5,a0
    8000510e:	0187c783          	lbu	a5,24(a5)
    80005112:	ebb9                	bnez	a5,80005168 <free_desc+0x72>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005114:	00451613          	slli	a2,a0,0x4
    80005118:	00015797          	auipc	a5,0x15
    8000511c:	89878793          	addi	a5,a5,-1896 # 800199b0 <disk>
    80005120:	6394                	ld	a3,0(a5)
    80005122:	96b2                	add	a3,a3,a2
    80005124:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005128:	6398                	ld	a4,0(a5)
    8000512a:	9732                	add	a4,a4,a2
    8000512c:	00072423          	sw	zero,8(a4)
  disk.desc[i].flags = 0;
    80005130:	00071623          	sh	zero,12(a4)
  disk.desc[i].next = 0;
    80005134:	00071723          	sh	zero,14(a4)
  disk.free[i] = 1;
    80005138:	953e                	add	a0,a0,a5
    8000513a:	4785                	li	a5,1
    8000513c:	00f50c23          	sb	a5,24(a0) # c201018 <_entry-0x73dfefe8>
  wakeup(&disk.free[0]);
    80005140:	00015517          	auipc	a0,0x15
    80005144:	88850513          	addi	a0,a0,-1912 # 800199c8 <disk+0x18>
    80005148:	ffffc097          	auipc	ra,0xffffc
    8000514c:	418080e7          	jalr	1048(ra) # 80001560 <wakeup>
}
    80005150:	60a2                	ld	ra,8(sp)
    80005152:	6402                	ld	s0,0(sp)
    80005154:	0141                	addi	sp,sp,16
    80005156:	8082                	ret
    panic("free_desc 1");
    80005158:	00003517          	auipc	a0,0x3
    8000515c:	56850513          	addi	a0,a0,1384 # 800086c0 <syscalls+0x2f0>
    80005160:	00001097          	auipc	ra,0x1
    80005164:	a72080e7          	jalr	-1422(ra) # 80005bd2 <panic>
    panic("free_desc 2");
    80005168:	00003517          	auipc	a0,0x3
    8000516c:	56850513          	addi	a0,a0,1384 # 800086d0 <syscalls+0x300>
    80005170:	00001097          	auipc	ra,0x1
    80005174:	a62080e7          	jalr	-1438(ra) # 80005bd2 <panic>

0000000080005178 <virtio_disk_init>:
{
    80005178:	1101                	addi	sp,sp,-32
    8000517a:	ec06                	sd	ra,24(sp)
    8000517c:	e822                	sd	s0,16(sp)
    8000517e:	e426                	sd	s1,8(sp)
    80005180:	e04a                	sd	s2,0(sp)
    80005182:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005184:	00003597          	auipc	a1,0x3
    80005188:	55c58593          	addi	a1,a1,1372 # 800086e0 <syscalls+0x310>
    8000518c:	00015517          	auipc	a0,0x15
    80005190:	94c50513          	addi	a0,a0,-1716 # 80019ad8 <disk+0x128>
    80005194:	00001097          	auipc	ra,0x1
    80005198:	ef8080e7          	jalr	-264(ra) # 8000608c <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    8000519c:	100017b7          	lui	a5,0x10001
    800051a0:	4398                	lw	a4,0(a5)
    800051a2:	2701                	sext.w	a4,a4
    800051a4:	747277b7          	lui	a5,0x74727
    800051a8:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800051ac:	14f71e63          	bne	a4,a5,80005308 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800051b0:	100017b7          	lui	a5,0x10001
    800051b4:	43dc                	lw	a5,4(a5)
    800051b6:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800051b8:	4709                	li	a4,2
    800051ba:	14e79763          	bne	a5,a4,80005308 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800051be:	100017b7          	lui	a5,0x10001
    800051c2:	479c                	lw	a5,8(a5)
    800051c4:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 2 ||
    800051c6:	14e79163          	bne	a5,a4,80005308 <virtio_disk_init+0x190>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    800051ca:	100017b7          	lui	a5,0x10001
    800051ce:	47d8                	lw	a4,12(a5)
    800051d0:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    800051d2:	554d47b7          	lui	a5,0x554d4
    800051d6:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    800051da:	12f71763          	bne	a4,a5,80005308 <virtio_disk_init+0x190>
  *R(VIRTIO_MMIO_STATUS) = status;
    800051de:	100017b7          	lui	a5,0x10001
    800051e2:	0607a823          	sw	zero,112(a5) # 10001070 <_entry-0x6fffef90>
  *R(VIRTIO_MMIO_STATUS) = status;
    800051e6:	4705                	li	a4,1
    800051e8:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800051ea:	470d                	li	a4,3
    800051ec:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    800051ee:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    800051f0:	c7ffe737          	lui	a4,0xc7ffe
    800051f4:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fdca2f>
    800051f8:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    800051fa:	2701                	sext.w	a4,a4
    800051fc:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    800051fe:	472d                	li	a4,11
    80005200:	dbb8                	sw	a4,112(a5)
  status = *R(VIRTIO_MMIO_STATUS);
    80005202:	0707a903          	lw	s2,112(a5)
    80005206:	2901                	sext.w	s2,s2
  if(!(status & VIRTIO_CONFIG_S_FEATURES_OK))
    80005208:	00897793          	andi	a5,s2,8
    8000520c:	10078663          	beqz	a5,80005318 <virtio_disk_init+0x1a0>
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005210:	100017b7          	lui	a5,0x10001
    80005214:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  if(*R(VIRTIO_MMIO_QUEUE_READY))
    80005218:	43fc                	lw	a5,68(a5)
    8000521a:	2781                	sext.w	a5,a5
    8000521c:	10079663          	bnez	a5,80005328 <virtio_disk_init+0x1b0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005220:	100017b7          	lui	a5,0x10001
    80005224:	5bdc                	lw	a5,52(a5)
    80005226:	2781                	sext.w	a5,a5
  if(max == 0)
    80005228:	10078863          	beqz	a5,80005338 <virtio_disk_init+0x1c0>
  if(max < NUM)
    8000522c:	471d                	li	a4,7
    8000522e:	10f77d63          	bgeu	a4,a5,80005348 <virtio_disk_init+0x1d0>
  disk.desc = kalloc();
    80005232:	ffffb097          	auipc	ra,0xffffb
    80005236:	ee6080e7          	jalr	-282(ra) # 80000118 <kalloc>
    8000523a:	00014497          	auipc	s1,0x14
    8000523e:	77648493          	addi	s1,s1,1910 # 800199b0 <disk>
    80005242:	e088                	sd	a0,0(s1)
  disk.avail = kalloc();
    80005244:	ffffb097          	auipc	ra,0xffffb
    80005248:	ed4080e7          	jalr	-300(ra) # 80000118 <kalloc>
    8000524c:	e488                	sd	a0,8(s1)
  disk.used = kalloc();
    8000524e:	ffffb097          	auipc	ra,0xffffb
    80005252:	eca080e7          	jalr	-310(ra) # 80000118 <kalloc>
    80005256:	87aa                	mv	a5,a0
    80005258:	e888                	sd	a0,16(s1)
  if(!disk.desc || !disk.avail || !disk.used)
    8000525a:	6088                	ld	a0,0(s1)
    8000525c:	cd75                	beqz	a0,80005358 <virtio_disk_init+0x1e0>
    8000525e:	00014717          	auipc	a4,0x14
    80005262:	75a73703          	ld	a4,1882(a4) # 800199b8 <disk+0x8>
    80005266:	cb6d                	beqz	a4,80005358 <virtio_disk_init+0x1e0>
    80005268:	cbe5                	beqz	a5,80005358 <virtio_disk_init+0x1e0>
  memset(disk.desc, 0, PGSIZE);
    8000526a:	6605                	lui	a2,0x1
    8000526c:	4581                	li	a1,0
    8000526e:	ffffb097          	auipc	ra,0xffffb
    80005272:	f0a080e7          	jalr	-246(ra) # 80000178 <memset>
  memset(disk.avail, 0, PGSIZE);
    80005276:	00014497          	auipc	s1,0x14
    8000527a:	73a48493          	addi	s1,s1,1850 # 800199b0 <disk>
    8000527e:	6605                	lui	a2,0x1
    80005280:	4581                	li	a1,0
    80005282:	6488                	ld	a0,8(s1)
    80005284:	ffffb097          	auipc	ra,0xffffb
    80005288:	ef4080e7          	jalr	-268(ra) # 80000178 <memset>
  memset(disk.used, 0, PGSIZE);
    8000528c:	6605                	lui	a2,0x1
    8000528e:	4581                	li	a1,0
    80005290:	6888                	ld	a0,16(s1)
    80005292:	ffffb097          	auipc	ra,0xffffb
    80005296:	ee6080e7          	jalr	-282(ra) # 80000178 <memset>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    8000529a:	100017b7          	lui	a5,0x10001
    8000529e:	4721                	li	a4,8
    800052a0:	df98                	sw	a4,56(a5)
  *R(VIRTIO_MMIO_QUEUE_DESC_LOW) = (uint64)disk.desc;
    800052a2:	4098                	lw	a4,0(s1)
    800052a4:	08e7a023          	sw	a4,128(a5) # 10001080 <_entry-0x6fffef80>
  *R(VIRTIO_MMIO_QUEUE_DESC_HIGH) = (uint64)disk.desc >> 32;
    800052a8:	40d8                	lw	a4,4(s1)
    800052aa:	08e7a223          	sw	a4,132(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_LOW) = (uint64)disk.avail;
    800052ae:	6498                	ld	a4,8(s1)
    800052b0:	0007069b          	sext.w	a3,a4
    800052b4:	08d7a823          	sw	a3,144(a5)
  *R(VIRTIO_MMIO_DRIVER_DESC_HIGH) = (uint64)disk.avail >> 32;
    800052b8:	9701                	srai	a4,a4,0x20
    800052ba:	08e7aa23          	sw	a4,148(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_LOW) = (uint64)disk.used;
    800052be:	6898                	ld	a4,16(s1)
    800052c0:	0007069b          	sext.w	a3,a4
    800052c4:	0ad7a023          	sw	a3,160(a5)
  *R(VIRTIO_MMIO_DEVICE_DESC_HIGH) = (uint64)disk.used >> 32;
    800052c8:	9701                	srai	a4,a4,0x20
    800052ca:	0ae7a223          	sw	a4,164(a5)
  *R(VIRTIO_MMIO_QUEUE_READY) = 0x1;
    800052ce:	4685                	li	a3,1
    800052d0:	c3f4                	sw	a3,68(a5)
    disk.free[i] = 1;
    800052d2:	4705                	li	a4,1
    800052d4:	00d48c23          	sb	a3,24(s1)
    800052d8:	00e48ca3          	sb	a4,25(s1)
    800052dc:	00e48d23          	sb	a4,26(s1)
    800052e0:	00e48da3          	sb	a4,27(s1)
    800052e4:	00e48e23          	sb	a4,28(s1)
    800052e8:	00e48ea3          	sb	a4,29(s1)
    800052ec:	00e48f23          	sb	a4,30(s1)
    800052f0:	00e48fa3          	sb	a4,31(s1)
  status |= VIRTIO_CONFIG_S_DRIVER_OK;
    800052f4:	00496913          	ori	s2,s2,4
  *R(VIRTIO_MMIO_STATUS) = status;
    800052f8:	0727a823          	sw	s2,112(a5)
}
    800052fc:	60e2                	ld	ra,24(sp)
    800052fe:	6442                	ld	s0,16(sp)
    80005300:	64a2                	ld	s1,8(sp)
    80005302:	6902                	ld	s2,0(sp)
    80005304:	6105                	addi	sp,sp,32
    80005306:	8082                	ret
    panic("could not find virtio disk");
    80005308:	00003517          	auipc	a0,0x3
    8000530c:	3e850513          	addi	a0,a0,1000 # 800086f0 <syscalls+0x320>
    80005310:	00001097          	auipc	ra,0x1
    80005314:	8c2080e7          	jalr	-1854(ra) # 80005bd2 <panic>
    panic("virtio disk FEATURES_OK unset");
    80005318:	00003517          	auipc	a0,0x3
    8000531c:	3f850513          	addi	a0,a0,1016 # 80008710 <syscalls+0x340>
    80005320:	00001097          	auipc	ra,0x1
    80005324:	8b2080e7          	jalr	-1870(ra) # 80005bd2 <panic>
    panic("virtio disk should not be ready");
    80005328:	00003517          	auipc	a0,0x3
    8000532c:	40850513          	addi	a0,a0,1032 # 80008730 <syscalls+0x360>
    80005330:	00001097          	auipc	ra,0x1
    80005334:	8a2080e7          	jalr	-1886(ra) # 80005bd2 <panic>
    panic("virtio disk has no queue 0");
    80005338:	00003517          	auipc	a0,0x3
    8000533c:	41850513          	addi	a0,a0,1048 # 80008750 <syscalls+0x380>
    80005340:	00001097          	auipc	ra,0x1
    80005344:	892080e7          	jalr	-1902(ra) # 80005bd2 <panic>
    panic("virtio disk max queue too short");
    80005348:	00003517          	auipc	a0,0x3
    8000534c:	42850513          	addi	a0,a0,1064 # 80008770 <syscalls+0x3a0>
    80005350:	00001097          	auipc	ra,0x1
    80005354:	882080e7          	jalr	-1918(ra) # 80005bd2 <panic>
    panic("virtio disk kalloc");
    80005358:	00003517          	auipc	a0,0x3
    8000535c:	43850513          	addi	a0,a0,1080 # 80008790 <syscalls+0x3c0>
    80005360:	00001097          	auipc	ra,0x1
    80005364:	872080e7          	jalr	-1934(ra) # 80005bd2 <panic>

0000000080005368 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005368:	7159                	addi	sp,sp,-112
    8000536a:	f486                	sd	ra,104(sp)
    8000536c:	f0a2                	sd	s0,96(sp)
    8000536e:	eca6                	sd	s1,88(sp)
    80005370:	e8ca                	sd	s2,80(sp)
    80005372:	e4ce                	sd	s3,72(sp)
    80005374:	e0d2                	sd	s4,64(sp)
    80005376:	fc56                	sd	s5,56(sp)
    80005378:	f85a                	sd	s6,48(sp)
    8000537a:	f45e                	sd	s7,40(sp)
    8000537c:	f062                	sd	s8,32(sp)
    8000537e:	ec66                	sd	s9,24(sp)
    80005380:	e86a                	sd	s10,16(sp)
    80005382:	1880                	addi	s0,sp,112
    80005384:	892a                	mv	s2,a0
    80005386:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005388:	00c52c83          	lw	s9,12(a0)
    8000538c:	001c9c9b          	slliw	s9,s9,0x1
    80005390:	1c82                	slli	s9,s9,0x20
    80005392:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005396:	00014517          	auipc	a0,0x14
    8000539a:	74250513          	addi	a0,a0,1858 # 80019ad8 <disk+0x128>
    8000539e:	00001097          	auipc	ra,0x1
    800053a2:	d7e080e7          	jalr	-642(ra) # 8000611c <acquire>
  for(int i = 0; i < 3; i++){
    800053a6:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    800053a8:	4ba1                	li	s7,8
      disk.free[i] = 0;
    800053aa:	00014b17          	auipc	s6,0x14
    800053ae:	606b0b13          	addi	s6,s6,1542 # 800199b0 <disk>
  for(int i = 0; i < 3; i++){
    800053b2:	4a8d                	li	s5,3
  for(int i = 0; i < NUM; i++){
    800053b4:	8a4e                	mv	s4,s3
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800053b6:	00014c17          	auipc	s8,0x14
    800053ba:	722c0c13          	addi	s8,s8,1826 # 80019ad8 <disk+0x128>
    800053be:	a8b5                	j	8000543a <virtio_disk_rw+0xd2>
      disk.free[i] = 0;
    800053c0:	00fb06b3          	add	a3,s6,a5
    800053c4:	00068c23          	sb	zero,24(a3)
    idx[i] = alloc_desc();
    800053c8:	c21c                	sw	a5,0(a2)
    if(idx[i] < 0){
    800053ca:	0207c563          	bltz	a5,800053f4 <virtio_disk_rw+0x8c>
  for(int i = 0; i < 3; i++){
    800053ce:	2485                	addiw	s1,s1,1
    800053d0:	0711                	addi	a4,a4,4
    800053d2:	1f548a63          	beq	s1,s5,800055c6 <virtio_disk_rw+0x25e>
    idx[i] = alloc_desc();
    800053d6:	863a                	mv	a2,a4
  for(int i = 0; i < NUM; i++){
    800053d8:	00014697          	auipc	a3,0x14
    800053dc:	5d868693          	addi	a3,a3,1496 # 800199b0 <disk>
    800053e0:	87d2                	mv	a5,s4
    if(disk.free[i]){
    800053e2:	0186c583          	lbu	a1,24(a3)
    800053e6:	fde9                	bnez	a1,800053c0 <virtio_disk_rw+0x58>
  for(int i = 0; i < NUM; i++){
    800053e8:	2785                	addiw	a5,a5,1
    800053ea:	0685                	addi	a3,a3,1
    800053ec:	ff779be3          	bne	a5,s7,800053e2 <virtio_disk_rw+0x7a>
    idx[i] = alloc_desc();
    800053f0:	57fd                	li	a5,-1
    800053f2:	c21c                	sw	a5,0(a2)
      for(int j = 0; j < i; j++)
    800053f4:	02905a63          	blez	s1,80005428 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    800053f8:	f9042503          	lw	a0,-112(s0)
    800053fc:	00000097          	auipc	ra,0x0
    80005400:	cfa080e7          	jalr	-774(ra) # 800050f6 <free_desc>
      for(int j = 0; j < i; j++)
    80005404:	4785                	li	a5,1
    80005406:	0297d163          	bge	a5,s1,80005428 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    8000540a:	f9442503          	lw	a0,-108(s0)
    8000540e:	00000097          	auipc	ra,0x0
    80005412:	ce8080e7          	jalr	-792(ra) # 800050f6 <free_desc>
      for(int j = 0; j < i; j++)
    80005416:	4789                	li	a5,2
    80005418:	0097d863          	bge	a5,s1,80005428 <virtio_disk_rw+0xc0>
        free_desc(idx[j]);
    8000541c:	f9842503          	lw	a0,-104(s0)
    80005420:	00000097          	auipc	ra,0x0
    80005424:	cd6080e7          	jalr	-810(ra) # 800050f6 <free_desc>
    sleep(&disk.free[0], &disk.vdisk_lock);
    80005428:	85e2                	mv	a1,s8
    8000542a:	00014517          	auipc	a0,0x14
    8000542e:	59e50513          	addi	a0,a0,1438 # 800199c8 <disk+0x18>
    80005432:	ffffc097          	auipc	ra,0xffffc
    80005436:	0ca080e7          	jalr	202(ra) # 800014fc <sleep>
  for(int i = 0; i < 3; i++){
    8000543a:	f9040713          	addi	a4,s0,-112
    8000543e:	84ce                	mv	s1,s3
    80005440:	bf59                	j	800053d6 <virtio_disk_rw+0x6e>
  // qemu's virtio-blk.c reads them.

  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];

  if(write)
    buf0->type = VIRTIO_BLK_T_OUT; // write the disk
    80005442:	00a60793          	addi	a5,a2,10 # 100a <_entry-0x7fffeff6>
    80005446:	00479693          	slli	a3,a5,0x4
    8000544a:	00014797          	auipc	a5,0x14
    8000544e:	56678793          	addi	a5,a5,1382 # 800199b0 <disk>
    80005452:	97b6                	add	a5,a5,a3
    80005454:	4685                	li	a3,1
    80005456:	c794                	sw	a3,8(a5)
  else
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
  buf0->reserved = 0;
    80005458:	00014597          	auipc	a1,0x14
    8000545c:	55858593          	addi	a1,a1,1368 # 800199b0 <disk>
    80005460:	00a60793          	addi	a5,a2,10
    80005464:	0792                	slli	a5,a5,0x4
    80005466:	97ae                	add	a5,a5,a1
    80005468:	0007a623          	sw	zero,12(a5)
  buf0->sector = sector;
    8000546c:	0197b823          	sd	s9,16(a5)

  disk.desc[idx[0]].addr = (uint64) buf0;
    80005470:	f6070693          	addi	a3,a4,-160
    80005474:	619c                	ld	a5,0(a1)
    80005476:	97b6                	add	a5,a5,a3
    80005478:	e388                	sd	a0,0(a5)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000547a:	6188                	ld	a0,0(a1)
    8000547c:	96aa                	add	a3,a3,a0
    8000547e:	47c1                	li	a5,16
    80005480:	c69c                	sw	a5,8(a3)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005482:	4785                	li	a5,1
    80005484:	00f69623          	sh	a5,12(a3)
  disk.desc[idx[0]].next = idx[1];
    80005488:	f9442783          	lw	a5,-108(s0)
    8000548c:	00f69723          	sh	a5,14(a3)

  disk.desc[idx[1]].addr = (uint64) b->data;
    80005490:	0792                	slli	a5,a5,0x4
    80005492:	953e                	add	a0,a0,a5
    80005494:	05890693          	addi	a3,s2,88
    80005498:	e114                	sd	a3,0(a0)
  disk.desc[idx[1]].len = BSIZE;
    8000549a:	6188                	ld	a0,0(a1)
    8000549c:	97aa                	add	a5,a5,a0
    8000549e:	40000693          	li	a3,1024
    800054a2:	c794                	sw	a3,8(a5)
  if(write)
    800054a4:	100d0d63          	beqz	s10,800055be <virtio_disk_rw+0x256>
    disk.desc[idx[1]].flags = 0; // device reads b->data
    800054a8:	00079623          	sh	zero,12(a5)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800054ac:	00c7d683          	lhu	a3,12(a5)
    800054b0:	0016e693          	ori	a3,a3,1
    800054b4:	00d79623          	sh	a3,12(a5)
  disk.desc[idx[1]].next = idx[2];
    800054b8:	f9842583          	lw	a1,-104(s0)
    800054bc:	00b79723          	sh	a1,14(a5)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    800054c0:	00014697          	auipc	a3,0x14
    800054c4:	4f068693          	addi	a3,a3,1264 # 800199b0 <disk>
    800054c8:	00260793          	addi	a5,a2,2
    800054cc:	0792                	slli	a5,a5,0x4
    800054ce:	97b6                	add	a5,a5,a3
    800054d0:	587d                	li	a6,-1
    800054d2:	01078823          	sb	a6,16(a5)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    800054d6:	0592                	slli	a1,a1,0x4
    800054d8:	952e                	add	a0,a0,a1
    800054da:	f9070713          	addi	a4,a4,-112
    800054de:	9736                	add	a4,a4,a3
    800054e0:	e118                	sd	a4,0(a0)
  disk.desc[idx[2]].len = 1;
    800054e2:	6298                	ld	a4,0(a3)
    800054e4:	972e                	add	a4,a4,a1
    800054e6:	4585                	li	a1,1
    800054e8:	c70c                	sw	a1,8(a4)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    800054ea:	4509                	li	a0,2
    800054ec:	00a71623          	sh	a0,12(a4)
  disk.desc[idx[2]].next = 0;
    800054f0:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    800054f4:	00b92223          	sw	a1,4(s2)
  disk.info[idx[0]].b = b;
    800054f8:	0127b423          	sd	s2,8(a5)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    800054fc:	6698                	ld	a4,8(a3)
    800054fe:	00275783          	lhu	a5,2(a4)
    80005502:	8b9d                	andi	a5,a5,7
    80005504:	0786                	slli	a5,a5,0x1
    80005506:	97ba                	add	a5,a5,a4
    80005508:	00c79223          	sh	a2,4(a5)

  __sync_synchronize();
    8000550c:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005510:	6698                	ld	a4,8(a3)
    80005512:	00275783          	lhu	a5,2(a4)
    80005516:	2785                	addiw	a5,a5,1
    80005518:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    8000551c:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005520:	100017b7          	lui	a5,0x10001
    80005524:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    80005528:	00492703          	lw	a4,4(s2)
    8000552c:	4785                	li	a5,1
    8000552e:	02f71163          	bne	a4,a5,80005550 <virtio_disk_rw+0x1e8>
    sleep(b, &disk.vdisk_lock);
    80005532:	00014997          	auipc	s3,0x14
    80005536:	5a698993          	addi	s3,s3,1446 # 80019ad8 <disk+0x128>
  while(b->disk == 1) {
    8000553a:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    8000553c:	85ce                	mv	a1,s3
    8000553e:	854a                	mv	a0,s2
    80005540:	ffffc097          	auipc	ra,0xffffc
    80005544:	fbc080e7          	jalr	-68(ra) # 800014fc <sleep>
  while(b->disk == 1) {
    80005548:	00492783          	lw	a5,4(s2)
    8000554c:	fe9788e3          	beq	a5,s1,8000553c <virtio_disk_rw+0x1d4>
  }

  disk.info[idx[0]].b = 0;
    80005550:	f9042903          	lw	s2,-112(s0)
    80005554:	00290793          	addi	a5,s2,2
    80005558:	00479713          	slli	a4,a5,0x4
    8000555c:	00014797          	auipc	a5,0x14
    80005560:	45478793          	addi	a5,a5,1108 # 800199b0 <disk>
    80005564:	97ba                	add	a5,a5,a4
    80005566:	0007b423          	sd	zero,8(a5)
    int flag = disk.desc[i].flags;
    8000556a:	00014997          	auipc	s3,0x14
    8000556e:	44698993          	addi	s3,s3,1094 # 800199b0 <disk>
    80005572:	00491713          	slli	a4,s2,0x4
    80005576:	0009b783          	ld	a5,0(s3)
    8000557a:	97ba                	add	a5,a5,a4
    8000557c:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80005580:	854a                	mv	a0,s2
    80005582:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80005586:	00000097          	auipc	ra,0x0
    8000558a:	b70080e7          	jalr	-1168(ra) # 800050f6 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    8000558e:	8885                	andi	s1,s1,1
    80005590:	f0ed                	bnez	s1,80005572 <virtio_disk_rw+0x20a>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80005592:	00014517          	auipc	a0,0x14
    80005596:	54650513          	addi	a0,a0,1350 # 80019ad8 <disk+0x128>
    8000559a:	00001097          	auipc	ra,0x1
    8000559e:	c36080e7          	jalr	-970(ra) # 800061d0 <release>
}
    800055a2:	70a6                	ld	ra,104(sp)
    800055a4:	7406                	ld	s0,96(sp)
    800055a6:	64e6                	ld	s1,88(sp)
    800055a8:	6946                	ld	s2,80(sp)
    800055aa:	69a6                	ld	s3,72(sp)
    800055ac:	6a06                	ld	s4,64(sp)
    800055ae:	7ae2                	ld	s5,56(sp)
    800055b0:	7b42                	ld	s6,48(sp)
    800055b2:	7ba2                	ld	s7,40(sp)
    800055b4:	7c02                	ld	s8,32(sp)
    800055b6:	6ce2                	ld	s9,24(sp)
    800055b8:	6d42                	ld	s10,16(sp)
    800055ba:	6165                	addi	sp,sp,112
    800055bc:	8082                	ret
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800055be:	4689                	li	a3,2
    800055c0:	00d79623          	sh	a3,12(a5)
    800055c4:	b5e5                	j	800054ac <virtio_disk_rw+0x144>
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    800055c6:	f9042603          	lw	a2,-112(s0)
    800055ca:	00a60713          	addi	a4,a2,10
    800055ce:	0712                	slli	a4,a4,0x4
    800055d0:	00014517          	auipc	a0,0x14
    800055d4:	3e850513          	addi	a0,a0,1000 # 800199b8 <disk+0x8>
    800055d8:	953a                	add	a0,a0,a4
  if(write)
    800055da:	e60d14e3          	bnez	s10,80005442 <virtio_disk_rw+0xda>
    buf0->type = VIRTIO_BLK_T_IN; // read the disk
    800055de:	00a60793          	addi	a5,a2,10
    800055e2:	00479693          	slli	a3,a5,0x4
    800055e6:	00014797          	auipc	a5,0x14
    800055ea:	3ca78793          	addi	a5,a5,970 # 800199b0 <disk>
    800055ee:	97b6                	add	a5,a5,a3
    800055f0:	0007a423          	sw	zero,8(a5)
    800055f4:	b595                	j	80005458 <virtio_disk_rw+0xf0>

00000000800055f6 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800055f6:	1101                	addi	sp,sp,-32
    800055f8:	ec06                	sd	ra,24(sp)
    800055fa:	e822                	sd	s0,16(sp)
    800055fc:	e426                	sd	s1,8(sp)
    800055fe:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005600:	00014497          	auipc	s1,0x14
    80005604:	3b048493          	addi	s1,s1,944 # 800199b0 <disk>
    80005608:	00014517          	auipc	a0,0x14
    8000560c:	4d050513          	addi	a0,a0,1232 # 80019ad8 <disk+0x128>
    80005610:	00001097          	auipc	ra,0x1
    80005614:	b0c080e7          	jalr	-1268(ra) # 8000611c <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    80005618:	10001737          	lui	a4,0x10001
    8000561c:	533c                	lw	a5,96(a4)
    8000561e:	8b8d                	andi	a5,a5,3
    80005620:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    80005622:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    80005626:	689c                	ld	a5,16(s1)
    80005628:	0204d703          	lhu	a4,32(s1)
    8000562c:	0027d783          	lhu	a5,2(a5)
    80005630:	04f70863          	beq	a4,a5,80005680 <virtio_disk_intr+0x8a>
    __sync_synchronize();
    80005634:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    80005638:	6898                	ld	a4,16(s1)
    8000563a:	0204d783          	lhu	a5,32(s1)
    8000563e:	8b9d                	andi	a5,a5,7
    80005640:	078e                	slli	a5,a5,0x3
    80005642:	97ba                	add	a5,a5,a4
    80005644:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    80005646:	00278713          	addi	a4,a5,2
    8000564a:	0712                	slli	a4,a4,0x4
    8000564c:	9726                	add	a4,a4,s1
    8000564e:	01074703          	lbu	a4,16(a4) # 10001010 <_entry-0x6fffeff0>
    80005652:	e721                	bnez	a4,8000569a <virtio_disk_intr+0xa4>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    80005654:	0789                	addi	a5,a5,2
    80005656:	0792                	slli	a5,a5,0x4
    80005658:	97a6                	add	a5,a5,s1
    8000565a:	6788                	ld	a0,8(a5)
    b->disk = 0;   // disk is done with buf
    8000565c:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005660:	ffffc097          	auipc	ra,0xffffc
    80005664:	f00080e7          	jalr	-256(ra) # 80001560 <wakeup>

    disk.used_idx += 1;
    80005668:	0204d783          	lhu	a5,32(s1)
    8000566c:	2785                	addiw	a5,a5,1
    8000566e:	17c2                	slli	a5,a5,0x30
    80005670:	93c1                	srli	a5,a5,0x30
    80005672:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    80005676:	6898                	ld	a4,16(s1)
    80005678:	00275703          	lhu	a4,2(a4)
    8000567c:	faf71ce3          	bne	a4,a5,80005634 <virtio_disk_intr+0x3e>
  }

  release(&disk.vdisk_lock);
    80005680:	00014517          	auipc	a0,0x14
    80005684:	45850513          	addi	a0,a0,1112 # 80019ad8 <disk+0x128>
    80005688:	00001097          	auipc	ra,0x1
    8000568c:	b48080e7          	jalr	-1208(ra) # 800061d0 <release>
}
    80005690:	60e2                	ld	ra,24(sp)
    80005692:	6442                	ld	s0,16(sp)
    80005694:	64a2                	ld	s1,8(sp)
    80005696:	6105                	addi	sp,sp,32
    80005698:	8082                	ret
      panic("virtio_disk_intr status");
    8000569a:	00003517          	auipc	a0,0x3
    8000569e:	10e50513          	addi	a0,a0,270 # 800087a8 <syscalls+0x3d8>
    800056a2:	00000097          	auipc	ra,0x0
    800056a6:	530080e7          	jalr	1328(ra) # 80005bd2 <panic>

00000000800056aa <timerinit>:
// at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    800056aa:	1141                	addi	sp,sp,-16
    800056ac:	e422                	sd	s0,8(sp)
    800056ae:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800056b0:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    800056b4:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    800056b8:	0037979b          	slliw	a5,a5,0x3
    800056bc:	02004737          	lui	a4,0x2004
    800056c0:	97ba                	add	a5,a5,a4
    800056c2:	0200c737          	lui	a4,0x200c
    800056c6:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    800056ca:	000f4637          	lui	a2,0xf4
    800056ce:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    800056d2:	95b2                	add	a1,a1,a2
    800056d4:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    800056d6:	00269713          	slli	a4,a3,0x2
    800056da:	9736                	add	a4,a4,a3
    800056dc:	00371693          	slli	a3,a4,0x3
    800056e0:	00014717          	auipc	a4,0x14
    800056e4:	41070713          	addi	a4,a4,1040 # 80019af0 <timer_scratch>
    800056e8:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    800056ea:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    800056ec:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    800056ee:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    800056f2:	00000797          	auipc	a5,0x0
    800056f6:	93e78793          	addi	a5,a5,-1730 # 80005030 <timervec>
    800056fa:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800056fe:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80005702:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005706:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000570a:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    8000570e:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80005712:	30479073          	csrw	mie,a5
}
    80005716:	6422                	ld	s0,8(sp)
    80005718:	0141                	addi	sp,sp,16
    8000571a:	8082                	ret

000000008000571c <start>:
{
    8000571c:	1141                	addi	sp,sp,-16
    8000571e:	e406                	sd	ra,8(sp)
    80005720:	e022                	sd	s0,0(sp)
    80005722:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80005724:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    80005728:	7779                	lui	a4,0xffffe
    8000572a:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffdcacf>
    8000572e:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    80005730:	6705                	lui	a4,0x1
    80005732:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    80005736:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80005738:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    8000573c:	ffffb797          	auipc	a5,0xffffb
    80005740:	bea78793          	addi	a5,a5,-1046 # 80000326 <main>
    80005744:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    80005748:	4781                	li	a5,0
    8000574a:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    8000574e:	67c1                	lui	a5,0x10
    80005750:	17fd                	addi	a5,a5,-1
    80005752:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    80005756:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    8000575a:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    8000575e:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005762:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    80005766:	57fd                	li	a5,-1
    80005768:	83a9                	srli	a5,a5,0xa
    8000576a:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    8000576e:	47bd                	li	a5,15
    80005770:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    80005774:	00000097          	auipc	ra,0x0
    80005778:	f36080e7          	jalr	-202(ra) # 800056aa <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    8000577c:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005780:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005782:	823e                	mv	tp,a5
  asm volatile("mret");
    80005784:	30200073          	mret
}
    80005788:	60a2                	ld	ra,8(sp)
    8000578a:	6402                	ld	s0,0(sp)
    8000578c:	0141                	addi	sp,sp,16
    8000578e:	8082                	ret

0000000080005790 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005790:	715d                	addi	sp,sp,-80
    80005792:	e486                	sd	ra,72(sp)
    80005794:	e0a2                	sd	s0,64(sp)
    80005796:	fc26                	sd	s1,56(sp)
    80005798:	f84a                	sd	s2,48(sp)
    8000579a:	f44e                	sd	s3,40(sp)
    8000579c:	f052                	sd	s4,32(sp)
    8000579e:	ec56                	sd	s5,24(sp)
    800057a0:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    800057a2:	04c05663          	blez	a2,800057ee <consolewrite+0x5e>
    800057a6:	8a2a                	mv	s4,a0
    800057a8:	84ae                	mv	s1,a1
    800057aa:	89b2                	mv	s3,a2
    800057ac:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    800057ae:	5afd                	li	s5,-1
    800057b0:	4685                	li	a3,1
    800057b2:	8626                	mv	a2,s1
    800057b4:	85d2                	mv	a1,s4
    800057b6:	fbf40513          	addi	a0,s0,-65
    800057ba:	ffffc097          	auipc	ra,0xffffc
    800057be:	1a0080e7          	jalr	416(ra) # 8000195a <either_copyin>
    800057c2:	01550c63          	beq	a0,s5,800057da <consolewrite+0x4a>
      break;
    uartputc(c);
    800057c6:	fbf44503          	lbu	a0,-65(s0)
    800057ca:	00000097          	auipc	ra,0x0
    800057ce:	794080e7          	jalr	1940(ra) # 80005f5e <uartputc>
  for(i = 0; i < n; i++){
    800057d2:	2905                	addiw	s2,s2,1
    800057d4:	0485                	addi	s1,s1,1
    800057d6:	fd299de3          	bne	s3,s2,800057b0 <consolewrite+0x20>
  }

  return i;
}
    800057da:	854a                	mv	a0,s2
    800057dc:	60a6                	ld	ra,72(sp)
    800057de:	6406                	ld	s0,64(sp)
    800057e0:	74e2                	ld	s1,56(sp)
    800057e2:	7942                	ld	s2,48(sp)
    800057e4:	79a2                	ld	s3,40(sp)
    800057e6:	7a02                	ld	s4,32(sp)
    800057e8:	6ae2                	ld	s5,24(sp)
    800057ea:	6161                	addi	sp,sp,80
    800057ec:	8082                	ret
  for(i = 0; i < n; i++){
    800057ee:	4901                	li	s2,0
    800057f0:	b7ed                	j	800057da <consolewrite+0x4a>

00000000800057f2 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    800057f2:	7119                	addi	sp,sp,-128
    800057f4:	fc86                	sd	ra,120(sp)
    800057f6:	f8a2                	sd	s0,112(sp)
    800057f8:	f4a6                	sd	s1,104(sp)
    800057fa:	f0ca                	sd	s2,96(sp)
    800057fc:	ecce                	sd	s3,88(sp)
    800057fe:	e8d2                	sd	s4,80(sp)
    80005800:	e4d6                	sd	s5,72(sp)
    80005802:	e0da                	sd	s6,64(sp)
    80005804:	fc5e                	sd	s7,56(sp)
    80005806:	f862                	sd	s8,48(sp)
    80005808:	f466                	sd	s9,40(sp)
    8000580a:	f06a                	sd	s10,32(sp)
    8000580c:	ec6e                	sd	s11,24(sp)
    8000580e:	0100                	addi	s0,sp,128
    80005810:	8b2a                	mv	s6,a0
    80005812:	8aae                	mv	s5,a1
    80005814:	8a32                	mv	s4,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80005816:	00060b9b          	sext.w	s7,a2
  acquire(&cons.lock);
    8000581a:	0001c517          	auipc	a0,0x1c
    8000581e:	41650513          	addi	a0,a0,1046 # 80021c30 <cons>
    80005822:	00001097          	auipc	ra,0x1
    80005826:	8fa080e7          	jalr	-1798(ra) # 8000611c <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    8000582a:	0001c497          	auipc	s1,0x1c
    8000582e:	40648493          	addi	s1,s1,1030 # 80021c30 <cons>
      if(killed(myproc())){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    80005832:	89a6                	mv	s3,s1
    80005834:	0001c917          	auipc	s2,0x1c
    80005838:	49490913          	addi	s2,s2,1172 # 80021cc8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];

    if(c == C('D')){  // end-of-file
    8000583c:	4c91                	li	s9,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000583e:	5d7d                	li	s10,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    80005840:	4da9                	li	s11,10
  while(n > 0){
    80005842:	07405b63          	blez	s4,800058b8 <consoleread+0xc6>
    while(cons.r == cons.w){
    80005846:	0984a783          	lw	a5,152(s1)
    8000584a:	09c4a703          	lw	a4,156(s1)
    8000584e:	02f71763          	bne	a4,a5,8000587c <consoleread+0x8a>
      if(killed(myproc())){
    80005852:	ffffb097          	auipc	ra,0xffffb
    80005856:	606080e7          	jalr	1542(ra) # 80000e58 <myproc>
    8000585a:	ffffc097          	auipc	ra,0xffffc
    8000585e:	f4a080e7          	jalr	-182(ra) # 800017a4 <killed>
    80005862:	e535                	bnez	a0,800058ce <consoleread+0xdc>
      sleep(&cons.r, &cons.lock);
    80005864:	85ce                	mv	a1,s3
    80005866:	854a                	mv	a0,s2
    80005868:	ffffc097          	auipc	ra,0xffffc
    8000586c:	c94080e7          	jalr	-876(ra) # 800014fc <sleep>
    while(cons.r == cons.w){
    80005870:	0984a783          	lw	a5,152(s1)
    80005874:	09c4a703          	lw	a4,156(s1)
    80005878:	fcf70de3          	beq	a4,a5,80005852 <consoleread+0x60>
    c = cons.buf[cons.r++ % INPUT_BUF_SIZE];
    8000587c:	0017871b          	addiw	a4,a5,1
    80005880:	08e4ac23          	sw	a4,152(s1)
    80005884:	07f7f713          	andi	a4,a5,127
    80005888:	9726                	add	a4,a4,s1
    8000588a:	01874703          	lbu	a4,24(a4)
    8000588e:	00070c1b          	sext.w	s8,a4
    if(c == C('D')){  // end-of-file
    80005892:	079c0663          	beq	s8,s9,800058fe <consoleread+0x10c>
    cbuf = c;
    80005896:	f8e407a3          	sb	a4,-113(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    8000589a:	4685                	li	a3,1
    8000589c:	f8f40613          	addi	a2,s0,-113
    800058a0:	85d6                	mv	a1,s5
    800058a2:	855a                	mv	a0,s6
    800058a4:	ffffc097          	auipc	ra,0xffffc
    800058a8:	060080e7          	jalr	96(ra) # 80001904 <either_copyout>
    800058ac:	01a50663          	beq	a0,s10,800058b8 <consoleread+0xc6>
    dst++;
    800058b0:	0a85                	addi	s5,s5,1
    --n;
    800058b2:	3a7d                	addiw	s4,s4,-1
    if(c == '\n'){
    800058b4:	f9bc17e3          	bne	s8,s11,80005842 <consoleread+0x50>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    800058b8:	0001c517          	auipc	a0,0x1c
    800058bc:	37850513          	addi	a0,a0,888 # 80021c30 <cons>
    800058c0:	00001097          	auipc	ra,0x1
    800058c4:	910080e7          	jalr	-1776(ra) # 800061d0 <release>

  return target - n;
    800058c8:	414b853b          	subw	a0,s7,s4
    800058cc:	a811                	j	800058e0 <consoleread+0xee>
        release(&cons.lock);
    800058ce:	0001c517          	auipc	a0,0x1c
    800058d2:	36250513          	addi	a0,a0,866 # 80021c30 <cons>
    800058d6:	00001097          	auipc	ra,0x1
    800058da:	8fa080e7          	jalr	-1798(ra) # 800061d0 <release>
        return -1;
    800058de:	557d                	li	a0,-1
}
    800058e0:	70e6                	ld	ra,120(sp)
    800058e2:	7446                	ld	s0,112(sp)
    800058e4:	74a6                	ld	s1,104(sp)
    800058e6:	7906                	ld	s2,96(sp)
    800058e8:	69e6                	ld	s3,88(sp)
    800058ea:	6a46                	ld	s4,80(sp)
    800058ec:	6aa6                	ld	s5,72(sp)
    800058ee:	6b06                	ld	s6,64(sp)
    800058f0:	7be2                	ld	s7,56(sp)
    800058f2:	7c42                	ld	s8,48(sp)
    800058f4:	7ca2                	ld	s9,40(sp)
    800058f6:	7d02                	ld	s10,32(sp)
    800058f8:	6de2                	ld	s11,24(sp)
    800058fa:	6109                	addi	sp,sp,128
    800058fc:	8082                	ret
      if(n < target){
    800058fe:	000a071b          	sext.w	a4,s4
    80005902:	fb777be3          	bgeu	a4,s7,800058b8 <consoleread+0xc6>
        cons.r--;
    80005906:	0001c717          	auipc	a4,0x1c
    8000590a:	3cf72123          	sw	a5,962(a4) # 80021cc8 <cons+0x98>
    8000590e:	b76d                	j	800058b8 <consoleread+0xc6>

0000000080005910 <consputc>:
{
    80005910:	1141                	addi	sp,sp,-16
    80005912:	e406                	sd	ra,8(sp)
    80005914:	e022                	sd	s0,0(sp)
    80005916:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    80005918:	10000793          	li	a5,256
    8000591c:	00f50a63          	beq	a0,a5,80005930 <consputc+0x20>
    uartputc_sync(c);
    80005920:	00000097          	auipc	ra,0x0
    80005924:	564080e7          	jalr	1380(ra) # 80005e84 <uartputc_sync>
}
    80005928:	60a2                	ld	ra,8(sp)
    8000592a:	6402                	ld	s0,0(sp)
    8000592c:	0141                	addi	sp,sp,16
    8000592e:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80005930:	4521                	li	a0,8
    80005932:	00000097          	auipc	ra,0x0
    80005936:	552080e7          	jalr	1362(ra) # 80005e84 <uartputc_sync>
    8000593a:	02000513          	li	a0,32
    8000593e:	00000097          	auipc	ra,0x0
    80005942:	546080e7          	jalr	1350(ra) # 80005e84 <uartputc_sync>
    80005946:	4521                	li	a0,8
    80005948:	00000097          	auipc	ra,0x0
    8000594c:	53c080e7          	jalr	1340(ra) # 80005e84 <uartputc_sync>
    80005950:	bfe1                	j	80005928 <consputc+0x18>

0000000080005952 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    80005952:	1101                	addi	sp,sp,-32
    80005954:	ec06                	sd	ra,24(sp)
    80005956:	e822                	sd	s0,16(sp)
    80005958:	e426                	sd	s1,8(sp)
    8000595a:	e04a                	sd	s2,0(sp)
    8000595c:	1000                	addi	s0,sp,32
    8000595e:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    80005960:	0001c517          	auipc	a0,0x1c
    80005964:	2d050513          	addi	a0,a0,720 # 80021c30 <cons>
    80005968:	00000097          	auipc	ra,0x0
    8000596c:	7b4080e7          	jalr	1972(ra) # 8000611c <acquire>

  switch(c){
    80005970:	47d5                	li	a5,21
    80005972:	0af48663          	beq	s1,a5,80005a1e <consoleintr+0xcc>
    80005976:	0297ca63          	blt	a5,s1,800059aa <consoleintr+0x58>
    8000597a:	47a1                	li	a5,8
    8000597c:	0ef48763          	beq	s1,a5,80005a6a <consoleintr+0x118>
    80005980:	47c1                	li	a5,16
    80005982:	10f49a63          	bne	s1,a5,80005a96 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80005986:	ffffc097          	auipc	ra,0xffffc
    8000598a:	02a080e7          	jalr	42(ra) # 800019b0 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    8000598e:	0001c517          	auipc	a0,0x1c
    80005992:	2a250513          	addi	a0,a0,674 # 80021c30 <cons>
    80005996:	00001097          	auipc	ra,0x1
    8000599a:	83a080e7          	jalr	-1990(ra) # 800061d0 <release>
}
    8000599e:	60e2                	ld	ra,24(sp)
    800059a0:	6442                	ld	s0,16(sp)
    800059a2:	64a2                	ld	s1,8(sp)
    800059a4:	6902                	ld	s2,0(sp)
    800059a6:	6105                	addi	sp,sp,32
    800059a8:	8082                	ret
  switch(c){
    800059aa:	07f00793          	li	a5,127
    800059ae:	0af48e63          	beq	s1,a5,80005a6a <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    800059b2:	0001c717          	auipc	a4,0x1c
    800059b6:	27e70713          	addi	a4,a4,638 # 80021c30 <cons>
    800059ba:	0a072783          	lw	a5,160(a4)
    800059be:	09872703          	lw	a4,152(a4)
    800059c2:	9f99                	subw	a5,a5,a4
    800059c4:	07f00713          	li	a4,127
    800059c8:	fcf763e3          	bltu	a4,a5,8000598e <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    800059cc:	47b5                	li	a5,13
    800059ce:	0cf48763          	beq	s1,a5,80005a9c <consoleintr+0x14a>
      consputc(c);
    800059d2:	8526                	mv	a0,s1
    800059d4:	00000097          	auipc	ra,0x0
    800059d8:	f3c080e7          	jalr	-196(ra) # 80005910 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    800059dc:	0001c797          	auipc	a5,0x1c
    800059e0:	25478793          	addi	a5,a5,596 # 80021c30 <cons>
    800059e4:	0a07a683          	lw	a3,160(a5)
    800059e8:	0016871b          	addiw	a4,a3,1
    800059ec:	0007061b          	sext.w	a2,a4
    800059f0:	0ae7a023          	sw	a4,160(a5)
    800059f4:	07f6f693          	andi	a3,a3,127
    800059f8:	97b6                	add	a5,a5,a3
    800059fa:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e-cons.r == INPUT_BUF_SIZE){
    800059fe:	47a9                	li	a5,10
    80005a00:	0cf48563          	beq	s1,a5,80005aca <consoleintr+0x178>
    80005a04:	4791                	li	a5,4
    80005a06:	0cf48263          	beq	s1,a5,80005aca <consoleintr+0x178>
    80005a0a:	0001c797          	auipc	a5,0x1c
    80005a0e:	2be7a783          	lw	a5,702(a5) # 80021cc8 <cons+0x98>
    80005a12:	9f1d                	subw	a4,a4,a5
    80005a14:	08000793          	li	a5,128
    80005a18:	f6f71be3          	bne	a4,a5,8000598e <consoleintr+0x3c>
    80005a1c:	a07d                	j	80005aca <consoleintr+0x178>
    while(cons.e != cons.w &&
    80005a1e:	0001c717          	auipc	a4,0x1c
    80005a22:	21270713          	addi	a4,a4,530 # 80021c30 <cons>
    80005a26:	0a072783          	lw	a5,160(a4)
    80005a2a:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005a2e:	0001c497          	auipc	s1,0x1c
    80005a32:	20248493          	addi	s1,s1,514 # 80021c30 <cons>
    while(cons.e != cons.w &&
    80005a36:	4929                	li	s2,10
    80005a38:	f4f70be3          	beq	a4,a5,8000598e <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF_SIZE] != '\n'){
    80005a3c:	37fd                	addiw	a5,a5,-1
    80005a3e:	07f7f713          	andi	a4,a5,127
    80005a42:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005a44:	01874703          	lbu	a4,24(a4)
    80005a48:	f52703e3          	beq	a4,s2,8000598e <consoleintr+0x3c>
      cons.e--;
    80005a4c:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005a50:	10000513          	li	a0,256
    80005a54:	00000097          	auipc	ra,0x0
    80005a58:	ebc080e7          	jalr	-324(ra) # 80005910 <consputc>
    while(cons.e != cons.w &&
    80005a5c:	0a04a783          	lw	a5,160(s1)
    80005a60:	09c4a703          	lw	a4,156(s1)
    80005a64:	fcf71ce3          	bne	a4,a5,80005a3c <consoleintr+0xea>
    80005a68:	b71d                	j	8000598e <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005a6a:	0001c717          	auipc	a4,0x1c
    80005a6e:	1c670713          	addi	a4,a4,454 # 80021c30 <cons>
    80005a72:	0a072783          	lw	a5,160(a4)
    80005a76:	09c72703          	lw	a4,156(a4)
    80005a7a:	f0f70ae3          	beq	a4,a5,8000598e <consoleintr+0x3c>
      cons.e--;
    80005a7e:	37fd                	addiw	a5,a5,-1
    80005a80:	0001c717          	auipc	a4,0x1c
    80005a84:	24f72823          	sw	a5,592(a4) # 80021cd0 <cons+0xa0>
      consputc(BACKSPACE);
    80005a88:	10000513          	li	a0,256
    80005a8c:	00000097          	auipc	ra,0x0
    80005a90:	e84080e7          	jalr	-380(ra) # 80005910 <consputc>
    80005a94:	bded                	j	8000598e <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF_SIZE){
    80005a96:	ee048ce3          	beqz	s1,8000598e <consoleintr+0x3c>
    80005a9a:	bf21                	j	800059b2 <consoleintr+0x60>
      consputc(c);
    80005a9c:	4529                	li	a0,10
    80005a9e:	00000097          	auipc	ra,0x0
    80005aa2:	e72080e7          	jalr	-398(ra) # 80005910 <consputc>
      cons.buf[cons.e++ % INPUT_BUF_SIZE] = c;
    80005aa6:	0001c797          	auipc	a5,0x1c
    80005aaa:	18a78793          	addi	a5,a5,394 # 80021c30 <cons>
    80005aae:	0a07a703          	lw	a4,160(a5)
    80005ab2:	0017069b          	addiw	a3,a4,1
    80005ab6:	0006861b          	sext.w	a2,a3
    80005aba:	0ad7a023          	sw	a3,160(a5)
    80005abe:	07f77713          	andi	a4,a4,127
    80005ac2:	97ba                	add	a5,a5,a4
    80005ac4:	4729                	li	a4,10
    80005ac6:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005aca:	0001c797          	auipc	a5,0x1c
    80005ace:	20c7a123          	sw	a2,514(a5) # 80021ccc <cons+0x9c>
        wakeup(&cons.r);
    80005ad2:	0001c517          	auipc	a0,0x1c
    80005ad6:	1f650513          	addi	a0,a0,502 # 80021cc8 <cons+0x98>
    80005ada:	ffffc097          	auipc	ra,0xffffc
    80005ade:	a86080e7          	jalr	-1402(ra) # 80001560 <wakeup>
    80005ae2:	b575                	j	8000598e <consoleintr+0x3c>

0000000080005ae4 <consoleinit>:

void
consoleinit(void)
{
    80005ae4:	1141                	addi	sp,sp,-16
    80005ae6:	e406                	sd	ra,8(sp)
    80005ae8:	e022                	sd	s0,0(sp)
    80005aea:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005aec:	00003597          	auipc	a1,0x3
    80005af0:	cd458593          	addi	a1,a1,-812 # 800087c0 <syscalls+0x3f0>
    80005af4:	0001c517          	auipc	a0,0x1c
    80005af8:	13c50513          	addi	a0,a0,316 # 80021c30 <cons>
    80005afc:	00000097          	auipc	ra,0x0
    80005b00:	590080e7          	jalr	1424(ra) # 8000608c <initlock>

  uartinit();
    80005b04:	00000097          	auipc	ra,0x0
    80005b08:	330080e7          	jalr	816(ra) # 80005e34 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005b0c:	00013797          	auipc	a5,0x13
    80005b10:	e4c78793          	addi	a5,a5,-436 # 80018958 <devsw>
    80005b14:	00000717          	auipc	a4,0x0
    80005b18:	cde70713          	addi	a4,a4,-802 # 800057f2 <consoleread>
    80005b1c:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005b1e:	00000717          	auipc	a4,0x0
    80005b22:	c7270713          	addi	a4,a4,-910 # 80005790 <consolewrite>
    80005b26:	ef98                	sd	a4,24(a5)
}
    80005b28:	60a2                	ld	ra,8(sp)
    80005b2a:	6402                	ld	s0,0(sp)
    80005b2c:	0141                	addi	sp,sp,16
    80005b2e:	8082                	ret

0000000080005b30 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005b30:	7179                	addi	sp,sp,-48
    80005b32:	f406                	sd	ra,40(sp)
    80005b34:	f022                	sd	s0,32(sp)
    80005b36:	ec26                	sd	s1,24(sp)
    80005b38:	e84a                	sd	s2,16(sp)
    80005b3a:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005b3c:	c219                	beqz	a2,80005b42 <printint+0x12>
    80005b3e:	08054663          	bltz	a0,80005bca <printint+0x9a>
    x = -xx;
  else
    x = xx;
    80005b42:	2501                	sext.w	a0,a0
    80005b44:	4881                	li	a7,0
    80005b46:	fd040693          	addi	a3,s0,-48

  i = 0;
    80005b4a:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005b4c:	2581                	sext.w	a1,a1
    80005b4e:	00003617          	auipc	a2,0x3
    80005b52:	ca260613          	addi	a2,a2,-862 # 800087f0 <digits>
    80005b56:	883a                	mv	a6,a4
    80005b58:	2705                	addiw	a4,a4,1
    80005b5a:	02b577bb          	remuw	a5,a0,a1
    80005b5e:	1782                	slli	a5,a5,0x20
    80005b60:	9381                	srli	a5,a5,0x20
    80005b62:	97b2                	add	a5,a5,a2
    80005b64:	0007c783          	lbu	a5,0(a5)
    80005b68:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005b6c:	0005079b          	sext.w	a5,a0
    80005b70:	02b5553b          	divuw	a0,a0,a1
    80005b74:	0685                	addi	a3,a3,1
    80005b76:	feb7f0e3          	bgeu	a5,a1,80005b56 <printint+0x26>

  if(sign)
    80005b7a:	00088b63          	beqz	a7,80005b90 <printint+0x60>
    buf[i++] = '-';
    80005b7e:	fe040793          	addi	a5,s0,-32
    80005b82:	973e                	add	a4,a4,a5
    80005b84:	02d00793          	li	a5,45
    80005b88:	fef70823          	sb	a5,-16(a4)
    80005b8c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80005b90:	02e05763          	blez	a4,80005bbe <printint+0x8e>
    80005b94:	fd040793          	addi	a5,s0,-48
    80005b98:	00e784b3          	add	s1,a5,a4
    80005b9c:	fff78913          	addi	s2,a5,-1
    80005ba0:	993a                	add	s2,s2,a4
    80005ba2:	377d                	addiw	a4,a4,-1
    80005ba4:	1702                	slli	a4,a4,0x20
    80005ba6:	9301                	srli	a4,a4,0x20
    80005ba8:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005bac:	fff4c503          	lbu	a0,-1(s1)
    80005bb0:	00000097          	auipc	ra,0x0
    80005bb4:	d60080e7          	jalr	-672(ra) # 80005910 <consputc>
  while(--i >= 0)
    80005bb8:	14fd                	addi	s1,s1,-1
    80005bba:	ff2499e3          	bne	s1,s2,80005bac <printint+0x7c>
}
    80005bbe:	70a2                	ld	ra,40(sp)
    80005bc0:	7402                	ld	s0,32(sp)
    80005bc2:	64e2                	ld	s1,24(sp)
    80005bc4:	6942                	ld	s2,16(sp)
    80005bc6:	6145                	addi	sp,sp,48
    80005bc8:	8082                	ret
    x = -xx;
    80005bca:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005bce:	4885                	li	a7,1
    x = -xx;
    80005bd0:	bf9d                	j	80005b46 <printint+0x16>

0000000080005bd2 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005bd2:	1101                	addi	sp,sp,-32
    80005bd4:	ec06                	sd	ra,24(sp)
    80005bd6:	e822                	sd	s0,16(sp)
    80005bd8:	e426                	sd	s1,8(sp)
    80005bda:	1000                	addi	s0,sp,32
    80005bdc:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005bde:	0001c797          	auipc	a5,0x1c
    80005be2:	1007a923          	sw	zero,274(a5) # 80021cf0 <pr+0x18>
  printf("panic: ");
    80005be6:	00003517          	auipc	a0,0x3
    80005bea:	be250513          	addi	a0,a0,-1054 # 800087c8 <syscalls+0x3f8>
    80005bee:	00000097          	auipc	ra,0x0
    80005bf2:	02e080e7          	jalr	46(ra) # 80005c1c <printf>
  printf(s);
    80005bf6:	8526                	mv	a0,s1
    80005bf8:	00000097          	auipc	ra,0x0
    80005bfc:	024080e7          	jalr	36(ra) # 80005c1c <printf>
  printf("\n");
    80005c00:	00002517          	auipc	a0,0x2
    80005c04:	44850513          	addi	a0,a0,1096 # 80008048 <etext+0x48>
    80005c08:	00000097          	auipc	ra,0x0
    80005c0c:	014080e7          	jalr	20(ra) # 80005c1c <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005c10:	4785                	li	a5,1
    80005c12:	00003717          	auipc	a4,0x3
    80005c16:	c8f72d23          	sw	a5,-870(a4) # 800088ac <panicked>
  for(;;)
    80005c1a:	a001                	j	80005c1a <panic+0x48>

0000000080005c1c <printf>:
{
    80005c1c:	7131                	addi	sp,sp,-192
    80005c1e:	fc86                	sd	ra,120(sp)
    80005c20:	f8a2                	sd	s0,112(sp)
    80005c22:	f4a6                	sd	s1,104(sp)
    80005c24:	f0ca                	sd	s2,96(sp)
    80005c26:	ecce                	sd	s3,88(sp)
    80005c28:	e8d2                	sd	s4,80(sp)
    80005c2a:	e4d6                	sd	s5,72(sp)
    80005c2c:	e0da                	sd	s6,64(sp)
    80005c2e:	fc5e                	sd	s7,56(sp)
    80005c30:	f862                	sd	s8,48(sp)
    80005c32:	f466                	sd	s9,40(sp)
    80005c34:	f06a                	sd	s10,32(sp)
    80005c36:	ec6e                	sd	s11,24(sp)
    80005c38:	0100                	addi	s0,sp,128
    80005c3a:	8a2a                	mv	s4,a0
    80005c3c:	e40c                	sd	a1,8(s0)
    80005c3e:	e810                	sd	a2,16(s0)
    80005c40:	ec14                	sd	a3,24(s0)
    80005c42:	f018                	sd	a4,32(s0)
    80005c44:	f41c                	sd	a5,40(s0)
    80005c46:	03043823          	sd	a6,48(s0)
    80005c4a:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005c4e:	0001cd97          	auipc	s11,0x1c
    80005c52:	0a2dad83          	lw	s11,162(s11) # 80021cf0 <pr+0x18>
  if(locking)
    80005c56:	020d9b63          	bnez	s11,80005c8c <printf+0x70>
  if (fmt == 0)
    80005c5a:	040a0263          	beqz	s4,80005c9e <printf+0x82>
  va_start(ap, fmt);
    80005c5e:	00840793          	addi	a5,s0,8
    80005c62:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005c66:	000a4503          	lbu	a0,0(s4)
    80005c6a:	16050263          	beqz	a0,80005dce <printf+0x1b2>
    80005c6e:	4481                	li	s1,0
    if(c != '%'){
    80005c70:	02500a93          	li	s5,37
    switch(c){
    80005c74:	07000b13          	li	s6,112
  consputc('x');
    80005c78:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005c7a:	00003b97          	auipc	s7,0x3
    80005c7e:	b76b8b93          	addi	s7,s7,-1162 # 800087f0 <digits>
    switch(c){
    80005c82:	07300c93          	li	s9,115
    80005c86:	06400c13          	li	s8,100
    80005c8a:	a82d                	j	80005cc4 <printf+0xa8>
    acquire(&pr.lock);
    80005c8c:	0001c517          	auipc	a0,0x1c
    80005c90:	04c50513          	addi	a0,a0,76 # 80021cd8 <pr>
    80005c94:	00000097          	auipc	ra,0x0
    80005c98:	488080e7          	jalr	1160(ra) # 8000611c <acquire>
    80005c9c:	bf7d                	j	80005c5a <printf+0x3e>
    panic("null fmt");
    80005c9e:	00003517          	auipc	a0,0x3
    80005ca2:	b3a50513          	addi	a0,a0,-1222 # 800087d8 <syscalls+0x408>
    80005ca6:	00000097          	auipc	ra,0x0
    80005caa:	f2c080e7          	jalr	-212(ra) # 80005bd2 <panic>
      consputc(c);
    80005cae:	00000097          	auipc	ra,0x0
    80005cb2:	c62080e7          	jalr	-926(ra) # 80005910 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005cb6:	2485                	addiw	s1,s1,1
    80005cb8:	009a07b3          	add	a5,s4,s1
    80005cbc:	0007c503          	lbu	a0,0(a5)
    80005cc0:	10050763          	beqz	a0,80005dce <printf+0x1b2>
    if(c != '%'){
    80005cc4:	ff5515e3          	bne	a0,s5,80005cae <printf+0x92>
    c = fmt[++i] & 0xff;
    80005cc8:	2485                	addiw	s1,s1,1
    80005cca:	009a07b3          	add	a5,s4,s1
    80005cce:	0007c783          	lbu	a5,0(a5)
    80005cd2:	0007891b          	sext.w	s2,a5
    if(c == 0)
    80005cd6:	cfe5                	beqz	a5,80005dce <printf+0x1b2>
    switch(c){
    80005cd8:	05678a63          	beq	a5,s6,80005d2c <printf+0x110>
    80005cdc:	02fb7663          	bgeu	s6,a5,80005d08 <printf+0xec>
    80005ce0:	09978963          	beq	a5,s9,80005d72 <printf+0x156>
    80005ce4:	07800713          	li	a4,120
    80005ce8:	0ce79863          	bne	a5,a4,80005db8 <printf+0x19c>
      printint(va_arg(ap, int), 16, 1);
    80005cec:	f8843783          	ld	a5,-120(s0)
    80005cf0:	00878713          	addi	a4,a5,8
    80005cf4:	f8e43423          	sd	a4,-120(s0)
    80005cf8:	4605                	li	a2,1
    80005cfa:	85ea                	mv	a1,s10
    80005cfc:	4388                	lw	a0,0(a5)
    80005cfe:	00000097          	auipc	ra,0x0
    80005d02:	e32080e7          	jalr	-462(ra) # 80005b30 <printint>
      break;
    80005d06:	bf45                	j	80005cb6 <printf+0x9a>
    switch(c){
    80005d08:	0b578263          	beq	a5,s5,80005dac <printf+0x190>
    80005d0c:	0b879663          	bne	a5,s8,80005db8 <printf+0x19c>
      printint(va_arg(ap, int), 10, 1);
    80005d10:	f8843783          	ld	a5,-120(s0)
    80005d14:	00878713          	addi	a4,a5,8
    80005d18:	f8e43423          	sd	a4,-120(s0)
    80005d1c:	4605                	li	a2,1
    80005d1e:	45a9                	li	a1,10
    80005d20:	4388                	lw	a0,0(a5)
    80005d22:	00000097          	auipc	ra,0x0
    80005d26:	e0e080e7          	jalr	-498(ra) # 80005b30 <printint>
      break;
    80005d2a:	b771                	j	80005cb6 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80005d2c:	f8843783          	ld	a5,-120(s0)
    80005d30:	00878713          	addi	a4,a5,8
    80005d34:	f8e43423          	sd	a4,-120(s0)
    80005d38:	0007b983          	ld	s3,0(a5)
  consputc('0');
    80005d3c:	03000513          	li	a0,48
    80005d40:	00000097          	auipc	ra,0x0
    80005d44:	bd0080e7          	jalr	-1072(ra) # 80005910 <consputc>
  consputc('x');
    80005d48:	07800513          	li	a0,120
    80005d4c:	00000097          	auipc	ra,0x0
    80005d50:	bc4080e7          	jalr	-1084(ra) # 80005910 <consputc>
    80005d54:	896a                	mv	s2,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005d56:	03c9d793          	srli	a5,s3,0x3c
    80005d5a:	97de                	add	a5,a5,s7
    80005d5c:	0007c503          	lbu	a0,0(a5)
    80005d60:	00000097          	auipc	ra,0x0
    80005d64:	bb0080e7          	jalr	-1104(ra) # 80005910 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005d68:	0992                	slli	s3,s3,0x4
    80005d6a:	397d                	addiw	s2,s2,-1
    80005d6c:	fe0915e3          	bnez	s2,80005d56 <printf+0x13a>
    80005d70:	b799                	j	80005cb6 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80005d72:	f8843783          	ld	a5,-120(s0)
    80005d76:	00878713          	addi	a4,a5,8
    80005d7a:	f8e43423          	sd	a4,-120(s0)
    80005d7e:	0007b903          	ld	s2,0(a5)
    80005d82:	00090e63          	beqz	s2,80005d9e <printf+0x182>
      for(; *s; s++)
    80005d86:	00094503          	lbu	a0,0(s2)
    80005d8a:	d515                	beqz	a0,80005cb6 <printf+0x9a>
        consputc(*s);
    80005d8c:	00000097          	auipc	ra,0x0
    80005d90:	b84080e7          	jalr	-1148(ra) # 80005910 <consputc>
      for(; *s; s++)
    80005d94:	0905                	addi	s2,s2,1
    80005d96:	00094503          	lbu	a0,0(s2)
    80005d9a:	f96d                	bnez	a0,80005d8c <printf+0x170>
    80005d9c:	bf29                	j	80005cb6 <printf+0x9a>
        s = "(null)";
    80005d9e:	00003917          	auipc	s2,0x3
    80005da2:	a3290913          	addi	s2,s2,-1486 # 800087d0 <syscalls+0x400>
      for(; *s; s++)
    80005da6:	02800513          	li	a0,40
    80005daa:	b7cd                	j	80005d8c <printf+0x170>
      consputc('%');
    80005dac:	8556                	mv	a0,s5
    80005dae:	00000097          	auipc	ra,0x0
    80005db2:	b62080e7          	jalr	-1182(ra) # 80005910 <consputc>
      break;
    80005db6:	b701                	j	80005cb6 <printf+0x9a>
      consputc('%');
    80005db8:	8556                	mv	a0,s5
    80005dba:	00000097          	auipc	ra,0x0
    80005dbe:	b56080e7          	jalr	-1194(ra) # 80005910 <consputc>
      consputc(c);
    80005dc2:	854a                	mv	a0,s2
    80005dc4:	00000097          	auipc	ra,0x0
    80005dc8:	b4c080e7          	jalr	-1204(ra) # 80005910 <consputc>
      break;
    80005dcc:	b5ed                	j	80005cb6 <printf+0x9a>
  if(locking)
    80005dce:	020d9163          	bnez	s11,80005df0 <printf+0x1d4>
}
    80005dd2:	70e6                	ld	ra,120(sp)
    80005dd4:	7446                	ld	s0,112(sp)
    80005dd6:	74a6                	ld	s1,104(sp)
    80005dd8:	7906                	ld	s2,96(sp)
    80005dda:	69e6                	ld	s3,88(sp)
    80005ddc:	6a46                	ld	s4,80(sp)
    80005dde:	6aa6                	ld	s5,72(sp)
    80005de0:	6b06                	ld	s6,64(sp)
    80005de2:	7be2                	ld	s7,56(sp)
    80005de4:	7c42                	ld	s8,48(sp)
    80005de6:	7ca2                	ld	s9,40(sp)
    80005de8:	7d02                	ld	s10,32(sp)
    80005dea:	6de2                	ld	s11,24(sp)
    80005dec:	6129                	addi	sp,sp,192
    80005dee:	8082                	ret
    release(&pr.lock);
    80005df0:	0001c517          	auipc	a0,0x1c
    80005df4:	ee850513          	addi	a0,a0,-280 # 80021cd8 <pr>
    80005df8:	00000097          	auipc	ra,0x0
    80005dfc:	3d8080e7          	jalr	984(ra) # 800061d0 <release>
}
    80005e00:	bfc9                	j	80005dd2 <printf+0x1b6>

0000000080005e02 <printfinit>:
    ;
}

void
printfinit(void)
{
    80005e02:	1101                	addi	sp,sp,-32
    80005e04:	ec06                	sd	ra,24(sp)
    80005e06:	e822                	sd	s0,16(sp)
    80005e08:	e426                	sd	s1,8(sp)
    80005e0a:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80005e0c:	0001c497          	auipc	s1,0x1c
    80005e10:	ecc48493          	addi	s1,s1,-308 # 80021cd8 <pr>
    80005e14:	00003597          	auipc	a1,0x3
    80005e18:	9d458593          	addi	a1,a1,-1580 # 800087e8 <syscalls+0x418>
    80005e1c:	8526                	mv	a0,s1
    80005e1e:	00000097          	auipc	ra,0x0
    80005e22:	26e080e7          	jalr	622(ra) # 8000608c <initlock>
  pr.locking = 1;
    80005e26:	4785                	li	a5,1
    80005e28:	cc9c                	sw	a5,24(s1)
}
    80005e2a:	60e2                	ld	ra,24(sp)
    80005e2c:	6442                	ld	s0,16(sp)
    80005e2e:	64a2                	ld	s1,8(sp)
    80005e30:	6105                	addi	sp,sp,32
    80005e32:	8082                	ret

0000000080005e34 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80005e34:	1141                	addi	sp,sp,-16
    80005e36:	e406                	sd	ra,8(sp)
    80005e38:	e022                	sd	s0,0(sp)
    80005e3a:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005e3c:	100007b7          	lui	a5,0x10000
    80005e40:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005e44:	f8000713          	li	a4,-128
    80005e48:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005e4c:	470d                	li	a4,3
    80005e4e:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80005e52:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005e56:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005e5a:	469d                	li	a3,7
    80005e5c:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80005e60:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80005e64:	00003597          	auipc	a1,0x3
    80005e68:	9a458593          	addi	a1,a1,-1628 # 80008808 <digits+0x18>
    80005e6c:	0001c517          	auipc	a0,0x1c
    80005e70:	e8c50513          	addi	a0,a0,-372 # 80021cf8 <uart_tx_lock>
    80005e74:	00000097          	auipc	ra,0x0
    80005e78:	218080e7          	jalr	536(ra) # 8000608c <initlock>
}
    80005e7c:	60a2                	ld	ra,8(sp)
    80005e7e:	6402                	ld	s0,0(sp)
    80005e80:	0141                	addi	sp,sp,16
    80005e82:	8082                	ret

0000000080005e84 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80005e84:	1101                	addi	sp,sp,-32
    80005e86:	ec06                	sd	ra,24(sp)
    80005e88:	e822                	sd	s0,16(sp)
    80005e8a:	e426                	sd	s1,8(sp)
    80005e8c:	1000                	addi	s0,sp,32
    80005e8e:	84aa                	mv	s1,a0
  push_off();
    80005e90:	00000097          	auipc	ra,0x0
    80005e94:	240080e7          	jalr	576(ra) # 800060d0 <push_off>

  if(panicked){
    80005e98:	00003797          	auipc	a5,0x3
    80005e9c:	a147a783          	lw	a5,-1516(a5) # 800088ac <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005ea0:	10000737          	lui	a4,0x10000
  if(panicked){
    80005ea4:	c391                	beqz	a5,80005ea8 <uartputc_sync+0x24>
    for(;;)
    80005ea6:	a001                	j	80005ea6 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005ea8:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005eac:	0ff7f793          	andi	a5,a5,255
    80005eb0:	0207f793          	andi	a5,a5,32
    80005eb4:	dbf5                	beqz	a5,80005ea8 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80005eb6:	0ff4f793          	andi	a5,s1,255
    80005eba:	10000737          	lui	a4,0x10000
    80005ebe:	00f70023          	sb	a5,0(a4) # 10000000 <_entry-0x70000000>

  pop_off();
    80005ec2:	00000097          	auipc	ra,0x0
    80005ec6:	2ae080e7          	jalr	686(ra) # 80006170 <pop_off>
}
    80005eca:	60e2                	ld	ra,24(sp)
    80005ecc:	6442                	ld	s0,16(sp)
    80005ece:	64a2                	ld	s1,8(sp)
    80005ed0:	6105                	addi	sp,sp,32
    80005ed2:	8082                	ret

0000000080005ed4 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80005ed4:	00003717          	auipc	a4,0x3
    80005ed8:	9dc73703          	ld	a4,-1572(a4) # 800088b0 <uart_tx_r>
    80005edc:	00003797          	auipc	a5,0x3
    80005ee0:	9dc7b783          	ld	a5,-1572(a5) # 800088b8 <uart_tx_w>
    80005ee4:	06e78c63          	beq	a5,a4,80005f5c <uartstart+0x88>
{
    80005ee8:	7139                	addi	sp,sp,-64
    80005eea:	fc06                	sd	ra,56(sp)
    80005eec:	f822                	sd	s0,48(sp)
    80005eee:	f426                	sd	s1,40(sp)
    80005ef0:	f04a                	sd	s2,32(sp)
    80005ef2:	ec4e                	sd	s3,24(sp)
    80005ef4:	e852                	sd	s4,16(sp)
    80005ef6:	e456                	sd	s5,8(sp)
    80005ef8:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005efa:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005efe:	0001ca17          	auipc	s4,0x1c
    80005f02:	dfaa0a13          	addi	s4,s4,-518 # 80021cf8 <uart_tx_lock>
    uart_tx_r += 1;
    80005f06:	00003497          	auipc	s1,0x3
    80005f0a:	9aa48493          	addi	s1,s1,-1622 # 800088b0 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80005f0e:	00003997          	auipc	s3,0x3
    80005f12:	9aa98993          	addi	s3,s3,-1622 # 800088b8 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005f16:	00594783          	lbu	a5,5(s2) # 10000005 <_entry-0x6ffffffb>
    80005f1a:	0ff7f793          	andi	a5,a5,255
    80005f1e:	0207f793          	andi	a5,a5,32
    80005f22:	c785                	beqz	a5,80005f4a <uartstart+0x76>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005f24:	01f77793          	andi	a5,a4,31
    80005f28:	97d2                	add	a5,a5,s4
    80005f2a:	0187ca83          	lbu	s5,24(a5)
    uart_tx_r += 1;
    80005f2e:	0705                	addi	a4,a4,1
    80005f30:	e098                	sd	a4,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80005f32:	8526                	mv	a0,s1
    80005f34:	ffffb097          	auipc	ra,0xffffb
    80005f38:	62c080e7          	jalr	1580(ra) # 80001560 <wakeup>
    
    WriteReg(THR, c);
    80005f3c:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80005f40:	6098                	ld	a4,0(s1)
    80005f42:	0009b783          	ld	a5,0(s3)
    80005f46:	fce798e3          	bne	a5,a4,80005f16 <uartstart+0x42>
  }
}
    80005f4a:	70e2                	ld	ra,56(sp)
    80005f4c:	7442                	ld	s0,48(sp)
    80005f4e:	74a2                	ld	s1,40(sp)
    80005f50:	7902                	ld	s2,32(sp)
    80005f52:	69e2                	ld	s3,24(sp)
    80005f54:	6a42                	ld	s4,16(sp)
    80005f56:	6aa2                	ld	s5,8(sp)
    80005f58:	6121                	addi	sp,sp,64
    80005f5a:	8082                	ret
    80005f5c:	8082                	ret

0000000080005f5e <uartputc>:
{
    80005f5e:	7179                	addi	sp,sp,-48
    80005f60:	f406                	sd	ra,40(sp)
    80005f62:	f022                	sd	s0,32(sp)
    80005f64:	ec26                	sd	s1,24(sp)
    80005f66:	e84a                	sd	s2,16(sp)
    80005f68:	e44e                	sd	s3,8(sp)
    80005f6a:	e052                	sd	s4,0(sp)
    80005f6c:	1800                	addi	s0,sp,48
    80005f6e:	89aa                	mv	s3,a0
  acquire(&uart_tx_lock);
    80005f70:	0001c517          	auipc	a0,0x1c
    80005f74:	d8850513          	addi	a0,a0,-632 # 80021cf8 <uart_tx_lock>
    80005f78:	00000097          	auipc	ra,0x0
    80005f7c:	1a4080e7          	jalr	420(ra) # 8000611c <acquire>
  if(panicked){
    80005f80:	00003797          	auipc	a5,0x3
    80005f84:	92c7a783          	lw	a5,-1748(a5) # 800088ac <panicked>
    80005f88:	e7c9                	bnez	a5,80006012 <uartputc+0xb4>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005f8a:	00003797          	auipc	a5,0x3
    80005f8e:	92e7b783          	ld	a5,-1746(a5) # 800088b8 <uart_tx_w>
    80005f92:	00003717          	auipc	a4,0x3
    80005f96:	91e73703          	ld	a4,-1762(a4) # 800088b0 <uart_tx_r>
    80005f9a:	02070713          	addi	a4,a4,32
    sleep(&uart_tx_r, &uart_tx_lock);
    80005f9e:	0001ca17          	auipc	s4,0x1c
    80005fa2:	d5aa0a13          	addi	s4,s4,-678 # 80021cf8 <uart_tx_lock>
    80005fa6:	00003497          	auipc	s1,0x3
    80005faa:	90a48493          	addi	s1,s1,-1782 # 800088b0 <uart_tx_r>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005fae:	00003917          	auipc	s2,0x3
    80005fb2:	90a90913          	addi	s2,s2,-1782 # 800088b8 <uart_tx_w>
    80005fb6:	00f71f63          	bne	a4,a5,80005fd4 <uartputc+0x76>
    sleep(&uart_tx_r, &uart_tx_lock);
    80005fba:	85d2                	mv	a1,s4
    80005fbc:	8526                	mv	a0,s1
    80005fbe:	ffffb097          	auipc	ra,0xffffb
    80005fc2:	53e080e7          	jalr	1342(ra) # 800014fc <sleep>
  while(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80005fc6:	00093783          	ld	a5,0(s2)
    80005fca:	6098                	ld	a4,0(s1)
    80005fcc:	02070713          	addi	a4,a4,32
    80005fd0:	fef705e3          	beq	a4,a5,80005fba <uartputc+0x5c>
  uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80005fd4:	0001c497          	auipc	s1,0x1c
    80005fd8:	d2448493          	addi	s1,s1,-732 # 80021cf8 <uart_tx_lock>
    80005fdc:	01f7f713          	andi	a4,a5,31
    80005fe0:	9726                	add	a4,a4,s1
    80005fe2:	01370c23          	sb	s3,24(a4)
  uart_tx_w += 1;
    80005fe6:	0785                	addi	a5,a5,1
    80005fe8:	00003717          	auipc	a4,0x3
    80005fec:	8cf73823          	sd	a5,-1840(a4) # 800088b8 <uart_tx_w>
  uartstart();
    80005ff0:	00000097          	auipc	ra,0x0
    80005ff4:	ee4080e7          	jalr	-284(ra) # 80005ed4 <uartstart>
  release(&uart_tx_lock);
    80005ff8:	8526                	mv	a0,s1
    80005ffa:	00000097          	auipc	ra,0x0
    80005ffe:	1d6080e7          	jalr	470(ra) # 800061d0 <release>
}
    80006002:	70a2                	ld	ra,40(sp)
    80006004:	7402                	ld	s0,32(sp)
    80006006:	64e2                	ld	s1,24(sp)
    80006008:	6942                	ld	s2,16(sp)
    8000600a:	69a2                	ld	s3,8(sp)
    8000600c:	6a02                	ld	s4,0(sp)
    8000600e:	6145                	addi	sp,sp,48
    80006010:	8082                	ret
    for(;;)
    80006012:	a001                	j	80006012 <uartputc+0xb4>

0000000080006014 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    80006014:	1141                	addi	sp,sp,-16
    80006016:	e422                	sd	s0,8(sp)
    80006018:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    8000601a:	100007b7          	lui	a5,0x10000
    8000601e:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    80006022:	8b85                	andi	a5,a5,1
    80006024:	cb91                	beqz	a5,80006038 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    80006026:	100007b7          	lui	a5,0x10000
    8000602a:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    8000602e:	0ff57513          	andi	a0,a0,255
  } else {
    return -1;
  }
}
    80006032:	6422                	ld	s0,8(sp)
    80006034:	0141                	addi	sp,sp,16
    80006036:	8082                	ret
    return -1;
    80006038:	557d                	li	a0,-1
    8000603a:	bfe5                	j	80006032 <uartgetc+0x1e>

000000008000603c <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from devintr().
void
uartintr(void)
{
    8000603c:	1101                	addi	sp,sp,-32
    8000603e:	ec06                	sd	ra,24(sp)
    80006040:	e822                	sd	s0,16(sp)
    80006042:	e426                	sd	s1,8(sp)
    80006044:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    80006046:	54fd                	li	s1,-1
    int c = uartgetc();
    80006048:	00000097          	auipc	ra,0x0
    8000604c:	fcc080e7          	jalr	-52(ra) # 80006014 <uartgetc>
    if(c == -1)
    80006050:	00950763          	beq	a0,s1,8000605e <uartintr+0x22>
      break;
    consoleintr(c);
    80006054:	00000097          	auipc	ra,0x0
    80006058:	8fe080e7          	jalr	-1794(ra) # 80005952 <consoleintr>
  while(1){
    8000605c:	b7f5                	j	80006048 <uartintr+0xc>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    8000605e:	0001c497          	auipc	s1,0x1c
    80006062:	c9a48493          	addi	s1,s1,-870 # 80021cf8 <uart_tx_lock>
    80006066:	8526                	mv	a0,s1
    80006068:	00000097          	auipc	ra,0x0
    8000606c:	0b4080e7          	jalr	180(ra) # 8000611c <acquire>
  uartstart();
    80006070:	00000097          	auipc	ra,0x0
    80006074:	e64080e7          	jalr	-412(ra) # 80005ed4 <uartstart>
  release(&uart_tx_lock);
    80006078:	8526                	mv	a0,s1
    8000607a:	00000097          	auipc	ra,0x0
    8000607e:	156080e7          	jalr	342(ra) # 800061d0 <release>
}
    80006082:	60e2                	ld	ra,24(sp)
    80006084:	6442                	ld	s0,16(sp)
    80006086:	64a2                	ld	s1,8(sp)
    80006088:	6105                	addi	sp,sp,32
    8000608a:	8082                	ret

000000008000608c <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    8000608c:	1141                	addi	sp,sp,-16
    8000608e:	e422                	sd	s0,8(sp)
    80006090:	0800                	addi	s0,sp,16
  lk->name = name;
    80006092:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006094:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006098:	00053823          	sd	zero,16(a0)
}
    8000609c:	6422                	ld	s0,8(sp)
    8000609e:	0141                	addi	sp,sp,16
    800060a0:	8082                	ret

00000000800060a2 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    800060a2:	411c                	lw	a5,0(a0)
    800060a4:	e399                	bnez	a5,800060aa <holding+0x8>
    800060a6:	4501                	li	a0,0
  return r;
}
    800060a8:	8082                	ret
{
    800060aa:	1101                	addi	sp,sp,-32
    800060ac:	ec06                	sd	ra,24(sp)
    800060ae:	e822                	sd	s0,16(sp)
    800060b0:	e426                	sd	s1,8(sp)
    800060b2:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    800060b4:	6904                	ld	s1,16(a0)
    800060b6:	ffffb097          	auipc	ra,0xffffb
    800060ba:	d86080e7          	jalr	-634(ra) # 80000e3c <mycpu>
    800060be:	40a48533          	sub	a0,s1,a0
    800060c2:	00153513          	seqz	a0,a0
}
    800060c6:	60e2                	ld	ra,24(sp)
    800060c8:	6442                	ld	s0,16(sp)
    800060ca:	64a2                	ld	s1,8(sp)
    800060cc:	6105                	addi	sp,sp,32
    800060ce:	8082                	ret

00000000800060d0 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    800060d0:	1101                	addi	sp,sp,-32
    800060d2:	ec06                	sd	ra,24(sp)
    800060d4:	e822                	sd	s0,16(sp)
    800060d6:	e426                	sd	s1,8(sp)
    800060d8:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800060da:	100024f3          	csrr	s1,sstatus
    800060de:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800060e2:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800060e4:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    800060e8:	ffffb097          	auipc	ra,0xffffb
    800060ec:	d54080e7          	jalr	-684(ra) # 80000e3c <mycpu>
    800060f0:	5d3c                	lw	a5,120(a0)
    800060f2:	cf89                	beqz	a5,8000610c <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    800060f4:	ffffb097          	auipc	ra,0xffffb
    800060f8:	d48080e7          	jalr	-696(ra) # 80000e3c <mycpu>
    800060fc:	5d3c                	lw	a5,120(a0)
    800060fe:	2785                	addiw	a5,a5,1
    80006100:	dd3c                	sw	a5,120(a0)
}
    80006102:	60e2                	ld	ra,24(sp)
    80006104:	6442                	ld	s0,16(sp)
    80006106:	64a2                	ld	s1,8(sp)
    80006108:	6105                	addi	sp,sp,32
    8000610a:	8082                	ret
    mycpu()->intena = old;
    8000610c:	ffffb097          	auipc	ra,0xffffb
    80006110:	d30080e7          	jalr	-720(ra) # 80000e3c <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80006114:	8085                	srli	s1,s1,0x1
    80006116:	8885                	andi	s1,s1,1
    80006118:	dd64                	sw	s1,124(a0)
    8000611a:	bfe9                	j	800060f4 <push_off+0x24>

000000008000611c <acquire>:
{
    8000611c:	1101                	addi	sp,sp,-32
    8000611e:	ec06                	sd	ra,24(sp)
    80006120:	e822                	sd	s0,16(sp)
    80006122:	e426                	sd	s1,8(sp)
    80006124:	1000                	addi	s0,sp,32
    80006126:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80006128:	00000097          	auipc	ra,0x0
    8000612c:	fa8080e7          	jalr	-88(ra) # 800060d0 <push_off>
  if(holding(lk))
    80006130:	8526                	mv	a0,s1
    80006132:	00000097          	auipc	ra,0x0
    80006136:	f70080e7          	jalr	-144(ra) # 800060a2 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000613a:	4705                	li	a4,1
  if(holding(lk))
    8000613c:	e115                	bnez	a0,80006160 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    8000613e:	87ba                	mv	a5,a4
    80006140:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80006144:	2781                	sext.w	a5,a5
    80006146:	ffe5                	bnez	a5,8000613e <acquire+0x22>
  __sync_synchronize();
    80006148:	0ff0000f          	fence
  lk->cpu = mycpu();
    8000614c:	ffffb097          	auipc	ra,0xffffb
    80006150:	cf0080e7          	jalr	-784(ra) # 80000e3c <mycpu>
    80006154:	e888                	sd	a0,16(s1)
}
    80006156:	60e2                	ld	ra,24(sp)
    80006158:	6442                	ld	s0,16(sp)
    8000615a:	64a2                	ld	s1,8(sp)
    8000615c:	6105                	addi	sp,sp,32
    8000615e:	8082                	ret
    panic("acquire");
    80006160:	00002517          	auipc	a0,0x2
    80006164:	6b050513          	addi	a0,a0,1712 # 80008810 <digits+0x20>
    80006168:	00000097          	auipc	ra,0x0
    8000616c:	a6a080e7          	jalr	-1430(ra) # 80005bd2 <panic>

0000000080006170 <pop_off>:

void
pop_off(void)
{
    80006170:	1141                	addi	sp,sp,-16
    80006172:	e406                	sd	ra,8(sp)
    80006174:	e022                	sd	s0,0(sp)
    80006176:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006178:	ffffb097          	auipc	ra,0xffffb
    8000617c:	cc4080e7          	jalr	-828(ra) # 80000e3c <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006180:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80006184:	8b89                	andi	a5,a5,2
  if(intr_get())
    80006186:	e78d                	bnez	a5,800061b0 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006188:	5d3c                	lw	a5,120(a0)
    8000618a:	02f05b63          	blez	a5,800061c0 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    8000618e:	37fd                	addiw	a5,a5,-1
    80006190:	0007871b          	sext.w	a4,a5
    80006194:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80006196:	eb09                	bnez	a4,800061a8 <pop_off+0x38>
    80006198:	5d7c                	lw	a5,124(a0)
    8000619a:	c799                	beqz	a5,800061a8 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000619c:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800061a0:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800061a4:	10079073          	csrw	sstatus,a5
    intr_on();
}
    800061a8:	60a2                	ld	ra,8(sp)
    800061aa:	6402                	ld	s0,0(sp)
    800061ac:	0141                	addi	sp,sp,16
    800061ae:	8082                	ret
    panic("pop_off - interruptible");
    800061b0:	00002517          	auipc	a0,0x2
    800061b4:	66850513          	addi	a0,a0,1640 # 80008818 <digits+0x28>
    800061b8:	00000097          	auipc	ra,0x0
    800061bc:	a1a080e7          	jalr	-1510(ra) # 80005bd2 <panic>
    panic("pop_off");
    800061c0:	00002517          	auipc	a0,0x2
    800061c4:	67050513          	addi	a0,a0,1648 # 80008830 <digits+0x40>
    800061c8:	00000097          	auipc	ra,0x0
    800061cc:	a0a080e7          	jalr	-1526(ra) # 80005bd2 <panic>

00000000800061d0 <release>:
{
    800061d0:	1101                	addi	sp,sp,-32
    800061d2:	ec06                	sd	ra,24(sp)
    800061d4:	e822                	sd	s0,16(sp)
    800061d6:	e426                	sd	s1,8(sp)
    800061d8:	1000                	addi	s0,sp,32
    800061da:	84aa                	mv	s1,a0
  if(!holding(lk))
    800061dc:	00000097          	auipc	ra,0x0
    800061e0:	ec6080e7          	jalr	-314(ra) # 800060a2 <holding>
    800061e4:	c115                	beqz	a0,80006208 <release+0x38>
  lk->cpu = 0;
    800061e6:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    800061ea:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    800061ee:	0f50000f          	fence	iorw,ow
    800061f2:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    800061f6:	00000097          	auipc	ra,0x0
    800061fa:	f7a080e7          	jalr	-134(ra) # 80006170 <pop_off>
}
    800061fe:	60e2                	ld	ra,24(sp)
    80006200:	6442                	ld	s0,16(sp)
    80006202:	64a2                	ld	s1,8(sp)
    80006204:	6105                	addi	sp,sp,32
    80006206:	8082                	ret
    panic("release");
    80006208:	00002517          	auipc	a0,0x2
    8000620c:	63050513          	addi	a0,a0,1584 # 80008838 <digits+0x48>
    80006210:	00000097          	auipc	ra,0x0
    80006214:	9c2080e7          	jalr	-1598(ra) # 80005bd2 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051073          	csrw	sscratch,a0
    80007004:	02000537          	lui	a0,0x2000
    80007008:	357d                	addiw	a0,a0,-1
    8000700a:	0536                	slli	a0,a0,0xd
    8000700c:	02153423          	sd	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    80007010:	02253823          	sd	sp,48(a0)
    80007014:	02353c23          	sd	gp,56(a0)
    80007018:	04453023          	sd	tp,64(a0)
    8000701c:	04553423          	sd	t0,72(a0)
    80007020:	04653823          	sd	t1,80(a0)
    80007024:	04753c23          	sd	t2,88(a0)
    80007028:	f120                	sd	s0,96(a0)
    8000702a:	f524                	sd	s1,104(a0)
    8000702c:	fd2c                	sd	a1,120(a0)
    8000702e:	e150                	sd	a2,128(a0)
    80007030:	e554                	sd	a3,136(a0)
    80007032:	e958                	sd	a4,144(a0)
    80007034:	ed5c                	sd	a5,152(a0)
    80007036:	0b053023          	sd	a6,160(a0)
    8000703a:	0b153423          	sd	a7,168(a0)
    8000703e:	0b253823          	sd	s2,176(a0)
    80007042:	0b353c23          	sd	s3,184(a0)
    80007046:	0d453023          	sd	s4,192(a0)
    8000704a:	0d553423          	sd	s5,200(a0)
    8000704e:	0d653823          	sd	s6,208(a0)
    80007052:	0d753c23          	sd	s7,216(a0)
    80007056:	0f853023          	sd	s8,224(a0)
    8000705a:	0f953423          	sd	s9,232(a0)
    8000705e:	0fa53823          	sd	s10,240(a0)
    80007062:	0fb53c23          	sd	s11,248(a0)
    80007066:	11c53023          	sd	t3,256(a0)
    8000706a:	11d53423          	sd	t4,264(a0)
    8000706e:	11e53823          	sd	t5,272(a0)
    80007072:	11f53c23          	sd	t6,280(a0)
    80007076:	140022f3          	csrr	t0,sscratch
    8000707a:	06553823          	sd	t0,112(a0)
    8000707e:	00853103          	ld	sp,8(a0)
    80007082:	02053203          	ld	tp,32(a0)
    80007086:	01053283          	ld	t0,16(a0)
    8000708a:	00053303          	ld	t1,0(a0)
    8000708e:	12000073          	sfence.vma
    80007092:	18031073          	csrw	satp,t1
    80007096:	12000073          	sfence.vma
    8000709a:	8282                	jr	t0

000000008000709c <userret>:
    8000709c:	12000073          	sfence.vma
    800070a0:	18051073          	csrw	satp,a0
    800070a4:	12000073          	sfence.vma
    800070a8:	02000537          	lui	a0,0x2000
    800070ac:	357d                	addiw	a0,a0,-1
    800070ae:	0536                	slli	a0,a0,0xd
    800070b0:	02853083          	ld	ra,40(a0) # 2000028 <_entry-0x7dffffd8>
    800070b4:	03053103          	ld	sp,48(a0)
    800070b8:	03853183          	ld	gp,56(a0)
    800070bc:	04053203          	ld	tp,64(a0)
    800070c0:	04853283          	ld	t0,72(a0)
    800070c4:	05053303          	ld	t1,80(a0)
    800070c8:	05853383          	ld	t2,88(a0)
    800070cc:	7120                	ld	s0,96(a0)
    800070ce:	7524                	ld	s1,104(a0)
    800070d0:	7d2c                	ld	a1,120(a0)
    800070d2:	6150                	ld	a2,128(a0)
    800070d4:	6554                	ld	a3,136(a0)
    800070d6:	6958                	ld	a4,144(a0)
    800070d8:	6d5c                	ld	a5,152(a0)
    800070da:	0a053803          	ld	a6,160(a0)
    800070de:	0a853883          	ld	a7,168(a0)
    800070e2:	0b053903          	ld	s2,176(a0)
    800070e6:	0b853983          	ld	s3,184(a0)
    800070ea:	0c053a03          	ld	s4,192(a0)
    800070ee:	0c853a83          	ld	s5,200(a0)
    800070f2:	0d053b03          	ld	s6,208(a0)
    800070f6:	0d853b83          	ld	s7,216(a0)
    800070fa:	0e053c03          	ld	s8,224(a0)
    800070fe:	0e853c83          	ld	s9,232(a0)
    80007102:	0f053d03          	ld	s10,240(a0)
    80007106:	0f853d83          	ld	s11,248(a0)
    8000710a:	10053e03          	ld	t3,256(a0)
    8000710e:	10853e83          	ld	t4,264(a0)
    80007112:	11053f03          	ld	t5,272(a0)
    80007116:	11853f83          	ld	t6,280(a0)
    8000711a:	7928                	ld	a0,112(a0)
    8000711c:	10200073          	sret
	...
