
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	c00080e7          	jalr	-1024(ra) # 5c10 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	bee080e7          	jalr	-1042(ra) # 5c10 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	0d250513          	addi	a0,a0,210 # 6110 <malloc+0x10a>
      46:	00006097          	auipc	ra,0x6
      4a:	f02080e7          	jalr	-254(ra) # 5f48 <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00006097          	auipc	ra,0x6
      54:	b80080e7          	jalr	-1152(ra) # 5bd0 <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	0000a797          	auipc	a5,0xa
      5c:	51078793          	addi	a5,a5,1296 # a568 <uninit>
      60:	0000d697          	auipc	a3,0xd
      64:	c1868693          	addi	a3,a3,-1000 # cc78 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	0b050513          	addi	a0,a0,176 # 6130 <malloc+0x12a>
      88:	00006097          	auipc	ra,0x6
      8c:	ec0080e7          	jalr	-320(ra) # 5f48 <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00006097          	auipc	ra,0x6
      96:	b3e080e7          	jalr	-1218(ra) # 5bd0 <exit>

000000000000009a <opentest>:
{
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	0a050513          	addi	a0,a0,160 # 6148 <malloc+0x142>
      b0:	00006097          	auipc	ra,0x6
      b4:	b60080e7          	jalr	-1184(ra) # 5c10 <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00006097          	auipc	ra,0x6
      c0:	b3c080e7          	jalr	-1220(ra) # 5bf8 <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	0a250513          	addi	a0,a0,162 # 6168 <malloc+0x162>
      ce:	00006097          	auipc	ra,0x6
      d2:	b42080e7          	jalr	-1214(ra) # 5c10 <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	06a50513          	addi	a0,a0,106 # 6150 <malloc+0x14a>
      ee:	00006097          	auipc	ra,0x6
      f2:	e5a080e7          	jalr	-422(ra) # 5f48 <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00006097          	auipc	ra,0x6
      fc:	ad8080e7          	jalr	-1320(ra) # 5bd0 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	07650513          	addi	a0,a0,118 # 6178 <malloc+0x172>
     10a:	00006097          	auipc	ra,0x6
     10e:	e3e080e7          	jalr	-450(ra) # 5f48 <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00006097          	auipc	ra,0x6
     118:	abc080e7          	jalr	-1348(ra) # 5bd0 <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	07450513          	addi	a0,a0,116 # 61a0 <malloc+0x19a>
     134:	00006097          	auipc	ra,0x6
     138:	aec080e7          	jalr	-1300(ra) # 5c20 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	06050513          	addi	a0,a0,96 # 61a0 <malloc+0x19a>
     148:	00006097          	auipc	ra,0x6
     14c:	ac8080e7          	jalr	-1336(ra) # 5c10 <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	05c58593          	addi	a1,a1,92 # 61b0 <malloc+0x1aa>
     15c:	00006097          	auipc	ra,0x6
     160:	a94080e7          	jalr	-1388(ra) # 5bf0 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	03850513          	addi	a0,a0,56 # 61a0 <malloc+0x19a>
     170:	00006097          	auipc	ra,0x6
     174:	aa0080e7          	jalr	-1376(ra) # 5c10 <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	03c58593          	addi	a1,a1,60 # 61b8 <malloc+0x1b2>
     184:	8526                	mv	a0,s1
     186:	00006097          	auipc	ra,0x6
     18a:	a6a080e7          	jalr	-1430(ra) # 5bf0 <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	00c50513          	addi	a0,a0,12 # 61a0 <malloc+0x19a>
     19c:	00006097          	auipc	ra,0x6
     1a0:	a84080e7          	jalr	-1404(ra) # 5c20 <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00006097          	auipc	ra,0x6
     1aa:	a52080e7          	jalr	-1454(ra) # 5bf8 <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00006097          	auipc	ra,0x6
     1b4:	a48080e7          	jalr	-1464(ra) # 5bf8 <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	ff650513          	addi	a0,a0,-10 # 61c0 <malloc+0x1ba>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	d76080e7          	jalr	-650(ra) # 5f48 <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00006097          	auipc	ra,0x6
     1e0:	9f4080e7          	jalr	-1548(ra) # 5bd0 <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00006097          	auipc	ra,0x6
     214:	a00080e7          	jalr	-1536(ra) # 5c10 <open>
    close(fd);
     218:	00006097          	auipc	ra,0x6
     21c:	9e0080e7          	jalr	-1568(ra) # 5bf8 <close>
  for(i = 0; i < N; i++){
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	andi	s1,s1,255
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00006097          	auipc	ra,0x6
     24a:	9da080e7          	jalr	-1574(ra) # 5c20 <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	andi	s1,s1,255
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	f6c50513          	addi	a0,a0,-148 # 61e8 <malloc+0x1e2>
     284:	00006097          	auipc	ra,0x6
     288:	99c080e7          	jalr	-1636(ra) # 5c20 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	f58a8a93          	addi	s5,s5,-168 # 61e8 <malloc+0x1e2>
      int cc = write(fd, buf, sz);
     298:	0000da17          	auipc	s4,0xd
     29c:	9e0a0a13          	addi	s4,s4,-1568 # cc78 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <fourteen+0x1a3>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00006097          	auipc	ra,0x6
     2b0:	964080e7          	jalr	-1692(ra) # 5c10 <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00006097          	auipc	ra,0x6
     2c2:	932080e7          	jalr	-1742(ra) # 5bf0 <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49463          	bne	s1,a0,330 <bigwrite+0xcc>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00006097          	auipc	ra,0x6
     2d6:	91e080e7          	jalr	-1762(ra) # 5bf0 <write>
      if(cc != sz){
     2da:	04951963          	bne	a0,s1,32c <bigwrite+0xc8>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00006097          	auipc	ra,0x6
     2e4:	918080e7          	jalr	-1768(ra) # 5bf8 <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00006097          	auipc	ra,0x6
     2ee:	936080e7          	jalr	-1738(ra) # 5c20 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	ee650513          	addi	a0,a0,-282 # 61f8 <malloc+0x1f2>
     31a:	00006097          	auipc	ra,0x6
     31e:	c2e080e7          	jalr	-978(ra) # 5f48 <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00006097          	auipc	ra,0x6
     328:	8ac080e7          	jalr	-1876(ra) # 5bd0 <exit>
     32c:	84ce                	mv	s1,s3
      int cc = write(fd, buf, sz);
     32e:	89aa                	mv	s3,a0
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     330:	86ce                	mv	a3,s3
     332:	8626                	mv	a2,s1
     334:	85de                	mv	a1,s7
     336:	00006517          	auipc	a0,0x6
     33a:	ee250513          	addi	a0,a0,-286 # 6218 <malloc+0x212>
     33e:	00006097          	auipc	ra,0x6
     342:	c0a080e7          	jalr	-1014(ra) # 5f48 <printf>
        exit(1);
     346:	4505                	li	a0,1
     348:	00006097          	auipc	ra,0x6
     34c:	888080e7          	jalr	-1912(ra) # 5bd0 <exit>

0000000000000350 <badwrite>:
// file is deleted? if the kernel has this bug, it will panic: balloc:
// out of blocks. assumed_free may need to be raised to be more than
// the number of free blocks. this test takes a long time.
void
badwrite(char *s)
{
     350:	7179                	addi	sp,sp,-48
     352:	f406                	sd	ra,40(sp)
     354:	f022                	sd	s0,32(sp)
     356:	ec26                	sd	s1,24(sp)
     358:	e84a                	sd	s2,16(sp)
     35a:	e44e                	sd	s3,8(sp)
     35c:	e052                	sd	s4,0(sp)
     35e:	1800                	addi	s0,sp,48
  int assumed_free = 600;
  
  unlink("junk");
     360:	00006517          	auipc	a0,0x6
     364:	ed050513          	addi	a0,a0,-304 # 6230 <malloc+0x22a>
     368:	00006097          	auipc	ra,0x6
     36c:	8b8080e7          	jalr	-1864(ra) # 5c20 <unlink>
     370:	25800913          	li	s2,600
  for(int i = 0; i < assumed_free; i++){
    int fd = open("junk", O_CREATE|O_WRONLY);
     374:	00006997          	auipc	s3,0x6
     378:	ebc98993          	addi	s3,s3,-324 # 6230 <malloc+0x22a>
    if(fd < 0){
      printf("open junk failed\n");
      exit(1);
    }
    write(fd, (char*)0xffffffffffL, 1);
     37c:	5a7d                	li	s4,-1
     37e:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
     382:	20100593          	li	a1,513
     386:	854e                	mv	a0,s3
     388:	00006097          	auipc	ra,0x6
     38c:	888080e7          	jalr	-1912(ra) # 5c10 <open>
     390:	84aa                	mv	s1,a0
    if(fd < 0){
     392:	06054b63          	bltz	a0,408 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
     396:	4605                	li	a2,1
     398:	85d2                	mv	a1,s4
     39a:	00006097          	auipc	ra,0x6
     39e:	856080e7          	jalr	-1962(ra) # 5bf0 <write>
    close(fd);
     3a2:	8526                	mv	a0,s1
     3a4:	00006097          	auipc	ra,0x6
     3a8:	854080e7          	jalr	-1964(ra) # 5bf8 <close>
    unlink("junk");
     3ac:	854e                	mv	a0,s3
     3ae:	00006097          	auipc	ra,0x6
     3b2:	872080e7          	jalr	-1934(ra) # 5c20 <unlink>
  for(int i = 0; i < assumed_free; i++){
     3b6:	397d                	addiw	s2,s2,-1
     3b8:	fc0915e3          	bnez	s2,382 <badwrite+0x32>
  }

  int fd = open("junk", O_CREATE|O_WRONLY);
     3bc:	20100593          	li	a1,513
     3c0:	00006517          	auipc	a0,0x6
     3c4:	e7050513          	addi	a0,a0,-400 # 6230 <malloc+0x22a>
     3c8:	00006097          	auipc	ra,0x6
     3cc:	848080e7          	jalr	-1976(ra) # 5c10 <open>
     3d0:	84aa                	mv	s1,a0
  if(fd < 0){
     3d2:	04054863          	bltz	a0,422 <badwrite+0xd2>
    printf("open junk failed\n");
    exit(1);
  }
  if(write(fd, "x", 1) != 1){
     3d6:	4605                	li	a2,1
     3d8:	00006597          	auipc	a1,0x6
     3dc:	de058593          	addi	a1,a1,-544 # 61b8 <malloc+0x1b2>
     3e0:	00006097          	auipc	ra,0x6
     3e4:	810080e7          	jalr	-2032(ra) # 5bf0 <write>
     3e8:	4785                	li	a5,1
     3ea:	04f50963          	beq	a0,a5,43c <badwrite+0xec>
    printf("write failed\n");
     3ee:	00006517          	auipc	a0,0x6
     3f2:	e6250513          	addi	a0,a0,-414 # 6250 <malloc+0x24a>
     3f6:	00006097          	auipc	ra,0x6
     3fa:	b52080e7          	jalr	-1198(ra) # 5f48 <printf>
    exit(1);
     3fe:	4505                	li	a0,1
     400:	00005097          	auipc	ra,0x5
     404:	7d0080e7          	jalr	2000(ra) # 5bd0 <exit>
      printf("open junk failed\n");
     408:	00006517          	auipc	a0,0x6
     40c:	e3050513          	addi	a0,a0,-464 # 6238 <malloc+0x232>
     410:	00006097          	auipc	ra,0x6
     414:	b38080e7          	jalr	-1224(ra) # 5f48 <printf>
      exit(1);
     418:	4505                	li	a0,1
     41a:	00005097          	auipc	ra,0x5
     41e:	7b6080e7          	jalr	1974(ra) # 5bd0 <exit>
    printf("open junk failed\n");
     422:	00006517          	auipc	a0,0x6
     426:	e1650513          	addi	a0,a0,-490 # 6238 <malloc+0x232>
     42a:	00006097          	auipc	ra,0x6
     42e:	b1e080e7          	jalr	-1250(ra) # 5f48 <printf>
    exit(1);
     432:	4505                	li	a0,1
     434:	00005097          	auipc	ra,0x5
     438:	79c080e7          	jalr	1948(ra) # 5bd0 <exit>
  }
  close(fd);
     43c:	8526                	mv	a0,s1
     43e:	00005097          	auipc	ra,0x5
     442:	7ba080e7          	jalr	1978(ra) # 5bf8 <close>
  unlink("junk");
     446:	00006517          	auipc	a0,0x6
     44a:	dea50513          	addi	a0,a0,-534 # 6230 <malloc+0x22a>
     44e:	00005097          	auipc	ra,0x5
     452:	7d2080e7          	jalr	2002(ra) # 5c20 <unlink>

  exit(0);
     456:	4501                	li	a0,0
     458:	00005097          	auipc	ra,0x5
     45c:	778080e7          	jalr	1912(ra) # 5bd0 <exit>

0000000000000460 <outofinodes>:
  }
}

void
outofinodes(char *s)
{
     460:	715d                	addi	sp,sp,-80
     462:	e486                	sd	ra,72(sp)
     464:	e0a2                	sd	s0,64(sp)
     466:	fc26                	sd	s1,56(sp)
     468:	f84a                	sd	s2,48(sp)
     46a:	f44e                	sd	s3,40(sp)
     46c:	0880                	addi	s0,sp,80
  int nzz = 32*32;
  for(int i = 0; i < nzz; i++){
     46e:	4481                	li	s1,0
    char name[32];
    name[0] = 'z';
     470:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     474:	40000993          	li	s3,1024
    name[0] = 'z';
     478:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     47c:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     480:	41f4d79b          	sraiw	a5,s1,0x1f
     484:	01b7d71b          	srliw	a4,a5,0x1b
     488:	009707bb          	addw	a5,a4,s1
     48c:	4057d69b          	sraiw	a3,a5,0x5
     490:	0306869b          	addiw	a3,a3,48
     494:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     498:	8bfd                	andi	a5,a5,31
     49a:	9f99                	subw	a5,a5,a4
     49c:	0307879b          	addiw	a5,a5,48
     4a0:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     4a4:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     4a8:	fb040513          	addi	a0,s0,-80
     4ac:	00005097          	auipc	ra,0x5
     4b0:	774080e7          	jalr	1908(ra) # 5c20 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
     4b4:	60200593          	li	a1,1538
     4b8:	fb040513          	addi	a0,s0,-80
     4bc:	00005097          	auipc	ra,0x5
     4c0:	754080e7          	jalr	1876(ra) # 5c10 <open>
    if(fd < 0){
     4c4:	00054963          	bltz	a0,4d6 <outofinodes+0x76>
      // failure is eventually expected.
      break;
    }
    close(fd);
     4c8:	00005097          	auipc	ra,0x5
     4cc:	730080e7          	jalr	1840(ra) # 5bf8 <close>
  for(int i = 0; i < nzz; i++){
     4d0:	2485                	addiw	s1,s1,1
     4d2:	fb3493e3          	bne	s1,s3,478 <outofinodes+0x18>
     4d6:	4481                	li	s1,0
  }

  for(int i = 0; i < nzz; i++){
    char name[32];
    name[0] = 'z';
     4d8:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
     4dc:	40000993          	li	s3,1024
    name[0] = 'z';
     4e0:	fb240823          	sb	s2,-80(s0)
    name[1] = 'z';
     4e4:	fb2408a3          	sb	s2,-79(s0)
    name[2] = '0' + (i / 32);
     4e8:	41f4d79b          	sraiw	a5,s1,0x1f
     4ec:	01b7d71b          	srliw	a4,a5,0x1b
     4f0:	009707bb          	addw	a5,a4,s1
     4f4:	4057d69b          	sraiw	a3,a5,0x5
     4f8:	0306869b          	addiw	a3,a3,48
     4fc:	fad40923          	sb	a3,-78(s0)
    name[3] = '0' + (i % 32);
     500:	8bfd                	andi	a5,a5,31
     502:	9f99                	subw	a5,a5,a4
     504:	0307879b          	addiw	a5,a5,48
     508:	faf409a3          	sb	a5,-77(s0)
    name[4] = '\0';
     50c:	fa040a23          	sb	zero,-76(s0)
    unlink(name);
     510:	fb040513          	addi	a0,s0,-80
     514:	00005097          	auipc	ra,0x5
     518:	70c080e7          	jalr	1804(ra) # 5c20 <unlink>
  for(int i = 0; i < nzz; i++){
     51c:	2485                	addiw	s1,s1,1
     51e:	fd3491e3          	bne	s1,s3,4e0 <outofinodes+0x80>
  }
}
     522:	60a6                	ld	ra,72(sp)
     524:	6406                	ld	s0,64(sp)
     526:	74e2                	ld	s1,56(sp)
     528:	7942                	ld	s2,48(sp)
     52a:	79a2                	ld	s3,40(sp)
     52c:	6161                	addi	sp,sp,80
     52e:	8082                	ret

0000000000000530 <copyin>:
{
     530:	715d                	addi	sp,sp,-80
     532:	e486                	sd	ra,72(sp)
     534:	e0a2                	sd	s0,64(sp)
     536:	fc26                	sd	s1,56(sp)
     538:	f84a                	sd	s2,48(sp)
     53a:	f44e                	sd	s3,40(sp)
     53c:	f052                	sd	s4,32(sp)
     53e:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     540:	4785                	li	a5,1
     542:	07fe                	slli	a5,a5,0x1f
     544:	fcf43023          	sd	a5,-64(s0)
     548:	57fd                	li	a5,-1
     54a:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     54e:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     552:	00006a17          	auipc	s4,0x6
     556:	d0ea0a13          	addi	s4,s4,-754 # 6260 <malloc+0x25a>
    uint64 addr = addrs[ai];
     55a:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     55e:	20100593          	li	a1,513
     562:	8552                	mv	a0,s4
     564:	00005097          	auipc	ra,0x5
     568:	6ac080e7          	jalr	1708(ra) # 5c10 <open>
     56c:	84aa                	mv	s1,a0
    if(fd < 0){
     56e:	08054863          	bltz	a0,5fe <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     572:	6609                	lui	a2,0x2
     574:	85ce                	mv	a1,s3
     576:	00005097          	auipc	ra,0x5
     57a:	67a080e7          	jalr	1658(ra) # 5bf0 <write>
    if(n >= 0){
     57e:	08055d63          	bgez	a0,618 <copyin+0xe8>
    close(fd);
     582:	8526                	mv	a0,s1
     584:	00005097          	auipc	ra,0x5
     588:	674080e7          	jalr	1652(ra) # 5bf8 <close>
    unlink("copyin1");
     58c:	8552                	mv	a0,s4
     58e:	00005097          	auipc	ra,0x5
     592:	692080e7          	jalr	1682(ra) # 5c20 <unlink>
    n = write(1, (char*)addr, 8192);
     596:	6609                	lui	a2,0x2
     598:	85ce                	mv	a1,s3
     59a:	4505                	li	a0,1
     59c:	00005097          	auipc	ra,0x5
     5a0:	654080e7          	jalr	1620(ra) # 5bf0 <write>
    if(n > 0){
     5a4:	08a04963          	bgtz	a0,636 <copyin+0x106>
    if(pipe(fds) < 0){
     5a8:	fb840513          	addi	a0,s0,-72
     5ac:	00005097          	auipc	ra,0x5
     5b0:	634080e7          	jalr	1588(ra) # 5be0 <pipe>
     5b4:	0a054063          	bltz	a0,654 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     5b8:	6609                	lui	a2,0x2
     5ba:	85ce                	mv	a1,s3
     5bc:	fbc42503          	lw	a0,-68(s0)
     5c0:	00005097          	auipc	ra,0x5
     5c4:	630080e7          	jalr	1584(ra) # 5bf0 <write>
    if(n > 0){
     5c8:	0aa04363          	bgtz	a0,66e <copyin+0x13e>
    close(fds[0]);
     5cc:	fb842503          	lw	a0,-72(s0)
     5d0:	00005097          	auipc	ra,0x5
     5d4:	628080e7          	jalr	1576(ra) # 5bf8 <close>
    close(fds[1]);
     5d8:	fbc42503          	lw	a0,-68(s0)
     5dc:	00005097          	auipc	ra,0x5
     5e0:	61c080e7          	jalr	1564(ra) # 5bf8 <close>
  for(int ai = 0; ai < 2; ai++){
     5e4:	0921                	addi	s2,s2,8
     5e6:	fd040793          	addi	a5,s0,-48
     5ea:	f6f918e3          	bne	s2,a5,55a <copyin+0x2a>
}
     5ee:	60a6                	ld	ra,72(sp)
     5f0:	6406                	ld	s0,64(sp)
     5f2:	74e2                	ld	s1,56(sp)
     5f4:	7942                	ld	s2,48(sp)
     5f6:	79a2                	ld	s3,40(sp)
     5f8:	7a02                	ld	s4,32(sp)
     5fa:	6161                	addi	sp,sp,80
     5fc:	8082                	ret
      printf("open(copyin1) failed\n");
     5fe:	00006517          	auipc	a0,0x6
     602:	c6a50513          	addi	a0,a0,-918 # 6268 <malloc+0x262>
     606:	00006097          	auipc	ra,0x6
     60a:	942080e7          	jalr	-1726(ra) # 5f48 <printf>
      exit(1);
     60e:	4505                	li	a0,1
     610:	00005097          	auipc	ra,0x5
     614:	5c0080e7          	jalr	1472(ra) # 5bd0 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     618:	862a                	mv	a2,a0
     61a:	85ce                	mv	a1,s3
     61c:	00006517          	auipc	a0,0x6
     620:	c6450513          	addi	a0,a0,-924 # 6280 <malloc+0x27a>
     624:	00006097          	auipc	ra,0x6
     628:	924080e7          	jalr	-1756(ra) # 5f48 <printf>
      exit(1);
     62c:	4505                	li	a0,1
     62e:	00005097          	auipc	ra,0x5
     632:	5a2080e7          	jalr	1442(ra) # 5bd0 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     636:	862a                	mv	a2,a0
     638:	85ce                	mv	a1,s3
     63a:	00006517          	auipc	a0,0x6
     63e:	c7650513          	addi	a0,a0,-906 # 62b0 <malloc+0x2aa>
     642:	00006097          	auipc	ra,0x6
     646:	906080e7          	jalr	-1786(ra) # 5f48 <printf>
      exit(1);
     64a:	4505                	li	a0,1
     64c:	00005097          	auipc	ra,0x5
     650:	584080e7          	jalr	1412(ra) # 5bd0 <exit>
      printf("pipe() failed\n");
     654:	00006517          	auipc	a0,0x6
     658:	c8c50513          	addi	a0,a0,-884 # 62e0 <malloc+0x2da>
     65c:	00006097          	auipc	ra,0x6
     660:	8ec080e7          	jalr	-1812(ra) # 5f48 <printf>
      exit(1);
     664:	4505                	li	a0,1
     666:	00005097          	auipc	ra,0x5
     66a:	56a080e7          	jalr	1386(ra) # 5bd0 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     66e:	862a                	mv	a2,a0
     670:	85ce                	mv	a1,s3
     672:	00006517          	auipc	a0,0x6
     676:	c7e50513          	addi	a0,a0,-898 # 62f0 <malloc+0x2ea>
     67a:	00006097          	auipc	ra,0x6
     67e:	8ce080e7          	jalr	-1842(ra) # 5f48 <printf>
      exit(1);
     682:	4505                	li	a0,1
     684:	00005097          	auipc	ra,0x5
     688:	54c080e7          	jalr	1356(ra) # 5bd0 <exit>

000000000000068c <copyout>:
{
     68c:	711d                	addi	sp,sp,-96
     68e:	ec86                	sd	ra,88(sp)
     690:	e8a2                	sd	s0,80(sp)
     692:	e4a6                	sd	s1,72(sp)
     694:	e0ca                	sd	s2,64(sp)
     696:	fc4e                	sd	s3,56(sp)
     698:	f852                	sd	s4,48(sp)
     69a:	f456                	sd	s5,40(sp)
     69c:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     69e:	4785                	li	a5,1
     6a0:	07fe                	slli	a5,a5,0x1f
     6a2:	faf43823          	sd	a5,-80(s0)
     6a6:	57fd                	li	a5,-1
     6a8:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     6ac:	fb040913          	addi	s2,s0,-80
    int fd = open("README", 0);
     6b0:	00006a17          	auipc	s4,0x6
     6b4:	c70a0a13          	addi	s4,s4,-912 # 6320 <malloc+0x31a>
    n = write(fds[1], "x", 1);
     6b8:	00006a97          	auipc	s5,0x6
     6bc:	b00a8a93          	addi	s5,s5,-1280 # 61b8 <malloc+0x1b2>
    uint64 addr = addrs[ai];
     6c0:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     6c4:	4581                	li	a1,0
     6c6:	8552                	mv	a0,s4
     6c8:	00005097          	auipc	ra,0x5
     6cc:	548080e7          	jalr	1352(ra) # 5c10 <open>
     6d0:	84aa                	mv	s1,a0
    if(fd < 0){
     6d2:	08054663          	bltz	a0,75e <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     6d6:	6609                	lui	a2,0x2
     6d8:	85ce                	mv	a1,s3
     6da:	00005097          	auipc	ra,0x5
     6de:	50e080e7          	jalr	1294(ra) # 5be8 <read>
    if(n > 0){
     6e2:	08a04b63          	bgtz	a0,778 <copyout+0xec>
    close(fd);
     6e6:	8526                	mv	a0,s1
     6e8:	00005097          	auipc	ra,0x5
     6ec:	510080e7          	jalr	1296(ra) # 5bf8 <close>
    if(pipe(fds) < 0){
     6f0:	fa840513          	addi	a0,s0,-88
     6f4:	00005097          	auipc	ra,0x5
     6f8:	4ec080e7          	jalr	1260(ra) # 5be0 <pipe>
     6fc:	08054d63          	bltz	a0,796 <copyout+0x10a>
    n = write(fds[1], "x", 1);
     700:	4605                	li	a2,1
     702:	85d6                	mv	a1,s5
     704:	fac42503          	lw	a0,-84(s0)
     708:	00005097          	auipc	ra,0x5
     70c:	4e8080e7          	jalr	1256(ra) # 5bf0 <write>
    if(n != 1){
     710:	4785                	li	a5,1
     712:	08f51f63          	bne	a0,a5,7b0 <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     716:	6609                	lui	a2,0x2
     718:	85ce                	mv	a1,s3
     71a:	fa842503          	lw	a0,-88(s0)
     71e:	00005097          	auipc	ra,0x5
     722:	4ca080e7          	jalr	1226(ra) # 5be8 <read>
    if(n > 0){
     726:	0aa04263          	bgtz	a0,7ca <copyout+0x13e>
    close(fds[0]);
     72a:	fa842503          	lw	a0,-88(s0)
     72e:	00005097          	auipc	ra,0x5
     732:	4ca080e7          	jalr	1226(ra) # 5bf8 <close>
    close(fds[1]);
     736:	fac42503          	lw	a0,-84(s0)
     73a:	00005097          	auipc	ra,0x5
     73e:	4be080e7          	jalr	1214(ra) # 5bf8 <close>
  for(int ai = 0; ai < 2; ai++){
     742:	0921                	addi	s2,s2,8
     744:	fc040793          	addi	a5,s0,-64
     748:	f6f91ce3          	bne	s2,a5,6c0 <copyout+0x34>
}
     74c:	60e6                	ld	ra,88(sp)
     74e:	6446                	ld	s0,80(sp)
     750:	64a6                	ld	s1,72(sp)
     752:	6906                	ld	s2,64(sp)
     754:	79e2                	ld	s3,56(sp)
     756:	7a42                	ld	s4,48(sp)
     758:	7aa2                	ld	s5,40(sp)
     75a:	6125                	addi	sp,sp,96
     75c:	8082                	ret
      printf("open(README) failed\n");
     75e:	00006517          	auipc	a0,0x6
     762:	bca50513          	addi	a0,a0,-1078 # 6328 <malloc+0x322>
     766:	00005097          	auipc	ra,0x5
     76a:	7e2080e7          	jalr	2018(ra) # 5f48 <printf>
      exit(1);
     76e:	4505                	li	a0,1
     770:	00005097          	auipc	ra,0x5
     774:	460080e7          	jalr	1120(ra) # 5bd0 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     778:	862a                	mv	a2,a0
     77a:	85ce                	mv	a1,s3
     77c:	00006517          	auipc	a0,0x6
     780:	bc450513          	addi	a0,a0,-1084 # 6340 <malloc+0x33a>
     784:	00005097          	auipc	ra,0x5
     788:	7c4080e7          	jalr	1988(ra) # 5f48 <printf>
      exit(1);
     78c:	4505                	li	a0,1
     78e:	00005097          	auipc	ra,0x5
     792:	442080e7          	jalr	1090(ra) # 5bd0 <exit>
      printf("pipe() failed\n");
     796:	00006517          	auipc	a0,0x6
     79a:	b4a50513          	addi	a0,a0,-1206 # 62e0 <malloc+0x2da>
     79e:	00005097          	auipc	ra,0x5
     7a2:	7aa080e7          	jalr	1962(ra) # 5f48 <printf>
      exit(1);
     7a6:	4505                	li	a0,1
     7a8:	00005097          	auipc	ra,0x5
     7ac:	428080e7          	jalr	1064(ra) # 5bd0 <exit>
      printf("pipe write failed\n");
     7b0:	00006517          	auipc	a0,0x6
     7b4:	bc050513          	addi	a0,a0,-1088 # 6370 <malloc+0x36a>
     7b8:	00005097          	auipc	ra,0x5
     7bc:	790080e7          	jalr	1936(ra) # 5f48 <printf>
      exit(1);
     7c0:	4505                	li	a0,1
     7c2:	00005097          	auipc	ra,0x5
     7c6:	40e080e7          	jalr	1038(ra) # 5bd0 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     7ca:	862a                	mv	a2,a0
     7cc:	85ce                	mv	a1,s3
     7ce:	00006517          	auipc	a0,0x6
     7d2:	bba50513          	addi	a0,a0,-1094 # 6388 <malloc+0x382>
     7d6:	00005097          	auipc	ra,0x5
     7da:	772080e7          	jalr	1906(ra) # 5f48 <printf>
      exit(1);
     7de:	4505                	li	a0,1
     7e0:	00005097          	auipc	ra,0x5
     7e4:	3f0080e7          	jalr	1008(ra) # 5bd0 <exit>

00000000000007e8 <truncate1>:
{
     7e8:	711d                	addi	sp,sp,-96
     7ea:	ec86                	sd	ra,88(sp)
     7ec:	e8a2                	sd	s0,80(sp)
     7ee:	e4a6                	sd	s1,72(sp)
     7f0:	e0ca                	sd	s2,64(sp)
     7f2:	fc4e                	sd	s3,56(sp)
     7f4:	f852                	sd	s4,48(sp)
     7f6:	f456                	sd	s5,40(sp)
     7f8:	1080                	addi	s0,sp,96
     7fa:	8aaa                	mv	s5,a0
  unlink("truncfile");
     7fc:	00006517          	auipc	a0,0x6
     800:	9a450513          	addi	a0,a0,-1628 # 61a0 <malloc+0x19a>
     804:	00005097          	auipc	ra,0x5
     808:	41c080e7          	jalr	1052(ra) # 5c20 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     80c:	60100593          	li	a1,1537
     810:	00006517          	auipc	a0,0x6
     814:	99050513          	addi	a0,a0,-1648 # 61a0 <malloc+0x19a>
     818:	00005097          	auipc	ra,0x5
     81c:	3f8080e7          	jalr	1016(ra) # 5c10 <open>
     820:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     822:	4611                	li	a2,4
     824:	00006597          	auipc	a1,0x6
     828:	98c58593          	addi	a1,a1,-1652 # 61b0 <malloc+0x1aa>
     82c:	00005097          	auipc	ra,0x5
     830:	3c4080e7          	jalr	964(ra) # 5bf0 <write>
  close(fd1);
     834:	8526                	mv	a0,s1
     836:	00005097          	auipc	ra,0x5
     83a:	3c2080e7          	jalr	962(ra) # 5bf8 <close>
  int fd2 = open("truncfile", O_RDONLY);
     83e:	4581                	li	a1,0
     840:	00006517          	auipc	a0,0x6
     844:	96050513          	addi	a0,a0,-1696 # 61a0 <malloc+0x19a>
     848:	00005097          	auipc	ra,0x5
     84c:	3c8080e7          	jalr	968(ra) # 5c10 <open>
     850:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     852:	02000613          	li	a2,32
     856:	fa040593          	addi	a1,s0,-96
     85a:	00005097          	auipc	ra,0x5
     85e:	38e080e7          	jalr	910(ra) # 5be8 <read>
  if(n != 4){
     862:	4791                	li	a5,4
     864:	0cf51e63          	bne	a0,a5,940 <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     868:	40100593          	li	a1,1025
     86c:	00006517          	auipc	a0,0x6
     870:	93450513          	addi	a0,a0,-1740 # 61a0 <malloc+0x19a>
     874:	00005097          	auipc	ra,0x5
     878:	39c080e7          	jalr	924(ra) # 5c10 <open>
     87c:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     87e:	4581                	li	a1,0
     880:	00006517          	auipc	a0,0x6
     884:	92050513          	addi	a0,a0,-1760 # 61a0 <malloc+0x19a>
     888:	00005097          	auipc	ra,0x5
     88c:	388080e7          	jalr	904(ra) # 5c10 <open>
     890:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     892:	02000613          	li	a2,32
     896:	fa040593          	addi	a1,s0,-96
     89a:	00005097          	auipc	ra,0x5
     89e:	34e080e7          	jalr	846(ra) # 5be8 <read>
     8a2:	8a2a                	mv	s4,a0
  if(n != 0){
     8a4:	ed4d                	bnez	a0,95e <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     8a6:	02000613          	li	a2,32
     8aa:	fa040593          	addi	a1,s0,-96
     8ae:	8526                	mv	a0,s1
     8b0:	00005097          	auipc	ra,0x5
     8b4:	338080e7          	jalr	824(ra) # 5be8 <read>
     8b8:	8a2a                	mv	s4,a0
  if(n != 0){
     8ba:	e971                	bnez	a0,98e <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     8bc:	4619                	li	a2,6
     8be:	00006597          	auipc	a1,0x6
     8c2:	b5a58593          	addi	a1,a1,-1190 # 6418 <malloc+0x412>
     8c6:	854e                	mv	a0,s3
     8c8:	00005097          	auipc	ra,0x5
     8cc:	328080e7          	jalr	808(ra) # 5bf0 <write>
  n = read(fd3, buf, sizeof(buf));
     8d0:	02000613          	li	a2,32
     8d4:	fa040593          	addi	a1,s0,-96
     8d8:	854a                	mv	a0,s2
     8da:	00005097          	auipc	ra,0x5
     8de:	30e080e7          	jalr	782(ra) # 5be8 <read>
  if(n != 6){
     8e2:	4799                	li	a5,6
     8e4:	0cf51d63          	bne	a0,a5,9be <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     8e8:	02000613          	li	a2,32
     8ec:	fa040593          	addi	a1,s0,-96
     8f0:	8526                	mv	a0,s1
     8f2:	00005097          	auipc	ra,0x5
     8f6:	2f6080e7          	jalr	758(ra) # 5be8 <read>
  if(n != 2){
     8fa:	4789                	li	a5,2
     8fc:	0ef51063          	bne	a0,a5,9dc <truncate1+0x1f4>
  unlink("truncfile");
     900:	00006517          	auipc	a0,0x6
     904:	8a050513          	addi	a0,a0,-1888 # 61a0 <malloc+0x19a>
     908:	00005097          	auipc	ra,0x5
     90c:	318080e7          	jalr	792(ra) # 5c20 <unlink>
  close(fd1);
     910:	854e                	mv	a0,s3
     912:	00005097          	auipc	ra,0x5
     916:	2e6080e7          	jalr	742(ra) # 5bf8 <close>
  close(fd2);
     91a:	8526                	mv	a0,s1
     91c:	00005097          	auipc	ra,0x5
     920:	2dc080e7          	jalr	732(ra) # 5bf8 <close>
  close(fd3);
     924:	854a                	mv	a0,s2
     926:	00005097          	auipc	ra,0x5
     92a:	2d2080e7          	jalr	722(ra) # 5bf8 <close>
}
     92e:	60e6                	ld	ra,88(sp)
     930:	6446                	ld	s0,80(sp)
     932:	64a6                	ld	s1,72(sp)
     934:	6906                	ld	s2,64(sp)
     936:	79e2                	ld	s3,56(sp)
     938:	7a42                	ld	s4,48(sp)
     93a:	7aa2                	ld	s5,40(sp)
     93c:	6125                	addi	sp,sp,96
     93e:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     940:	862a                	mv	a2,a0
     942:	85d6                	mv	a1,s5
     944:	00006517          	auipc	a0,0x6
     948:	a7450513          	addi	a0,a0,-1420 # 63b8 <malloc+0x3b2>
     94c:	00005097          	auipc	ra,0x5
     950:	5fc080e7          	jalr	1532(ra) # 5f48 <printf>
    exit(1);
     954:	4505                	li	a0,1
     956:	00005097          	auipc	ra,0x5
     95a:	27a080e7          	jalr	634(ra) # 5bd0 <exit>
    printf("aaa fd3=%d\n", fd3);
     95e:	85ca                	mv	a1,s2
     960:	00006517          	auipc	a0,0x6
     964:	a7850513          	addi	a0,a0,-1416 # 63d8 <malloc+0x3d2>
     968:	00005097          	auipc	ra,0x5
     96c:	5e0080e7          	jalr	1504(ra) # 5f48 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     970:	8652                	mv	a2,s4
     972:	85d6                	mv	a1,s5
     974:	00006517          	auipc	a0,0x6
     978:	a7450513          	addi	a0,a0,-1420 # 63e8 <malloc+0x3e2>
     97c:	00005097          	auipc	ra,0x5
     980:	5cc080e7          	jalr	1484(ra) # 5f48 <printf>
    exit(1);
     984:	4505                	li	a0,1
     986:	00005097          	auipc	ra,0x5
     98a:	24a080e7          	jalr	586(ra) # 5bd0 <exit>
    printf("bbb fd2=%d\n", fd2);
     98e:	85a6                	mv	a1,s1
     990:	00006517          	auipc	a0,0x6
     994:	a7850513          	addi	a0,a0,-1416 # 6408 <malloc+0x402>
     998:	00005097          	auipc	ra,0x5
     99c:	5b0080e7          	jalr	1456(ra) # 5f48 <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     9a0:	8652                	mv	a2,s4
     9a2:	85d6                	mv	a1,s5
     9a4:	00006517          	auipc	a0,0x6
     9a8:	a4450513          	addi	a0,a0,-1468 # 63e8 <malloc+0x3e2>
     9ac:	00005097          	auipc	ra,0x5
     9b0:	59c080e7          	jalr	1436(ra) # 5f48 <printf>
    exit(1);
     9b4:	4505                	li	a0,1
     9b6:	00005097          	auipc	ra,0x5
     9ba:	21a080e7          	jalr	538(ra) # 5bd0 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     9be:	862a                	mv	a2,a0
     9c0:	85d6                	mv	a1,s5
     9c2:	00006517          	auipc	a0,0x6
     9c6:	a5e50513          	addi	a0,a0,-1442 # 6420 <malloc+0x41a>
     9ca:	00005097          	auipc	ra,0x5
     9ce:	57e080e7          	jalr	1406(ra) # 5f48 <printf>
    exit(1);
     9d2:	4505                	li	a0,1
     9d4:	00005097          	auipc	ra,0x5
     9d8:	1fc080e7          	jalr	508(ra) # 5bd0 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     9dc:	862a                	mv	a2,a0
     9de:	85d6                	mv	a1,s5
     9e0:	00006517          	auipc	a0,0x6
     9e4:	a6050513          	addi	a0,a0,-1440 # 6440 <malloc+0x43a>
     9e8:	00005097          	auipc	ra,0x5
     9ec:	560080e7          	jalr	1376(ra) # 5f48 <printf>
    exit(1);
     9f0:	4505                	li	a0,1
     9f2:	00005097          	auipc	ra,0x5
     9f6:	1de080e7          	jalr	478(ra) # 5bd0 <exit>

00000000000009fa <writetest>:
{
     9fa:	7139                	addi	sp,sp,-64
     9fc:	fc06                	sd	ra,56(sp)
     9fe:	f822                	sd	s0,48(sp)
     a00:	f426                	sd	s1,40(sp)
     a02:	f04a                	sd	s2,32(sp)
     a04:	ec4e                	sd	s3,24(sp)
     a06:	e852                	sd	s4,16(sp)
     a08:	e456                	sd	s5,8(sp)
     a0a:	e05a                	sd	s6,0(sp)
     a0c:	0080                	addi	s0,sp,64
     a0e:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     a10:	20200593          	li	a1,514
     a14:	00006517          	auipc	a0,0x6
     a18:	a4c50513          	addi	a0,a0,-1460 # 6460 <malloc+0x45a>
     a1c:	00005097          	auipc	ra,0x5
     a20:	1f4080e7          	jalr	500(ra) # 5c10 <open>
  if(fd < 0){
     a24:	0a054d63          	bltz	a0,ade <writetest+0xe4>
     a28:	892a                	mv	s2,a0
     a2a:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a2c:	00006997          	auipc	s3,0x6
     a30:	a5c98993          	addi	s3,s3,-1444 # 6488 <malloc+0x482>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a34:	00006a97          	auipc	s5,0x6
     a38:	a8ca8a93          	addi	s5,s5,-1396 # 64c0 <malloc+0x4ba>
  for(i = 0; i < N; i++){
     a3c:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     a40:	4629                	li	a2,10
     a42:	85ce                	mv	a1,s3
     a44:	854a                	mv	a0,s2
     a46:	00005097          	auipc	ra,0x5
     a4a:	1aa080e7          	jalr	426(ra) # 5bf0 <write>
     a4e:	47a9                	li	a5,10
     a50:	0af51563          	bne	a0,a5,afa <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     a54:	4629                	li	a2,10
     a56:	85d6                	mv	a1,s5
     a58:	854a                	mv	a0,s2
     a5a:	00005097          	auipc	ra,0x5
     a5e:	196080e7          	jalr	406(ra) # 5bf0 <write>
     a62:	47a9                	li	a5,10
     a64:	0af51a63          	bne	a0,a5,b18 <writetest+0x11e>
  for(i = 0; i < N; i++){
     a68:	2485                	addiw	s1,s1,1
     a6a:	fd449be3          	bne	s1,s4,a40 <writetest+0x46>
  close(fd);
     a6e:	854a                	mv	a0,s2
     a70:	00005097          	auipc	ra,0x5
     a74:	188080e7          	jalr	392(ra) # 5bf8 <close>
  fd = open("small", O_RDONLY);
     a78:	4581                	li	a1,0
     a7a:	00006517          	auipc	a0,0x6
     a7e:	9e650513          	addi	a0,a0,-1562 # 6460 <malloc+0x45a>
     a82:	00005097          	auipc	ra,0x5
     a86:	18e080e7          	jalr	398(ra) # 5c10 <open>
     a8a:	84aa                	mv	s1,a0
  if(fd < 0){
     a8c:	0a054563          	bltz	a0,b36 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     a90:	7d000613          	li	a2,2000
     a94:	0000c597          	auipc	a1,0xc
     a98:	1e458593          	addi	a1,a1,484 # cc78 <buf>
     a9c:	00005097          	auipc	ra,0x5
     aa0:	14c080e7          	jalr	332(ra) # 5be8 <read>
  if(i != N*SZ*2){
     aa4:	7d000793          	li	a5,2000
     aa8:	0af51563          	bne	a0,a5,b52 <writetest+0x158>
  close(fd);
     aac:	8526                	mv	a0,s1
     aae:	00005097          	auipc	ra,0x5
     ab2:	14a080e7          	jalr	330(ra) # 5bf8 <close>
  if(unlink("small") < 0){
     ab6:	00006517          	auipc	a0,0x6
     aba:	9aa50513          	addi	a0,a0,-1622 # 6460 <malloc+0x45a>
     abe:	00005097          	auipc	ra,0x5
     ac2:	162080e7          	jalr	354(ra) # 5c20 <unlink>
     ac6:	0a054463          	bltz	a0,b6e <writetest+0x174>
}
     aca:	70e2                	ld	ra,56(sp)
     acc:	7442                	ld	s0,48(sp)
     ace:	74a2                	ld	s1,40(sp)
     ad0:	7902                	ld	s2,32(sp)
     ad2:	69e2                	ld	s3,24(sp)
     ad4:	6a42                	ld	s4,16(sp)
     ad6:	6aa2                	ld	s5,8(sp)
     ad8:	6b02                	ld	s6,0(sp)
     ada:	6121                	addi	sp,sp,64
     adc:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     ade:	85da                	mv	a1,s6
     ae0:	00006517          	auipc	a0,0x6
     ae4:	98850513          	addi	a0,a0,-1656 # 6468 <malloc+0x462>
     ae8:	00005097          	auipc	ra,0x5
     aec:	460080e7          	jalr	1120(ra) # 5f48 <printf>
    exit(1);
     af0:	4505                	li	a0,1
     af2:	00005097          	auipc	ra,0x5
     af6:	0de080e7          	jalr	222(ra) # 5bd0 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     afa:	8626                	mv	a2,s1
     afc:	85da                	mv	a1,s6
     afe:	00006517          	auipc	a0,0x6
     b02:	99a50513          	addi	a0,a0,-1638 # 6498 <malloc+0x492>
     b06:	00005097          	auipc	ra,0x5
     b0a:	442080e7          	jalr	1090(ra) # 5f48 <printf>
      exit(1);
     b0e:	4505                	li	a0,1
     b10:	00005097          	auipc	ra,0x5
     b14:	0c0080e7          	jalr	192(ra) # 5bd0 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     b18:	8626                	mv	a2,s1
     b1a:	85da                	mv	a1,s6
     b1c:	00006517          	auipc	a0,0x6
     b20:	9b450513          	addi	a0,a0,-1612 # 64d0 <malloc+0x4ca>
     b24:	00005097          	auipc	ra,0x5
     b28:	424080e7          	jalr	1060(ra) # 5f48 <printf>
      exit(1);
     b2c:	4505                	li	a0,1
     b2e:	00005097          	auipc	ra,0x5
     b32:	0a2080e7          	jalr	162(ra) # 5bd0 <exit>
    printf("%s: error: open small failed!\n", s);
     b36:	85da                	mv	a1,s6
     b38:	00006517          	auipc	a0,0x6
     b3c:	9c050513          	addi	a0,a0,-1600 # 64f8 <malloc+0x4f2>
     b40:	00005097          	auipc	ra,0x5
     b44:	408080e7          	jalr	1032(ra) # 5f48 <printf>
    exit(1);
     b48:	4505                	li	a0,1
     b4a:	00005097          	auipc	ra,0x5
     b4e:	086080e7          	jalr	134(ra) # 5bd0 <exit>
    printf("%s: read failed\n", s);
     b52:	85da                	mv	a1,s6
     b54:	00006517          	auipc	a0,0x6
     b58:	9c450513          	addi	a0,a0,-1596 # 6518 <malloc+0x512>
     b5c:	00005097          	auipc	ra,0x5
     b60:	3ec080e7          	jalr	1004(ra) # 5f48 <printf>
    exit(1);
     b64:	4505                	li	a0,1
     b66:	00005097          	auipc	ra,0x5
     b6a:	06a080e7          	jalr	106(ra) # 5bd0 <exit>
    printf("%s: unlink small failed\n", s);
     b6e:	85da                	mv	a1,s6
     b70:	00006517          	auipc	a0,0x6
     b74:	9c050513          	addi	a0,a0,-1600 # 6530 <malloc+0x52a>
     b78:	00005097          	auipc	ra,0x5
     b7c:	3d0080e7          	jalr	976(ra) # 5f48 <printf>
    exit(1);
     b80:	4505                	li	a0,1
     b82:	00005097          	auipc	ra,0x5
     b86:	04e080e7          	jalr	78(ra) # 5bd0 <exit>

0000000000000b8a <writebig>:
{
     b8a:	7139                	addi	sp,sp,-64
     b8c:	fc06                	sd	ra,56(sp)
     b8e:	f822                	sd	s0,48(sp)
     b90:	f426                	sd	s1,40(sp)
     b92:	f04a                	sd	s2,32(sp)
     b94:	ec4e                	sd	s3,24(sp)
     b96:	e852                	sd	s4,16(sp)
     b98:	e456                	sd	s5,8(sp)
     b9a:	0080                	addi	s0,sp,64
     b9c:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     b9e:	20200593          	li	a1,514
     ba2:	00006517          	auipc	a0,0x6
     ba6:	9ae50513          	addi	a0,a0,-1618 # 6550 <malloc+0x54a>
     baa:	00005097          	auipc	ra,0x5
     bae:	066080e7          	jalr	102(ra) # 5c10 <open>
     bb2:	89aa                	mv	s3,a0
  for(i = 0; i < MAXFILE; i++){
     bb4:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     bb6:	0000c917          	auipc	s2,0xc
     bba:	0c290913          	addi	s2,s2,194 # cc78 <buf>
  for(i = 0; i < MAXFILE; i++){
     bbe:	10c00a13          	li	s4,268
  if(fd < 0){
     bc2:	06054c63          	bltz	a0,c3a <writebig+0xb0>
    ((int*)buf)[0] = i;
     bc6:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     bca:	40000613          	li	a2,1024
     bce:	85ca                	mv	a1,s2
     bd0:	854e                	mv	a0,s3
     bd2:	00005097          	auipc	ra,0x5
     bd6:	01e080e7          	jalr	30(ra) # 5bf0 <write>
     bda:	40000793          	li	a5,1024
     bde:	06f51c63          	bne	a0,a5,c56 <writebig+0xcc>
  for(i = 0; i < MAXFILE; i++){
     be2:	2485                	addiw	s1,s1,1
     be4:	ff4491e3          	bne	s1,s4,bc6 <writebig+0x3c>
  close(fd);
     be8:	854e                	mv	a0,s3
     bea:	00005097          	auipc	ra,0x5
     bee:	00e080e7          	jalr	14(ra) # 5bf8 <close>
  fd = open("big", O_RDONLY);
     bf2:	4581                	li	a1,0
     bf4:	00006517          	auipc	a0,0x6
     bf8:	95c50513          	addi	a0,a0,-1700 # 6550 <malloc+0x54a>
     bfc:	00005097          	auipc	ra,0x5
     c00:	014080e7          	jalr	20(ra) # 5c10 <open>
     c04:	89aa                	mv	s3,a0
  n = 0;
     c06:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     c08:	0000c917          	auipc	s2,0xc
     c0c:	07090913          	addi	s2,s2,112 # cc78 <buf>
  if(fd < 0){
     c10:	06054263          	bltz	a0,c74 <writebig+0xea>
    i = read(fd, buf, BSIZE);
     c14:	40000613          	li	a2,1024
     c18:	85ca                	mv	a1,s2
     c1a:	854e                	mv	a0,s3
     c1c:	00005097          	auipc	ra,0x5
     c20:	fcc080e7          	jalr	-52(ra) # 5be8 <read>
    if(i == 0){
     c24:	c535                	beqz	a0,c90 <writebig+0x106>
    } else if(i != BSIZE){
     c26:	40000793          	li	a5,1024
     c2a:	0af51f63          	bne	a0,a5,ce8 <writebig+0x15e>
    if(((int*)buf)[0] != n){
     c2e:	00092683          	lw	a3,0(s2)
     c32:	0c969a63          	bne	a3,s1,d06 <writebig+0x17c>
    n++;
     c36:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     c38:	bff1                	j	c14 <writebig+0x8a>
    printf("%s: error: creat big failed!\n", s);
     c3a:	85d6                	mv	a1,s5
     c3c:	00006517          	auipc	a0,0x6
     c40:	91c50513          	addi	a0,a0,-1764 # 6558 <malloc+0x552>
     c44:	00005097          	auipc	ra,0x5
     c48:	304080e7          	jalr	772(ra) # 5f48 <printf>
    exit(1);
     c4c:	4505                	li	a0,1
     c4e:	00005097          	auipc	ra,0x5
     c52:	f82080e7          	jalr	-126(ra) # 5bd0 <exit>
      printf("%s: error: write big file failed\n", s, i);
     c56:	8626                	mv	a2,s1
     c58:	85d6                	mv	a1,s5
     c5a:	00006517          	auipc	a0,0x6
     c5e:	91e50513          	addi	a0,a0,-1762 # 6578 <malloc+0x572>
     c62:	00005097          	auipc	ra,0x5
     c66:	2e6080e7          	jalr	742(ra) # 5f48 <printf>
      exit(1);
     c6a:	4505                	li	a0,1
     c6c:	00005097          	auipc	ra,0x5
     c70:	f64080e7          	jalr	-156(ra) # 5bd0 <exit>
    printf("%s: error: open big failed!\n", s);
     c74:	85d6                	mv	a1,s5
     c76:	00006517          	auipc	a0,0x6
     c7a:	92a50513          	addi	a0,a0,-1750 # 65a0 <malloc+0x59a>
     c7e:	00005097          	auipc	ra,0x5
     c82:	2ca080e7          	jalr	714(ra) # 5f48 <printf>
    exit(1);
     c86:	4505                	li	a0,1
     c88:	00005097          	auipc	ra,0x5
     c8c:	f48080e7          	jalr	-184(ra) # 5bd0 <exit>
      if(n == MAXFILE - 1){
     c90:	10b00793          	li	a5,267
     c94:	02f48a63          	beq	s1,a5,cc8 <writebig+0x13e>
  close(fd);
     c98:	854e                	mv	a0,s3
     c9a:	00005097          	auipc	ra,0x5
     c9e:	f5e080e7          	jalr	-162(ra) # 5bf8 <close>
  if(unlink("big") < 0){
     ca2:	00006517          	auipc	a0,0x6
     ca6:	8ae50513          	addi	a0,a0,-1874 # 6550 <malloc+0x54a>
     caa:	00005097          	auipc	ra,0x5
     cae:	f76080e7          	jalr	-138(ra) # 5c20 <unlink>
     cb2:	06054963          	bltz	a0,d24 <writebig+0x19a>
}
     cb6:	70e2                	ld	ra,56(sp)
     cb8:	7442                	ld	s0,48(sp)
     cba:	74a2                	ld	s1,40(sp)
     cbc:	7902                	ld	s2,32(sp)
     cbe:	69e2                	ld	s3,24(sp)
     cc0:	6a42                	ld	s4,16(sp)
     cc2:	6aa2                	ld	s5,8(sp)
     cc4:	6121                	addi	sp,sp,64
     cc6:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     cc8:	10b00613          	li	a2,267
     ccc:	85d6                	mv	a1,s5
     cce:	00006517          	auipc	a0,0x6
     cd2:	8f250513          	addi	a0,a0,-1806 # 65c0 <malloc+0x5ba>
     cd6:	00005097          	auipc	ra,0x5
     cda:	272080e7          	jalr	626(ra) # 5f48 <printf>
        exit(1);
     cde:	4505                	li	a0,1
     ce0:	00005097          	auipc	ra,0x5
     ce4:	ef0080e7          	jalr	-272(ra) # 5bd0 <exit>
      printf("%s: read failed %d\n", s, i);
     ce8:	862a                	mv	a2,a0
     cea:	85d6                	mv	a1,s5
     cec:	00006517          	auipc	a0,0x6
     cf0:	8fc50513          	addi	a0,a0,-1796 # 65e8 <malloc+0x5e2>
     cf4:	00005097          	auipc	ra,0x5
     cf8:	254080e7          	jalr	596(ra) # 5f48 <printf>
      exit(1);
     cfc:	4505                	li	a0,1
     cfe:	00005097          	auipc	ra,0x5
     d02:	ed2080e7          	jalr	-302(ra) # 5bd0 <exit>
      printf("%s: read content of block %d is %d\n", s,
     d06:	8626                	mv	a2,s1
     d08:	85d6                	mv	a1,s5
     d0a:	00006517          	auipc	a0,0x6
     d0e:	8f650513          	addi	a0,a0,-1802 # 6600 <malloc+0x5fa>
     d12:	00005097          	auipc	ra,0x5
     d16:	236080e7          	jalr	566(ra) # 5f48 <printf>
      exit(1);
     d1a:	4505                	li	a0,1
     d1c:	00005097          	auipc	ra,0x5
     d20:	eb4080e7          	jalr	-332(ra) # 5bd0 <exit>
    printf("%s: unlink big failed\n", s);
     d24:	85d6                	mv	a1,s5
     d26:	00006517          	auipc	a0,0x6
     d2a:	90250513          	addi	a0,a0,-1790 # 6628 <malloc+0x622>
     d2e:	00005097          	auipc	ra,0x5
     d32:	21a080e7          	jalr	538(ra) # 5f48 <printf>
    exit(1);
     d36:	4505                	li	a0,1
     d38:	00005097          	auipc	ra,0x5
     d3c:	e98080e7          	jalr	-360(ra) # 5bd0 <exit>

0000000000000d40 <unlinkread>:
{
     d40:	7179                	addi	sp,sp,-48
     d42:	f406                	sd	ra,40(sp)
     d44:	f022                	sd	s0,32(sp)
     d46:	ec26                	sd	s1,24(sp)
     d48:	e84a                	sd	s2,16(sp)
     d4a:	e44e                	sd	s3,8(sp)
     d4c:	1800                	addi	s0,sp,48
     d4e:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     d50:	20200593          	li	a1,514
     d54:	00006517          	auipc	a0,0x6
     d58:	8ec50513          	addi	a0,a0,-1812 # 6640 <malloc+0x63a>
     d5c:	00005097          	auipc	ra,0x5
     d60:	eb4080e7          	jalr	-332(ra) # 5c10 <open>
  if(fd < 0){
     d64:	0e054563          	bltz	a0,e4e <unlinkread+0x10e>
     d68:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     d6a:	4615                	li	a2,5
     d6c:	00006597          	auipc	a1,0x6
     d70:	90458593          	addi	a1,a1,-1788 # 6670 <malloc+0x66a>
     d74:	00005097          	auipc	ra,0x5
     d78:	e7c080e7          	jalr	-388(ra) # 5bf0 <write>
  close(fd);
     d7c:	8526                	mv	a0,s1
     d7e:	00005097          	auipc	ra,0x5
     d82:	e7a080e7          	jalr	-390(ra) # 5bf8 <close>
  fd = open("unlinkread", O_RDWR);
     d86:	4589                	li	a1,2
     d88:	00006517          	auipc	a0,0x6
     d8c:	8b850513          	addi	a0,a0,-1864 # 6640 <malloc+0x63a>
     d90:	00005097          	auipc	ra,0x5
     d94:	e80080e7          	jalr	-384(ra) # 5c10 <open>
     d98:	84aa                	mv	s1,a0
  if(fd < 0){
     d9a:	0c054863          	bltz	a0,e6a <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     d9e:	00006517          	auipc	a0,0x6
     da2:	8a250513          	addi	a0,a0,-1886 # 6640 <malloc+0x63a>
     da6:	00005097          	auipc	ra,0x5
     daa:	e7a080e7          	jalr	-390(ra) # 5c20 <unlink>
     dae:	ed61                	bnez	a0,e86 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     db0:	20200593          	li	a1,514
     db4:	00006517          	auipc	a0,0x6
     db8:	88c50513          	addi	a0,a0,-1908 # 6640 <malloc+0x63a>
     dbc:	00005097          	auipc	ra,0x5
     dc0:	e54080e7          	jalr	-428(ra) # 5c10 <open>
     dc4:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     dc6:	460d                	li	a2,3
     dc8:	00006597          	auipc	a1,0x6
     dcc:	8f058593          	addi	a1,a1,-1808 # 66b8 <malloc+0x6b2>
     dd0:	00005097          	auipc	ra,0x5
     dd4:	e20080e7          	jalr	-480(ra) # 5bf0 <write>
  close(fd1);
     dd8:	854a                	mv	a0,s2
     dda:	00005097          	auipc	ra,0x5
     dde:	e1e080e7          	jalr	-482(ra) # 5bf8 <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     de2:	660d                	lui	a2,0x3
     de4:	0000c597          	auipc	a1,0xc
     de8:	e9458593          	addi	a1,a1,-364 # cc78 <buf>
     dec:	8526                	mv	a0,s1
     dee:	00005097          	auipc	ra,0x5
     df2:	dfa080e7          	jalr	-518(ra) # 5be8 <read>
     df6:	4795                	li	a5,5
     df8:	0af51563          	bne	a0,a5,ea2 <unlinkread+0x162>
  if(buf[0] != 'h'){
     dfc:	0000c717          	auipc	a4,0xc
     e00:	e7c74703          	lbu	a4,-388(a4) # cc78 <buf>
     e04:	06800793          	li	a5,104
     e08:	0af71b63          	bne	a4,a5,ebe <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     e0c:	4629                	li	a2,10
     e0e:	0000c597          	auipc	a1,0xc
     e12:	e6a58593          	addi	a1,a1,-406 # cc78 <buf>
     e16:	8526                	mv	a0,s1
     e18:	00005097          	auipc	ra,0x5
     e1c:	dd8080e7          	jalr	-552(ra) # 5bf0 <write>
     e20:	47a9                	li	a5,10
     e22:	0af51c63          	bne	a0,a5,eda <unlinkread+0x19a>
  close(fd);
     e26:	8526                	mv	a0,s1
     e28:	00005097          	auipc	ra,0x5
     e2c:	dd0080e7          	jalr	-560(ra) # 5bf8 <close>
  unlink("unlinkread");
     e30:	00006517          	auipc	a0,0x6
     e34:	81050513          	addi	a0,a0,-2032 # 6640 <malloc+0x63a>
     e38:	00005097          	auipc	ra,0x5
     e3c:	de8080e7          	jalr	-536(ra) # 5c20 <unlink>
}
     e40:	70a2                	ld	ra,40(sp)
     e42:	7402                	ld	s0,32(sp)
     e44:	64e2                	ld	s1,24(sp)
     e46:	6942                	ld	s2,16(sp)
     e48:	69a2                	ld	s3,8(sp)
     e4a:	6145                	addi	sp,sp,48
     e4c:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     e4e:	85ce                	mv	a1,s3
     e50:	00006517          	auipc	a0,0x6
     e54:	80050513          	addi	a0,a0,-2048 # 6650 <malloc+0x64a>
     e58:	00005097          	auipc	ra,0x5
     e5c:	0f0080e7          	jalr	240(ra) # 5f48 <printf>
    exit(1);
     e60:	4505                	li	a0,1
     e62:	00005097          	auipc	ra,0x5
     e66:	d6e080e7          	jalr	-658(ra) # 5bd0 <exit>
    printf("%s: open unlinkread failed\n", s);
     e6a:	85ce                	mv	a1,s3
     e6c:	00006517          	auipc	a0,0x6
     e70:	80c50513          	addi	a0,a0,-2036 # 6678 <malloc+0x672>
     e74:	00005097          	auipc	ra,0x5
     e78:	0d4080e7          	jalr	212(ra) # 5f48 <printf>
    exit(1);
     e7c:	4505                	li	a0,1
     e7e:	00005097          	auipc	ra,0x5
     e82:	d52080e7          	jalr	-686(ra) # 5bd0 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     e86:	85ce                	mv	a1,s3
     e88:	00006517          	auipc	a0,0x6
     e8c:	81050513          	addi	a0,a0,-2032 # 6698 <malloc+0x692>
     e90:	00005097          	auipc	ra,0x5
     e94:	0b8080e7          	jalr	184(ra) # 5f48 <printf>
    exit(1);
     e98:	4505                	li	a0,1
     e9a:	00005097          	auipc	ra,0x5
     e9e:	d36080e7          	jalr	-714(ra) # 5bd0 <exit>
    printf("%s: unlinkread read failed", s);
     ea2:	85ce                	mv	a1,s3
     ea4:	00006517          	auipc	a0,0x6
     ea8:	81c50513          	addi	a0,a0,-2020 # 66c0 <malloc+0x6ba>
     eac:	00005097          	auipc	ra,0x5
     eb0:	09c080e7          	jalr	156(ra) # 5f48 <printf>
    exit(1);
     eb4:	4505                	li	a0,1
     eb6:	00005097          	auipc	ra,0x5
     eba:	d1a080e7          	jalr	-742(ra) # 5bd0 <exit>
    printf("%s: unlinkread wrong data\n", s);
     ebe:	85ce                	mv	a1,s3
     ec0:	00006517          	auipc	a0,0x6
     ec4:	82050513          	addi	a0,a0,-2016 # 66e0 <malloc+0x6da>
     ec8:	00005097          	auipc	ra,0x5
     ecc:	080080e7          	jalr	128(ra) # 5f48 <printf>
    exit(1);
     ed0:	4505                	li	a0,1
     ed2:	00005097          	auipc	ra,0x5
     ed6:	cfe080e7          	jalr	-770(ra) # 5bd0 <exit>
    printf("%s: unlinkread write failed\n", s);
     eda:	85ce                	mv	a1,s3
     edc:	00006517          	auipc	a0,0x6
     ee0:	82450513          	addi	a0,a0,-2012 # 6700 <malloc+0x6fa>
     ee4:	00005097          	auipc	ra,0x5
     ee8:	064080e7          	jalr	100(ra) # 5f48 <printf>
    exit(1);
     eec:	4505                	li	a0,1
     eee:	00005097          	auipc	ra,0x5
     ef2:	ce2080e7          	jalr	-798(ra) # 5bd0 <exit>

0000000000000ef6 <linktest>:
{
     ef6:	1101                	addi	sp,sp,-32
     ef8:	ec06                	sd	ra,24(sp)
     efa:	e822                	sd	s0,16(sp)
     efc:	e426                	sd	s1,8(sp)
     efe:	e04a                	sd	s2,0(sp)
     f00:	1000                	addi	s0,sp,32
     f02:	892a                	mv	s2,a0
  unlink("lf1");
     f04:	00006517          	auipc	a0,0x6
     f08:	81c50513          	addi	a0,a0,-2020 # 6720 <malloc+0x71a>
     f0c:	00005097          	auipc	ra,0x5
     f10:	d14080e7          	jalr	-748(ra) # 5c20 <unlink>
  unlink("lf2");
     f14:	00006517          	auipc	a0,0x6
     f18:	81450513          	addi	a0,a0,-2028 # 6728 <malloc+0x722>
     f1c:	00005097          	auipc	ra,0x5
     f20:	d04080e7          	jalr	-764(ra) # 5c20 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     f24:	20200593          	li	a1,514
     f28:	00005517          	auipc	a0,0x5
     f2c:	7f850513          	addi	a0,a0,2040 # 6720 <malloc+0x71a>
     f30:	00005097          	auipc	ra,0x5
     f34:	ce0080e7          	jalr	-800(ra) # 5c10 <open>
  if(fd < 0){
     f38:	10054763          	bltz	a0,1046 <linktest+0x150>
     f3c:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     f3e:	4615                	li	a2,5
     f40:	00005597          	auipc	a1,0x5
     f44:	73058593          	addi	a1,a1,1840 # 6670 <malloc+0x66a>
     f48:	00005097          	auipc	ra,0x5
     f4c:	ca8080e7          	jalr	-856(ra) # 5bf0 <write>
     f50:	4795                	li	a5,5
     f52:	10f51863          	bne	a0,a5,1062 <linktest+0x16c>
  close(fd);
     f56:	8526                	mv	a0,s1
     f58:	00005097          	auipc	ra,0x5
     f5c:	ca0080e7          	jalr	-864(ra) # 5bf8 <close>
  if(link("lf1", "lf2") < 0){
     f60:	00005597          	auipc	a1,0x5
     f64:	7c858593          	addi	a1,a1,1992 # 6728 <malloc+0x722>
     f68:	00005517          	auipc	a0,0x5
     f6c:	7b850513          	addi	a0,a0,1976 # 6720 <malloc+0x71a>
     f70:	00005097          	auipc	ra,0x5
     f74:	cc0080e7          	jalr	-832(ra) # 5c30 <link>
     f78:	10054363          	bltz	a0,107e <linktest+0x188>
  unlink("lf1");
     f7c:	00005517          	auipc	a0,0x5
     f80:	7a450513          	addi	a0,a0,1956 # 6720 <malloc+0x71a>
     f84:	00005097          	auipc	ra,0x5
     f88:	c9c080e7          	jalr	-868(ra) # 5c20 <unlink>
  if(open("lf1", 0) >= 0){
     f8c:	4581                	li	a1,0
     f8e:	00005517          	auipc	a0,0x5
     f92:	79250513          	addi	a0,a0,1938 # 6720 <malloc+0x71a>
     f96:	00005097          	auipc	ra,0x5
     f9a:	c7a080e7          	jalr	-902(ra) # 5c10 <open>
     f9e:	0e055e63          	bgez	a0,109a <linktest+0x1a4>
  fd = open("lf2", 0);
     fa2:	4581                	li	a1,0
     fa4:	00005517          	auipc	a0,0x5
     fa8:	78450513          	addi	a0,a0,1924 # 6728 <malloc+0x722>
     fac:	00005097          	auipc	ra,0x5
     fb0:	c64080e7          	jalr	-924(ra) # 5c10 <open>
     fb4:	84aa                	mv	s1,a0
  if(fd < 0){
     fb6:	10054063          	bltz	a0,10b6 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     fba:	660d                	lui	a2,0x3
     fbc:	0000c597          	auipc	a1,0xc
     fc0:	cbc58593          	addi	a1,a1,-836 # cc78 <buf>
     fc4:	00005097          	auipc	ra,0x5
     fc8:	c24080e7          	jalr	-988(ra) # 5be8 <read>
     fcc:	4795                	li	a5,5
     fce:	10f51263          	bne	a0,a5,10d2 <linktest+0x1dc>
  close(fd);
     fd2:	8526                	mv	a0,s1
     fd4:	00005097          	auipc	ra,0x5
     fd8:	c24080e7          	jalr	-988(ra) # 5bf8 <close>
  if(link("lf2", "lf2") >= 0){
     fdc:	00005597          	auipc	a1,0x5
     fe0:	74c58593          	addi	a1,a1,1868 # 6728 <malloc+0x722>
     fe4:	852e                	mv	a0,a1
     fe6:	00005097          	auipc	ra,0x5
     fea:	c4a080e7          	jalr	-950(ra) # 5c30 <link>
     fee:	10055063          	bgez	a0,10ee <linktest+0x1f8>
  unlink("lf2");
     ff2:	00005517          	auipc	a0,0x5
     ff6:	73650513          	addi	a0,a0,1846 # 6728 <malloc+0x722>
     ffa:	00005097          	auipc	ra,0x5
     ffe:	c26080e7          	jalr	-986(ra) # 5c20 <unlink>
  if(link("lf2", "lf1") >= 0){
    1002:	00005597          	auipc	a1,0x5
    1006:	71e58593          	addi	a1,a1,1822 # 6720 <malloc+0x71a>
    100a:	00005517          	auipc	a0,0x5
    100e:	71e50513          	addi	a0,a0,1822 # 6728 <malloc+0x722>
    1012:	00005097          	auipc	ra,0x5
    1016:	c1e080e7          	jalr	-994(ra) # 5c30 <link>
    101a:	0e055863          	bgez	a0,110a <linktest+0x214>
  if(link(".", "lf1") >= 0){
    101e:	00005597          	auipc	a1,0x5
    1022:	70258593          	addi	a1,a1,1794 # 6720 <malloc+0x71a>
    1026:	00006517          	auipc	a0,0x6
    102a:	80a50513          	addi	a0,a0,-2038 # 6830 <malloc+0x82a>
    102e:	00005097          	auipc	ra,0x5
    1032:	c02080e7          	jalr	-1022(ra) # 5c30 <link>
    1036:	0e055863          	bgez	a0,1126 <linktest+0x230>
}
    103a:	60e2                	ld	ra,24(sp)
    103c:	6442                	ld	s0,16(sp)
    103e:	64a2                	ld	s1,8(sp)
    1040:	6902                	ld	s2,0(sp)
    1042:	6105                	addi	sp,sp,32
    1044:	8082                	ret
    printf("%s: create lf1 failed\n", s);
    1046:	85ca                	mv	a1,s2
    1048:	00005517          	auipc	a0,0x5
    104c:	6e850513          	addi	a0,a0,1768 # 6730 <malloc+0x72a>
    1050:	00005097          	auipc	ra,0x5
    1054:	ef8080e7          	jalr	-264(ra) # 5f48 <printf>
    exit(1);
    1058:	4505                	li	a0,1
    105a:	00005097          	auipc	ra,0x5
    105e:	b76080e7          	jalr	-1162(ra) # 5bd0 <exit>
    printf("%s: write lf1 failed\n", s);
    1062:	85ca                	mv	a1,s2
    1064:	00005517          	auipc	a0,0x5
    1068:	6e450513          	addi	a0,a0,1764 # 6748 <malloc+0x742>
    106c:	00005097          	auipc	ra,0x5
    1070:	edc080e7          	jalr	-292(ra) # 5f48 <printf>
    exit(1);
    1074:	4505                	li	a0,1
    1076:	00005097          	auipc	ra,0x5
    107a:	b5a080e7          	jalr	-1190(ra) # 5bd0 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
    107e:	85ca                	mv	a1,s2
    1080:	00005517          	auipc	a0,0x5
    1084:	6e050513          	addi	a0,a0,1760 # 6760 <malloc+0x75a>
    1088:	00005097          	auipc	ra,0x5
    108c:	ec0080e7          	jalr	-320(ra) # 5f48 <printf>
    exit(1);
    1090:	4505                	li	a0,1
    1092:	00005097          	auipc	ra,0x5
    1096:	b3e080e7          	jalr	-1218(ra) # 5bd0 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
    109a:	85ca                	mv	a1,s2
    109c:	00005517          	auipc	a0,0x5
    10a0:	6e450513          	addi	a0,a0,1764 # 6780 <malloc+0x77a>
    10a4:	00005097          	auipc	ra,0x5
    10a8:	ea4080e7          	jalr	-348(ra) # 5f48 <printf>
    exit(1);
    10ac:	4505                	li	a0,1
    10ae:	00005097          	auipc	ra,0x5
    10b2:	b22080e7          	jalr	-1246(ra) # 5bd0 <exit>
    printf("%s: open lf2 failed\n", s);
    10b6:	85ca                	mv	a1,s2
    10b8:	00005517          	auipc	a0,0x5
    10bc:	6f850513          	addi	a0,a0,1784 # 67b0 <malloc+0x7aa>
    10c0:	00005097          	auipc	ra,0x5
    10c4:	e88080e7          	jalr	-376(ra) # 5f48 <printf>
    exit(1);
    10c8:	4505                	li	a0,1
    10ca:	00005097          	auipc	ra,0x5
    10ce:	b06080e7          	jalr	-1274(ra) # 5bd0 <exit>
    printf("%s: read lf2 failed\n", s);
    10d2:	85ca                	mv	a1,s2
    10d4:	00005517          	auipc	a0,0x5
    10d8:	6f450513          	addi	a0,a0,1780 # 67c8 <malloc+0x7c2>
    10dc:	00005097          	auipc	ra,0x5
    10e0:	e6c080e7          	jalr	-404(ra) # 5f48 <printf>
    exit(1);
    10e4:	4505                	li	a0,1
    10e6:	00005097          	auipc	ra,0x5
    10ea:	aea080e7          	jalr	-1302(ra) # 5bd0 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
    10ee:	85ca                	mv	a1,s2
    10f0:	00005517          	auipc	a0,0x5
    10f4:	6f050513          	addi	a0,a0,1776 # 67e0 <malloc+0x7da>
    10f8:	00005097          	auipc	ra,0x5
    10fc:	e50080e7          	jalr	-432(ra) # 5f48 <printf>
    exit(1);
    1100:	4505                	li	a0,1
    1102:	00005097          	auipc	ra,0x5
    1106:	ace080e7          	jalr	-1330(ra) # 5bd0 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
    110a:	85ca                	mv	a1,s2
    110c:	00005517          	auipc	a0,0x5
    1110:	6fc50513          	addi	a0,a0,1788 # 6808 <malloc+0x802>
    1114:	00005097          	auipc	ra,0x5
    1118:	e34080e7          	jalr	-460(ra) # 5f48 <printf>
    exit(1);
    111c:	4505                	li	a0,1
    111e:	00005097          	auipc	ra,0x5
    1122:	ab2080e7          	jalr	-1358(ra) # 5bd0 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
    1126:	85ca                	mv	a1,s2
    1128:	00005517          	auipc	a0,0x5
    112c:	71050513          	addi	a0,a0,1808 # 6838 <malloc+0x832>
    1130:	00005097          	auipc	ra,0x5
    1134:	e18080e7          	jalr	-488(ra) # 5f48 <printf>
    exit(1);
    1138:	4505                	li	a0,1
    113a:	00005097          	auipc	ra,0x5
    113e:	a96080e7          	jalr	-1386(ra) # 5bd0 <exit>

0000000000001142 <validatetest>:
{
    1142:	7139                	addi	sp,sp,-64
    1144:	fc06                	sd	ra,56(sp)
    1146:	f822                	sd	s0,48(sp)
    1148:	f426                	sd	s1,40(sp)
    114a:	f04a                	sd	s2,32(sp)
    114c:	ec4e                	sd	s3,24(sp)
    114e:	e852                	sd	s4,16(sp)
    1150:	e456                	sd	s5,8(sp)
    1152:	e05a                	sd	s6,0(sp)
    1154:	0080                	addi	s0,sp,64
    1156:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1158:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    115a:	00005997          	auipc	s3,0x5
    115e:	6fe98993          	addi	s3,s3,1790 # 6858 <malloc+0x852>
    1162:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    1164:	6a85                	lui	s5,0x1
    1166:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    116a:	85a6                	mv	a1,s1
    116c:	854e                	mv	a0,s3
    116e:	00005097          	auipc	ra,0x5
    1172:	ac2080e7          	jalr	-1342(ra) # 5c30 <link>
    1176:	01251f63          	bne	a0,s2,1194 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    117a:	94d6                	add	s1,s1,s5
    117c:	ff4497e3          	bne	s1,s4,116a <validatetest+0x28>
}
    1180:	70e2                	ld	ra,56(sp)
    1182:	7442                	ld	s0,48(sp)
    1184:	74a2                	ld	s1,40(sp)
    1186:	7902                	ld	s2,32(sp)
    1188:	69e2                	ld	s3,24(sp)
    118a:	6a42                	ld	s4,16(sp)
    118c:	6aa2                	ld	s5,8(sp)
    118e:	6b02                	ld	s6,0(sp)
    1190:	6121                	addi	sp,sp,64
    1192:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1194:	85da                	mv	a1,s6
    1196:	00005517          	auipc	a0,0x5
    119a:	6d250513          	addi	a0,a0,1746 # 6868 <malloc+0x862>
    119e:	00005097          	auipc	ra,0x5
    11a2:	daa080e7          	jalr	-598(ra) # 5f48 <printf>
      exit(1);
    11a6:	4505                	li	a0,1
    11a8:	00005097          	auipc	ra,0x5
    11ac:	a28080e7          	jalr	-1496(ra) # 5bd0 <exit>

00000000000011b0 <bigdir>:
{
    11b0:	715d                	addi	sp,sp,-80
    11b2:	e486                	sd	ra,72(sp)
    11b4:	e0a2                	sd	s0,64(sp)
    11b6:	fc26                	sd	s1,56(sp)
    11b8:	f84a                	sd	s2,48(sp)
    11ba:	f44e                	sd	s3,40(sp)
    11bc:	f052                	sd	s4,32(sp)
    11be:	ec56                	sd	s5,24(sp)
    11c0:	e85a                	sd	s6,16(sp)
    11c2:	0880                	addi	s0,sp,80
    11c4:	89aa                	mv	s3,a0
  unlink("bd");
    11c6:	00005517          	auipc	a0,0x5
    11ca:	6c250513          	addi	a0,a0,1730 # 6888 <malloc+0x882>
    11ce:	00005097          	auipc	ra,0x5
    11d2:	a52080e7          	jalr	-1454(ra) # 5c20 <unlink>
  fd = open("bd", O_CREATE);
    11d6:	20000593          	li	a1,512
    11da:	00005517          	auipc	a0,0x5
    11de:	6ae50513          	addi	a0,a0,1710 # 6888 <malloc+0x882>
    11e2:	00005097          	auipc	ra,0x5
    11e6:	a2e080e7          	jalr	-1490(ra) # 5c10 <open>
  if(fd < 0){
    11ea:	0c054963          	bltz	a0,12bc <bigdir+0x10c>
  close(fd);
    11ee:	00005097          	auipc	ra,0x5
    11f2:	a0a080e7          	jalr	-1526(ra) # 5bf8 <close>
  for(i = 0; i < N; i++){
    11f6:	4901                	li	s2,0
    name[0] = 'x';
    11f8:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
    11fc:	00005a17          	auipc	s4,0x5
    1200:	68ca0a13          	addi	s4,s4,1676 # 6888 <malloc+0x882>
  for(i = 0; i < N; i++){
    1204:	1f400b13          	li	s6,500
    name[0] = 'x';
    1208:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
    120c:	41f9579b          	sraiw	a5,s2,0x1f
    1210:	01a7d71b          	srliw	a4,a5,0x1a
    1214:	012707bb          	addw	a5,a4,s2
    1218:	4067d69b          	sraiw	a3,a5,0x6
    121c:	0306869b          	addiw	a3,a3,48
    1220:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1224:	03f7f793          	andi	a5,a5,63
    1228:	9f99                	subw	a5,a5,a4
    122a:	0307879b          	addiw	a5,a5,48
    122e:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1232:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
    1236:	fb040593          	addi	a1,s0,-80
    123a:	8552                	mv	a0,s4
    123c:	00005097          	auipc	ra,0x5
    1240:	9f4080e7          	jalr	-1548(ra) # 5c30 <link>
    1244:	84aa                	mv	s1,a0
    1246:	e949                	bnez	a0,12d8 <bigdir+0x128>
  for(i = 0; i < N; i++){
    1248:	2905                	addiw	s2,s2,1
    124a:	fb691fe3          	bne	s2,s6,1208 <bigdir+0x58>
  unlink("bd");
    124e:	00005517          	auipc	a0,0x5
    1252:	63a50513          	addi	a0,a0,1594 # 6888 <malloc+0x882>
    1256:	00005097          	auipc	ra,0x5
    125a:	9ca080e7          	jalr	-1590(ra) # 5c20 <unlink>
    name[0] = 'x';
    125e:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1262:	1f400a13          	li	s4,500
    name[0] = 'x';
    1266:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    126a:	41f4d79b          	sraiw	a5,s1,0x1f
    126e:	01a7d71b          	srliw	a4,a5,0x1a
    1272:	009707bb          	addw	a5,a4,s1
    1276:	4067d69b          	sraiw	a3,a5,0x6
    127a:	0306869b          	addiw	a3,a3,48
    127e:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1282:	03f7f793          	andi	a5,a5,63
    1286:	9f99                	subw	a5,a5,a4
    1288:	0307879b          	addiw	a5,a5,48
    128c:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1290:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1294:	fb040513          	addi	a0,s0,-80
    1298:	00005097          	auipc	ra,0x5
    129c:	988080e7          	jalr	-1656(ra) # 5c20 <unlink>
    12a0:	ed21                	bnez	a0,12f8 <bigdir+0x148>
  for(i = 0; i < N; i++){
    12a2:	2485                	addiw	s1,s1,1
    12a4:	fd4491e3          	bne	s1,s4,1266 <bigdir+0xb6>
}
    12a8:	60a6                	ld	ra,72(sp)
    12aa:	6406                	ld	s0,64(sp)
    12ac:	74e2                	ld	s1,56(sp)
    12ae:	7942                	ld	s2,48(sp)
    12b0:	79a2                	ld	s3,40(sp)
    12b2:	7a02                	ld	s4,32(sp)
    12b4:	6ae2                	ld	s5,24(sp)
    12b6:	6b42                	ld	s6,16(sp)
    12b8:	6161                	addi	sp,sp,80
    12ba:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    12bc:	85ce                	mv	a1,s3
    12be:	00005517          	auipc	a0,0x5
    12c2:	5d250513          	addi	a0,a0,1490 # 6890 <malloc+0x88a>
    12c6:	00005097          	auipc	ra,0x5
    12ca:	c82080e7          	jalr	-894(ra) # 5f48 <printf>
    exit(1);
    12ce:	4505                	li	a0,1
    12d0:	00005097          	auipc	ra,0x5
    12d4:	900080e7          	jalr	-1792(ra) # 5bd0 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    12d8:	fb040613          	addi	a2,s0,-80
    12dc:	85ce                	mv	a1,s3
    12de:	00005517          	auipc	a0,0x5
    12e2:	5d250513          	addi	a0,a0,1490 # 68b0 <malloc+0x8aa>
    12e6:	00005097          	auipc	ra,0x5
    12ea:	c62080e7          	jalr	-926(ra) # 5f48 <printf>
      exit(1);
    12ee:	4505                	li	a0,1
    12f0:	00005097          	auipc	ra,0x5
    12f4:	8e0080e7          	jalr	-1824(ra) # 5bd0 <exit>
      printf("%s: bigdir unlink failed", s);
    12f8:	85ce                	mv	a1,s3
    12fa:	00005517          	auipc	a0,0x5
    12fe:	5d650513          	addi	a0,a0,1494 # 68d0 <malloc+0x8ca>
    1302:	00005097          	auipc	ra,0x5
    1306:	c46080e7          	jalr	-954(ra) # 5f48 <printf>
      exit(1);
    130a:	4505                	li	a0,1
    130c:	00005097          	auipc	ra,0x5
    1310:	8c4080e7          	jalr	-1852(ra) # 5bd0 <exit>

0000000000001314 <pgbug>:
{
    1314:	7179                	addi	sp,sp,-48
    1316:	f406                	sd	ra,40(sp)
    1318:	f022                	sd	s0,32(sp)
    131a:	ec26                	sd	s1,24(sp)
    131c:	1800                	addi	s0,sp,48
  argv[0] = 0;
    131e:	fc043c23          	sd	zero,-40(s0)
  exec(big, argv);
    1322:	00008497          	auipc	s1,0x8
    1326:	cde48493          	addi	s1,s1,-802 # 9000 <big>
    132a:	fd840593          	addi	a1,s0,-40
    132e:	6088                	ld	a0,0(s1)
    1330:	00005097          	auipc	ra,0x5
    1334:	8d8080e7          	jalr	-1832(ra) # 5c08 <exec>
  pipe(big);
    1338:	6088                	ld	a0,0(s1)
    133a:	00005097          	auipc	ra,0x5
    133e:	8a6080e7          	jalr	-1882(ra) # 5be0 <pipe>
  exit(0);
    1342:	4501                	li	a0,0
    1344:	00005097          	auipc	ra,0x5
    1348:	88c080e7          	jalr	-1908(ra) # 5bd0 <exit>

000000000000134c <badarg>:
{
    134c:	7139                	addi	sp,sp,-64
    134e:	fc06                	sd	ra,56(sp)
    1350:	f822                	sd	s0,48(sp)
    1352:	f426                	sd	s1,40(sp)
    1354:	f04a                	sd	s2,32(sp)
    1356:	ec4e                	sd	s3,24(sp)
    1358:	0080                	addi	s0,sp,64
    135a:	64b1                	lui	s1,0xc
    135c:	35048493          	addi	s1,s1,848 # c350 <uninit+0x1de8>
    argv[0] = (char*)0xffffffff;
    1360:	597d                	li	s2,-1
    1362:	02095913          	srli	s2,s2,0x20
    exec("echo", argv);
    1366:	00005997          	auipc	s3,0x5
    136a:	de298993          	addi	s3,s3,-542 # 6148 <malloc+0x142>
    argv[0] = (char*)0xffffffff;
    136e:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1372:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1376:	fc040593          	addi	a1,s0,-64
    137a:	854e                	mv	a0,s3
    137c:	00005097          	auipc	ra,0x5
    1380:	88c080e7          	jalr	-1908(ra) # 5c08 <exec>
  for(int i = 0; i < 50000; i++){
    1384:	34fd                	addiw	s1,s1,-1
    1386:	f4e5                	bnez	s1,136e <badarg+0x22>
  exit(0);
    1388:	4501                	li	a0,0
    138a:	00005097          	auipc	ra,0x5
    138e:	846080e7          	jalr	-1978(ra) # 5bd0 <exit>

0000000000001392 <copyinstr2>:
{
    1392:	7155                	addi	sp,sp,-208
    1394:	e586                	sd	ra,200(sp)
    1396:	e1a2                	sd	s0,192(sp)
    1398:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    139a:	f6840793          	addi	a5,s0,-152
    139e:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    13a2:	07800713          	li	a4,120
    13a6:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    13aa:	0785                	addi	a5,a5,1
    13ac:	fed79de3          	bne	a5,a3,13a6 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    13b0:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    13b4:	f6840513          	addi	a0,s0,-152
    13b8:	00005097          	auipc	ra,0x5
    13bc:	868080e7          	jalr	-1944(ra) # 5c20 <unlink>
  if(ret != -1){
    13c0:	57fd                	li	a5,-1
    13c2:	0ef51063          	bne	a0,a5,14a2 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    13c6:	20100593          	li	a1,513
    13ca:	f6840513          	addi	a0,s0,-152
    13ce:	00005097          	auipc	ra,0x5
    13d2:	842080e7          	jalr	-1982(ra) # 5c10 <open>
  if(fd != -1){
    13d6:	57fd                	li	a5,-1
    13d8:	0ef51563          	bne	a0,a5,14c2 <copyinstr2+0x130>
  ret = link(b, b);
    13dc:	f6840593          	addi	a1,s0,-152
    13e0:	852e                	mv	a0,a1
    13e2:	00005097          	auipc	ra,0x5
    13e6:	84e080e7          	jalr	-1970(ra) # 5c30 <link>
  if(ret != -1){
    13ea:	57fd                	li	a5,-1
    13ec:	0ef51b63          	bne	a0,a5,14e2 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    13f0:	00006797          	auipc	a5,0x6
    13f4:	73878793          	addi	a5,a5,1848 # 7b28 <malloc+0x1b22>
    13f8:	f4f43c23          	sd	a5,-168(s0)
    13fc:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1400:	f5840593          	addi	a1,s0,-168
    1404:	f6840513          	addi	a0,s0,-152
    1408:	00005097          	auipc	ra,0x5
    140c:	800080e7          	jalr	-2048(ra) # 5c08 <exec>
  if(ret != -1){
    1410:	57fd                	li	a5,-1
    1412:	0ef51963          	bne	a0,a5,1504 <copyinstr2+0x172>
  int pid = fork();
    1416:	00004097          	auipc	ra,0x4
    141a:	7b2080e7          	jalr	1970(ra) # 5bc8 <fork>
  if(pid < 0){
    141e:	10054363          	bltz	a0,1524 <copyinstr2+0x192>
  if(pid == 0){
    1422:	12051463          	bnez	a0,154a <copyinstr2+0x1b8>
    1426:	00008797          	auipc	a5,0x8
    142a:	13a78793          	addi	a5,a5,314 # 9560 <big.1266>
    142e:	00009697          	auipc	a3,0x9
    1432:	13268693          	addi	a3,a3,306 # a560 <big.1266+0x1000>
      big[i] = 'x';
    1436:	07800713          	li	a4,120
    143a:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    143e:	0785                	addi	a5,a5,1
    1440:	fed79de3          	bne	a5,a3,143a <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    1444:	00009797          	auipc	a5,0x9
    1448:	10078e23          	sb	zero,284(a5) # a560 <big.1266+0x1000>
    char *args2[] = { big, big, big, 0 };
    144c:	00007797          	auipc	a5,0x7
    1450:	0fc78793          	addi	a5,a5,252 # 8548 <malloc+0x2542>
    1454:	6390                	ld	a2,0(a5)
    1456:	6794                	ld	a3,8(a5)
    1458:	6b98                	ld	a4,16(a5)
    145a:	6f9c                	ld	a5,24(a5)
    145c:	f2c43823          	sd	a2,-208(s0)
    1460:	f2d43c23          	sd	a3,-200(s0)
    1464:	f4e43023          	sd	a4,-192(s0)
    1468:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    146c:	f3040593          	addi	a1,s0,-208
    1470:	00005517          	auipc	a0,0x5
    1474:	cd850513          	addi	a0,a0,-808 # 6148 <malloc+0x142>
    1478:	00004097          	auipc	ra,0x4
    147c:	790080e7          	jalr	1936(ra) # 5c08 <exec>
    if(ret != -1){
    1480:	57fd                	li	a5,-1
    1482:	0af50e63          	beq	a0,a5,153e <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    1486:	55fd                	li	a1,-1
    1488:	00005517          	auipc	a0,0x5
    148c:	4f050513          	addi	a0,a0,1264 # 6978 <malloc+0x972>
    1490:	00005097          	auipc	ra,0x5
    1494:	ab8080e7          	jalr	-1352(ra) # 5f48 <printf>
      exit(1);
    1498:	4505                	li	a0,1
    149a:	00004097          	auipc	ra,0x4
    149e:	736080e7          	jalr	1846(ra) # 5bd0 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    14a2:	862a                	mv	a2,a0
    14a4:	f6840593          	addi	a1,s0,-152
    14a8:	00005517          	auipc	a0,0x5
    14ac:	44850513          	addi	a0,a0,1096 # 68f0 <malloc+0x8ea>
    14b0:	00005097          	auipc	ra,0x5
    14b4:	a98080e7          	jalr	-1384(ra) # 5f48 <printf>
    exit(1);
    14b8:	4505                	li	a0,1
    14ba:	00004097          	auipc	ra,0x4
    14be:	716080e7          	jalr	1814(ra) # 5bd0 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    14c2:	862a                	mv	a2,a0
    14c4:	f6840593          	addi	a1,s0,-152
    14c8:	00005517          	auipc	a0,0x5
    14cc:	44850513          	addi	a0,a0,1096 # 6910 <malloc+0x90a>
    14d0:	00005097          	auipc	ra,0x5
    14d4:	a78080e7          	jalr	-1416(ra) # 5f48 <printf>
    exit(1);
    14d8:	4505                	li	a0,1
    14da:	00004097          	auipc	ra,0x4
    14de:	6f6080e7          	jalr	1782(ra) # 5bd0 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    14e2:	86aa                	mv	a3,a0
    14e4:	f6840613          	addi	a2,s0,-152
    14e8:	85b2                	mv	a1,a2
    14ea:	00005517          	auipc	a0,0x5
    14ee:	44650513          	addi	a0,a0,1094 # 6930 <malloc+0x92a>
    14f2:	00005097          	auipc	ra,0x5
    14f6:	a56080e7          	jalr	-1450(ra) # 5f48 <printf>
    exit(1);
    14fa:	4505                	li	a0,1
    14fc:	00004097          	auipc	ra,0x4
    1500:	6d4080e7          	jalr	1748(ra) # 5bd0 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1504:	567d                	li	a2,-1
    1506:	f6840593          	addi	a1,s0,-152
    150a:	00005517          	auipc	a0,0x5
    150e:	44e50513          	addi	a0,a0,1102 # 6958 <malloc+0x952>
    1512:	00005097          	auipc	ra,0x5
    1516:	a36080e7          	jalr	-1482(ra) # 5f48 <printf>
    exit(1);
    151a:	4505                	li	a0,1
    151c:	00004097          	auipc	ra,0x4
    1520:	6b4080e7          	jalr	1716(ra) # 5bd0 <exit>
    printf("fork failed\n");
    1524:	00006517          	auipc	a0,0x6
    1528:	8b450513          	addi	a0,a0,-1868 # 6dd8 <malloc+0xdd2>
    152c:	00005097          	auipc	ra,0x5
    1530:	a1c080e7          	jalr	-1508(ra) # 5f48 <printf>
    exit(1);
    1534:	4505                	li	a0,1
    1536:	00004097          	auipc	ra,0x4
    153a:	69a080e7          	jalr	1690(ra) # 5bd0 <exit>
    exit(747); // OK
    153e:	2eb00513          	li	a0,747
    1542:	00004097          	auipc	ra,0x4
    1546:	68e080e7          	jalr	1678(ra) # 5bd0 <exit>
  int st = 0;
    154a:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    154e:	f5440513          	addi	a0,s0,-172
    1552:	00004097          	auipc	ra,0x4
    1556:	686080e7          	jalr	1670(ra) # 5bd8 <wait>
  if(st != 747){
    155a:	f5442703          	lw	a4,-172(s0)
    155e:	2eb00793          	li	a5,747
    1562:	00f71663          	bne	a4,a5,156e <copyinstr2+0x1dc>
}
    1566:	60ae                	ld	ra,200(sp)
    1568:	640e                	ld	s0,192(sp)
    156a:	6169                	addi	sp,sp,208
    156c:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    156e:	00005517          	auipc	a0,0x5
    1572:	43250513          	addi	a0,a0,1074 # 69a0 <malloc+0x99a>
    1576:	00005097          	auipc	ra,0x5
    157a:	9d2080e7          	jalr	-1582(ra) # 5f48 <printf>
    exit(1);
    157e:	4505                	li	a0,1
    1580:	00004097          	auipc	ra,0x4
    1584:	650080e7          	jalr	1616(ra) # 5bd0 <exit>

0000000000001588 <truncate3>:
{
    1588:	7159                	addi	sp,sp,-112
    158a:	f486                	sd	ra,104(sp)
    158c:	f0a2                	sd	s0,96(sp)
    158e:	eca6                	sd	s1,88(sp)
    1590:	e8ca                	sd	s2,80(sp)
    1592:	e4ce                	sd	s3,72(sp)
    1594:	e0d2                	sd	s4,64(sp)
    1596:	fc56                	sd	s5,56(sp)
    1598:	1880                	addi	s0,sp,112
    159a:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    159c:	60100593          	li	a1,1537
    15a0:	00005517          	auipc	a0,0x5
    15a4:	c0050513          	addi	a0,a0,-1024 # 61a0 <malloc+0x19a>
    15a8:	00004097          	auipc	ra,0x4
    15ac:	668080e7          	jalr	1640(ra) # 5c10 <open>
    15b0:	00004097          	auipc	ra,0x4
    15b4:	648080e7          	jalr	1608(ra) # 5bf8 <close>
  pid = fork();
    15b8:	00004097          	auipc	ra,0x4
    15bc:	610080e7          	jalr	1552(ra) # 5bc8 <fork>
  if(pid < 0){
    15c0:	08054063          	bltz	a0,1640 <truncate3+0xb8>
  if(pid == 0){
    15c4:	e969                	bnez	a0,1696 <truncate3+0x10e>
    15c6:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    15ca:	00005a17          	auipc	s4,0x5
    15ce:	bd6a0a13          	addi	s4,s4,-1066 # 61a0 <malloc+0x19a>
      int n = write(fd, "1234567890", 10);
    15d2:	00005a97          	auipc	s5,0x5
    15d6:	42ea8a93          	addi	s5,s5,1070 # 6a00 <malloc+0x9fa>
      int fd = open("truncfile", O_WRONLY);
    15da:	4585                	li	a1,1
    15dc:	8552                	mv	a0,s4
    15de:	00004097          	auipc	ra,0x4
    15e2:	632080e7          	jalr	1586(ra) # 5c10 <open>
    15e6:	84aa                	mv	s1,a0
      if(fd < 0){
    15e8:	06054a63          	bltz	a0,165c <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    15ec:	4629                	li	a2,10
    15ee:	85d6                	mv	a1,s5
    15f0:	00004097          	auipc	ra,0x4
    15f4:	600080e7          	jalr	1536(ra) # 5bf0 <write>
      if(n != 10){
    15f8:	47a9                	li	a5,10
    15fa:	06f51f63          	bne	a0,a5,1678 <truncate3+0xf0>
      close(fd);
    15fe:	8526                	mv	a0,s1
    1600:	00004097          	auipc	ra,0x4
    1604:	5f8080e7          	jalr	1528(ra) # 5bf8 <close>
      fd = open("truncfile", O_RDONLY);
    1608:	4581                	li	a1,0
    160a:	8552                	mv	a0,s4
    160c:	00004097          	auipc	ra,0x4
    1610:	604080e7          	jalr	1540(ra) # 5c10 <open>
    1614:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1616:	02000613          	li	a2,32
    161a:	f9840593          	addi	a1,s0,-104
    161e:	00004097          	auipc	ra,0x4
    1622:	5ca080e7          	jalr	1482(ra) # 5be8 <read>
      close(fd);
    1626:	8526                	mv	a0,s1
    1628:	00004097          	auipc	ra,0x4
    162c:	5d0080e7          	jalr	1488(ra) # 5bf8 <close>
    for(int i = 0; i < 100; i++){
    1630:	39fd                	addiw	s3,s3,-1
    1632:	fa0994e3          	bnez	s3,15da <truncate3+0x52>
    exit(0);
    1636:	4501                	li	a0,0
    1638:	00004097          	auipc	ra,0x4
    163c:	598080e7          	jalr	1432(ra) # 5bd0 <exit>
    printf("%s: fork failed\n", s);
    1640:	85ca                	mv	a1,s2
    1642:	00005517          	auipc	a0,0x5
    1646:	38e50513          	addi	a0,a0,910 # 69d0 <malloc+0x9ca>
    164a:	00005097          	auipc	ra,0x5
    164e:	8fe080e7          	jalr	-1794(ra) # 5f48 <printf>
    exit(1);
    1652:	4505                	li	a0,1
    1654:	00004097          	auipc	ra,0x4
    1658:	57c080e7          	jalr	1404(ra) # 5bd0 <exit>
        printf("%s: open failed\n", s);
    165c:	85ca                	mv	a1,s2
    165e:	00005517          	auipc	a0,0x5
    1662:	38a50513          	addi	a0,a0,906 # 69e8 <malloc+0x9e2>
    1666:	00005097          	auipc	ra,0x5
    166a:	8e2080e7          	jalr	-1822(ra) # 5f48 <printf>
        exit(1);
    166e:	4505                	li	a0,1
    1670:	00004097          	auipc	ra,0x4
    1674:	560080e7          	jalr	1376(ra) # 5bd0 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1678:	862a                	mv	a2,a0
    167a:	85ca                	mv	a1,s2
    167c:	00005517          	auipc	a0,0x5
    1680:	39450513          	addi	a0,a0,916 # 6a10 <malloc+0xa0a>
    1684:	00005097          	auipc	ra,0x5
    1688:	8c4080e7          	jalr	-1852(ra) # 5f48 <printf>
        exit(1);
    168c:	4505                	li	a0,1
    168e:	00004097          	auipc	ra,0x4
    1692:	542080e7          	jalr	1346(ra) # 5bd0 <exit>
    1696:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    169a:	00005a17          	auipc	s4,0x5
    169e:	b06a0a13          	addi	s4,s4,-1274 # 61a0 <malloc+0x19a>
    int n = write(fd, "xxx", 3);
    16a2:	00005a97          	auipc	s5,0x5
    16a6:	38ea8a93          	addi	s5,s5,910 # 6a30 <malloc+0xa2a>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    16aa:	60100593          	li	a1,1537
    16ae:	8552                	mv	a0,s4
    16b0:	00004097          	auipc	ra,0x4
    16b4:	560080e7          	jalr	1376(ra) # 5c10 <open>
    16b8:	84aa                	mv	s1,a0
    if(fd < 0){
    16ba:	04054763          	bltz	a0,1708 <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    16be:	460d                	li	a2,3
    16c0:	85d6                	mv	a1,s5
    16c2:	00004097          	auipc	ra,0x4
    16c6:	52e080e7          	jalr	1326(ra) # 5bf0 <write>
    if(n != 3){
    16ca:	478d                	li	a5,3
    16cc:	04f51c63          	bne	a0,a5,1724 <truncate3+0x19c>
    close(fd);
    16d0:	8526                	mv	a0,s1
    16d2:	00004097          	auipc	ra,0x4
    16d6:	526080e7          	jalr	1318(ra) # 5bf8 <close>
  for(int i = 0; i < 150; i++){
    16da:	39fd                	addiw	s3,s3,-1
    16dc:	fc0997e3          	bnez	s3,16aa <truncate3+0x122>
  wait(&xstatus);
    16e0:	fbc40513          	addi	a0,s0,-68
    16e4:	00004097          	auipc	ra,0x4
    16e8:	4f4080e7          	jalr	1268(ra) # 5bd8 <wait>
  unlink("truncfile");
    16ec:	00005517          	auipc	a0,0x5
    16f0:	ab450513          	addi	a0,a0,-1356 # 61a0 <malloc+0x19a>
    16f4:	00004097          	auipc	ra,0x4
    16f8:	52c080e7          	jalr	1324(ra) # 5c20 <unlink>
  exit(xstatus);
    16fc:	fbc42503          	lw	a0,-68(s0)
    1700:	00004097          	auipc	ra,0x4
    1704:	4d0080e7          	jalr	1232(ra) # 5bd0 <exit>
      printf("%s: open failed\n", s);
    1708:	85ca                	mv	a1,s2
    170a:	00005517          	auipc	a0,0x5
    170e:	2de50513          	addi	a0,a0,734 # 69e8 <malloc+0x9e2>
    1712:	00005097          	auipc	ra,0x5
    1716:	836080e7          	jalr	-1994(ra) # 5f48 <printf>
      exit(1);
    171a:	4505                	li	a0,1
    171c:	00004097          	auipc	ra,0x4
    1720:	4b4080e7          	jalr	1204(ra) # 5bd0 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1724:	862a                	mv	a2,a0
    1726:	85ca                	mv	a1,s2
    1728:	00005517          	auipc	a0,0x5
    172c:	31050513          	addi	a0,a0,784 # 6a38 <malloc+0xa32>
    1730:	00005097          	auipc	ra,0x5
    1734:	818080e7          	jalr	-2024(ra) # 5f48 <printf>
      exit(1);
    1738:	4505                	li	a0,1
    173a:	00004097          	auipc	ra,0x4
    173e:	496080e7          	jalr	1174(ra) # 5bd0 <exit>

0000000000001742 <exectest>:
{
    1742:	715d                	addi	sp,sp,-80
    1744:	e486                	sd	ra,72(sp)
    1746:	e0a2                	sd	s0,64(sp)
    1748:	fc26                	sd	s1,56(sp)
    174a:	f84a                	sd	s2,48(sp)
    174c:	0880                	addi	s0,sp,80
    174e:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1750:	00005797          	auipc	a5,0x5
    1754:	9f878793          	addi	a5,a5,-1544 # 6148 <malloc+0x142>
    1758:	fcf43023          	sd	a5,-64(s0)
    175c:	00005797          	auipc	a5,0x5
    1760:	2fc78793          	addi	a5,a5,764 # 6a58 <malloc+0xa52>
    1764:	fcf43423          	sd	a5,-56(s0)
    1768:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    176c:	00005517          	auipc	a0,0x5
    1770:	2f450513          	addi	a0,a0,756 # 6a60 <malloc+0xa5a>
    1774:	00004097          	auipc	ra,0x4
    1778:	4ac080e7          	jalr	1196(ra) # 5c20 <unlink>
  pid = fork();
    177c:	00004097          	auipc	ra,0x4
    1780:	44c080e7          	jalr	1100(ra) # 5bc8 <fork>
  if(pid < 0) {
    1784:	04054663          	bltz	a0,17d0 <exectest+0x8e>
    1788:	84aa                	mv	s1,a0
  if(pid == 0) {
    178a:	e959                	bnez	a0,1820 <exectest+0xde>
    close(1);
    178c:	4505                	li	a0,1
    178e:	00004097          	auipc	ra,0x4
    1792:	46a080e7          	jalr	1130(ra) # 5bf8 <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    1796:	20100593          	li	a1,513
    179a:	00005517          	auipc	a0,0x5
    179e:	2c650513          	addi	a0,a0,710 # 6a60 <malloc+0xa5a>
    17a2:	00004097          	auipc	ra,0x4
    17a6:	46e080e7          	jalr	1134(ra) # 5c10 <open>
    if(fd < 0) {
    17aa:	04054163          	bltz	a0,17ec <exectest+0xaa>
    if(fd != 1) {
    17ae:	4785                	li	a5,1
    17b0:	04f50c63          	beq	a0,a5,1808 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    17b4:	85ca                	mv	a1,s2
    17b6:	00005517          	auipc	a0,0x5
    17ba:	2ca50513          	addi	a0,a0,714 # 6a80 <malloc+0xa7a>
    17be:	00004097          	auipc	ra,0x4
    17c2:	78a080e7          	jalr	1930(ra) # 5f48 <printf>
      exit(1);
    17c6:	4505                	li	a0,1
    17c8:	00004097          	auipc	ra,0x4
    17cc:	408080e7          	jalr	1032(ra) # 5bd0 <exit>
     printf("%s: fork failed\n", s);
    17d0:	85ca                	mv	a1,s2
    17d2:	00005517          	auipc	a0,0x5
    17d6:	1fe50513          	addi	a0,a0,510 # 69d0 <malloc+0x9ca>
    17da:	00004097          	auipc	ra,0x4
    17de:	76e080e7          	jalr	1902(ra) # 5f48 <printf>
     exit(1);
    17e2:	4505                	li	a0,1
    17e4:	00004097          	auipc	ra,0x4
    17e8:	3ec080e7          	jalr	1004(ra) # 5bd0 <exit>
      printf("%s: create failed\n", s);
    17ec:	85ca                	mv	a1,s2
    17ee:	00005517          	auipc	a0,0x5
    17f2:	27a50513          	addi	a0,a0,634 # 6a68 <malloc+0xa62>
    17f6:	00004097          	auipc	ra,0x4
    17fa:	752080e7          	jalr	1874(ra) # 5f48 <printf>
      exit(1);
    17fe:	4505                	li	a0,1
    1800:	00004097          	auipc	ra,0x4
    1804:	3d0080e7          	jalr	976(ra) # 5bd0 <exit>
    if(exec("echo", echoargv) < 0){
    1808:	fc040593          	addi	a1,s0,-64
    180c:	00005517          	auipc	a0,0x5
    1810:	93c50513          	addi	a0,a0,-1732 # 6148 <malloc+0x142>
    1814:	00004097          	auipc	ra,0x4
    1818:	3f4080e7          	jalr	1012(ra) # 5c08 <exec>
    181c:	02054163          	bltz	a0,183e <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    1820:	fdc40513          	addi	a0,s0,-36
    1824:	00004097          	auipc	ra,0x4
    1828:	3b4080e7          	jalr	948(ra) # 5bd8 <wait>
    182c:	02951763          	bne	a0,s1,185a <exectest+0x118>
  if(xstatus != 0)
    1830:	fdc42503          	lw	a0,-36(s0)
    1834:	cd0d                	beqz	a0,186e <exectest+0x12c>
    exit(xstatus);
    1836:	00004097          	auipc	ra,0x4
    183a:	39a080e7          	jalr	922(ra) # 5bd0 <exit>
      printf("%s: exec echo failed\n", s);
    183e:	85ca                	mv	a1,s2
    1840:	00005517          	auipc	a0,0x5
    1844:	25050513          	addi	a0,a0,592 # 6a90 <malloc+0xa8a>
    1848:	00004097          	auipc	ra,0x4
    184c:	700080e7          	jalr	1792(ra) # 5f48 <printf>
      exit(1);
    1850:	4505                	li	a0,1
    1852:	00004097          	auipc	ra,0x4
    1856:	37e080e7          	jalr	894(ra) # 5bd0 <exit>
    printf("%s: wait failed!\n", s);
    185a:	85ca                	mv	a1,s2
    185c:	00005517          	auipc	a0,0x5
    1860:	24c50513          	addi	a0,a0,588 # 6aa8 <malloc+0xaa2>
    1864:	00004097          	auipc	ra,0x4
    1868:	6e4080e7          	jalr	1764(ra) # 5f48 <printf>
    186c:	b7d1                	j	1830 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    186e:	4581                	li	a1,0
    1870:	00005517          	auipc	a0,0x5
    1874:	1f050513          	addi	a0,a0,496 # 6a60 <malloc+0xa5a>
    1878:	00004097          	auipc	ra,0x4
    187c:	398080e7          	jalr	920(ra) # 5c10 <open>
  if(fd < 0) {
    1880:	02054a63          	bltz	a0,18b4 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    1884:	4609                	li	a2,2
    1886:	fb840593          	addi	a1,s0,-72
    188a:	00004097          	auipc	ra,0x4
    188e:	35e080e7          	jalr	862(ra) # 5be8 <read>
    1892:	4789                	li	a5,2
    1894:	02f50e63          	beq	a0,a5,18d0 <exectest+0x18e>
    printf("%s: read failed\n", s);
    1898:	85ca                	mv	a1,s2
    189a:	00005517          	auipc	a0,0x5
    189e:	c7e50513          	addi	a0,a0,-898 # 6518 <malloc+0x512>
    18a2:	00004097          	auipc	ra,0x4
    18a6:	6a6080e7          	jalr	1702(ra) # 5f48 <printf>
    exit(1);
    18aa:	4505                	li	a0,1
    18ac:	00004097          	auipc	ra,0x4
    18b0:	324080e7          	jalr	804(ra) # 5bd0 <exit>
    printf("%s: open failed\n", s);
    18b4:	85ca                	mv	a1,s2
    18b6:	00005517          	auipc	a0,0x5
    18ba:	13250513          	addi	a0,a0,306 # 69e8 <malloc+0x9e2>
    18be:	00004097          	auipc	ra,0x4
    18c2:	68a080e7          	jalr	1674(ra) # 5f48 <printf>
    exit(1);
    18c6:	4505                	li	a0,1
    18c8:	00004097          	auipc	ra,0x4
    18cc:	308080e7          	jalr	776(ra) # 5bd0 <exit>
  unlink("echo-ok");
    18d0:	00005517          	auipc	a0,0x5
    18d4:	19050513          	addi	a0,a0,400 # 6a60 <malloc+0xa5a>
    18d8:	00004097          	auipc	ra,0x4
    18dc:	348080e7          	jalr	840(ra) # 5c20 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    18e0:	fb844703          	lbu	a4,-72(s0)
    18e4:	04f00793          	li	a5,79
    18e8:	00f71863          	bne	a4,a5,18f8 <exectest+0x1b6>
    18ec:	fb944703          	lbu	a4,-71(s0)
    18f0:	04b00793          	li	a5,75
    18f4:	02f70063          	beq	a4,a5,1914 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    18f8:	85ca                	mv	a1,s2
    18fa:	00005517          	auipc	a0,0x5
    18fe:	1c650513          	addi	a0,a0,454 # 6ac0 <malloc+0xaba>
    1902:	00004097          	auipc	ra,0x4
    1906:	646080e7          	jalr	1606(ra) # 5f48 <printf>
    exit(1);
    190a:	4505                	li	a0,1
    190c:	00004097          	auipc	ra,0x4
    1910:	2c4080e7          	jalr	708(ra) # 5bd0 <exit>
    exit(0);
    1914:	4501                	li	a0,0
    1916:	00004097          	auipc	ra,0x4
    191a:	2ba080e7          	jalr	698(ra) # 5bd0 <exit>

000000000000191e <pipe1>:
{
    191e:	711d                	addi	sp,sp,-96
    1920:	ec86                	sd	ra,88(sp)
    1922:	e8a2                	sd	s0,80(sp)
    1924:	e4a6                	sd	s1,72(sp)
    1926:	e0ca                	sd	s2,64(sp)
    1928:	fc4e                	sd	s3,56(sp)
    192a:	f852                	sd	s4,48(sp)
    192c:	f456                	sd	s5,40(sp)
    192e:	f05a                	sd	s6,32(sp)
    1930:	ec5e                	sd	s7,24(sp)
    1932:	1080                	addi	s0,sp,96
    1934:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    1936:	fa840513          	addi	a0,s0,-88
    193a:	00004097          	auipc	ra,0x4
    193e:	2a6080e7          	jalr	678(ra) # 5be0 <pipe>
    1942:	ed25                	bnez	a0,19ba <pipe1+0x9c>
    1944:	84aa                	mv	s1,a0
  pid = fork();
    1946:	00004097          	auipc	ra,0x4
    194a:	282080e7          	jalr	642(ra) # 5bc8 <fork>
    194e:	8a2a                	mv	s4,a0
  if(pid == 0){
    1950:	c159                	beqz	a0,19d6 <pipe1+0xb8>
  } else if(pid > 0){
    1952:	16a05e63          	blez	a0,1ace <pipe1+0x1b0>
    close(fds[1]);
    1956:	fac42503          	lw	a0,-84(s0)
    195a:	00004097          	auipc	ra,0x4
    195e:	29e080e7          	jalr	670(ra) # 5bf8 <close>
    total = 0;
    1962:	8a26                	mv	s4,s1
    cc = 1;
    1964:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1966:	0000ba97          	auipc	s5,0xb
    196a:	312a8a93          	addi	s5,s5,786 # cc78 <buf>
      if(cc > sizeof(buf))
    196e:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    1970:	864e                	mv	a2,s3
    1972:	85d6                	mv	a1,s5
    1974:	fa842503          	lw	a0,-88(s0)
    1978:	00004097          	auipc	ra,0x4
    197c:	270080e7          	jalr	624(ra) # 5be8 <read>
    1980:	10a05263          	blez	a0,1a84 <pipe1+0x166>
      for(i = 0; i < n; i++){
    1984:	0000b717          	auipc	a4,0xb
    1988:	2f470713          	addi	a4,a4,756 # cc78 <buf>
    198c:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    1990:	00074683          	lbu	a3,0(a4)
    1994:	0ff4f793          	andi	a5,s1,255
    1998:	2485                	addiw	s1,s1,1
    199a:	0cf69163          	bne	a3,a5,1a5c <pipe1+0x13e>
      for(i = 0; i < n; i++){
    199e:	0705                	addi	a4,a4,1
    19a0:	fec498e3          	bne	s1,a2,1990 <pipe1+0x72>
      total += n;
    19a4:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    19a8:	0019979b          	slliw	a5,s3,0x1
    19ac:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    19b0:	013b7363          	bgeu	s6,s3,19b6 <pipe1+0x98>
        cc = sizeof(buf);
    19b4:	89da                	mv	s3,s6
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    19b6:	84b2                	mv	s1,a2
    19b8:	bf65                	j	1970 <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    19ba:	85ca                	mv	a1,s2
    19bc:	00005517          	auipc	a0,0x5
    19c0:	11c50513          	addi	a0,a0,284 # 6ad8 <malloc+0xad2>
    19c4:	00004097          	auipc	ra,0x4
    19c8:	584080e7          	jalr	1412(ra) # 5f48 <printf>
    exit(1);
    19cc:	4505                	li	a0,1
    19ce:	00004097          	auipc	ra,0x4
    19d2:	202080e7          	jalr	514(ra) # 5bd0 <exit>
    close(fds[0]);
    19d6:	fa842503          	lw	a0,-88(s0)
    19da:	00004097          	auipc	ra,0x4
    19de:	21e080e7          	jalr	542(ra) # 5bf8 <close>
    for(n = 0; n < N; n++){
    19e2:	0000bb17          	auipc	s6,0xb
    19e6:	296b0b13          	addi	s6,s6,662 # cc78 <buf>
    19ea:	416004bb          	negw	s1,s6
    19ee:	0ff4f493          	andi	s1,s1,255
    19f2:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    19f6:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    19f8:	6a85                	lui	s5,0x1
    19fa:	42da8a93          	addi	s5,s5,1069 # 142d <copyinstr2+0x9b>
{
    19fe:	87da                	mv	a5,s6
        buf[i] = seq++;
    1a00:	0097873b          	addw	a4,a5,s1
    1a04:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1a08:	0785                	addi	a5,a5,1
    1a0a:	fef99be3          	bne	s3,a5,1a00 <pipe1+0xe2>
    1a0e:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1a12:	40900613          	li	a2,1033
    1a16:	85de                	mv	a1,s7
    1a18:	fac42503          	lw	a0,-84(s0)
    1a1c:	00004097          	auipc	ra,0x4
    1a20:	1d4080e7          	jalr	468(ra) # 5bf0 <write>
    1a24:	40900793          	li	a5,1033
    1a28:	00f51c63          	bne	a0,a5,1a40 <pipe1+0x122>
    for(n = 0; n < N; n++){
    1a2c:	24a5                	addiw	s1,s1,9
    1a2e:	0ff4f493          	andi	s1,s1,255
    1a32:	fd5a16e3          	bne	s4,s5,19fe <pipe1+0xe0>
    exit(0);
    1a36:	4501                	li	a0,0
    1a38:	00004097          	auipc	ra,0x4
    1a3c:	198080e7          	jalr	408(ra) # 5bd0 <exit>
        printf("%s: pipe1 oops 1\n", s);
    1a40:	85ca                	mv	a1,s2
    1a42:	00005517          	auipc	a0,0x5
    1a46:	0ae50513          	addi	a0,a0,174 # 6af0 <malloc+0xaea>
    1a4a:	00004097          	auipc	ra,0x4
    1a4e:	4fe080e7          	jalr	1278(ra) # 5f48 <printf>
        exit(1);
    1a52:	4505                	li	a0,1
    1a54:	00004097          	auipc	ra,0x4
    1a58:	17c080e7          	jalr	380(ra) # 5bd0 <exit>
          printf("%s: pipe1 oops 2\n", s);
    1a5c:	85ca                	mv	a1,s2
    1a5e:	00005517          	auipc	a0,0x5
    1a62:	0aa50513          	addi	a0,a0,170 # 6b08 <malloc+0xb02>
    1a66:	00004097          	auipc	ra,0x4
    1a6a:	4e2080e7          	jalr	1250(ra) # 5f48 <printf>
}
    1a6e:	60e6                	ld	ra,88(sp)
    1a70:	6446                	ld	s0,80(sp)
    1a72:	64a6                	ld	s1,72(sp)
    1a74:	6906                	ld	s2,64(sp)
    1a76:	79e2                	ld	s3,56(sp)
    1a78:	7a42                	ld	s4,48(sp)
    1a7a:	7aa2                	ld	s5,40(sp)
    1a7c:	7b02                	ld	s6,32(sp)
    1a7e:	6be2                	ld	s7,24(sp)
    1a80:	6125                	addi	sp,sp,96
    1a82:	8082                	ret
    if(total != N * SZ){
    1a84:	6785                	lui	a5,0x1
    1a86:	42d78793          	addi	a5,a5,1069 # 142d <copyinstr2+0x9b>
    1a8a:	02fa0063          	beq	s4,a5,1aaa <pipe1+0x18c>
      printf("%s: pipe1 oops 3 total %d\n", total);
    1a8e:	85d2                	mv	a1,s4
    1a90:	00005517          	auipc	a0,0x5
    1a94:	09050513          	addi	a0,a0,144 # 6b20 <malloc+0xb1a>
    1a98:	00004097          	auipc	ra,0x4
    1a9c:	4b0080e7          	jalr	1200(ra) # 5f48 <printf>
      exit(1);
    1aa0:	4505                	li	a0,1
    1aa2:	00004097          	auipc	ra,0x4
    1aa6:	12e080e7          	jalr	302(ra) # 5bd0 <exit>
    close(fds[0]);
    1aaa:	fa842503          	lw	a0,-88(s0)
    1aae:	00004097          	auipc	ra,0x4
    1ab2:	14a080e7          	jalr	330(ra) # 5bf8 <close>
    wait(&xstatus);
    1ab6:	fa440513          	addi	a0,s0,-92
    1aba:	00004097          	auipc	ra,0x4
    1abe:	11e080e7          	jalr	286(ra) # 5bd8 <wait>
    exit(xstatus);
    1ac2:	fa442503          	lw	a0,-92(s0)
    1ac6:	00004097          	auipc	ra,0x4
    1aca:	10a080e7          	jalr	266(ra) # 5bd0 <exit>
    printf("%s: fork() failed\n", s);
    1ace:	85ca                	mv	a1,s2
    1ad0:	00005517          	auipc	a0,0x5
    1ad4:	07050513          	addi	a0,a0,112 # 6b40 <malloc+0xb3a>
    1ad8:	00004097          	auipc	ra,0x4
    1adc:	470080e7          	jalr	1136(ra) # 5f48 <printf>
    exit(1);
    1ae0:	4505                	li	a0,1
    1ae2:	00004097          	auipc	ra,0x4
    1ae6:	0ee080e7          	jalr	238(ra) # 5bd0 <exit>

0000000000001aea <exitwait>:
{
    1aea:	7139                	addi	sp,sp,-64
    1aec:	fc06                	sd	ra,56(sp)
    1aee:	f822                	sd	s0,48(sp)
    1af0:	f426                	sd	s1,40(sp)
    1af2:	f04a                	sd	s2,32(sp)
    1af4:	ec4e                	sd	s3,24(sp)
    1af6:	e852                	sd	s4,16(sp)
    1af8:	0080                	addi	s0,sp,64
    1afa:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    1afc:	4901                	li	s2,0
    1afe:	06400993          	li	s3,100
    pid = fork();
    1b02:	00004097          	auipc	ra,0x4
    1b06:	0c6080e7          	jalr	198(ra) # 5bc8 <fork>
    1b0a:	84aa                	mv	s1,a0
    if(pid < 0){
    1b0c:	02054a63          	bltz	a0,1b40 <exitwait+0x56>
    if(pid){
    1b10:	c151                	beqz	a0,1b94 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1b12:	fcc40513          	addi	a0,s0,-52
    1b16:	00004097          	auipc	ra,0x4
    1b1a:	0c2080e7          	jalr	194(ra) # 5bd8 <wait>
    1b1e:	02951f63          	bne	a0,s1,1b5c <exitwait+0x72>
      if(i != xstate) {
    1b22:	fcc42783          	lw	a5,-52(s0)
    1b26:	05279963          	bne	a5,s2,1b78 <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1b2a:	2905                	addiw	s2,s2,1
    1b2c:	fd391be3          	bne	s2,s3,1b02 <exitwait+0x18>
}
    1b30:	70e2                	ld	ra,56(sp)
    1b32:	7442                	ld	s0,48(sp)
    1b34:	74a2                	ld	s1,40(sp)
    1b36:	7902                	ld	s2,32(sp)
    1b38:	69e2                	ld	s3,24(sp)
    1b3a:	6a42                	ld	s4,16(sp)
    1b3c:	6121                	addi	sp,sp,64
    1b3e:	8082                	ret
      printf("%s: fork failed\n", s);
    1b40:	85d2                	mv	a1,s4
    1b42:	00005517          	auipc	a0,0x5
    1b46:	e8e50513          	addi	a0,a0,-370 # 69d0 <malloc+0x9ca>
    1b4a:	00004097          	auipc	ra,0x4
    1b4e:	3fe080e7          	jalr	1022(ra) # 5f48 <printf>
      exit(1);
    1b52:	4505                	li	a0,1
    1b54:	00004097          	auipc	ra,0x4
    1b58:	07c080e7          	jalr	124(ra) # 5bd0 <exit>
        printf("%s: wait wrong pid\n", s);
    1b5c:	85d2                	mv	a1,s4
    1b5e:	00005517          	auipc	a0,0x5
    1b62:	ffa50513          	addi	a0,a0,-6 # 6b58 <malloc+0xb52>
    1b66:	00004097          	auipc	ra,0x4
    1b6a:	3e2080e7          	jalr	994(ra) # 5f48 <printf>
        exit(1);
    1b6e:	4505                	li	a0,1
    1b70:	00004097          	auipc	ra,0x4
    1b74:	060080e7          	jalr	96(ra) # 5bd0 <exit>
        printf("%s: wait wrong exit status\n", s);
    1b78:	85d2                	mv	a1,s4
    1b7a:	00005517          	auipc	a0,0x5
    1b7e:	ff650513          	addi	a0,a0,-10 # 6b70 <malloc+0xb6a>
    1b82:	00004097          	auipc	ra,0x4
    1b86:	3c6080e7          	jalr	966(ra) # 5f48 <printf>
        exit(1);
    1b8a:	4505                	li	a0,1
    1b8c:	00004097          	auipc	ra,0x4
    1b90:	044080e7          	jalr	68(ra) # 5bd0 <exit>
      exit(i);
    1b94:	854a                	mv	a0,s2
    1b96:	00004097          	auipc	ra,0x4
    1b9a:	03a080e7          	jalr	58(ra) # 5bd0 <exit>

0000000000001b9e <twochildren>:
{
    1b9e:	1101                	addi	sp,sp,-32
    1ba0:	ec06                	sd	ra,24(sp)
    1ba2:	e822                	sd	s0,16(sp)
    1ba4:	e426                	sd	s1,8(sp)
    1ba6:	e04a                	sd	s2,0(sp)
    1ba8:	1000                	addi	s0,sp,32
    1baa:	892a                	mv	s2,a0
    1bac:	3e800493          	li	s1,1000
    int pid1 = fork();
    1bb0:	00004097          	auipc	ra,0x4
    1bb4:	018080e7          	jalr	24(ra) # 5bc8 <fork>
    if(pid1 < 0){
    1bb8:	02054c63          	bltz	a0,1bf0 <twochildren+0x52>
    if(pid1 == 0){
    1bbc:	c921                	beqz	a0,1c0c <twochildren+0x6e>
      int pid2 = fork();
    1bbe:	00004097          	auipc	ra,0x4
    1bc2:	00a080e7          	jalr	10(ra) # 5bc8 <fork>
      if(pid2 < 0){
    1bc6:	04054763          	bltz	a0,1c14 <twochildren+0x76>
      if(pid2 == 0){
    1bca:	c13d                	beqz	a0,1c30 <twochildren+0x92>
        wait(0);
    1bcc:	4501                	li	a0,0
    1bce:	00004097          	auipc	ra,0x4
    1bd2:	00a080e7          	jalr	10(ra) # 5bd8 <wait>
        wait(0);
    1bd6:	4501                	li	a0,0
    1bd8:	00004097          	auipc	ra,0x4
    1bdc:	000080e7          	jalr	ra # 5bd8 <wait>
  for(int i = 0; i < 1000; i++){
    1be0:	34fd                	addiw	s1,s1,-1
    1be2:	f4f9                	bnez	s1,1bb0 <twochildren+0x12>
}
    1be4:	60e2                	ld	ra,24(sp)
    1be6:	6442                	ld	s0,16(sp)
    1be8:	64a2                	ld	s1,8(sp)
    1bea:	6902                	ld	s2,0(sp)
    1bec:	6105                	addi	sp,sp,32
    1bee:	8082                	ret
      printf("%s: fork failed\n", s);
    1bf0:	85ca                	mv	a1,s2
    1bf2:	00005517          	auipc	a0,0x5
    1bf6:	dde50513          	addi	a0,a0,-546 # 69d0 <malloc+0x9ca>
    1bfa:	00004097          	auipc	ra,0x4
    1bfe:	34e080e7          	jalr	846(ra) # 5f48 <printf>
      exit(1);
    1c02:	4505                	li	a0,1
    1c04:	00004097          	auipc	ra,0x4
    1c08:	fcc080e7          	jalr	-52(ra) # 5bd0 <exit>
      exit(0);
    1c0c:	00004097          	auipc	ra,0x4
    1c10:	fc4080e7          	jalr	-60(ra) # 5bd0 <exit>
        printf("%s: fork failed\n", s);
    1c14:	85ca                	mv	a1,s2
    1c16:	00005517          	auipc	a0,0x5
    1c1a:	dba50513          	addi	a0,a0,-582 # 69d0 <malloc+0x9ca>
    1c1e:	00004097          	auipc	ra,0x4
    1c22:	32a080e7          	jalr	810(ra) # 5f48 <printf>
        exit(1);
    1c26:	4505                	li	a0,1
    1c28:	00004097          	auipc	ra,0x4
    1c2c:	fa8080e7          	jalr	-88(ra) # 5bd0 <exit>
        exit(0);
    1c30:	00004097          	auipc	ra,0x4
    1c34:	fa0080e7          	jalr	-96(ra) # 5bd0 <exit>

0000000000001c38 <forkfork>:
{
    1c38:	7179                	addi	sp,sp,-48
    1c3a:	f406                	sd	ra,40(sp)
    1c3c:	f022                	sd	s0,32(sp)
    1c3e:	ec26                	sd	s1,24(sp)
    1c40:	1800                	addi	s0,sp,48
    1c42:	84aa                	mv	s1,a0
    int pid = fork();
    1c44:	00004097          	auipc	ra,0x4
    1c48:	f84080e7          	jalr	-124(ra) # 5bc8 <fork>
    if(pid < 0){
    1c4c:	04054163          	bltz	a0,1c8e <forkfork+0x56>
    if(pid == 0){
    1c50:	cd29                	beqz	a0,1caa <forkfork+0x72>
    int pid = fork();
    1c52:	00004097          	auipc	ra,0x4
    1c56:	f76080e7          	jalr	-138(ra) # 5bc8 <fork>
    if(pid < 0){
    1c5a:	02054a63          	bltz	a0,1c8e <forkfork+0x56>
    if(pid == 0){
    1c5e:	c531                	beqz	a0,1caa <forkfork+0x72>
    wait(&xstatus);
    1c60:	fdc40513          	addi	a0,s0,-36
    1c64:	00004097          	auipc	ra,0x4
    1c68:	f74080e7          	jalr	-140(ra) # 5bd8 <wait>
    if(xstatus != 0) {
    1c6c:	fdc42783          	lw	a5,-36(s0)
    1c70:	ebbd                	bnez	a5,1ce6 <forkfork+0xae>
    wait(&xstatus);
    1c72:	fdc40513          	addi	a0,s0,-36
    1c76:	00004097          	auipc	ra,0x4
    1c7a:	f62080e7          	jalr	-158(ra) # 5bd8 <wait>
    if(xstatus != 0) {
    1c7e:	fdc42783          	lw	a5,-36(s0)
    1c82:	e3b5                	bnez	a5,1ce6 <forkfork+0xae>
}
    1c84:	70a2                	ld	ra,40(sp)
    1c86:	7402                	ld	s0,32(sp)
    1c88:	64e2                	ld	s1,24(sp)
    1c8a:	6145                	addi	sp,sp,48
    1c8c:	8082                	ret
      printf("%s: fork failed", s);
    1c8e:	85a6                	mv	a1,s1
    1c90:	00005517          	auipc	a0,0x5
    1c94:	f0050513          	addi	a0,a0,-256 # 6b90 <malloc+0xb8a>
    1c98:	00004097          	auipc	ra,0x4
    1c9c:	2b0080e7          	jalr	688(ra) # 5f48 <printf>
      exit(1);
    1ca0:	4505                	li	a0,1
    1ca2:	00004097          	auipc	ra,0x4
    1ca6:	f2e080e7          	jalr	-210(ra) # 5bd0 <exit>
{
    1caa:	0c800493          	li	s1,200
        int pid1 = fork();
    1cae:	00004097          	auipc	ra,0x4
    1cb2:	f1a080e7          	jalr	-230(ra) # 5bc8 <fork>
        if(pid1 < 0){
    1cb6:	00054f63          	bltz	a0,1cd4 <forkfork+0x9c>
        if(pid1 == 0){
    1cba:	c115                	beqz	a0,1cde <forkfork+0xa6>
        wait(0);
    1cbc:	4501                	li	a0,0
    1cbe:	00004097          	auipc	ra,0x4
    1cc2:	f1a080e7          	jalr	-230(ra) # 5bd8 <wait>
      for(int j = 0; j < 200; j++){
    1cc6:	34fd                	addiw	s1,s1,-1
    1cc8:	f0fd                	bnez	s1,1cae <forkfork+0x76>
      exit(0);
    1cca:	4501                	li	a0,0
    1ccc:	00004097          	auipc	ra,0x4
    1cd0:	f04080e7          	jalr	-252(ra) # 5bd0 <exit>
          exit(1);
    1cd4:	4505                	li	a0,1
    1cd6:	00004097          	auipc	ra,0x4
    1cda:	efa080e7          	jalr	-262(ra) # 5bd0 <exit>
          exit(0);
    1cde:	00004097          	auipc	ra,0x4
    1ce2:	ef2080e7          	jalr	-270(ra) # 5bd0 <exit>
      printf("%s: fork in child failed", s);
    1ce6:	85a6                	mv	a1,s1
    1ce8:	00005517          	auipc	a0,0x5
    1cec:	eb850513          	addi	a0,a0,-328 # 6ba0 <malloc+0xb9a>
    1cf0:	00004097          	auipc	ra,0x4
    1cf4:	258080e7          	jalr	600(ra) # 5f48 <printf>
      exit(1);
    1cf8:	4505                	li	a0,1
    1cfa:	00004097          	auipc	ra,0x4
    1cfe:	ed6080e7          	jalr	-298(ra) # 5bd0 <exit>

0000000000001d02 <reparent2>:
{
    1d02:	1101                	addi	sp,sp,-32
    1d04:	ec06                	sd	ra,24(sp)
    1d06:	e822                	sd	s0,16(sp)
    1d08:	e426                	sd	s1,8(sp)
    1d0a:	1000                	addi	s0,sp,32
    1d0c:	32000493          	li	s1,800
    int pid1 = fork();
    1d10:	00004097          	auipc	ra,0x4
    1d14:	eb8080e7          	jalr	-328(ra) # 5bc8 <fork>
    if(pid1 < 0){
    1d18:	00054f63          	bltz	a0,1d36 <reparent2+0x34>
    if(pid1 == 0){
    1d1c:	c915                	beqz	a0,1d50 <reparent2+0x4e>
    wait(0);
    1d1e:	4501                	li	a0,0
    1d20:	00004097          	auipc	ra,0x4
    1d24:	eb8080e7          	jalr	-328(ra) # 5bd8 <wait>
  for(int i = 0; i < 800; i++){
    1d28:	34fd                	addiw	s1,s1,-1
    1d2a:	f0fd                	bnez	s1,1d10 <reparent2+0xe>
  exit(0);
    1d2c:	4501                	li	a0,0
    1d2e:	00004097          	auipc	ra,0x4
    1d32:	ea2080e7          	jalr	-350(ra) # 5bd0 <exit>
      printf("fork failed\n");
    1d36:	00005517          	auipc	a0,0x5
    1d3a:	0a250513          	addi	a0,a0,162 # 6dd8 <malloc+0xdd2>
    1d3e:	00004097          	auipc	ra,0x4
    1d42:	20a080e7          	jalr	522(ra) # 5f48 <printf>
      exit(1);
    1d46:	4505                	li	a0,1
    1d48:	00004097          	auipc	ra,0x4
    1d4c:	e88080e7          	jalr	-376(ra) # 5bd0 <exit>
      fork();
    1d50:	00004097          	auipc	ra,0x4
    1d54:	e78080e7          	jalr	-392(ra) # 5bc8 <fork>
      fork();
    1d58:	00004097          	auipc	ra,0x4
    1d5c:	e70080e7          	jalr	-400(ra) # 5bc8 <fork>
      exit(0);
    1d60:	4501                	li	a0,0
    1d62:	00004097          	auipc	ra,0x4
    1d66:	e6e080e7          	jalr	-402(ra) # 5bd0 <exit>

0000000000001d6a <createdelete>:
{
    1d6a:	7175                	addi	sp,sp,-144
    1d6c:	e506                	sd	ra,136(sp)
    1d6e:	e122                	sd	s0,128(sp)
    1d70:	fca6                	sd	s1,120(sp)
    1d72:	f8ca                	sd	s2,112(sp)
    1d74:	f4ce                	sd	s3,104(sp)
    1d76:	f0d2                	sd	s4,96(sp)
    1d78:	ecd6                	sd	s5,88(sp)
    1d7a:	e8da                	sd	s6,80(sp)
    1d7c:	e4de                	sd	s7,72(sp)
    1d7e:	e0e2                	sd	s8,64(sp)
    1d80:	fc66                	sd	s9,56(sp)
    1d82:	0900                	addi	s0,sp,144
    1d84:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1d86:	4901                	li	s2,0
    1d88:	4991                	li	s3,4
    pid = fork();
    1d8a:	00004097          	auipc	ra,0x4
    1d8e:	e3e080e7          	jalr	-450(ra) # 5bc8 <fork>
    1d92:	84aa                	mv	s1,a0
    if(pid < 0){
    1d94:	02054f63          	bltz	a0,1dd2 <createdelete+0x68>
    if(pid == 0){
    1d98:	c939                	beqz	a0,1dee <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1d9a:	2905                	addiw	s2,s2,1
    1d9c:	ff3917e3          	bne	s2,s3,1d8a <createdelete+0x20>
    1da0:	4491                	li	s1,4
    wait(&xstatus);
    1da2:	f7c40513          	addi	a0,s0,-132
    1da6:	00004097          	auipc	ra,0x4
    1daa:	e32080e7          	jalr	-462(ra) # 5bd8 <wait>
    if(xstatus != 0)
    1dae:	f7c42903          	lw	s2,-132(s0)
    1db2:	0e091263          	bnez	s2,1e96 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1db6:	34fd                	addiw	s1,s1,-1
    1db8:	f4ed                	bnez	s1,1da2 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1dba:	f8040123          	sb	zero,-126(s0)
    1dbe:	03000993          	li	s3,48
    1dc2:	5a7d                	li	s4,-1
    1dc4:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1dc8:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1dca:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1dcc:	07400a93          	li	s5,116
    1dd0:	a29d                	j	1f36 <createdelete+0x1cc>
      printf("fork failed\n", s);
    1dd2:	85e6                	mv	a1,s9
    1dd4:	00005517          	auipc	a0,0x5
    1dd8:	00450513          	addi	a0,a0,4 # 6dd8 <malloc+0xdd2>
    1ddc:	00004097          	auipc	ra,0x4
    1de0:	16c080e7          	jalr	364(ra) # 5f48 <printf>
      exit(1);
    1de4:	4505                	li	a0,1
    1de6:	00004097          	auipc	ra,0x4
    1dea:	dea080e7          	jalr	-534(ra) # 5bd0 <exit>
      name[0] = 'p' + pi;
    1dee:	0709091b          	addiw	s2,s2,112
    1df2:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1df6:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1dfa:	4951                	li	s2,20
    1dfc:	a015                	j	1e20 <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1dfe:	85e6                	mv	a1,s9
    1e00:	00005517          	auipc	a0,0x5
    1e04:	c6850513          	addi	a0,a0,-920 # 6a68 <malloc+0xa62>
    1e08:	00004097          	auipc	ra,0x4
    1e0c:	140080e7          	jalr	320(ra) # 5f48 <printf>
          exit(1);
    1e10:	4505                	li	a0,1
    1e12:	00004097          	auipc	ra,0x4
    1e16:	dbe080e7          	jalr	-578(ra) # 5bd0 <exit>
      for(i = 0; i < N; i++){
    1e1a:	2485                	addiw	s1,s1,1
    1e1c:	07248863          	beq	s1,s2,1e8c <createdelete+0x122>
        name[1] = '0' + i;
    1e20:	0304879b          	addiw	a5,s1,48
    1e24:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1e28:	20200593          	li	a1,514
    1e2c:	f8040513          	addi	a0,s0,-128
    1e30:	00004097          	auipc	ra,0x4
    1e34:	de0080e7          	jalr	-544(ra) # 5c10 <open>
        if(fd < 0){
    1e38:	fc0543e3          	bltz	a0,1dfe <createdelete+0x94>
        close(fd);
    1e3c:	00004097          	auipc	ra,0x4
    1e40:	dbc080e7          	jalr	-580(ra) # 5bf8 <close>
        if(i > 0 && (i % 2 ) == 0){
    1e44:	fc905be3          	blez	s1,1e1a <createdelete+0xb0>
    1e48:	0014f793          	andi	a5,s1,1
    1e4c:	f7f9                	bnez	a5,1e1a <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1e4e:	01f4d79b          	srliw	a5,s1,0x1f
    1e52:	9fa5                	addw	a5,a5,s1
    1e54:	4017d79b          	sraiw	a5,a5,0x1
    1e58:	0307879b          	addiw	a5,a5,48
    1e5c:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1e60:	f8040513          	addi	a0,s0,-128
    1e64:	00004097          	auipc	ra,0x4
    1e68:	dbc080e7          	jalr	-580(ra) # 5c20 <unlink>
    1e6c:	fa0557e3          	bgez	a0,1e1a <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1e70:	85e6                	mv	a1,s9
    1e72:	00005517          	auipc	a0,0x5
    1e76:	d4e50513          	addi	a0,a0,-690 # 6bc0 <malloc+0xbba>
    1e7a:	00004097          	auipc	ra,0x4
    1e7e:	0ce080e7          	jalr	206(ra) # 5f48 <printf>
            exit(1);
    1e82:	4505                	li	a0,1
    1e84:	00004097          	auipc	ra,0x4
    1e88:	d4c080e7          	jalr	-692(ra) # 5bd0 <exit>
      exit(0);
    1e8c:	4501                	li	a0,0
    1e8e:	00004097          	auipc	ra,0x4
    1e92:	d42080e7          	jalr	-702(ra) # 5bd0 <exit>
      exit(1);
    1e96:	4505                	li	a0,1
    1e98:	00004097          	auipc	ra,0x4
    1e9c:	d38080e7          	jalr	-712(ra) # 5bd0 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1ea0:	f8040613          	addi	a2,s0,-128
    1ea4:	85e6                	mv	a1,s9
    1ea6:	00005517          	auipc	a0,0x5
    1eaa:	d3250513          	addi	a0,a0,-718 # 6bd8 <malloc+0xbd2>
    1eae:	00004097          	auipc	ra,0x4
    1eb2:	09a080e7          	jalr	154(ra) # 5f48 <printf>
        exit(1);
    1eb6:	4505                	li	a0,1
    1eb8:	00004097          	auipc	ra,0x4
    1ebc:	d18080e7          	jalr	-744(ra) # 5bd0 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ec0:	054b7163          	bgeu	s6,s4,1f02 <createdelete+0x198>
      if(fd >= 0)
    1ec4:	02055a63          	bgez	a0,1ef8 <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1ec8:	2485                	addiw	s1,s1,1
    1eca:	0ff4f493          	andi	s1,s1,255
    1ece:	05548c63          	beq	s1,s5,1f26 <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1ed2:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1ed6:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1eda:	4581                	li	a1,0
    1edc:	f8040513          	addi	a0,s0,-128
    1ee0:	00004097          	auipc	ra,0x4
    1ee4:	d30080e7          	jalr	-720(ra) # 5c10 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1ee8:	00090463          	beqz	s2,1ef0 <createdelete+0x186>
    1eec:	fd2bdae3          	bge	s7,s2,1ec0 <createdelete+0x156>
    1ef0:	fa0548e3          	bltz	a0,1ea0 <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1ef4:	014b7963          	bgeu	s6,s4,1f06 <createdelete+0x19c>
        close(fd);
    1ef8:	00004097          	auipc	ra,0x4
    1efc:	d00080e7          	jalr	-768(ra) # 5bf8 <close>
    1f00:	b7e1                	j	1ec8 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1f02:	fc0543e3          	bltz	a0,1ec8 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1f06:	f8040613          	addi	a2,s0,-128
    1f0a:	85e6                	mv	a1,s9
    1f0c:	00005517          	auipc	a0,0x5
    1f10:	cf450513          	addi	a0,a0,-780 # 6c00 <malloc+0xbfa>
    1f14:	00004097          	auipc	ra,0x4
    1f18:	034080e7          	jalr	52(ra) # 5f48 <printf>
        exit(1);
    1f1c:	4505                	li	a0,1
    1f1e:	00004097          	auipc	ra,0x4
    1f22:	cb2080e7          	jalr	-846(ra) # 5bd0 <exit>
  for(i = 0; i < N; i++){
    1f26:	2905                	addiw	s2,s2,1
    1f28:	2a05                	addiw	s4,s4,1
    1f2a:	2985                	addiw	s3,s3,1
    1f2c:	0ff9f993          	andi	s3,s3,255
    1f30:	47d1                	li	a5,20
    1f32:	02f90a63          	beq	s2,a5,1f66 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1f36:	84e2                	mv	s1,s8
    1f38:	bf69                	j	1ed2 <createdelete+0x168>
  for(i = 0; i < N; i++){
    1f3a:	2905                	addiw	s2,s2,1
    1f3c:	0ff97913          	andi	s2,s2,255
    1f40:	2985                	addiw	s3,s3,1
    1f42:	0ff9f993          	andi	s3,s3,255
    1f46:	03490863          	beq	s2,s4,1f76 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1f4a:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1f4c:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1f50:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1f54:	f8040513          	addi	a0,s0,-128
    1f58:	00004097          	auipc	ra,0x4
    1f5c:	cc8080e7          	jalr	-824(ra) # 5c20 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1f60:	34fd                	addiw	s1,s1,-1
    1f62:	f4ed                	bnez	s1,1f4c <createdelete+0x1e2>
    1f64:	bfd9                	j	1f3a <createdelete+0x1d0>
    1f66:	03000993          	li	s3,48
    1f6a:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1f6e:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1f70:	08400a13          	li	s4,132
    1f74:	bfd9                	j	1f4a <createdelete+0x1e0>
}
    1f76:	60aa                	ld	ra,136(sp)
    1f78:	640a                	ld	s0,128(sp)
    1f7a:	74e6                	ld	s1,120(sp)
    1f7c:	7946                	ld	s2,112(sp)
    1f7e:	79a6                	ld	s3,104(sp)
    1f80:	7a06                	ld	s4,96(sp)
    1f82:	6ae6                	ld	s5,88(sp)
    1f84:	6b46                	ld	s6,80(sp)
    1f86:	6ba6                	ld	s7,72(sp)
    1f88:	6c06                	ld	s8,64(sp)
    1f8a:	7ce2                	ld	s9,56(sp)
    1f8c:	6149                	addi	sp,sp,144
    1f8e:	8082                	ret

0000000000001f90 <linkunlink>:
{
    1f90:	711d                	addi	sp,sp,-96
    1f92:	ec86                	sd	ra,88(sp)
    1f94:	e8a2                	sd	s0,80(sp)
    1f96:	e4a6                	sd	s1,72(sp)
    1f98:	e0ca                	sd	s2,64(sp)
    1f9a:	fc4e                	sd	s3,56(sp)
    1f9c:	f852                	sd	s4,48(sp)
    1f9e:	f456                	sd	s5,40(sp)
    1fa0:	f05a                	sd	s6,32(sp)
    1fa2:	ec5e                	sd	s7,24(sp)
    1fa4:	e862                	sd	s8,16(sp)
    1fa6:	e466                	sd	s9,8(sp)
    1fa8:	1080                	addi	s0,sp,96
    1faa:	84aa                	mv	s1,a0
  unlink("x");
    1fac:	00004517          	auipc	a0,0x4
    1fb0:	20c50513          	addi	a0,a0,524 # 61b8 <malloc+0x1b2>
    1fb4:	00004097          	auipc	ra,0x4
    1fb8:	c6c080e7          	jalr	-916(ra) # 5c20 <unlink>
  pid = fork();
    1fbc:	00004097          	auipc	ra,0x4
    1fc0:	c0c080e7          	jalr	-1012(ra) # 5bc8 <fork>
  if(pid < 0){
    1fc4:	02054b63          	bltz	a0,1ffa <linkunlink+0x6a>
    1fc8:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1fca:	4c85                	li	s9,1
    1fcc:	e119                	bnez	a0,1fd2 <linkunlink+0x42>
    1fce:	06100c93          	li	s9,97
    1fd2:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1fd6:	41c659b7          	lui	s3,0x41c65
    1fda:	e6d9899b          	addiw	s3,s3,-403
    1fde:	690d                	lui	s2,0x3
    1fe0:	0399091b          	addiw	s2,s2,57
    if((x % 3) == 0){
    1fe4:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1fe6:	4b05                	li	s6,1
      unlink("x");
    1fe8:	00004a97          	auipc	s5,0x4
    1fec:	1d0a8a93          	addi	s5,s5,464 # 61b8 <malloc+0x1b2>
      link("cat", "x");
    1ff0:	00005b97          	auipc	s7,0x5
    1ff4:	c38b8b93          	addi	s7,s7,-968 # 6c28 <malloc+0xc22>
    1ff8:	a091                	j	203c <linkunlink+0xac>
    printf("%s: fork failed\n", s);
    1ffa:	85a6                	mv	a1,s1
    1ffc:	00005517          	auipc	a0,0x5
    2000:	9d450513          	addi	a0,a0,-1580 # 69d0 <malloc+0x9ca>
    2004:	00004097          	auipc	ra,0x4
    2008:	f44080e7          	jalr	-188(ra) # 5f48 <printf>
    exit(1);
    200c:	4505                	li	a0,1
    200e:	00004097          	auipc	ra,0x4
    2012:	bc2080e7          	jalr	-1086(ra) # 5bd0 <exit>
      close(open("x", O_RDWR | O_CREATE));
    2016:	20200593          	li	a1,514
    201a:	8556                	mv	a0,s5
    201c:	00004097          	auipc	ra,0x4
    2020:	bf4080e7          	jalr	-1036(ra) # 5c10 <open>
    2024:	00004097          	auipc	ra,0x4
    2028:	bd4080e7          	jalr	-1068(ra) # 5bf8 <close>
    202c:	a031                	j	2038 <linkunlink+0xa8>
      unlink("x");
    202e:	8556                	mv	a0,s5
    2030:	00004097          	auipc	ra,0x4
    2034:	bf0080e7          	jalr	-1040(ra) # 5c20 <unlink>
  for(i = 0; i < 100; i++){
    2038:	34fd                	addiw	s1,s1,-1
    203a:	c09d                	beqz	s1,2060 <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    203c:	033c87bb          	mulw	a5,s9,s3
    2040:	012787bb          	addw	a5,a5,s2
    2044:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    2048:	0347f7bb          	remuw	a5,a5,s4
    204c:	d7e9                	beqz	a5,2016 <linkunlink+0x86>
    } else if((x % 3) == 1){
    204e:	ff6790e3          	bne	a5,s6,202e <linkunlink+0x9e>
      link("cat", "x");
    2052:	85d6                	mv	a1,s5
    2054:	855e                	mv	a0,s7
    2056:	00004097          	auipc	ra,0x4
    205a:	bda080e7          	jalr	-1062(ra) # 5c30 <link>
    205e:	bfe9                	j	2038 <linkunlink+0xa8>
  if(pid)
    2060:	020c0463          	beqz	s8,2088 <linkunlink+0xf8>
    wait(0);
    2064:	4501                	li	a0,0
    2066:	00004097          	auipc	ra,0x4
    206a:	b72080e7          	jalr	-1166(ra) # 5bd8 <wait>
}
    206e:	60e6                	ld	ra,88(sp)
    2070:	6446                	ld	s0,80(sp)
    2072:	64a6                	ld	s1,72(sp)
    2074:	6906                	ld	s2,64(sp)
    2076:	79e2                	ld	s3,56(sp)
    2078:	7a42                	ld	s4,48(sp)
    207a:	7aa2                	ld	s5,40(sp)
    207c:	7b02                	ld	s6,32(sp)
    207e:	6be2                	ld	s7,24(sp)
    2080:	6c42                	ld	s8,16(sp)
    2082:	6ca2                	ld	s9,8(sp)
    2084:	6125                	addi	sp,sp,96
    2086:	8082                	ret
    exit(0);
    2088:	4501                	li	a0,0
    208a:	00004097          	auipc	ra,0x4
    208e:	b46080e7          	jalr	-1210(ra) # 5bd0 <exit>

0000000000002092 <forktest>:
{
    2092:	7179                	addi	sp,sp,-48
    2094:	f406                	sd	ra,40(sp)
    2096:	f022                	sd	s0,32(sp)
    2098:	ec26                	sd	s1,24(sp)
    209a:	e84a                	sd	s2,16(sp)
    209c:	e44e                	sd	s3,8(sp)
    209e:	1800                	addi	s0,sp,48
    20a0:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    20a2:	4481                	li	s1,0
    20a4:	3e800913          	li	s2,1000
    pid = fork();
    20a8:	00004097          	auipc	ra,0x4
    20ac:	b20080e7          	jalr	-1248(ra) # 5bc8 <fork>
    if(pid < 0)
    20b0:	02054863          	bltz	a0,20e0 <forktest+0x4e>
    if(pid == 0)
    20b4:	c115                	beqz	a0,20d8 <forktest+0x46>
  for(n=0; n<N; n++){
    20b6:	2485                	addiw	s1,s1,1
    20b8:	ff2498e3          	bne	s1,s2,20a8 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    20bc:	85ce                	mv	a1,s3
    20be:	00005517          	auipc	a0,0x5
    20c2:	b8a50513          	addi	a0,a0,-1142 # 6c48 <malloc+0xc42>
    20c6:	00004097          	auipc	ra,0x4
    20ca:	e82080e7          	jalr	-382(ra) # 5f48 <printf>
    exit(1);
    20ce:	4505                	li	a0,1
    20d0:	00004097          	auipc	ra,0x4
    20d4:	b00080e7          	jalr	-1280(ra) # 5bd0 <exit>
      exit(0);
    20d8:	00004097          	auipc	ra,0x4
    20dc:	af8080e7          	jalr	-1288(ra) # 5bd0 <exit>
  if (n == 0) {
    20e0:	cc9d                	beqz	s1,211e <forktest+0x8c>
  if(n == N){
    20e2:	3e800793          	li	a5,1000
    20e6:	fcf48be3          	beq	s1,a5,20bc <forktest+0x2a>
  for(; n > 0; n--){
    20ea:	00905b63          	blez	s1,2100 <forktest+0x6e>
    if(wait(0) < 0){
    20ee:	4501                	li	a0,0
    20f0:	00004097          	auipc	ra,0x4
    20f4:	ae8080e7          	jalr	-1304(ra) # 5bd8 <wait>
    20f8:	04054163          	bltz	a0,213a <forktest+0xa8>
  for(; n > 0; n--){
    20fc:	34fd                	addiw	s1,s1,-1
    20fe:	f8e5                	bnez	s1,20ee <forktest+0x5c>
  if(wait(0) != -1){
    2100:	4501                	li	a0,0
    2102:	00004097          	auipc	ra,0x4
    2106:	ad6080e7          	jalr	-1322(ra) # 5bd8 <wait>
    210a:	57fd                	li	a5,-1
    210c:	04f51563          	bne	a0,a5,2156 <forktest+0xc4>
}
    2110:	70a2                	ld	ra,40(sp)
    2112:	7402                	ld	s0,32(sp)
    2114:	64e2                	ld	s1,24(sp)
    2116:	6942                	ld	s2,16(sp)
    2118:	69a2                	ld	s3,8(sp)
    211a:	6145                	addi	sp,sp,48
    211c:	8082                	ret
    printf("%s: no fork at all!\n", s);
    211e:	85ce                	mv	a1,s3
    2120:	00005517          	auipc	a0,0x5
    2124:	b1050513          	addi	a0,a0,-1264 # 6c30 <malloc+0xc2a>
    2128:	00004097          	auipc	ra,0x4
    212c:	e20080e7          	jalr	-480(ra) # 5f48 <printf>
    exit(1);
    2130:	4505                	li	a0,1
    2132:	00004097          	auipc	ra,0x4
    2136:	a9e080e7          	jalr	-1378(ra) # 5bd0 <exit>
      printf("%s: wait stopped early\n", s);
    213a:	85ce                	mv	a1,s3
    213c:	00005517          	auipc	a0,0x5
    2140:	b3450513          	addi	a0,a0,-1228 # 6c70 <malloc+0xc6a>
    2144:	00004097          	auipc	ra,0x4
    2148:	e04080e7          	jalr	-508(ra) # 5f48 <printf>
      exit(1);
    214c:	4505                	li	a0,1
    214e:	00004097          	auipc	ra,0x4
    2152:	a82080e7          	jalr	-1406(ra) # 5bd0 <exit>
    printf("%s: wait got too many\n", s);
    2156:	85ce                	mv	a1,s3
    2158:	00005517          	auipc	a0,0x5
    215c:	b3050513          	addi	a0,a0,-1232 # 6c88 <malloc+0xc82>
    2160:	00004097          	auipc	ra,0x4
    2164:	de8080e7          	jalr	-536(ra) # 5f48 <printf>
    exit(1);
    2168:	4505                	li	a0,1
    216a:	00004097          	auipc	ra,0x4
    216e:	a66080e7          	jalr	-1434(ra) # 5bd0 <exit>

0000000000002172 <kernmem>:
{
    2172:	715d                	addi	sp,sp,-80
    2174:	e486                	sd	ra,72(sp)
    2176:	e0a2                	sd	s0,64(sp)
    2178:	fc26                	sd	s1,56(sp)
    217a:	f84a                	sd	s2,48(sp)
    217c:	f44e                	sd	s3,40(sp)
    217e:	f052                	sd	s4,32(sp)
    2180:	ec56                	sd	s5,24(sp)
    2182:	0880                	addi	s0,sp,80
    2184:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2186:	4485                	li	s1,1
    2188:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    218a:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    218c:	69b1                	lui	s3,0xc
    218e:	35098993          	addi	s3,s3,848 # c350 <uninit+0x1de8>
    2192:	1003d937          	lui	s2,0x1003d
    2196:	090e                	slli	s2,s2,0x3
    2198:	48090913          	addi	s2,s2,1152 # 1003d480 <base+0x1002d808>
    pid = fork();
    219c:	00004097          	auipc	ra,0x4
    21a0:	a2c080e7          	jalr	-1492(ra) # 5bc8 <fork>
    if(pid < 0){
    21a4:	02054963          	bltz	a0,21d6 <kernmem+0x64>
    if(pid == 0){
    21a8:	c529                	beqz	a0,21f2 <kernmem+0x80>
    wait(&xstatus);
    21aa:	fbc40513          	addi	a0,s0,-68
    21ae:	00004097          	auipc	ra,0x4
    21b2:	a2a080e7          	jalr	-1494(ra) # 5bd8 <wait>
    if(xstatus != -1)  // did kernel kill child?
    21b6:	fbc42783          	lw	a5,-68(s0)
    21ba:	05579d63          	bne	a5,s5,2214 <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    21be:	94ce                	add	s1,s1,s3
    21c0:	fd249ee3          	bne	s1,s2,219c <kernmem+0x2a>
}
    21c4:	60a6                	ld	ra,72(sp)
    21c6:	6406                	ld	s0,64(sp)
    21c8:	74e2                	ld	s1,56(sp)
    21ca:	7942                	ld	s2,48(sp)
    21cc:	79a2                	ld	s3,40(sp)
    21ce:	7a02                	ld	s4,32(sp)
    21d0:	6ae2                	ld	s5,24(sp)
    21d2:	6161                	addi	sp,sp,80
    21d4:	8082                	ret
      printf("%s: fork failed\n", s);
    21d6:	85d2                	mv	a1,s4
    21d8:	00004517          	auipc	a0,0x4
    21dc:	7f850513          	addi	a0,a0,2040 # 69d0 <malloc+0x9ca>
    21e0:	00004097          	auipc	ra,0x4
    21e4:	d68080e7          	jalr	-664(ra) # 5f48 <printf>
      exit(1);
    21e8:	4505                	li	a0,1
    21ea:	00004097          	auipc	ra,0x4
    21ee:	9e6080e7          	jalr	-1562(ra) # 5bd0 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    21f2:	0004c683          	lbu	a3,0(s1)
    21f6:	8626                	mv	a2,s1
    21f8:	85d2                	mv	a1,s4
    21fa:	00005517          	auipc	a0,0x5
    21fe:	aa650513          	addi	a0,a0,-1370 # 6ca0 <malloc+0xc9a>
    2202:	00004097          	auipc	ra,0x4
    2206:	d46080e7          	jalr	-698(ra) # 5f48 <printf>
      exit(1);
    220a:	4505                	li	a0,1
    220c:	00004097          	auipc	ra,0x4
    2210:	9c4080e7          	jalr	-1596(ra) # 5bd0 <exit>
      exit(1);
    2214:	4505                	li	a0,1
    2216:	00004097          	auipc	ra,0x4
    221a:	9ba080e7          	jalr	-1606(ra) # 5bd0 <exit>

000000000000221e <MAXVAplus>:
{
    221e:	7179                	addi	sp,sp,-48
    2220:	f406                	sd	ra,40(sp)
    2222:	f022                	sd	s0,32(sp)
    2224:	ec26                	sd	s1,24(sp)
    2226:	e84a                	sd	s2,16(sp)
    2228:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    222a:	4785                	li	a5,1
    222c:	179a                	slli	a5,a5,0x26
    222e:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    2232:	fd843783          	ld	a5,-40(s0)
    2236:	cf85                	beqz	a5,226e <MAXVAplus+0x50>
    2238:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    223a:	54fd                	li	s1,-1
    pid = fork();
    223c:	00004097          	auipc	ra,0x4
    2240:	98c080e7          	jalr	-1652(ra) # 5bc8 <fork>
    if(pid < 0){
    2244:	02054b63          	bltz	a0,227a <MAXVAplus+0x5c>
    if(pid == 0){
    2248:	c539                	beqz	a0,2296 <MAXVAplus+0x78>
    wait(&xstatus);
    224a:	fd440513          	addi	a0,s0,-44
    224e:	00004097          	auipc	ra,0x4
    2252:	98a080e7          	jalr	-1654(ra) # 5bd8 <wait>
    if(xstatus != -1)  // did kernel kill child?
    2256:	fd442783          	lw	a5,-44(s0)
    225a:	06979463          	bne	a5,s1,22c2 <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    225e:	fd843783          	ld	a5,-40(s0)
    2262:	0786                	slli	a5,a5,0x1
    2264:	fcf43c23          	sd	a5,-40(s0)
    2268:	fd843783          	ld	a5,-40(s0)
    226c:	fbe1                	bnez	a5,223c <MAXVAplus+0x1e>
}
    226e:	70a2                	ld	ra,40(sp)
    2270:	7402                	ld	s0,32(sp)
    2272:	64e2                	ld	s1,24(sp)
    2274:	6942                	ld	s2,16(sp)
    2276:	6145                	addi	sp,sp,48
    2278:	8082                	ret
      printf("%s: fork failed\n", s);
    227a:	85ca                	mv	a1,s2
    227c:	00004517          	auipc	a0,0x4
    2280:	75450513          	addi	a0,a0,1876 # 69d0 <malloc+0x9ca>
    2284:	00004097          	auipc	ra,0x4
    2288:	cc4080e7          	jalr	-828(ra) # 5f48 <printf>
      exit(1);
    228c:	4505                	li	a0,1
    228e:	00004097          	auipc	ra,0x4
    2292:	942080e7          	jalr	-1726(ra) # 5bd0 <exit>
      *(char*)a = 99;
    2296:	fd843783          	ld	a5,-40(s0)
    229a:	06300713          	li	a4,99
    229e:	00e78023          	sb	a4,0(a5)
      printf("%s: oops wrote %x\n", s, a);
    22a2:	fd843603          	ld	a2,-40(s0)
    22a6:	85ca                	mv	a1,s2
    22a8:	00005517          	auipc	a0,0x5
    22ac:	a1850513          	addi	a0,a0,-1512 # 6cc0 <malloc+0xcba>
    22b0:	00004097          	auipc	ra,0x4
    22b4:	c98080e7          	jalr	-872(ra) # 5f48 <printf>
      exit(1);
    22b8:	4505                	li	a0,1
    22ba:	00004097          	auipc	ra,0x4
    22be:	916080e7          	jalr	-1770(ra) # 5bd0 <exit>
      exit(1);
    22c2:	4505                	li	a0,1
    22c4:	00004097          	auipc	ra,0x4
    22c8:	90c080e7          	jalr	-1780(ra) # 5bd0 <exit>

00000000000022cc <bigargtest>:
{
    22cc:	7179                	addi	sp,sp,-48
    22ce:	f406                	sd	ra,40(sp)
    22d0:	f022                	sd	s0,32(sp)
    22d2:	ec26                	sd	s1,24(sp)
    22d4:	1800                	addi	s0,sp,48
    22d6:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    22d8:	00005517          	auipc	a0,0x5
    22dc:	a0050513          	addi	a0,a0,-1536 # 6cd8 <malloc+0xcd2>
    22e0:	00004097          	auipc	ra,0x4
    22e4:	940080e7          	jalr	-1728(ra) # 5c20 <unlink>
  pid = fork();
    22e8:	00004097          	auipc	ra,0x4
    22ec:	8e0080e7          	jalr	-1824(ra) # 5bc8 <fork>
  if(pid == 0){
    22f0:	c121                	beqz	a0,2330 <bigargtest+0x64>
  } else if(pid < 0){
    22f2:	0a054063          	bltz	a0,2392 <bigargtest+0xc6>
  wait(&xstatus);
    22f6:	fdc40513          	addi	a0,s0,-36
    22fa:	00004097          	auipc	ra,0x4
    22fe:	8de080e7          	jalr	-1826(ra) # 5bd8 <wait>
  if(xstatus != 0)
    2302:	fdc42503          	lw	a0,-36(s0)
    2306:	e545                	bnez	a0,23ae <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    2308:	4581                	li	a1,0
    230a:	00005517          	auipc	a0,0x5
    230e:	9ce50513          	addi	a0,a0,-1586 # 6cd8 <malloc+0xcd2>
    2312:	00004097          	auipc	ra,0x4
    2316:	8fe080e7          	jalr	-1794(ra) # 5c10 <open>
  if(fd < 0){
    231a:	08054e63          	bltz	a0,23b6 <bigargtest+0xea>
  close(fd);
    231e:	00004097          	auipc	ra,0x4
    2322:	8da080e7          	jalr	-1830(ra) # 5bf8 <close>
}
    2326:	70a2                	ld	ra,40(sp)
    2328:	7402                	ld	s0,32(sp)
    232a:	64e2                	ld	s1,24(sp)
    232c:	6145                	addi	sp,sp,48
    232e:	8082                	ret
    2330:	00007797          	auipc	a5,0x7
    2334:	13078793          	addi	a5,a5,304 # 9460 <args.1814>
    2338:	00007697          	auipc	a3,0x7
    233c:	22068693          	addi	a3,a3,544 # 9558 <args.1814+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    2340:	00005717          	auipc	a4,0x5
    2344:	9a870713          	addi	a4,a4,-1624 # 6ce8 <malloc+0xce2>
    2348:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    234a:	07a1                	addi	a5,a5,8
    234c:	fed79ee3          	bne	a5,a3,2348 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    2350:	00007597          	auipc	a1,0x7
    2354:	11058593          	addi	a1,a1,272 # 9460 <args.1814>
    2358:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    235c:	00004517          	auipc	a0,0x4
    2360:	dec50513          	addi	a0,a0,-532 # 6148 <malloc+0x142>
    2364:	00004097          	auipc	ra,0x4
    2368:	8a4080e7          	jalr	-1884(ra) # 5c08 <exec>
    fd = open("bigarg-ok", O_CREATE);
    236c:	20000593          	li	a1,512
    2370:	00005517          	auipc	a0,0x5
    2374:	96850513          	addi	a0,a0,-1688 # 6cd8 <malloc+0xcd2>
    2378:	00004097          	auipc	ra,0x4
    237c:	898080e7          	jalr	-1896(ra) # 5c10 <open>
    close(fd);
    2380:	00004097          	auipc	ra,0x4
    2384:	878080e7          	jalr	-1928(ra) # 5bf8 <close>
    exit(0);
    2388:	4501                	li	a0,0
    238a:	00004097          	auipc	ra,0x4
    238e:	846080e7          	jalr	-1978(ra) # 5bd0 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    2392:	85a6                	mv	a1,s1
    2394:	00005517          	auipc	a0,0x5
    2398:	a3450513          	addi	a0,a0,-1484 # 6dc8 <malloc+0xdc2>
    239c:	00004097          	auipc	ra,0x4
    23a0:	bac080e7          	jalr	-1108(ra) # 5f48 <printf>
    exit(1);
    23a4:	4505                	li	a0,1
    23a6:	00004097          	auipc	ra,0x4
    23aa:	82a080e7          	jalr	-2006(ra) # 5bd0 <exit>
    exit(xstatus);
    23ae:	00004097          	auipc	ra,0x4
    23b2:	822080e7          	jalr	-2014(ra) # 5bd0 <exit>
    printf("%s: bigarg test failed!\n", s);
    23b6:	85a6                	mv	a1,s1
    23b8:	00005517          	auipc	a0,0x5
    23bc:	a3050513          	addi	a0,a0,-1488 # 6de8 <malloc+0xde2>
    23c0:	00004097          	auipc	ra,0x4
    23c4:	b88080e7          	jalr	-1144(ra) # 5f48 <printf>
    exit(1);
    23c8:	4505                	li	a0,1
    23ca:	00004097          	auipc	ra,0x4
    23ce:	806080e7          	jalr	-2042(ra) # 5bd0 <exit>

00000000000023d2 <stacktest>:
{
    23d2:	7179                	addi	sp,sp,-48
    23d4:	f406                	sd	ra,40(sp)
    23d6:	f022                	sd	s0,32(sp)
    23d8:	ec26                	sd	s1,24(sp)
    23da:	1800                	addi	s0,sp,48
    23dc:	84aa                	mv	s1,a0
  pid = fork();
    23de:	00003097          	auipc	ra,0x3
    23e2:	7ea080e7          	jalr	2026(ra) # 5bc8 <fork>
  if(pid == 0) {
    23e6:	c115                	beqz	a0,240a <stacktest+0x38>
  } else if(pid < 0){
    23e8:	04054463          	bltz	a0,2430 <stacktest+0x5e>
  wait(&xstatus);
    23ec:	fdc40513          	addi	a0,s0,-36
    23f0:	00003097          	auipc	ra,0x3
    23f4:	7e8080e7          	jalr	2024(ra) # 5bd8 <wait>
  if(xstatus == -1)  // kernel killed child?
    23f8:	fdc42503          	lw	a0,-36(s0)
    23fc:	57fd                	li	a5,-1
    23fe:	04f50763          	beq	a0,a5,244c <stacktest+0x7a>
    exit(xstatus);
    2402:	00003097          	auipc	ra,0x3
    2406:	7ce080e7          	jalr	1998(ra) # 5bd0 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    240a:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    240c:	77fd                	lui	a5,0xfffff
    240e:	97ba                	add	a5,a5,a4
    2410:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <base+0xfffffffffffef388>
    2414:	85a6                	mv	a1,s1
    2416:	00005517          	auipc	a0,0x5
    241a:	9f250513          	addi	a0,a0,-1550 # 6e08 <malloc+0xe02>
    241e:	00004097          	auipc	ra,0x4
    2422:	b2a080e7          	jalr	-1238(ra) # 5f48 <printf>
    exit(1);
    2426:	4505                	li	a0,1
    2428:	00003097          	auipc	ra,0x3
    242c:	7a8080e7          	jalr	1960(ra) # 5bd0 <exit>
    printf("%s: fork failed\n", s);
    2430:	85a6                	mv	a1,s1
    2432:	00004517          	auipc	a0,0x4
    2436:	59e50513          	addi	a0,a0,1438 # 69d0 <malloc+0x9ca>
    243a:	00004097          	auipc	ra,0x4
    243e:	b0e080e7          	jalr	-1266(ra) # 5f48 <printf>
    exit(1);
    2442:	4505                	li	a0,1
    2444:	00003097          	auipc	ra,0x3
    2448:	78c080e7          	jalr	1932(ra) # 5bd0 <exit>
    exit(0);
    244c:	4501                	li	a0,0
    244e:	00003097          	auipc	ra,0x3
    2452:	782080e7          	jalr	1922(ra) # 5bd0 <exit>

0000000000002456 <textwrite>:
{
    2456:	7179                	addi	sp,sp,-48
    2458:	f406                	sd	ra,40(sp)
    245a:	f022                	sd	s0,32(sp)
    245c:	ec26                	sd	s1,24(sp)
    245e:	1800                	addi	s0,sp,48
    2460:	84aa                	mv	s1,a0
  pid = fork();
    2462:	00003097          	auipc	ra,0x3
    2466:	766080e7          	jalr	1894(ra) # 5bc8 <fork>
  if(pid == 0) {
    246a:	c115                	beqz	a0,248e <textwrite+0x38>
  } else if(pid < 0){
    246c:	02054963          	bltz	a0,249e <textwrite+0x48>
  wait(&xstatus);
    2470:	fdc40513          	addi	a0,s0,-36
    2474:	00003097          	auipc	ra,0x3
    2478:	764080e7          	jalr	1892(ra) # 5bd8 <wait>
  if(xstatus == -1)  // kernel killed child?
    247c:	fdc42503          	lw	a0,-36(s0)
    2480:	57fd                	li	a5,-1
    2482:	02f50c63          	beq	a0,a5,24ba <textwrite+0x64>
    exit(xstatus);
    2486:	00003097          	auipc	ra,0x3
    248a:	74a080e7          	jalr	1866(ra) # 5bd0 <exit>
    *addr = 10;
    248e:	47a9                	li	a5,10
    2490:	00f02023          	sw	a5,0(zero) # 0 <copyinstr1>
    exit(1);
    2494:	4505                	li	a0,1
    2496:	00003097          	auipc	ra,0x3
    249a:	73a080e7          	jalr	1850(ra) # 5bd0 <exit>
    printf("%s: fork failed\n", s);
    249e:	85a6                	mv	a1,s1
    24a0:	00004517          	auipc	a0,0x4
    24a4:	53050513          	addi	a0,a0,1328 # 69d0 <malloc+0x9ca>
    24a8:	00004097          	auipc	ra,0x4
    24ac:	aa0080e7          	jalr	-1376(ra) # 5f48 <printf>
    exit(1);
    24b0:	4505                	li	a0,1
    24b2:	00003097          	auipc	ra,0x3
    24b6:	71e080e7          	jalr	1822(ra) # 5bd0 <exit>
    exit(0);
    24ba:	4501                	li	a0,0
    24bc:	00003097          	auipc	ra,0x3
    24c0:	714080e7          	jalr	1812(ra) # 5bd0 <exit>

00000000000024c4 <manywrites>:
{
    24c4:	711d                	addi	sp,sp,-96
    24c6:	ec86                	sd	ra,88(sp)
    24c8:	e8a2                	sd	s0,80(sp)
    24ca:	e4a6                	sd	s1,72(sp)
    24cc:	e0ca                	sd	s2,64(sp)
    24ce:	fc4e                	sd	s3,56(sp)
    24d0:	f852                	sd	s4,48(sp)
    24d2:	f456                	sd	s5,40(sp)
    24d4:	f05a                	sd	s6,32(sp)
    24d6:	ec5e                	sd	s7,24(sp)
    24d8:	1080                	addi	s0,sp,96
    24da:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    24dc:	4901                	li	s2,0
    24de:	4991                	li	s3,4
    int pid = fork();
    24e0:	00003097          	auipc	ra,0x3
    24e4:	6e8080e7          	jalr	1768(ra) # 5bc8 <fork>
    24e8:	84aa                	mv	s1,a0
    if(pid < 0){
    24ea:	02054963          	bltz	a0,251c <manywrites+0x58>
    if(pid == 0){
    24ee:	c521                	beqz	a0,2536 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    24f0:	2905                	addiw	s2,s2,1
    24f2:	ff3917e3          	bne	s2,s3,24e0 <manywrites+0x1c>
    24f6:	4491                	li	s1,4
    int st = 0;
    24f8:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    24fc:	fa840513          	addi	a0,s0,-88
    2500:	00003097          	auipc	ra,0x3
    2504:	6d8080e7          	jalr	1752(ra) # 5bd8 <wait>
    if(st != 0)
    2508:	fa842503          	lw	a0,-88(s0)
    250c:	ed6d                	bnez	a0,2606 <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    250e:	34fd                	addiw	s1,s1,-1
    2510:	f4e5                	bnez	s1,24f8 <manywrites+0x34>
  exit(0);
    2512:	4501                	li	a0,0
    2514:	00003097          	auipc	ra,0x3
    2518:	6bc080e7          	jalr	1724(ra) # 5bd0 <exit>
      printf("fork failed\n");
    251c:	00005517          	auipc	a0,0x5
    2520:	8bc50513          	addi	a0,a0,-1860 # 6dd8 <malloc+0xdd2>
    2524:	00004097          	auipc	ra,0x4
    2528:	a24080e7          	jalr	-1500(ra) # 5f48 <printf>
      exit(1);
    252c:	4505                	li	a0,1
    252e:	00003097          	auipc	ra,0x3
    2532:	6a2080e7          	jalr	1698(ra) # 5bd0 <exit>
      name[0] = 'b';
    2536:	06200793          	li	a5,98
    253a:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    253e:	0619079b          	addiw	a5,s2,97
    2542:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    2546:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    254a:	fa840513          	addi	a0,s0,-88
    254e:	00003097          	auipc	ra,0x3
    2552:	6d2080e7          	jalr	1746(ra) # 5c20 <unlink>
    2556:	4b79                	li	s6,30
          int cc = write(fd, buf, sz);
    2558:	0000ab97          	auipc	s7,0xa
    255c:	720b8b93          	addi	s7,s7,1824 # cc78 <buf>
        for(int i = 0; i < ci+1; i++){
    2560:	8a26                	mv	s4,s1
    2562:	02094e63          	bltz	s2,259e <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    2566:	20200593          	li	a1,514
    256a:	fa840513          	addi	a0,s0,-88
    256e:	00003097          	auipc	ra,0x3
    2572:	6a2080e7          	jalr	1698(ra) # 5c10 <open>
    2576:	89aa                	mv	s3,a0
          if(fd < 0){
    2578:	04054763          	bltz	a0,25c6 <manywrites+0x102>
          int cc = write(fd, buf, sz);
    257c:	660d                	lui	a2,0x3
    257e:	85de                	mv	a1,s7
    2580:	00003097          	auipc	ra,0x3
    2584:	670080e7          	jalr	1648(ra) # 5bf0 <write>
          if(cc != sz){
    2588:	678d                	lui	a5,0x3
    258a:	04f51e63          	bne	a0,a5,25e6 <manywrites+0x122>
          close(fd);
    258e:	854e                	mv	a0,s3
    2590:	00003097          	auipc	ra,0x3
    2594:	668080e7          	jalr	1640(ra) # 5bf8 <close>
        for(int i = 0; i < ci+1; i++){
    2598:	2a05                	addiw	s4,s4,1
    259a:	fd4956e3          	bge	s2,s4,2566 <manywrites+0xa2>
        unlink(name);
    259e:	fa840513          	addi	a0,s0,-88
    25a2:	00003097          	auipc	ra,0x3
    25a6:	67e080e7          	jalr	1662(ra) # 5c20 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    25aa:	3b7d                	addiw	s6,s6,-1
    25ac:	fa0b1ae3          	bnez	s6,2560 <manywrites+0x9c>
      unlink(name);
    25b0:	fa840513          	addi	a0,s0,-88
    25b4:	00003097          	auipc	ra,0x3
    25b8:	66c080e7          	jalr	1644(ra) # 5c20 <unlink>
      exit(0);
    25bc:	4501                	li	a0,0
    25be:	00003097          	auipc	ra,0x3
    25c2:	612080e7          	jalr	1554(ra) # 5bd0 <exit>
            printf("%s: cannot create %s\n", s, name);
    25c6:	fa840613          	addi	a2,s0,-88
    25ca:	85d6                	mv	a1,s5
    25cc:	00005517          	auipc	a0,0x5
    25d0:	86450513          	addi	a0,a0,-1948 # 6e30 <malloc+0xe2a>
    25d4:	00004097          	auipc	ra,0x4
    25d8:	974080e7          	jalr	-1676(ra) # 5f48 <printf>
            exit(1);
    25dc:	4505                	li	a0,1
    25de:	00003097          	auipc	ra,0x3
    25e2:	5f2080e7          	jalr	1522(ra) # 5bd0 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    25e6:	86aa                	mv	a3,a0
    25e8:	660d                	lui	a2,0x3
    25ea:	85d6                	mv	a1,s5
    25ec:	00004517          	auipc	a0,0x4
    25f0:	c2c50513          	addi	a0,a0,-980 # 6218 <malloc+0x212>
    25f4:	00004097          	auipc	ra,0x4
    25f8:	954080e7          	jalr	-1708(ra) # 5f48 <printf>
            exit(1);
    25fc:	4505                	li	a0,1
    25fe:	00003097          	auipc	ra,0x3
    2602:	5d2080e7          	jalr	1490(ra) # 5bd0 <exit>
      exit(st);
    2606:	00003097          	auipc	ra,0x3
    260a:	5ca080e7          	jalr	1482(ra) # 5bd0 <exit>

000000000000260e <copyinstr3>:
{
    260e:	7179                	addi	sp,sp,-48
    2610:	f406                	sd	ra,40(sp)
    2612:	f022                	sd	s0,32(sp)
    2614:	ec26                	sd	s1,24(sp)
    2616:	1800                	addi	s0,sp,48
  sbrk(8192);
    2618:	6509                	lui	a0,0x2
    261a:	00003097          	auipc	ra,0x3
    261e:	63e080e7          	jalr	1598(ra) # 5c58 <sbrk>
  uint64 top = (uint64) sbrk(0);
    2622:	4501                	li	a0,0
    2624:	00003097          	auipc	ra,0x3
    2628:	634080e7          	jalr	1588(ra) # 5c58 <sbrk>
  if((top % PGSIZE) != 0){
    262c:	03451793          	slli	a5,a0,0x34
    2630:	e3c9                	bnez	a5,26b2 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    2632:	4501                	li	a0,0
    2634:	00003097          	auipc	ra,0x3
    2638:	624080e7          	jalr	1572(ra) # 5c58 <sbrk>
  if(top % PGSIZE){
    263c:	03451793          	slli	a5,a0,0x34
    2640:	e3d9                	bnez	a5,26c6 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    2642:	fff50493          	addi	s1,a0,-1 # 1fff <linkunlink+0x6f>
  *b = 'x';
    2646:	07800793          	li	a5,120
    264a:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    264e:	8526                	mv	a0,s1
    2650:	00003097          	auipc	ra,0x3
    2654:	5d0080e7          	jalr	1488(ra) # 5c20 <unlink>
  if(ret != -1){
    2658:	57fd                	li	a5,-1
    265a:	08f51363          	bne	a0,a5,26e0 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    265e:	20100593          	li	a1,513
    2662:	8526                	mv	a0,s1
    2664:	00003097          	auipc	ra,0x3
    2668:	5ac080e7          	jalr	1452(ra) # 5c10 <open>
  if(fd != -1){
    266c:	57fd                	li	a5,-1
    266e:	08f51863          	bne	a0,a5,26fe <copyinstr3+0xf0>
  ret = link(b, b);
    2672:	85a6                	mv	a1,s1
    2674:	8526                	mv	a0,s1
    2676:	00003097          	auipc	ra,0x3
    267a:	5ba080e7          	jalr	1466(ra) # 5c30 <link>
  if(ret != -1){
    267e:	57fd                	li	a5,-1
    2680:	08f51e63          	bne	a0,a5,271c <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2684:	00005797          	auipc	a5,0x5
    2688:	4a478793          	addi	a5,a5,1188 # 7b28 <malloc+0x1b22>
    268c:	fcf43823          	sd	a5,-48(s0)
    2690:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2694:	fd040593          	addi	a1,s0,-48
    2698:	8526                	mv	a0,s1
    269a:	00003097          	auipc	ra,0x3
    269e:	56e080e7          	jalr	1390(ra) # 5c08 <exec>
  if(ret != -1){
    26a2:	57fd                	li	a5,-1
    26a4:	08f51c63          	bne	a0,a5,273c <copyinstr3+0x12e>
}
    26a8:	70a2                	ld	ra,40(sp)
    26aa:	7402                	ld	s0,32(sp)
    26ac:	64e2                	ld	s1,24(sp)
    26ae:	6145                	addi	sp,sp,48
    26b0:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    26b2:	0347d513          	srli	a0,a5,0x34
    26b6:	6785                	lui	a5,0x1
    26b8:	40a7853b          	subw	a0,a5,a0
    26bc:	00003097          	auipc	ra,0x3
    26c0:	59c080e7          	jalr	1436(ra) # 5c58 <sbrk>
    26c4:	b7bd                	j	2632 <copyinstr3+0x24>
    printf("oops\n");
    26c6:	00004517          	auipc	a0,0x4
    26ca:	78250513          	addi	a0,a0,1922 # 6e48 <malloc+0xe42>
    26ce:	00004097          	auipc	ra,0x4
    26d2:	87a080e7          	jalr	-1926(ra) # 5f48 <printf>
    exit(1);
    26d6:	4505                	li	a0,1
    26d8:	00003097          	auipc	ra,0x3
    26dc:	4f8080e7          	jalr	1272(ra) # 5bd0 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    26e0:	862a                	mv	a2,a0
    26e2:	85a6                	mv	a1,s1
    26e4:	00004517          	auipc	a0,0x4
    26e8:	20c50513          	addi	a0,a0,524 # 68f0 <malloc+0x8ea>
    26ec:	00004097          	auipc	ra,0x4
    26f0:	85c080e7          	jalr	-1956(ra) # 5f48 <printf>
    exit(1);
    26f4:	4505                	li	a0,1
    26f6:	00003097          	auipc	ra,0x3
    26fa:	4da080e7          	jalr	1242(ra) # 5bd0 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    26fe:	862a                	mv	a2,a0
    2700:	85a6                	mv	a1,s1
    2702:	00004517          	auipc	a0,0x4
    2706:	20e50513          	addi	a0,a0,526 # 6910 <malloc+0x90a>
    270a:	00004097          	auipc	ra,0x4
    270e:	83e080e7          	jalr	-1986(ra) # 5f48 <printf>
    exit(1);
    2712:	4505                	li	a0,1
    2714:	00003097          	auipc	ra,0x3
    2718:	4bc080e7          	jalr	1212(ra) # 5bd0 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    271c:	86aa                	mv	a3,a0
    271e:	8626                	mv	a2,s1
    2720:	85a6                	mv	a1,s1
    2722:	00004517          	auipc	a0,0x4
    2726:	20e50513          	addi	a0,a0,526 # 6930 <malloc+0x92a>
    272a:	00004097          	auipc	ra,0x4
    272e:	81e080e7          	jalr	-2018(ra) # 5f48 <printf>
    exit(1);
    2732:	4505                	li	a0,1
    2734:	00003097          	auipc	ra,0x3
    2738:	49c080e7          	jalr	1180(ra) # 5bd0 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    273c:	567d                	li	a2,-1
    273e:	85a6                	mv	a1,s1
    2740:	00004517          	auipc	a0,0x4
    2744:	21850513          	addi	a0,a0,536 # 6958 <malloc+0x952>
    2748:	00004097          	auipc	ra,0x4
    274c:	800080e7          	jalr	-2048(ra) # 5f48 <printf>
    exit(1);
    2750:	4505                	li	a0,1
    2752:	00003097          	auipc	ra,0x3
    2756:	47e080e7          	jalr	1150(ra) # 5bd0 <exit>

000000000000275a <rwsbrk>:
{
    275a:	1101                	addi	sp,sp,-32
    275c:	ec06                	sd	ra,24(sp)
    275e:	e822                	sd	s0,16(sp)
    2760:	e426                	sd	s1,8(sp)
    2762:	e04a                	sd	s2,0(sp)
    2764:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    2766:	6509                	lui	a0,0x2
    2768:	00003097          	auipc	ra,0x3
    276c:	4f0080e7          	jalr	1264(ra) # 5c58 <sbrk>
  if(a == 0xffffffffffffffffLL) {
    2770:	57fd                	li	a5,-1
    2772:	06f50363          	beq	a0,a5,27d8 <rwsbrk+0x7e>
    2776:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    2778:	7579                	lui	a0,0xffffe
    277a:	00003097          	auipc	ra,0x3
    277e:	4de080e7          	jalr	1246(ra) # 5c58 <sbrk>
    2782:	57fd                	li	a5,-1
    2784:	06f50763          	beq	a0,a5,27f2 <rwsbrk+0x98>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    2788:	20100593          	li	a1,513
    278c:	00004517          	auipc	a0,0x4
    2790:	6fc50513          	addi	a0,a0,1788 # 6e88 <malloc+0xe82>
    2794:	00003097          	auipc	ra,0x3
    2798:	47c080e7          	jalr	1148(ra) # 5c10 <open>
    279c:	892a                	mv	s2,a0
  if(fd < 0){
    279e:	06054763          	bltz	a0,280c <rwsbrk+0xb2>
  n = write(fd, (void*)(a+4096), 1024);
    27a2:	6505                	lui	a0,0x1
    27a4:	94aa                	add	s1,s1,a0
    27a6:	40000613          	li	a2,1024
    27aa:	85a6                	mv	a1,s1
    27ac:	854a                	mv	a0,s2
    27ae:	00003097          	auipc	ra,0x3
    27b2:	442080e7          	jalr	1090(ra) # 5bf0 <write>
    27b6:	862a                	mv	a2,a0
  if(n >= 0){
    27b8:	06054763          	bltz	a0,2826 <rwsbrk+0xcc>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    27bc:	85a6                	mv	a1,s1
    27be:	00004517          	auipc	a0,0x4
    27c2:	6ea50513          	addi	a0,a0,1770 # 6ea8 <malloc+0xea2>
    27c6:	00003097          	auipc	ra,0x3
    27ca:	782080e7          	jalr	1922(ra) # 5f48 <printf>
    exit(1);
    27ce:	4505                	li	a0,1
    27d0:	00003097          	auipc	ra,0x3
    27d4:	400080e7          	jalr	1024(ra) # 5bd0 <exit>
    printf("sbrk(rwsbrk) failed\n");
    27d8:	00004517          	auipc	a0,0x4
    27dc:	67850513          	addi	a0,a0,1656 # 6e50 <malloc+0xe4a>
    27e0:	00003097          	auipc	ra,0x3
    27e4:	768080e7          	jalr	1896(ra) # 5f48 <printf>
    exit(1);
    27e8:	4505                	li	a0,1
    27ea:	00003097          	auipc	ra,0x3
    27ee:	3e6080e7          	jalr	998(ra) # 5bd0 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    27f2:	00004517          	auipc	a0,0x4
    27f6:	67650513          	addi	a0,a0,1654 # 6e68 <malloc+0xe62>
    27fa:	00003097          	auipc	ra,0x3
    27fe:	74e080e7          	jalr	1870(ra) # 5f48 <printf>
    exit(1);
    2802:	4505                	li	a0,1
    2804:	00003097          	auipc	ra,0x3
    2808:	3cc080e7          	jalr	972(ra) # 5bd0 <exit>
    printf("open(rwsbrk) failed\n");
    280c:	00004517          	auipc	a0,0x4
    2810:	68450513          	addi	a0,a0,1668 # 6e90 <malloc+0xe8a>
    2814:	00003097          	auipc	ra,0x3
    2818:	734080e7          	jalr	1844(ra) # 5f48 <printf>
    exit(1);
    281c:	4505                	li	a0,1
    281e:	00003097          	auipc	ra,0x3
    2822:	3b2080e7          	jalr	946(ra) # 5bd0 <exit>
  close(fd);
    2826:	854a                	mv	a0,s2
    2828:	00003097          	auipc	ra,0x3
    282c:	3d0080e7          	jalr	976(ra) # 5bf8 <close>
  unlink("rwsbrk");
    2830:	00004517          	auipc	a0,0x4
    2834:	65850513          	addi	a0,a0,1624 # 6e88 <malloc+0xe82>
    2838:	00003097          	auipc	ra,0x3
    283c:	3e8080e7          	jalr	1000(ra) # 5c20 <unlink>
  fd = open("README", O_RDONLY);
    2840:	4581                	li	a1,0
    2842:	00004517          	auipc	a0,0x4
    2846:	ade50513          	addi	a0,a0,-1314 # 6320 <malloc+0x31a>
    284a:	00003097          	auipc	ra,0x3
    284e:	3c6080e7          	jalr	966(ra) # 5c10 <open>
    2852:	892a                	mv	s2,a0
  if(fd < 0){
    2854:	02054963          	bltz	a0,2886 <rwsbrk+0x12c>
  n = read(fd, (void*)(a+4096), 10);
    2858:	4629                	li	a2,10
    285a:	85a6                	mv	a1,s1
    285c:	00003097          	auipc	ra,0x3
    2860:	38c080e7          	jalr	908(ra) # 5be8 <read>
    2864:	862a                	mv	a2,a0
  if(n >= 0){
    2866:	02054d63          	bltz	a0,28a0 <rwsbrk+0x146>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    286a:	85a6                	mv	a1,s1
    286c:	00004517          	auipc	a0,0x4
    2870:	66c50513          	addi	a0,a0,1644 # 6ed8 <malloc+0xed2>
    2874:	00003097          	auipc	ra,0x3
    2878:	6d4080e7          	jalr	1748(ra) # 5f48 <printf>
    exit(1);
    287c:	4505                	li	a0,1
    287e:	00003097          	auipc	ra,0x3
    2882:	352080e7          	jalr	850(ra) # 5bd0 <exit>
    printf("open(rwsbrk) failed\n");
    2886:	00004517          	auipc	a0,0x4
    288a:	60a50513          	addi	a0,a0,1546 # 6e90 <malloc+0xe8a>
    288e:	00003097          	auipc	ra,0x3
    2892:	6ba080e7          	jalr	1722(ra) # 5f48 <printf>
    exit(1);
    2896:	4505                	li	a0,1
    2898:	00003097          	auipc	ra,0x3
    289c:	338080e7          	jalr	824(ra) # 5bd0 <exit>
  close(fd);
    28a0:	854a                	mv	a0,s2
    28a2:	00003097          	auipc	ra,0x3
    28a6:	356080e7          	jalr	854(ra) # 5bf8 <close>
  exit(0);
    28aa:	4501                	li	a0,0
    28ac:	00003097          	auipc	ra,0x3
    28b0:	324080e7          	jalr	804(ra) # 5bd0 <exit>

00000000000028b4 <sbrkbasic>:
{
    28b4:	715d                	addi	sp,sp,-80
    28b6:	e486                	sd	ra,72(sp)
    28b8:	e0a2                	sd	s0,64(sp)
    28ba:	fc26                	sd	s1,56(sp)
    28bc:	f84a                	sd	s2,48(sp)
    28be:	f44e                	sd	s3,40(sp)
    28c0:	f052                	sd	s4,32(sp)
    28c2:	ec56                	sd	s5,24(sp)
    28c4:	0880                	addi	s0,sp,80
    28c6:	8a2a                	mv	s4,a0
  pid = fork();
    28c8:	00003097          	auipc	ra,0x3
    28cc:	300080e7          	jalr	768(ra) # 5bc8 <fork>
  if(pid < 0){
    28d0:	02054c63          	bltz	a0,2908 <sbrkbasic+0x54>
  if(pid == 0){
    28d4:	ed21                	bnez	a0,292c <sbrkbasic+0x78>
    a = sbrk(TOOMUCH);
    28d6:	40000537          	lui	a0,0x40000
    28da:	00003097          	auipc	ra,0x3
    28de:	37e080e7          	jalr	894(ra) # 5c58 <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    28e2:	57fd                	li	a5,-1
    28e4:	02f50f63          	beq	a0,a5,2922 <sbrkbasic+0x6e>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28e8:	400007b7          	lui	a5,0x40000
    28ec:	97aa                	add	a5,a5,a0
      *b = 99;
    28ee:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    28f2:	6705                	lui	a4,0x1
      *b = 99;
    28f4:	00d50023          	sb	a3,0(a0) # 40000000 <base+0x3fff0388>
    for(b = a; b < a+TOOMUCH; b += 4096){
    28f8:	953a                	add	a0,a0,a4
    28fa:	fef51de3          	bne	a0,a5,28f4 <sbrkbasic+0x40>
    exit(1);
    28fe:	4505                	li	a0,1
    2900:	00003097          	auipc	ra,0x3
    2904:	2d0080e7          	jalr	720(ra) # 5bd0 <exit>
    printf("fork failed in sbrkbasic\n");
    2908:	00004517          	auipc	a0,0x4
    290c:	5f850513          	addi	a0,a0,1528 # 6f00 <malloc+0xefa>
    2910:	00003097          	auipc	ra,0x3
    2914:	638080e7          	jalr	1592(ra) # 5f48 <printf>
    exit(1);
    2918:	4505                	li	a0,1
    291a:	00003097          	auipc	ra,0x3
    291e:	2b6080e7          	jalr	694(ra) # 5bd0 <exit>
      exit(0);
    2922:	4501                	li	a0,0
    2924:	00003097          	auipc	ra,0x3
    2928:	2ac080e7          	jalr	684(ra) # 5bd0 <exit>
  wait(&xstatus);
    292c:	fbc40513          	addi	a0,s0,-68
    2930:	00003097          	auipc	ra,0x3
    2934:	2a8080e7          	jalr	680(ra) # 5bd8 <wait>
  if(xstatus == 1){
    2938:	fbc42703          	lw	a4,-68(s0)
    293c:	4785                	li	a5,1
    293e:	00f70e63          	beq	a4,a5,295a <sbrkbasic+0xa6>
  a = sbrk(0);
    2942:	4501                	li	a0,0
    2944:	00003097          	auipc	ra,0x3
    2948:	314080e7          	jalr	788(ra) # 5c58 <sbrk>
    294c:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    294e:	4901                	li	s2,0
    *b = 1;
    2950:	4a85                	li	s5,1
  for(i = 0; i < 5000; i++){
    2952:	6985                	lui	s3,0x1
    2954:	38898993          	addi	s3,s3,904 # 1388 <badarg+0x3c>
    2958:	a005                	j	2978 <sbrkbasic+0xc4>
    printf("%s: too much memory allocated!\n", s);
    295a:	85d2                	mv	a1,s4
    295c:	00004517          	auipc	a0,0x4
    2960:	5c450513          	addi	a0,a0,1476 # 6f20 <malloc+0xf1a>
    2964:	00003097          	auipc	ra,0x3
    2968:	5e4080e7          	jalr	1508(ra) # 5f48 <printf>
    exit(1);
    296c:	4505                	li	a0,1
    296e:	00003097          	auipc	ra,0x3
    2972:	262080e7          	jalr	610(ra) # 5bd0 <exit>
    a = b + 1;
    2976:	84be                	mv	s1,a5
    b = sbrk(1);
    2978:	4505                	li	a0,1
    297a:	00003097          	auipc	ra,0x3
    297e:	2de080e7          	jalr	734(ra) # 5c58 <sbrk>
    if(b != a){
    2982:	04951b63          	bne	a0,s1,29d8 <sbrkbasic+0x124>
    *b = 1;
    2986:	01548023          	sb	s5,0(s1)
    a = b + 1;
    298a:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    298e:	2905                	addiw	s2,s2,1
    2990:	ff3913e3          	bne	s2,s3,2976 <sbrkbasic+0xc2>
  pid = fork();
    2994:	00003097          	auipc	ra,0x3
    2998:	234080e7          	jalr	564(ra) # 5bc8 <fork>
    299c:	892a                	mv	s2,a0
  if(pid < 0){
    299e:	04054e63          	bltz	a0,29fa <sbrkbasic+0x146>
  c = sbrk(1);
    29a2:	4505                	li	a0,1
    29a4:	00003097          	auipc	ra,0x3
    29a8:	2b4080e7          	jalr	692(ra) # 5c58 <sbrk>
  c = sbrk(1);
    29ac:	4505                	li	a0,1
    29ae:	00003097          	auipc	ra,0x3
    29b2:	2aa080e7          	jalr	682(ra) # 5c58 <sbrk>
  if(c != a + 1){
    29b6:	0489                	addi	s1,s1,2
    29b8:	04a48f63          	beq	s1,a0,2a16 <sbrkbasic+0x162>
    printf("%s: sbrk test failed post-fork\n", s);
    29bc:	85d2                	mv	a1,s4
    29be:	00004517          	auipc	a0,0x4
    29c2:	5c250513          	addi	a0,a0,1474 # 6f80 <malloc+0xf7a>
    29c6:	00003097          	auipc	ra,0x3
    29ca:	582080e7          	jalr	1410(ra) # 5f48 <printf>
    exit(1);
    29ce:	4505                	li	a0,1
    29d0:	00003097          	auipc	ra,0x3
    29d4:	200080e7          	jalr	512(ra) # 5bd0 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    29d8:	872a                	mv	a4,a0
    29da:	86a6                	mv	a3,s1
    29dc:	864a                	mv	a2,s2
    29de:	85d2                	mv	a1,s4
    29e0:	00004517          	auipc	a0,0x4
    29e4:	56050513          	addi	a0,a0,1376 # 6f40 <malloc+0xf3a>
    29e8:	00003097          	auipc	ra,0x3
    29ec:	560080e7          	jalr	1376(ra) # 5f48 <printf>
      exit(1);
    29f0:	4505                	li	a0,1
    29f2:	00003097          	auipc	ra,0x3
    29f6:	1de080e7          	jalr	478(ra) # 5bd0 <exit>
    printf("%s: sbrk test fork failed\n", s);
    29fa:	85d2                	mv	a1,s4
    29fc:	00004517          	auipc	a0,0x4
    2a00:	56450513          	addi	a0,a0,1380 # 6f60 <malloc+0xf5a>
    2a04:	00003097          	auipc	ra,0x3
    2a08:	544080e7          	jalr	1348(ra) # 5f48 <printf>
    exit(1);
    2a0c:	4505                	li	a0,1
    2a0e:	00003097          	auipc	ra,0x3
    2a12:	1c2080e7          	jalr	450(ra) # 5bd0 <exit>
  if(pid == 0)
    2a16:	00091763          	bnez	s2,2a24 <sbrkbasic+0x170>
    exit(0);
    2a1a:	4501                	li	a0,0
    2a1c:	00003097          	auipc	ra,0x3
    2a20:	1b4080e7          	jalr	436(ra) # 5bd0 <exit>
  wait(&xstatus);
    2a24:	fbc40513          	addi	a0,s0,-68
    2a28:	00003097          	auipc	ra,0x3
    2a2c:	1b0080e7          	jalr	432(ra) # 5bd8 <wait>
  exit(xstatus);
    2a30:	fbc42503          	lw	a0,-68(s0)
    2a34:	00003097          	auipc	ra,0x3
    2a38:	19c080e7          	jalr	412(ra) # 5bd0 <exit>

0000000000002a3c <sbrkmuch>:
{
    2a3c:	7179                	addi	sp,sp,-48
    2a3e:	f406                	sd	ra,40(sp)
    2a40:	f022                	sd	s0,32(sp)
    2a42:	ec26                	sd	s1,24(sp)
    2a44:	e84a                	sd	s2,16(sp)
    2a46:	e44e                	sd	s3,8(sp)
    2a48:	e052                	sd	s4,0(sp)
    2a4a:	1800                	addi	s0,sp,48
    2a4c:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    2a4e:	4501                	li	a0,0
    2a50:	00003097          	auipc	ra,0x3
    2a54:	208080e7          	jalr	520(ra) # 5c58 <sbrk>
    2a58:	892a                	mv	s2,a0
  a = sbrk(0);
    2a5a:	4501                	li	a0,0
    2a5c:	00003097          	auipc	ra,0x3
    2a60:	1fc080e7          	jalr	508(ra) # 5c58 <sbrk>
    2a64:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2a66:	06400537          	lui	a0,0x6400
    2a6a:	9d05                	subw	a0,a0,s1
    2a6c:	00003097          	auipc	ra,0x3
    2a70:	1ec080e7          	jalr	492(ra) # 5c58 <sbrk>
  if (p != a) {
    2a74:	0ca49863          	bne	s1,a0,2b44 <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2a78:	4501                	li	a0,0
    2a7a:	00003097          	auipc	ra,0x3
    2a7e:	1de080e7          	jalr	478(ra) # 5c58 <sbrk>
    2a82:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2a84:	00a4f963          	bgeu	s1,a0,2a96 <sbrkmuch+0x5a>
    *pp = 1;
    2a88:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2a8a:	6705                	lui	a4,0x1
    *pp = 1;
    2a8c:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    2a90:	94ba                	add	s1,s1,a4
    2a92:	fef4ede3          	bltu	s1,a5,2a8c <sbrkmuch+0x50>
  *lastaddr = 99;
    2a96:	064007b7          	lui	a5,0x6400
    2a9a:	06300713          	li	a4,99
    2a9e:	fee78fa3          	sb	a4,-1(a5) # 63fffff <base+0x63f0387>
  a = sbrk(0);
    2aa2:	4501                	li	a0,0
    2aa4:	00003097          	auipc	ra,0x3
    2aa8:	1b4080e7          	jalr	436(ra) # 5c58 <sbrk>
    2aac:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    2aae:	757d                	lui	a0,0xfffff
    2ab0:	00003097          	auipc	ra,0x3
    2ab4:	1a8080e7          	jalr	424(ra) # 5c58 <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2ab8:	57fd                	li	a5,-1
    2aba:	0af50363          	beq	a0,a5,2b60 <sbrkmuch+0x124>
  c = sbrk(0);
    2abe:	4501                	li	a0,0
    2ac0:	00003097          	auipc	ra,0x3
    2ac4:	198080e7          	jalr	408(ra) # 5c58 <sbrk>
  if(c != a - PGSIZE){
    2ac8:	77fd                	lui	a5,0xfffff
    2aca:	97a6                	add	a5,a5,s1
    2acc:	0af51863          	bne	a0,a5,2b7c <sbrkmuch+0x140>
  a = sbrk(0);
    2ad0:	4501                	li	a0,0
    2ad2:	00003097          	auipc	ra,0x3
    2ad6:	186080e7          	jalr	390(ra) # 5c58 <sbrk>
    2ada:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2adc:	6505                	lui	a0,0x1
    2ade:	00003097          	auipc	ra,0x3
    2ae2:	17a080e7          	jalr	378(ra) # 5c58 <sbrk>
    2ae6:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2ae8:	0aa49a63          	bne	s1,a0,2b9c <sbrkmuch+0x160>
    2aec:	4501                	li	a0,0
    2aee:	00003097          	auipc	ra,0x3
    2af2:	16a080e7          	jalr	362(ra) # 5c58 <sbrk>
    2af6:	6785                	lui	a5,0x1
    2af8:	97a6                	add	a5,a5,s1
    2afa:	0af51163          	bne	a0,a5,2b9c <sbrkmuch+0x160>
  if(*lastaddr == 99){
    2afe:	064007b7          	lui	a5,0x6400
    2b02:	fff7c703          	lbu	a4,-1(a5) # 63fffff <base+0x63f0387>
    2b06:	06300793          	li	a5,99
    2b0a:	0af70963          	beq	a4,a5,2bbc <sbrkmuch+0x180>
  a = sbrk(0);
    2b0e:	4501                	li	a0,0
    2b10:	00003097          	auipc	ra,0x3
    2b14:	148080e7          	jalr	328(ra) # 5c58 <sbrk>
    2b18:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    2b1a:	4501                	li	a0,0
    2b1c:	00003097          	auipc	ra,0x3
    2b20:	13c080e7          	jalr	316(ra) # 5c58 <sbrk>
    2b24:	40a9053b          	subw	a0,s2,a0
    2b28:	00003097          	auipc	ra,0x3
    2b2c:	130080e7          	jalr	304(ra) # 5c58 <sbrk>
  if(c != a){
    2b30:	0aa49463          	bne	s1,a0,2bd8 <sbrkmuch+0x19c>
}
    2b34:	70a2                	ld	ra,40(sp)
    2b36:	7402                	ld	s0,32(sp)
    2b38:	64e2                	ld	s1,24(sp)
    2b3a:	6942                	ld	s2,16(sp)
    2b3c:	69a2                	ld	s3,8(sp)
    2b3e:	6a02                	ld	s4,0(sp)
    2b40:	6145                	addi	sp,sp,48
    2b42:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    2b44:	85ce                	mv	a1,s3
    2b46:	00004517          	auipc	a0,0x4
    2b4a:	45a50513          	addi	a0,a0,1114 # 6fa0 <malloc+0xf9a>
    2b4e:	00003097          	auipc	ra,0x3
    2b52:	3fa080e7          	jalr	1018(ra) # 5f48 <printf>
    exit(1);
    2b56:	4505                	li	a0,1
    2b58:	00003097          	auipc	ra,0x3
    2b5c:	078080e7          	jalr	120(ra) # 5bd0 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    2b60:	85ce                	mv	a1,s3
    2b62:	00004517          	auipc	a0,0x4
    2b66:	48650513          	addi	a0,a0,1158 # 6fe8 <malloc+0xfe2>
    2b6a:	00003097          	auipc	ra,0x3
    2b6e:	3de080e7          	jalr	990(ra) # 5f48 <printf>
    exit(1);
    2b72:	4505                	li	a0,1
    2b74:	00003097          	auipc	ra,0x3
    2b78:	05c080e7          	jalr	92(ra) # 5bd0 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2b7c:	86aa                	mv	a3,a0
    2b7e:	8626                	mv	a2,s1
    2b80:	85ce                	mv	a1,s3
    2b82:	00004517          	auipc	a0,0x4
    2b86:	48650513          	addi	a0,a0,1158 # 7008 <malloc+0x1002>
    2b8a:	00003097          	auipc	ra,0x3
    2b8e:	3be080e7          	jalr	958(ra) # 5f48 <printf>
    exit(1);
    2b92:	4505                	li	a0,1
    2b94:	00003097          	auipc	ra,0x3
    2b98:	03c080e7          	jalr	60(ra) # 5bd0 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2b9c:	86d2                	mv	a3,s4
    2b9e:	8626                	mv	a2,s1
    2ba0:	85ce                	mv	a1,s3
    2ba2:	00004517          	auipc	a0,0x4
    2ba6:	4a650513          	addi	a0,a0,1190 # 7048 <malloc+0x1042>
    2baa:	00003097          	auipc	ra,0x3
    2bae:	39e080e7          	jalr	926(ra) # 5f48 <printf>
    exit(1);
    2bb2:	4505                	li	a0,1
    2bb4:	00003097          	auipc	ra,0x3
    2bb8:	01c080e7          	jalr	28(ra) # 5bd0 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2bbc:	85ce                	mv	a1,s3
    2bbe:	00004517          	auipc	a0,0x4
    2bc2:	4ba50513          	addi	a0,a0,1210 # 7078 <malloc+0x1072>
    2bc6:	00003097          	auipc	ra,0x3
    2bca:	382080e7          	jalr	898(ra) # 5f48 <printf>
    exit(1);
    2bce:	4505                	li	a0,1
    2bd0:	00003097          	auipc	ra,0x3
    2bd4:	000080e7          	jalr	ra # 5bd0 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2bd8:	86aa                	mv	a3,a0
    2bda:	8626                	mv	a2,s1
    2bdc:	85ce                	mv	a1,s3
    2bde:	00004517          	auipc	a0,0x4
    2be2:	4d250513          	addi	a0,a0,1234 # 70b0 <malloc+0x10aa>
    2be6:	00003097          	auipc	ra,0x3
    2bea:	362080e7          	jalr	866(ra) # 5f48 <printf>
    exit(1);
    2bee:	4505                	li	a0,1
    2bf0:	00003097          	auipc	ra,0x3
    2bf4:	fe0080e7          	jalr	-32(ra) # 5bd0 <exit>

0000000000002bf8 <sbrkarg>:
{
    2bf8:	7179                	addi	sp,sp,-48
    2bfa:	f406                	sd	ra,40(sp)
    2bfc:	f022                	sd	s0,32(sp)
    2bfe:	ec26                	sd	s1,24(sp)
    2c00:	e84a                	sd	s2,16(sp)
    2c02:	e44e                	sd	s3,8(sp)
    2c04:	1800                	addi	s0,sp,48
    2c06:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    2c08:	6505                	lui	a0,0x1
    2c0a:	00003097          	auipc	ra,0x3
    2c0e:	04e080e7          	jalr	78(ra) # 5c58 <sbrk>
    2c12:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    2c14:	20100593          	li	a1,513
    2c18:	00004517          	auipc	a0,0x4
    2c1c:	4c050513          	addi	a0,a0,1216 # 70d8 <malloc+0x10d2>
    2c20:	00003097          	auipc	ra,0x3
    2c24:	ff0080e7          	jalr	-16(ra) # 5c10 <open>
    2c28:	84aa                	mv	s1,a0
  unlink("sbrk");
    2c2a:	00004517          	auipc	a0,0x4
    2c2e:	4ae50513          	addi	a0,a0,1198 # 70d8 <malloc+0x10d2>
    2c32:	00003097          	auipc	ra,0x3
    2c36:	fee080e7          	jalr	-18(ra) # 5c20 <unlink>
  if(fd < 0)  {
    2c3a:	0404c163          	bltz	s1,2c7c <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    2c3e:	6605                	lui	a2,0x1
    2c40:	85ca                	mv	a1,s2
    2c42:	8526                	mv	a0,s1
    2c44:	00003097          	auipc	ra,0x3
    2c48:	fac080e7          	jalr	-84(ra) # 5bf0 <write>
    2c4c:	04054663          	bltz	a0,2c98 <sbrkarg+0xa0>
  close(fd);
    2c50:	8526                	mv	a0,s1
    2c52:	00003097          	auipc	ra,0x3
    2c56:	fa6080e7          	jalr	-90(ra) # 5bf8 <close>
  a = sbrk(PGSIZE);
    2c5a:	6505                	lui	a0,0x1
    2c5c:	00003097          	auipc	ra,0x3
    2c60:	ffc080e7          	jalr	-4(ra) # 5c58 <sbrk>
  if(pipe((int *) a) != 0){
    2c64:	00003097          	auipc	ra,0x3
    2c68:	f7c080e7          	jalr	-132(ra) # 5be0 <pipe>
    2c6c:	e521                	bnez	a0,2cb4 <sbrkarg+0xbc>
}
    2c6e:	70a2                	ld	ra,40(sp)
    2c70:	7402                	ld	s0,32(sp)
    2c72:	64e2                	ld	s1,24(sp)
    2c74:	6942                	ld	s2,16(sp)
    2c76:	69a2                	ld	s3,8(sp)
    2c78:	6145                	addi	sp,sp,48
    2c7a:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2c7c:	85ce                	mv	a1,s3
    2c7e:	00004517          	auipc	a0,0x4
    2c82:	46250513          	addi	a0,a0,1122 # 70e0 <malloc+0x10da>
    2c86:	00003097          	auipc	ra,0x3
    2c8a:	2c2080e7          	jalr	706(ra) # 5f48 <printf>
    exit(1);
    2c8e:	4505                	li	a0,1
    2c90:	00003097          	auipc	ra,0x3
    2c94:	f40080e7          	jalr	-192(ra) # 5bd0 <exit>
    printf("%s: write sbrk failed\n", s);
    2c98:	85ce                	mv	a1,s3
    2c9a:	00004517          	auipc	a0,0x4
    2c9e:	45e50513          	addi	a0,a0,1118 # 70f8 <malloc+0x10f2>
    2ca2:	00003097          	auipc	ra,0x3
    2ca6:	2a6080e7          	jalr	678(ra) # 5f48 <printf>
    exit(1);
    2caa:	4505                	li	a0,1
    2cac:	00003097          	auipc	ra,0x3
    2cb0:	f24080e7          	jalr	-220(ra) # 5bd0 <exit>
    printf("%s: pipe() failed\n", s);
    2cb4:	85ce                	mv	a1,s3
    2cb6:	00004517          	auipc	a0,0x4
    2cba:	e2250513          	addi	a0,a0,-478 # 6ad8 <malloc+0xad2>
    2cbe:	00003097          	auipc	ra,0x3
    2cc2:	28a080e7          	jalr	650(ra) # 5f48 <printf>
    exit(1);
    2cc6:	4505                	li	a0,1
    2cc8:	00003097          	auipc	ra,0x3
    2ccc:	f08080e7          	jalr	-248(ra) # 5bd0 <exit>

0000000000002cd0 <argptest>:
{
    2cd0:	1101                	addi	sp,sp,-32
    2cd2:	ec06                	sd	ra,24(sp)
    2cd4:	e822                	sd	s0,16(sp)
    2cd6:	e426                	sd	s1,8(sp)
    2cd8:	e04a                	sd	s2,0(sp)
    2cda:	1000                	addi	s0,sp,32
    2cdc:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2cde:	4581                	li	a1,0
    2ce0:	00004517          	auipc	a0,0x4
    2ce4:	43050513          	addi	a0,a0,1072 # 7110 <malloc+0x110a>
    2ce8:	00003097          	auipc	ra,0x3
    2cec:	f28080e7          	jalr	-216(ra) # 5c10 <open>
  if (fd < 0) {
    2cf0:	02054b63          	bltz	a0,2d26 <argptest+0x56>
    2cf4:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2cf6:	4501                	li	a0,0
    2cf8:	00003097          	auipc	ra,0x3
    2cfc:	f60080e7          	jalr	-160(ra) # 5c58 <sbrk>
    2d00:	567d                	li	a2,-1
    2d02:	fff50593          	addi	a1,a0,-1
    2d06:	8526                	mv	a0,s1
    2d08:	00003097          	auipc	ra,0x3
    2d0c:	ee0080e7          	jalr	-288(ra) # 5be8 <read>
  close(fd);
    2d10:	8526                	mv	a0,s1
    2d12:	00003097          	auipc	ra,0x3
    2d16:	ee6080e7          	jalr	-282(ra) # 5bf8 <close>
}
    2d1a:	60e2                	ld	ra,24(sp)
    2d1c:	6442                	ld	s0,16(sp)
    2d1e:	64a2                	ld	s1,8(sp)
    2d20:	6902                	ld	s2,0(sp)
    2d22:	6105                	addi	sp,sp,32
    2d24:	8082                	ret
    printf("%s: open failed\n", s);
    2d26:	85ca                	mv	a1,s2
    2d28:	00004517          	auipc	a0,0x4
    2d2c:	cc050513          	addi	a0,a0,-832 # 69e8 <malloc+0x9e2>
    2d30:	00003097          	auipc	ra,0x3
    2d34:	218080e7          	jalr	536(ra) # 5f48 <printf>
    exit(1);
    2d38:	4505                	li	a0,1
    2d3a:	00003097          	auipc	ra,0x3
    2d3e:	e96080e7          	jalr	-362(ra) # 5bd0 <exit>

0000000000002d42 <sbrkbugs>:
{
    2d42:	1141                	addi	sp,sp,-16
    2d44:	e406                	sd	ra,8(sp)
    2d46:	e022                	sd	s0,0(sp)
    2d48:	0800                	addi	s0,sp,16
  int pid = fork();
    2d4a:	00003097          	auipc	ra,0x3
    2d4e:	e7e080e7          	jalr	-386(ra) # 5bc8 <fork>
  if(pid < 0){
    2d52:	02054263          	bltz	a0,2d76 <sbrkbugs+0x34>
  if(pid == 0){
    2d56:	ed0d                	bnez	a0,2d90 <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2d58:	00003097          	auipc	ra,0x3
    2d5c:	f00080e7          	jalr	-256(ra) # 5c58 <sbrk>
    sbrk(-sz);
    2d60:	40a0053b          	negw	a0,a0
    2d64:	00003097          	auipc	ra,0x3
    2d68:	ef4080e7          	jalr	-268(ra) # 5c58 <sbrk>
    exit(0);
    2d6c:	4501                	li	a0,0
    2d6e:	00003097          	auipc	ra,0x3
    2d72:	e62080e7          	jalr	-414(ra) # 5bd0 <exit>
    printf("fork failed\n");
    2d76:	00004517          	auipc	a0,0x4
    2d7a:	06250513          	addi	a0,a0,98 # 6dd8 <malloc+0xdd2>
    2d7e:	00003097          	auipc	ra,0x3
    2d82:	1ca080e7          	jalr	458(ra) # 5f48 <printf>
    exit(1);
    2d86:	4505                	li	a0,1
    2d88:	00003097          	auipc	ra,0x3
    2d8c:	e48080e7          	jalr	-440(ra) # 5bd0 <exit>
  wait(0);
    2d90:	4501                	li	a0,0
    2d92:	00003097          	auipc	ra,0x3
    2d96:	e46080e7          	jalr	-442(ra) # 5bd8 <wait>
  pid = fork();
    2d9a:	00003097          	auipc	ra,0x3
    2d9e:	e2e080e7          	jalr	-466(ra) # 5bc8 <fork>
  if(pid < 0){
    2da2:	02054563          	bltz	a0,2dcc <sbrkbugs+0x8a>
  if(pid == 0){
    2da6:	e121                	bnez	a0,2de6 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2da8:	00003097          	auipc	ra,0x3
    2dac:	eb0080e7          	jalr	-336(ra) # 5c58 <sbrk>
    sbrk(-(sz - 3500));
    2db0:	6785                	lui	a5,0x1
    2db2:	dac7879b          	addiw	a5,a5,-596
    2db6:	40a7853b          	subw	a0,a5,a0
    2dba:	00003097          	auipc	ra,0x3
    2dbe:	e9e080e7          	jalr	-354(ra) # 5c58 <sbrk>
    exit(0);
    2dc2:	4501                	li	a0,0
    2dc4:	00003097          	auipc	ra,0x3
    2dc8:	e0c080e7          	jalr	-500(ra) # 5bd0 <exit>
    printf("fork failed\n");
    2dcc:	00004517          	auipc	a0,0x4
    2dd0:	00c50513          	addi	a0,a0,12 # 6dd8 <malloc+0xdd2>
    2dd4:	00003097          	auipc	ra,0x3
    2dd8:	174080e7          	jalr	372(ra) # 5f48 <printf>
    exit(1);
    2ddc:	4505                	li	a0,1
    2dde:	00003097          	auipc	ra,0x3
    2de2:	df2080e7          	jalr	-526(ra) # 5bd0 <exit>
  wait(0);
    2de6:	4501                	li	a0,0
    2de8:	00003097          	auipc	ra,0x3
    2dec:	df0080e7          	jalr	-528(ra) # 5bd8 <wait>
  pid = fork();
    2df0:	00003097          	auipc	ra,0x3
    2df4:	dd8080e7          	jalr	-552(ra) # 5bc8 <fork>
  if(pid < 0){
    2df8:	02054a63          	bltz	a0,2e2c <sbrkbugs+0xea>
  if(pid == 0){
    2dfc:	e529                	bnez	a0,2e46 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2dfe:	00003097          	auipc	ra,0x3
    2e02:	e5a080e7          	jalr	-422(ra) # 5c58 <sbrk>
    2e06:	67ad                	lui	a5,0xb
    2e08:	8007879b          	addiw	a5,a5,-2048
    2e0c:	40a7853b          	subw	a0,a5,a0
    2e10:	00003097          	auipc	ra,0x3
    2e14:	e48080e7          	jalr	-440(ra) # 5c58 <sbrk>
    sbrk(-10);
    2e18:	5559                	li	a0,-10
    2e1a:	00003097          	auipc	ra,0x3
    2e1e:	e3e080e7          	jalr	-450(ra) # 5c58 <sbrk>
    exit(0);
    2e22:	4501                	li	a0,0
    2e24:	00003097          	auipc	ra,0x3
    2e28:	dac080e7          	jalr	-596(ra) # 5bd0 <exit>
    printf("fork failed\n");
    2e2c:	00004517          	auipc	a0,0x4
    2e30:	fac50513          	addi	a0,a0,-84 # 6dd8 <malloc+0xdd2>
    2e34:	00003097          	auipc	ra,0x3
    2e38:	114080e7          	jalr	276(ra) # 5f48 <printf>
    exit(1);
    2e3c:	4505                	li	a0,1
    2e3e:	00003097          	auipc	ra,0x3
    2e42:	d92080e7          	jalr	-622(ra) # 5bd0 <exit>
  wait(0);
    2e46:	4501                	li	a0,0
    2e48:	00003097          	auipc	ra,0x3
    2e4c:	d90080e7          	jalr	-624(ra) # 5bd8 <wait>
  exit(0);
    2e50:	4501                	li	a0,0
    2e52:	00003097          	auipc	ra,0x3
    2e56:	d7e080e7          	jalr	-642(ra) # 5bd0 <exit>

0000000000002e5a <sbrklast>:
{
    2e5a:	7179                	addi	sp,sp,-48
    2e5c:	f406                	sd	ra,40(sp)
    2e5e:	f022                	sd	s0,32(sp)
    2e60:	ec26                	sd	s1,24(sp)
    2e62:	e84a                	sd	s2,16(sp)
    2e64:	e44e                	sd	s3,8(sp)
    2e66:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2e68:	4501                	li	a0,0
    2e6a:	00003097          	auipc	ra,0x3
    2e6e:	dee080e7          	jalr	-530(ra) # 5c58 <sbrk>
  if((top % 4096) != 0)
    2e72:	03451793          	slli	a5,a0,0x34
    2e76:	efc1                	bnez	a5,2f0e <sbrklast+0xb4>
  sbrk(4096);
    2e78:	6505                	lui	a0,0x1
    2e7a:	00003097          	auipc	ra,0x3
    2e7e:	dde080e7          	jalr	-546(ra) # 5c58 <sbrk>
  sbrk(10);
    2e82:	4529                	li	a0,10
    2e84:	00003097          	auipc	ra,0x3
    2e88:	dd4080e7          	jalr	-556(ra) # 5c58 <sbrk>
  sbrk(-20);
    2e8c:	5531                	li	a0,-20
    2e8e:	00003097          	auipc	ra,0x3
    2e92:	dca080e7          	jalr	-566(ra) # 5c58 <sbrk>
  top = (uint64) sbrk(0);
    2e96:	4501                	li	a0,0
    2e98:	00003097          	auipc	ra,0x3
    2e9c:	dc0080e7          	jalr	-576(ra) # 5c58 <sbrk>
    2ea0:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2ea2:	fc050913          	addi	s2,a0,-64 # fc0 <linktest+0xca>
  p[0] = 'x';
    2ea6:	07800793          	li	a5,120
    2eaa:	fcf50023          	sb	a5,-64(a0)
  p[1] = '\0';
    2eae:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2eb2:	20200593          	li	a1,514
    2eb6:	854a                	mv	a0,s2
    2eb8:	00003097          	auipc	ra,0x3
    2ebc:	d58080e7          	jalr	-680(ra) # 5c10 <open>
    2ec0:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2ec2:	4605                	li	a2,1
    2ec4:	85ca                	mv	a1,s2
    2ec6:	00003097          	auipc	ra,0x3
    2eca:	d2a080e7          	jalr	-726(ra) # 5bf0 <write>
  close(fd);
    2ece:	854e                	mv	a0,s3
    2ed0:	00003097          	auipc	ra,0x3
    2ed4:	d28080e7          	jalr	-728(ra) # 5bf8 <close>
  fd = open(p, O_RDWR);
    2ed8:	4589                	li	a1,2
    2eda:	854a                	mv	a0,s2
    2edc:	00003097          	auipc	ra,0x3
    2ee0:	d34080e7          	jalr	-716(ra) # 5c10 <open>
  p[0] = '\0';
    2ee4:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2ee8:	4605                	li	a2,1
    2eea:	85ca                	mv	a1,s2
    2eec:	00003097          	auipc	ra,0x3
    2ef0:	cfc080e7          	jalr	-772(ra) # 5be8 <read>
  if(p[0] != 'x')
    2ef4:	fc04c703          	lbu	a4,-64(s1)
    2ef8:	07800793          	li	a5,120
    2efc:	02f71363          	bne	a4,a5,2f22 <sbrklast+0xc8>
}
    2f00:	70a2                	ld	ra,40(sp)
    2f02:	7402                	ld	s0,32(sp)
    2f04:	64e2                	ld	s1,24(sp)
    2f06:	6942                	ld	s2,16(sp)
    2f08:	69a2                	ld	s3,8(sp)
    2f0a:	6145                	addi	sp,sp,48
    2f0c:	8082                	ret
    sbrk(4096 - (top % 4096));
    2f0e:	0347d513          	srli	a0,a5,0x34
    2f12:	6785                	lui	a5,0x1
    2f14:	40a7853b          	subw	a0,a5,a0
    2f18:	00003097          	auipc	ra,0x3
    2f1c:	d40080e7          	jalr	-704(ra) # 5c58 <sbrk>
    2f20:	bfa1                	j	2e78 <sbrklast+0x1e>
    exit(1);
    2f22:	4505                	li	a0,1
    2f24:	00003097          	auipc	ra,0x3
    2f28:	cac080e7          	jalr	-852(ra) # 5bd0 <exit>

0000000000002f2c <sbrk8000>:
{
    2f2c:	1141                	addi	sp,sp,-16
    2f2e:	e406                	sd	ra,8(sp)
    2f30:	e022                	sd	s0,0(sp)
    2f32:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2f34:	80000537          	lui	a0,0x80000
    2f38:	0511                	addi	a0,a0,4
    2f3a:	00003097          	auipc	ra,0x3
    2f3e:	d1e080e7          	jalr	-738(ra) # 5c58 <sbrk>
  volatile char *top = sbrk(0);
    2f42:	4501                	li	a0,0
    2f44:	00003097          	auipc	ra,0x3
    2f48:	d14080e7          	jalr	-748(ra) # 5c58 <sbrk>
  *(top-1) = *(top-1) + 1;
    2f4c:	fff54783          	lbu	a5,-1(a0) # ffffffff7fffffff <base+0xffffffff7fff0387>
    2f50:	0785                	addi	a5,a5,1
    2f52:	0ff7f793          	andi	a5,a5,255
    2f56:	fef50fa3          	sb	a5,-1(a0)
}
    2f5a:	60a2                	ld	ra,8(sp)
    2f5c:	6402                	ld	s0,0(sp)
    2f5e:	0141                	addi	sp,sp,16
    2f60:	8082                	ret

0000000000002f62 <execout>:
{
    2f62:	715d                	addi	sp,sp,-80
    2f64:	e486                	sd	ra,72(sp)
    2f66:	e0a2                	sd	s0,64(sp)
    2f68:	fc26                	sd	s1,56(sp)
    2f6a:	f84a                	sd	s2,48(sp)
    2f6c:	f44e                	sd	s3,40(sp)
    2f6e:	f052                	sd	s4,32(sp)
    2f70:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2f72:	4901                	li	s2,0
    2f74:	49bd                	li	s3,15
    int pid = fork();
    2f76:	00003097          	auipc	ra,0x3
    2f7a:	c52080e7          	jalr	-942(ra) # 5bc8 <fork>
    2f7e:	84aa                	mv	s1,a0
    if(pid < 0){
    2f80:	02054063          	bltz	a0,2fa0 <execout+0x3e>
    } else if(pid == 0){
    2f84:	c91d                	beqz	a0,2fba <execout+0x58>
      wait((int*)0);
    2f86:	4501                	li	a0,0
    2f88:	00003097          	auipc	ra,0x3
    2f8c:	c50080e7          	jalr	-944(ra) # 5bd8 <wait>
  for(int avail = 0; avail < 15; avail++){
    2f90:	2905                	addiw	s2,s2,1
    2f92:	ff3912e3          	bne	s2,s3,2f76 <execout+0x14>
  exit(0);
    2f96:	4501                	li	a0,0
    2f98:	00003097          	auipc	ra,0x3
    2f9c:	c38080e7          	jalr	-968(ra) # 5bd0 <exit>
      printf("fork failed\n");
    2fa0:	00004517          	auipc	a0,0x4
    2fa4:	e3850513          	addi	a0,a0,-456 # 6dd8 <malloc+0xdd2>
    2fa8:	00003097          	auipc	ra,0x3
    2fac:	fa0080e7          	jalr	-96(ra) # 5f48 <printf>
      exit(1);
    2fb0:	4505                	li	a0,1
    2fb2:	00003097          	auipc	ra,0x3
    2fb6:	c1e080e7          	jalr	-994(ra) # 5bd0 <exit>
        if(a == 0xffffffffffffffffLL)
    2fba:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2fbc:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2fbe:	6505                	lui	a0,0x1
    2fc0:	00003097          	auipc	ra,0x3
    2fc4:	c98080e7          	jalr	-872(ra) # 5c58 <sbrk>
        if(a == 0xffffffffffffffffLL)
    2fc8:	01350763          	beq	a0,s3,2fd6 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2fcc:	6785                	lui	a5,0x1
    2fce:	953e                	add	a0,a0,a5
    2fd0:	ff450fa3          	sb	s4,-1(a0) # fff <linktest+0x109>
      while(1){
    2fd4:	b7ed                	j	2fbe <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2fd6:	01205a63          	blez	s2,2fea <execout+0x88>
        sbrk(-4096);
    2fda:	757d                	lui	a0,0xfffff
    2fdc:	00003097          	auipc	ra,0x3
    2fe0:	c7c080e7          	jalr	-900(ra) # 5c58 <sbrk>
      for(int i = 0; i < avail; i++)
    2fe4:	2485                	addiw	s1,s1,1
    2fe6:	ff249ae3          	bne	s1,s2,2fda <execout+0x78>
      close(1);
    2fea:	4505                	li	a0,1
    2fec:	00003097          	auipc	ra,0x3
    2ff0:	c0c080e7          	jalr	-1012(ra) # 5bf8 <close>
      char *args[] = { "echo", "x", 0 };
    2ff4:	00003517          	auipc	a0,0x3
    2ff8:	15450513          	addi	a0,a0,340 # 6148 <malloc+0x142>
    2ffc:	faa43c23          	sd	a0,-72(s0)
    3000:	00003797          	auipc	a5,0x3
    3004:	1b878793          	addi	a5,a5,440 # 61b8 <malloc+0x1b2>
    3008:	fcf43023          	sd	a5,-64(s0)
    300c:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    3010:	fb840593          	addi	a1,s0,-72
    3014:	00003097          	auipc	ra,0x3
    3018:	bf4080e7          	jalr	-1036(ra) # 5c08 <exec>
      exit(0);
    301c:	4501                	li	a0,0
    301e:	00003097          	auipc	ra,0x3
    3022:	bb2080e7          	jalr	-1102(ra) # 5bd0 <exit>

0000000000003026 <fourteen>:
{
    3026:	1101                	addi	sp,sp,-32
    3028:	ec06                	sd	ra,24(sp)
    302a:	e822                	sd	s0,16(sp)
    302c:	e426                	sd	s1,8(sp)
    302e:	1000                	addi	s0,sp,32
    3030:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    3032:	00004517          	auipc	a0,0x4
    3036:	2b650513          	addi	a0,a0,694 # 72e8 <malloc+0x12e2>
    303a:	00003097          	auipc	ra,0x3
    303e:	bfe080e7          	jalr	-1026(ra) # 5c38 <mkdir>
    3042:	e165                	bnez	a0,3122 <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    3044:	00004517          	auipc	a0,0x4
    3048:	0fc50513          	addi	a0,a0,252 # 7140 <malloc+0x113a>
    304c:	00003097          	auipc	ra,0x3
    3050:	bec080e7          	jalr	-1044(ra) # 5c38 <mkdir>
    3054:	e56d                	bnez	a0,313e <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    3056:	20000593          	li	a1,512
    305a:	00004517          	auipc	a0,0x4
    305e:	13e50513          	addi	a0,a0,318 # 7198 <malloc+0x1192>
    3062:	00003097          	auipc	ra,0x3
    3066:	bae080e7          	jalr	-1106(ra) # 5c10 <open>
  if(fd < 0){
    306a:	0e054863          	bltz	a0,315a <fourteen+0x134>
  close(fd);
    306e:	00003097          	auipc	ra,0x3
    3072:	b8a080e7          	jalr	-1142(ra) # 5bf8 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    3076:	4581                	li	a1,0
    3078:	00004517          	auipc	a0,0x4
    307c:	19850513          	addi	a0,a0,408 # 7210 <malloc+0x120a>
    3080:	00003097          	auipc	ra,0x3
    3084:	b90080e7          	jalr	-1136(ra) # 5c10 <open>
  if(fd < 0){
    3088:	0e054763          	bltz	a0,3176 <fourteen+0x150>
  close(fd);
    308c:	00003097          	auipc	ra,0x3
    3090:	b6c080e7          	jalr	-1172(ra) # 5bf8 <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    3094:	00004517          	auipc	a0,0x4
    3098:	1ec50513          	addi	a0,a0,492 # 7280 <malloc+0x127a>
    309c:	00003097          	auipc	ra,0x3
    30a0:	b9c080e7          	jalr	-1124(ra) # 5c38 <mkdir>
    30a4:	c57d                	beqz	a0,3192 <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    30a6:	00004517          	auipc	a0,0x4
    30aa:	23250513          	addi	a0,a0,562 # 72d8 <malloc+0x12d2>
    30ae:	00003097          	auipc	ra,0x3
    30b2:	b8a080e7          	jalr	-1142(ra) # 5c38 <mkdir>
    30b6:	cd65                	beqz	a0,31ae <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    30b8:	00004517          	auipc	a0,0x4
    30bc:	22050513          	addi	a0,a0,544 # 72d8 <malloc+0x12d2>
    30c0:	00003097          	auipc	ra,0x3
    30c4:	b60080e7          	jalr	-1184(ra) # 5c20 <unlink>
  unlink("12345678901234/12345678901234");
    30c8:	00004517          	auipc	a0,0x4
    30cc:	1b850513          	addi	a0,a0,440 # 7280 <malloc+0x127a>
    30d0:	00003097          	auipc	ra,0x3
    30d4:	b50080e7          	jalr	-1200(ra) # 5c20 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    30d8:	00004517          	auipc	a0,0x4
    30dc:	13850513          	addi	a0,a0,312 # 7210 <malloc+0x120a>
    30e0:	00003097          	auipc	ra,0x3
    30e4:	b40080e7          	jalr	-1216(ra) # 5c20 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    30e8:	00004517          	auipc	a0,0x4
    30ec:	0b050513          	addi	a0,a0,176 # 7198 <malloc+0x1192>
    30f0:	00003097          	auipc	ra,0x3
    30f4:	b30080e7          	jalr	-1232(ra) # 5c20 <unlink>
  unlink("12345678901234/123456789012345");
    30f8:	00004517          	auipc	a0,0x4
    30fc:	04850513          	addi	a0,a0,72 # 7140 <malloc+0x113a>
    3100:	00003097          	auipc	ra,0x3
    3104:	b20080e7          	jalr	-1248(ra) # 5c20 <unlink>
  unlink("12345678901234");
    3108:	00004517          	auipc	a0,0x4
    310c:	1e050513          	addi	a0,a0,480 # 72e8 <malloc+0x12e2>
    3110:	00003097          	auipc	ra,0x3
    3114:	b10080e7          	jalr	-1264(ra) # 5c20 <unlink>
}
    3118:	60e2                	ld	ra,24(sp)
    311a:	6442                	ld	s0,16(sp)
    311c:	64a2                	ld	s1,8(sp)
    311e:	6105                	addi	sp,sp,32
    3120:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    3122:	85a6                	mv	a1,s1
    3124:	00004517          	auipc	a0,0x4
    3128:	ff450513          	addi	a0,a0,-12 # 7118 <malloc+0x1112>
    312c:	00003097          	auipc	ra,0x3
    3130:	e1c080e7          	jalr	-484(ra) # 5f48 <printf>
    exit(1);
    3134:	4505                	li	a0,1
    3136:	00003097          	auipc	ra,0x3
    313a:	a9a080e7          	jalr	-1382(ra) # 5bd0 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    313e:	85a6                	mv	a1,s1
    3140:	00004517          	auipc	a0,0x4
    3144:	02050513          	addi	a0,a0,32 # 7160 <malloc+0x115a>
    3148:	00003097          	auipc	ra,0x3
    314c:	e00080e7          	jalr	-512(ra) # 5f48 <printf>
    exit(1);
    3150:	4505                	li	a0,1
    3152:	00003097          	auipc	ra,0x3
    3156:	a7e080e7          	jalr	-1410(ra) # 5bd0 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    315a:	85a6                	mv	a1,s1
    315c:	00004517          	auipc	a0,0x4
    3160:	06c50513          	addi	a0,a0,108 # 71c8 <malloc+0x11c2>
    3164:	00003097          	auipc	ra,0x3
    3168:	de4080e7          	jalr	-540(ra) # 5f48 <printf>
    exit(1);
    316c:	4505                	li	a0,1
    316e:	00003097          	auipc	ra,0x3
    3172:	a62080e7          	jalr	-1438(ra) # 5bd0 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    3176:	85a6                	mv	a1,s1
    3178:	00004517          	auipc	a0,0x4
    317c:	0c850513          	addi	a0,a0,200 # 7240 <malloc+0x123a>
    3180:	00003097          	auipc	ra,0x3
    3184:	dc8080e7          	jalr	-568(ra) # 5f48 <printf>
    exit(1);
    3188:	4505                	li	a0,1
    318a:	00003097          	auipc	ra,0x3
    318e:	a46080e7          	jalr	-1466(ra) # 5bd0 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    3192:	85a6                	mv	a1,s1
    3194:	00004517          	auipc	a0,0x4
    3198:	10c50513          	addi	a0,a0,268 # 72a0 <malloc+0x129a>
    319c:	00003097          	auipc	ra,0x3
    31a0:	dac080e7          	jalr	-596(ra) # 5f48 <printf>
    exit(1);
    31a4:	4505                	li	a0,1
    31a6:	00003097          	auipc	ra,0x3
    31aa:	a2a080e7          	jalr	-1494(ra) # 5bd0 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    31ae:	85a6                	mv	a1,s1
    31b0:	00004517          	auipc	a0,0x4
    31b4:	14850513          	addi	a0,a0,328 # 72f8 <malloc+0x12f2>
    31b8:	00003097          	auipc	ra,0x3
    31bc:	d90080e7          	jalr	-624(ra) # 5f48 <printf>
    exit(1);
    31c0:	4505                	li	a0,1
    31c2:	00003097          	auipc	ra,0x3
    31c6:	a0e080e7          	jalr	-1522(ra) # 5bd0 <exit>

00000000000031ca <diskfull>:
{
    31ca:	b9010113          	addi	sp,sp,-1136
    31ce:	46113423          	sd	ra,1128(sp)
    31d2:	46813023          	sd	s0,1120(sp)
    31d6:	44913c23          	sd	s1,1112(sp)
    31da:	45213823          	sd	s2,1104(sp)
    31de:	45313423          	sd	s3,1096(sp)
    31e2:	45413023          	sd	s4,1088(sp)
    31e6:	43513c23          	sd	s5,1080(sp)
    31ea:	43613823          	sd	s6,1072(sp)
    31ee:	43713423          	sd	s7,1064(sp)
    31f2:	43813023          	sd	s8,1056(sp)
    31f6:	47010413          	addi	s0,sp,1136
    31fa:	8c2a                	mv	s8,a0
  unlink("diskfulldir");
    31fc:	00004517          	auipc	a0,0x4
    3200:	13450513          	addi	a0,a0,308 # 7330 <malloc+0x132a>
    3204:	00003097          	auipc	ra,0x3
    3208:	a1c080e7          	jalr	-1508(ra) # 5c20 <unlink>
  for(fi = 0; done == 0; fi++){
    320c:	4a01                	li	s4,0
    name[0] = 'b';
    320e:	06200b13          	li	s6,98
    name[1] = 'i';
    3212:	06900a93          	li	s5,105
    name[2] = 'g';
    3216:	06700993          	li	s3,103
    321a:	10c00b93          	li	s7,268
    321e:	aabd                	j	339c <diskfull+0x1d2>
      printf("%s: could not create file %s\n", s, name);
    3220:	b9040613          	addi	a2,s0,-1136
    3224:	85e2                	mv	a1,s8
    3226:	00004517          	auipc	a0,0x4
    322a:	11a50513          	addi	a0,a0,282 # 7340 <malloc+0x133a>
    322e:	00003097          	auipc	ra,0x3
    3232:	d1a080e7          	jalr	-742(ra) # 5f48 <printf>
      break;
    3236:	a821                	j	324e <diskfull+0x84>
        close(fd);
    3238:	854a                	mv	a0,s2
    323a:	00003097          	auipc	ra,0x3
    323e:	9be080e7          	jalr	-1602(ra) # 5bf8 <close>
    close(fd);
    3242:	854a                	mv	a0,s2
    3244:	00003097          	auipc	ra,0x3
    3248:	9b4080e7          	jalr	-1612(ra) # 5bf8 <close>
  for(fi = 0; done == 0; fi++){
    324c:	2a05                	addiw	s4,s4,1
  for(int i = 0; i < nzz; i++){
    324e:	4481                	li	s1,0
    name[0] = 'z';
    3250:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    3254:	08000993          	li	s3,128
    name[0] = 'z';
    3258:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    325c:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    3260:	41f4d79b          	sraiw	a5,s1,0x1f
    3264:	01b7d71b          	srliw	a4,a5,0x1b
    3268:	009707bb          	addw	a5,a4,s1
    326c:	4057d69b          	sraiw	a3,a5,0x5
    3270:	0306869b          	addiw	a3,a3,48
    3274:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    3278:	8bfd                	andi	a5,a5,31
    327a:	9f99                	subw	a5,a5,a4
    327c:	0307879b          	addiw	a5,a5,48
    3280:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3284:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3288:	bb040513          	addi	a0,s0,-1104
    328c:	00003097          	auipc	ra,0x3
    3290:	994080e7          	jalr	-1644(ra) # 5c20 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    3294:	60200593          	li	a1,1538
    3298:	bb040513          	addi	a0,s0,-1104
    329c:	00003097          	auipc	ra,0x3
    32a0:	974080e7          	jalr	-1676(ra) # 5c10 <open>
    if(fd < 0)
    32a4:	00054963          	bltz	a0,32b6 <diskfull+0xec>
    close(fd);
    32a8:	00003097          	auipc	ra,0x3
    32ac:	950080e7          	jalr	-1712(ra) # 5bf8 <close>
  for(int i = 0; i < nzz; i++){
    32b0:	2485                	addiw	s1,s1,1
    32b2:	fb3493e3          	bne	s1,s3,3258 <diskfull+0x8e>
  if(mkdir("diskfulldir") == 0)
    32b6:	00004517          	auipc	a0,0x4
    32ba:	07a50513          	addi	a0,a0,122 # 7330 <malloc+0x132a>
    32be:	00003097          	auipc	ra,0x3
    32c2:	97a080e7          	jalr	-1670(ra) # 5c38 <mkdir>
    32c6:	12050963          	beqz	a0,33f8 <diskfull+0x22e>
  unlink("diskfulldir");
    32ca:	00004517          	auipc	a0,0x4
    32ce:	06650513          	addi	a0,a0,102 # 7330 <malloc+0x132a>
    32d2:	00003097          	auipc	ra,0x3
    32d6:	94e080e7          	jalr	-1714(ra) # 5c20 <unlink>
  for(int i = 0; i < nzz; i++){
    32da:	4481                	li	s1,0
    name[0] = 'z';
    32dc:	07a00913          	li	s2,122
  for(int i = 0; i < nzz; i++){
    32e0:	08000993          	li	s3,128
    name[0] = 'z';
    32e4:	bb240823          	sb	s2,-1104(s0)
    name[1] = 'z';
    32e8:	bb2408a3          	sb	s2,-1103(s0)
    name[2] = '0' + (i / 32);
    32ec:	41f4d79b          	sraiw	a5,s1,0x1f
    32f0:	01b7d71b          	srliw	a4,a5,0x1b
    32f4:	009707bb          	addw	a5,a4,s1
    32f8:	4057d69b          	sraiw	a3,a5,0x5
    32fc:	0306869b          	addiw	a3,a3,48
    3300:	bad40923          	sb	a3,-1102(s0)
    name[3] = '0' + (i % 32);
    3304:	8bfd                	andi	a5,a5,31
    3306:	9f99                	subw	a5,a5,a4
    3308:	0307879b          	addiw	a5,a5,48
    330c:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    3310:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3314:	bb040513          	addi	a0,s0,-1104
    3318:	00003097          	auipc	ra,0x3
    331c:	908080e7          	jalr	-1784(ra) # 5c20 <unlink>
  for(int i = 0; i < nzz; i++){
    3320:	2485                	addiw	s1,s1,1
    3322:	fd3491e3          	bne	s1,s3,32e4 <diskfull+0x11a>
  for(int i = 0; i < fi; i++){
    3326:	03405e63          	blez	s4,3362 <diskfull+0x198>
    332a:	4481                	li	s1,0
    name[0] = 'b';
    332c:	06200a93          	li	s5,98
    name[1] = 'i';
    3330:	06900993          	li	s3,105
    name[2] = 'g';
    3334:	06700913          	li	s2,103
    name[0] = 'b';
    3338:	bb540823          	sb	s5,-1104(s0)
    name[1] = 'i';
    333c:	bb3408a3          	sb	s3,-1103(s0)
    name[2] = 'g';
    3340:	bb240923          	sb	s2,-1102(s0)
    name[3] = '0' + i;
    3344:	0304879b          	addiw	a5,s1,48
    3348:	baf409a3          	sb	a5,-1101(s0)
    name[4] = '\0';
    334c:	ba040a23          	sb	zero,-1100(s0)
    unlink(name);
    3350:	bb040513          	addi	a0,s0,-1104
    3354:	00003097          	auipc	ra,0x3
    3358:	8cc080e7          	jalr	-1844(ra) # 5c20 <unlink>
  for(int i = 0; i < fi; i++){
    335c:	2485                	addiw	s1,s1,1
    335e:	fd449de3          	bne	s1,s4,3338 <diskfull+0x16e>
}
    3362:	46813083          	ld	ra,1128(sp)
    3366:	46013403          	ld	s0,1120(sp)
    336a:	45813483          	ld	s1,1112(sp)
    336e:	45013903          	ld	s2,1104(sp)
    3372:	44813983          	ld	s3,1096(sp)
    3376:	44013a03          	ld	s4,1088(sp)
    337a:	43813a83          	ld	s5,1080(sp)
    337e:	43013b03          	ld	s6,1072(sp)
    3382:	42813b83          	ld	s7,1064(sp)
    3386:	42013c03          	ld	s8,1056(sp)
    338a:	47010113          	addi	sp,sp,1136
    338e:	8082                	ret
    close(fd);
    3390:	854a                	mv	a0,s2
    3392:	00003097          	auipc	ra,0x3
    3396:	866080e7          	jalr	-1946(ra) # 5bf8 <close>
  for(fi = 0; done == 0; fi++){
    339a:	2a05                	addiw	s4,s4,1
    name[0] = 'b';
    339c:	b9640823          	sb	s6,-1136(s0)
    name[1] = 'i';
    33a0:	b95408a3          	sb	s5,-1135(s0)
    name[2] = 'g';
    33a4:	b9340923          	sb	s3,-1134(s0)
    name[3] = '0' + fi;
    33a8:	030a079b          	addiw	a5,s4,48
    33ac:	b8f409a3          	sb	a5,-1133(s0)
    name[4] = '\0';
    33b0:	b8040a23          	sb	zero,-1132(s0)
    unlink(name);
    33b4:	b9040513          	addi	a0,s0,-1136
    33b8:	00003097          	auipc	ra,0x3
    33bc:	868080e7          	jalr	-1944(ra) # 5c20 <unlink>
    int fd = open(name, O_CREATE|O_RDWR|O_TRUNC);
    33c0:	60200593          	li	a1,1538
    33c4:	b9040513          	addi	a0,s0,-1136
    33c8:	00003097          	auipc	ra,0x3
    33cc:	848080e7          	jalr	-1976(ra) # 5c10 <open>
    33d0:	892a                	mv	s2,a0
    if(fd < 0){
    33d2:	e40547e3          	bltz	a0,3220 <diskfull+0x56>
    33d6:	84de                	mv	s1,s7
      if(write(fd, buf, BSIZE) != BSIZE){
    33d8:	40000613          	li	a2,1024
    33dc:	bb040593          	addi	a1,s0,-1104
    33e0:	854a                	mv	a0,s2
    33e2:	00003097          	auipc	ra,0x3
    33e6:	80e080e7          	jalr	-2034(ra) # 5bf0 <write>
    33ea:	40000793          	li	a5,1024
    33ee:	e4f515e3          	bne	a0,a5,3238 <diskfull+0x6e>
    for(int i = 0; i < MAXFILE; i++){
    33f2:	34fd                	addiw	s1,s1,-1
    33f4:	f0f5                	bnez	s1,33d8 <diskfull+0x20e>
    33f6:	bf69                	j	3390 <diskfull+0x1c6>
    printf("%s: mkdir(diskfulldir) unexpectedly succeeded!\n");
    33f8:	00004517          	auipc	a0,0x4
    33fc:	f6850513          	addi	a0,a0,-152 # 7360 <malloc+0x135a>
    3400:	00003097          	auipc	ra,0x3
    3404:	b48080e7          	jalr	-1208(ra) # 5f48 <printf>
    3408:	b5c9                	j	32ca <diskfull+0x100>

000000000000340a <iputtest>:
{
    340a:	1101                	addi	sp,sp,-32
    340c:	ec06                	sd	ra,24(sp)
    340e:	e822                	sd	s0,16(sp)
    3410:	e426                	sd	s1,8(sp)
    3412:	1000                	addi	s0,sp,32
    3414:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    3416:	00004517          	auipc	a0,0x4
    341a:	f7a50513          	addi	a0,a0,-134 # 7390 <malloc+0x138a>
    341e:	00003097          	auipc	ra,0x3
    3422:	81a080e7          	jalr	-2022(ra) # 5c38 <mkdir>
    3426:	04054563          	bltz	a0,3470 <iputtest+0x66>
  if(chdir("iputdir") < 0){
    342a:	00004517          	auipc	a0,0x4
    342e:	f6650513          	addi	a0,a0,-154 # 7390 <malloc+0x138a>
    3432:	00003097          	auipc	ra,0x3
    3436:	80e080e7          	jalr	-2034(ra) # 5c40 <chdir>
    343a:	04054963          	bltz	a0,348c <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    343e:	00004517          	auipc	a0,0x4
    3442:	f9250513          	addi	a0,a0,-110 # 73d0 <malloc+0x13ca>
    3446:	00002097          	auipc	ra,0x2
    344a:	7da080e7          	jalr	2010(ra) # 5c20 <unlink>
    344e:	04054d63          	bltz	a0,34a8 <iputtest+0x9e>
  if(chdir("/") < 0){
    3452:	00004517          	auipc	a0,0x4
    3456:	fae50513          	addi	a0,a0,-82 # 7400 <malloc+0x13fa>
    345a:	00002097          	auipc	ra,0x2
    345e:	7e6080e7          	jalr	2022(ra) # 5c40 <chdir>
    3462:	06054163          	bltz	a0,34c4 <iputtest+0xba>
}
    3466:	60e2                	ld	ra,24(sp)
    3468:	6442                	ld	s0,16(sp)
    346a:	64a2                	ld	s1,8(sp)
    346c:	6105                	addi	sp,sp,32
    346e:	8082                	ret
    printf("%s: mkdir failed\n", s);
    3470:	85a6                	mv	a1,s1
    3472:	00004517          	auipc	a0,0x4
    3476:	f2650513          	addi	a0,a0,-218 # 7398 <malloc+0x1392>
    347a:	00003097          	auipc	ra,0x3
    347e:	ace080e7          	jalr	-1330(ra) # 5f48 <printf>
    exit(1);
    3482:	4505                	li	a0,1
    3484:	00002097          	auipc	ra,0x2
    3488:	74c080e7          	jalr	1868(ra) # 5bd0 <exit>
    printf("%s: chdir iputdir failed\n", s);
    348c:	85a6                	mv	a1,s1
    348e:	00004517          	auipc	a0,0x4
    3492:	f2250513          	addi	a0,a0,-222 # 73b0 <malloc+0x13aa>
    3496:	00003097          	auipc	ra,0x3
    349a:	ab2080e7          	jalr	-1358(ra) # 5f48 <printf>
    exit(1);
    349e:	4505                	li	a0,1
    34a0:	00002097          	auipc	ra,0x2
    34a4:	730080e7          	jalr	1840(ra) # 5bd0 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    34a8:	85a6                	mv	a1,s1
    34aa:	00004517          	auipc	a0,0x4
    34ae:	f3650513          	addi	a0,a0,-202 # 73e0 <malloc+0x13da>
    34b2:	00003097          	auipc	ra,0x3
    34b6:	a96080e7          	jalr	-1386(ra) # 5f48 <printf>
    exit(1);
    34ba:	4505                	li	a0,1
    34bc:	00002097          	auipc	ra,0x2
    34c0:	714080e7          	jalr	1812(ra) # 5bd0 <exit>
    printf("%s: chdir / failed\n", s);
    34c4:	85a6                	mv	a1,s1
    34c6:	00004517          	auipc	a0,0x4
    34ca:	f4250513          	addi	a0,a0,-190 # 7408 <malloc+0x1402>
    34ce:	00003097          	auipc	ra,0x3
    34d2:	a7a080e7          	jalr	-1414(ra) # 5f48 <printf>
    exit(1);
    34d6:	4505                	li	a0,1
    34d8:	00002097          	auipc	ra,0x2
    34dc:	6f8080e7          	jalr	1784(ra) # 5bd0 <exit>

00000000000034e0 <exitiputtest>:
{
    34e0:	7179                	addi	sp,sp,-48
    34e2:	f406                	sd	ra,40(sp)
    34e4:	f022                	sd	s0,32(sp)
    34e6:	ec26                	sd	s1,24(sp)
    34e8:	1800                	addi	s0,sp,48
    34ea:	84aa                	mv	s1,a0
  pid = fork();
    34ec:	00002097          	auipc	ra,0x2
    34f0:	6dc080e7          	jalr	1756(ra) # 5bc8 <fork>
  if(pid < 0){
    34f4:	04054663          	bltz	a0,3540 <exitiputtest+0x60>
  if(pid == 0){
    34f8:	ed45                	bnez	a0,35b0 <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    34fa:	00004517          	auipc	a0,0x4
    34fe:	e9650513          	addi	a0,a0,-362 # 7390 <malloc+0x138a>
    3502:	00002097          	auipc	ra,0x2
    3506:	736080e7          	jalr	1846(ra) # 5c38 <mkdir>
    350a:	04054963          	bltz	a0,355c <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    350e:	00004517          	auipc	a0,0x4
    3512:	e8250513          	addi	a0,a0,-382 # 7390 <malloc+0x138a>
    3516:	00002097          	auipc	ra,0x2
    351a:	72a080e7          	jalr	1834(ra) # 5c40 <chdir>
    351e:	04054d63          	bltz	a0,3578 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    3522:	00004517          	auipc	a0,0x4
    3526:	eae50513          	addi	a0,a0,-338 # 73d0 <malloc+0x13ca>
    352a:	00002097          	auipc	ra,0x2
    352e:	6f6080e7          	jalr	1782(ra) # 5c20 <unlink>
    3532:	06054163          	bltz	a0,3594 <exitiputtest+0xb4>
    exit(0);
    3536:	4501                	li	a0,0
    3538:	00002097          	auipc	ra,0x2
    353c:	698080e7          	jalr	1688(ra) # 5bd0 <exit>
    printf("%s: fork failed\n", s);
    3540:	85a6                	mv	a1,s1
    3542:	00003517          	auipc	a0,0x3
    3546:	48e50513          	addi	a0,a0,1166 # 69d0 <malloc+0x9ca>
    354a:	00003097          	auipc	ra,0x3
    354e:	9fe080e7          	jalr	-1538(ra) # 5f48 <printf>
    exit(1);
    3552:	4505                	li	a0,1
    3554:	00002097          	auipc	ra,0x2
    3558:	67c080e7          	jalr	1660(ra) # 5bd0 <exit>
      printf("%s: mkdir failed\n", s);
    355c:	85a6                	mv	a1,s1
    355e:	00004517          	auipc	a0,0x4
    3562:	e3a50513          	addi	a0,a0,-454 # 7398 <malloc+0x1392>
    3566:	00003097          	auipc	ra,0x3
    356a:	9e2080e7          	jalr	-1566(ra) # 5f48 <printf>
      exit(1);
    356e:	4505                	li	a0,1
    3570:	00002097          	auipc	ra,0x2
    3574:	660080e7          	jalr	1632(ra) # 5bd0 <exit>
      printf("%s: child chdir failed\n", s);
    3578:	85a6                	mv	a1,s1
    357a:	00004517          	auipc	a0,0x4
    357e:	ea650513          	addi	a0,a0,-346 # 7420 <malloc+0x141a>
    3582:	00003097          	auipc	ra,0x3
    3586:	9c6080e7          	jalr	-1594(ra) # 5f48 <printf>
      exit(1);
    358a:	4505                	li	a0,1
    358c:	00002097          	auipc	ra,0x2
    3590:	644080e7          	jalr	1604(ra) # 5bd0 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    3594:	85a6                	mv	a1,s1
    3596:	00004517          	auipc	a0,0x4
    359a:	e4a50513          	addi	a0,a0,-438 # 73e0 <malloc+0x13da>
    359e:	00003097          	auipc	ra,0x3
    35a2:	9aa080e7          	jalr	-1622(ra) # 5f48 <printf>
      exit(1);
    35a6:	4505                	li	a0,1
    35a8:	00002097          	auipc	ra,0x2
    35ac:	628080e7          	jalr	1576(ra) # 5bd0 <exit>
  wait(&xstatus);
    35b0:	fdc40513          	addi	a0,s0,-36
    35b4:	00002097          	auipc	ra,0x2
    35b8:	624080e7          	jalr	1572(ra) # 5bd8 <wait>
  exit(xstatus);
    35bc:	fdc42503          	lw	a0,-36(s0)
    35c0:	00002097          	auipc	ra,0x2
    35c4:	610080e7          	jalr	1552(ra) # 5bd0 <exit>

00000000000035c8 <dirtest>:
{
    35c8:	1101                	addi	sp,sp,-32
    35ca:	ec06                	sd	ra,24(sp)
    35cc:	e822                	sd	s0,16(sp)
    35ce:	e426                	sd	s1,8(sp)
    35d0:	1000                	addi	s0,sp,32
    35d2:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    35d4:	00004517          	auipc	a0,0x4
    35d8:	e6450513          	addi	a0,a0,-412 # 7438 <malloc+0x1432>
    35dc:	00002097          	auipc	ra,0x2
    35e0:	65c080e7          	jalr	1628(ra) # 5c38 <mkdir>
    35e4:	04054563          	bltz	a0,362e <dirtest+0x66>
  if(chdir("dir0") < 0){
    35e8:	00004517          	auipc	a0,0x4
    35ec:	e5050513          	addi	a0,a0,-432 # 7438 <malloc+0x1432>
    35f0:	00002097          	auipc	ra,0x2
    35f4:	650080e7          	jalr	1616(ra) # 5c40 <chdir>
    35f8:	04054963          	bltz	a0,364a <dirtest+0x82>
  if(chdir("..") < 0){
    35fc:	00004517          	auipc	a0,0x4
    3600:	e5c50513          	addi	a0,a0,-420 # 7458 <malloc+0x1452>
    3604:	00002097          	auipc	ra,0x2
    3608:	63c080e7          	jalr	1596(ra) # 5c40 <chdir>
    360c:	04054d63          	bltz	a0,3666 <dirtest+0x9e>
  if(unlink("dir0") < 0){
    3610:	00004517          	auipc	a0,0x4
    3614:	e2850513          	addi	a0,a0,-472 # 7438 <malloc+0x1432>
    3618:	00002097          	auipc	ra,0x2
    361c:	608080e7          	jalr	1544(ra) # 5c20 <unlink>
    3620:	06054163          	bltz	a0,3682 <dirtest+0xba>
}
    3624:	60e2                	ld	ra,24(sp)
    3626:	6442                	ld	s0,16(sp)
    3628:	64a2                	ld	s1,8(sp)
    362a:	6105                	addi	sp,sp,32
    362c:	8082                	ret
    printf("%s: mkdir failed\n", s);
    362e:	85a6                	mv	a1,s1
    3630:	00004517          	auipc	a0,0x4
    3634:	d6850513          	addi	a0,a0,-664 # 7398 <malloc+0x1392>
    3638:	00003097          	auipc	ra,0x3
    363c:	910080e7          	jalr	-1776(ra) # 5f48 <printf>
    exit(1);
    3640:	4505                	li	a0,1
    3642:	00002097          	auipc	ra,0x2
    3646:	58e080e7          	jalr	1422(ra) # 5bd0 <exit>
    printf("%s: chdir dir0 failed\n", s);
    364a:	85a6                	mv	a1,s1
    364c:	00004517          	auipc	a0,0x4
    3650:	df450513          	addi	a0,a0,-524 # 7440 <malloc+0x143a>
    3654:	00003097          	auipc	ra,0x3
    3658:	8f4080e7          	jalr	-1804(ra) # 5f48 <printf>
    exit(1);
    365c:	4505                	li	a0,1
    365e:	00002097          	auipc	ra,0x2
    3662:	572080e7          	jalr	1394(ra) # 5bd0 <exit>
    printf("%s: chdir .. failed\n", s);
    3666:	85a6                	mv	a1,s1
    3668:	00004517          	auipc	a0,0x4
    366c:	df850513          	addi	a0,a0,-520 # 7460 <malloc+0x145a>
    3670:	00003097          	auipc	ra,0x3
    3674:	8d8080e7          	jalr	-1832(ra) # 5f48 <printf>
    exit(1);
    3678:	4505                	li	a0,1
    367a:	00002097          	auipc	ra,0x2
    367e:	556080e7          	jalr	1366(ra) # 5bd0 <exit>
    printf("%s: unlink dir0 failed\n", s);
    3682:	85a6                	mv	a1,s1
    3684:	00004517          	auipc	a0,0x4
    3688:	df450513          	addi	a0,a0,-524 # 7478 <malloc+0x1472>
    368c:	00003097          	auipc	ra,0x3
    3690:	8bc080e7          	jalr	-1860(ra) # 5f48 <printf>
    exit(1);
    3694:	4505                	li	a0,1
    3696:	00002097          	auipc	ra,0x2
    369a:	53a080e7          	jalr	1338(ra) # 5bd0 <exit>

000000000000369e <subdir>:
{
    369e:	1101                	addi	sp,sp,-32
    36a0:	ec06                	sd	ra,24(sp)
    36a2:	e822                	sd	s0,16(sp)
    36a4:	e426                	sd	s1,8(sp)
    36a6:	e04a                	sd	s2,0(sp)
    36a8:	1000                	addi	s0,sp,32
    36aa:	892a                	mv	s2,a0
  unlink("ff");
    36ac:	00004517          	auipc	a0,0x4
    36b0:	f1450513          	addi	a0,a0,-236 # 75c0 <malloc+0x15ba>
    36b4:	00002097          	auipc	ra,0x2
    36b8:	56c080e7          	jalr	1388(ra) # 5c20 <unlink>
  if(mkdir("dd") != 0){
    36bc:	00004517          	auipc	a0,0x4
    36c0:	dd450513          	addi	a0,a0,-556 # 7490 <malloc+0x148a>
    36c4:	00002097          	auipc	ra,0x2
    36c8:	574080e7          	jalr	1396(ra) # 5c38 <mkdir>
    36cc:	38051663          	bnez	a0,3a58 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    36d0:	20200593          	li	a1,514
    36d4:	00004517          	auipc	a0,0x4
    36d8:	ddc50513          	addi	a0,a0,-548 # 74b0 <malloc+0x14aa>
    36dc:	00002097          	auipc	ra,0x2
    36e0:	534080e7          	jalr	1332(ra) # 5c10 <open>
    36e4:	84aa                	mv	s1,a0
  if(fd < 0){
    36e6:	38054763          	bltz	a0,3a74 <subdir+0x3d6>
  write(fd, "ff", 2);
    36ea:	4609                	li	a2,2
    36ec:	00004597          	auipc	a1,0x4
    36f0:	ed458593          	addi	a1,a1,-300 # 75c0 <malloc+0x15ba>
    36f4:	00002097          	auipc	ra,0x2
    36f8:	4fc080e7          	jalr	1276(ra) # 5bf0 <write>
  close(fd);
    36fc:	8526                	mv	a0,s1
    36fe:	00002097          	auipc	ra,0x2
    3702:	4fa080e7          	jalr	1274(ra) # 5bf8 <close>
  if(unlink("dd") >= 0){
    3706:	00004517          	auipc	a0,0x4
    370a:	d8a50513          	addi	a0,a0,-630 # 7490 <malloc+0x148a>
    370e:	00002097          	auipc	ra,0x2
    3712:	512080e7          	jalr	1298(ra) # 5c20 <unlink>
    3716:	36055d63          	bgez	a0,3a90 <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    371a:	00004517          	auipc	a0,0x4
    371e:	dee50513          	addi	a0,a0,-530 # 7508 <malloc+0x1502>
    3722:	00002097          	auipc	ra,0x2
    3726:	516080e7          	jalr	1302(ra) # 5c38 <mkdir>
    372a:	38051163          	bnez	a0,3aac <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    372e:	20200593          	li	a1,514
    3732:	00004517          	auipc	a0,0x4
    3736:	dfe50513          	addi	a0,a0,-514 # 7530 <malloc+0x152a>
    373a:	00002097          	auipc	ra,0x2
    373e:	4d6080e7          	jalr	1238(ra) # 5c10 <open>
    3742:	84aa                	mv	s1,a0
  if(fd < 0){
    3744:	38054263          	bltz	a0,3ac8 <subdir+0x42a>
  write(fd, "FF", 2);
    3748:	4609                	li	a2,2
    374a:	00004597          	auipc	a1,0x4
    374e:	e1658593          	addi	a1,a1,-490 # 7560 <malloc+0x155a>
    3752:	00002097          	auipc	ra,0x2
    3756:	49e080e7          	jalr	1182(ra) # 5bf0 <write>
  close(fd);
    375a:	8526                	mv	a0,s1
    375c:	00002097          	auipc	ra,0x2
    3760:	49c080e7          	jalr	1180(ra) # 5bf8 <close>
  fd = open("dd/dd/../ff", 0);
    3764:	4581                	li	a1,0
    3766:	00004517          	auipc	a0,0x4
    376a:	e0250513          	addi	a0,a0,-510 # 7568 <malloc+0x1562>
    376e:	00002097          	auipc	ra,0x2
    3772:	4a2080e7          	jalr	1186(ra) # 5c10 <open>
    3776:	84aa                	mv	s1,a0
  if(fd < 0){
    3778:	36054663          	bltz	a0,3ae4 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    377c:	660d                	lui	a2,0x3
    377e:	00009597          	auipc	a1,0x9
    3782:	4fa58593          	addi	a1,a1,1274 # cc78 <buf>
    3786:	00002097          	auipc	ra,0x2
    378a:	462080e7          	jalr	1122(ra) # 5be8 <read>
  if(cc != 2 || buf[0] != 'f'){
    378e:	4789                	li	a5,2
    3790:	36f51863          	bne	a0,a5,3b00 <subdir+0x462>
    3794:	00009717          	auipc	a4,0x9
    3798:	4e474703          	lbu	a4,1252(a4) # cc78 <buf>
    379c:	06600793          	li	a5,102
    37a0:	36f71063          	bne	a4,a5,3b00 <subdir+0x462>
  close(fd);
    37a4:	8526                	mv	a0,s1
    37a6:	00002097          	auipc	ra,0x2
    37aa:	452080e7          	jalr	1106(ra) # 5bf8 <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    37ae:	00004597          	auipc	a1,0x4
    37b2:	e0a58593          	addi	a1,a1,-502 # 75b8 <malloc+0x15b2>
    37b6:	00004517          	auipc	a0,0x4
    37ba:	d7a50513          	addi	a0,a0,-646 # 7530 <malloc+0x152a>
    37be:	00002097          	auipc	ra,0x2
    37c2:	472080e7          	jalr	1138(ra) # 5c30 <link>
    37c6:	34051b63          	bnez	a0,3b1c <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    37ca:	00004517          	auipc	a0,0x4
    37ce:	d6650513          	addi	a0,a0,-666 # 7530 <malloc+0x152a>
    37d2:	00002097          	auipc	ra,0x2
    37d6:	44e080e7          	jalr	1102(ra) # 5c20 <unlink>
    37da:	34051f63          	bnez	a0,3b38 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    37de:	4581                	li	a1,0
    37e0:	00004517          	auipc	a0,0x4
    37e4:	d5050513          	addi	a0,a0,-688 # 7530 <malloc+0x152a>
    37e8:	00002097          	auipc	ra,0x2
    37ec:	428080e7          	jalr	1064(ra) # 5c10 <open>
    37f0:	36055263          	bgez	a0,3b54 <subdir+0x4b6>
  if(chdir("dd") != 0){
    37f4:	00004517          	auipc	a0,0x4
    37f8:	c9c50513          	addi	a0,a0,-868 # 7490 <malloc+0x148a>
    37fc:	00002097          	auipc	ra,0x2
    3800:	444080e7          	jalr	1092(ra) # 5c40 <chdir>
    3804:	36051663          	bnez	a0,3b70 <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    3808:	00004517          	auipc	a0,0x4
    380c:	e4850513          	addi	a0,a0,-440 # 7650 <malloc+0x164a>
    3810:	00002097          	auipc	ra,0x2
    3814:	430080e7          	jalr	1072(ra) # 5c40 <chdir>
    3818:	36051a63          	bnez	a0,3b8c <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    381c:	00004517          	auipc	a0,0x4
    3820:	e6450513          	addi	a0,a0,-412 # 7680 <malloc+0x167a>
    3824:	00002097          	auipc	ra,0x2
    3828:	41c080e7          	jalr	1052(ra) # 5c40 <chdir>
    382c:	36051e63          	bnez	a0,3ba8 <subdir+0x50a>
  if(chdir("./..") != 0){
    3830:	00004517          	auipc	a0,0x4
    3834:	e8050513          	addi	a0,a0,-384 # 76b0 <malloc+0x16aa>
    3838:	00002097          	auipc	ra,0x2
    383c:	408080e7          	jalr	1032(ra) # 5c40 <chdir>
    3840:	38051263          	bnez	a0,3bc4 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    3844:	4581                	li	a1,0
    3846:	00004517          	auipc	a0,0x4
    384a:	d7250513          	addi	a0,a0,-654 # 75b8 <malloc+0x15b2>
    384e:	00002097          	auipc	ra,0x2
    3852:	3c2080e7          	jalr	962(ra) # 5c10 <open>
    3856:	84aa                	mv	s1,a0
  if(fd < 0){
    3858:	38054463          	bltz	a0,3be0 <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    385c:	660d                	lui	a2,0x3
    385e:	00009597          	auipc	a1,0x9
    3862:	41a58593          	addi	a1,a1,1050 # cc78 <buf>
    3866:	00002097          	auipc	ra,0x2
    386a:	382080e7          	jalr	898(ra) # 5be8 <read>
    386e:	4789                	li	a5,2
    3870:	38f51663          	bne	a0,a5,3bfc <subdir+0x55e>
  close(fd);
    3874:	8526                	mv	a0,s1
    3876:	00002097          	auipc	ra,0x2
    387a:	382080e7          	jalr	898(ra) # 5bf8 <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    387e:	4581                	li	a1,0
    3880:	00004517          	auipc	a0,0x4
    3884:	cb050513          	addi	a0,a0,-848 # 7530 <malloc+0x152a>
    3888:	00002097          	auipc	ra,0x2
    388c:	388080e7          	jalr	904(ra) # 5c10 <open>
    3890:	38055463          	bgez	a0,3c18 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3894:	20200593          	li	a1,514
    3898:	00004517          	auipc	a0,0x4
    389c:	ea850513          	addi	a0,a0,-344 # 7740 <malloc+0x173a>
    38a0:	00002097          	auipc	ra,0x2
    38a4:	370080e7          	jalr	880(ra) # 5c10 <open>
    38a8:	38055663          	bgez	a0,3c34 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    38ac:	20200593          	li	a1,514
    38b0:	00004517          	auipc	a0,0x4
    38b4:	ec050513          	addi	a0,a0,-320 # 7770 <malloc+0x176a>
    38b8:	00002097          	auipc	ra,0x2
    38bc:	358080e7          	jalr	856(ra) # 5c10 <open>
    38c0:	38055863          	bgez	a0,3c50 <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    38c4:	20000593          	li	a1,512
    38c8:	00004517          	auipc	a0,0x4
    38cc:	bc850513          	addi	a0,a0,-1080 # 7490 <malloc+0x148a>
    38d0:	00002097          	auipc	ra,0x2
    38d4:	340080e7          	jalr	832(ra) # 5c10 <open>
    38d8:	38055a63          	bgez	a0,3c6c <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    38dc:	4589                	li	a1,2
    38de:	00004517          	auipc	a0,0x4
    38e2:	bb250513          	addi	a0,a0,-1102 # 7490 <malloc+0x148a>
    38e6:	00002097          	auipc	ra,0x2
    38ea:	32a080e7          	jalr	810(ra) # 5c10 <open>
    38ee:	38055d63          	bgez	a0,3c88 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    38f2:	4585                	li	a1,1
    38f4:	00004517          	auipc	a0,0x4
    38f8:	b9c50513          	addi	a0,a0,-1124 # 7490 <malloc+0x148a>
    38fc:	00002097          	auipc	ra,0x2
    3900:	314080e7          	jalr	788(ra) # 5c10 <open>
    3904:	3a055063          	bgez	a0,3ca4 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3908:	00004597          	auipc	a1,0x4
    390c:	ef858593          	addi	a1,a1,-264 # 7800 <malloc+0x17fa>
    3910:	00004517          	auipc	a0,0x4
    3914:	e3050513          	addi	a0,a0,-464 # 7740 <malloc+0x173a>
    3918:	00002097          	auipc	ra,0x2
    391c:	318080e7          	jalr	792(ra) # 5c30 <link>
    3920:	3a050063          	beqz	a0,3cc0 <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3924:	00004597          	auipc	a1,0x4
    3928:	edc58593          	addi	a1,a1,-292 # 7800 <malloc+0x17fa>
    392c:	00004517          	auipc	a0,0x4
    3930:	e4450513          	addi	a0,a0,-444 # 7770 <malloc+0x176a>
    3934:	00002097          	auipc	ra,0x2
    3938:	2fc080e7          	jalr	764(ra) # 5c30 <link>
    393c:	3a050063          	beqz	a0,3cdc <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    3940:	00004597          	auipc	a1,0x4
    3944:	c7858593          	addi	a1,a1,-904 # 75b8 <malloc+0x15b2>
    3948:	00004517          	auipc	a0,0x4
    394c:	b6850513          	addi	a0,a0,-1176 # 74b0 <malloc+0x14aa>
    3950:	00002097          	auipc	ra,0x2
    3954:	2e0080e7          	jalr	736(ra) # 5c30 <link>
    3958:	3a050063          	beqz	a0,3cf8 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    395c:	00004517          	auipc	a0,0x4
    3960:	de450513          	addi	a0,a0,-540 # 7740 <malloc+0x173a>
    3964:	00002097          	auipc	ra,0x2
    3968:	2d4080e7          	jalr	724(ra) # 5c38 <mkdir>
    396c:	3a050463          	beqz	a0,3d14 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    3970:	00004517          	auipc	a0,0x4
    3974:	e0050513          	addi	a0,a0,-512 # 7770 <malloc+0x176a>
    3978:	00002097          	auipc	ra,0x2
    397c:	2c0080e7          	jalr	704(ra) # 5c38 <mkdir>
    3980:	3a050863          	beqz	a0,3d30 <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    3984:	00004517          	auipc	a0,0x4
    3988:	c3450513          	addi	a0,a0,-972 # 75b8 <malloc+0x15b2>
    398c:	00002097          	auipc	ra,0x2
    3990:	2ac080e7          	jalr	684(ra) # 5c38 <mkdir>
    3994:	3a050c63          	beqz	a0,3d4c <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    3998:	00004517          	auipc	a0,0x4
    399c:	dd850513          	addi	a0,a0,-552 # 7770 <malloc+0x176a>
    39a0:	00002097          	auipc	ra,0x2
    39a4:	280080e7          	jalr	640(ra) # 5c20 <unlink>
    39a8:	3c050063          	beqz	a0,3d68 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    39ac:	00004517          	auipc	a0,0x4
    39b0:	d9450513          	addi	a0,a0,-620 # 7740 <malloc+0x173a>
    39b4:	00002097          	auipc	ra,0x2
    39b8:	26c080e7          	jalr	620(ra) # 5c20 <unlink>
    39bc:	3c050463          	beqz	a0,3d84 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    39c0:	00004517          	auipc	a0,0x4
    39c4:	af050513          	addi	a0,a0,-1296 # 74b0 <malloc+0x14aa>
    39c8:	00002097          	auipc	ra,0x2
    39cc:	278080e7          	jalr	632(ra) # 5c40 <chdir>
    39d0:	3c050863          	beqz	a0,3da0 <subdir+0x702>
  if(chdir("dd/xx") == 0){
    39d4:	00004517          	auipc	a0,0x4
    39d8:	f7c50513          	addi	a0,a0,-132 # 7950 <malloc+0x194a>
    39dc:	00002097          	auipc	ra,0x2
    39e0:	264080e7          	jalr	612(ra) # 5c40 <chdir>
    39e4:	3c050c63          	beqz	a0,3dbc <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    39e8:	00004517          	auipc	a0,0x4
    39ec:	bd050513          	addi	a0,a0,-1072 # 75b8 <malloc+0x15b2>
    39f0:	00002097          	auipc	ra,0x2
    39f4:	230080e7          	jalr	560(ra) # 5c20 <unlink>
    39f8:	3e051063          	bnez	a0,3dd8 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    39fc:	00004517          	auipc	a0,0x4
    3a00:	ab450513          	addi	a0,a0,-1356 # 74b0 <malloc+0x14aa>
    3a04:	00002097          	auipc	ra,0x2
    3a08:	21c080e7          	jalr	540(ra) # 5c20 <unlink>
    3a0c:	3e051463          	bnez	a0,3df4 <subdir+0x756>
  if(unlink("dd") == 0){
    3a10:	00004517          	auipc	a0,0x4
    3a14:	a8050513          	addi	a0,a0,-1408 # 7490 <malloc+0x148a>
    3a18:	00002097          	auipc	ra,0x2
    3a1c:	208080e7          	jalr	520(ra) # 5c20 <unlink>
    3a20:	3e050863          	beqz	a0,3e10 <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3a24:	00004517          	auipc	a0,0x4
    3a28:	f9c50513          	addi	a0,a0,-100 # 79c0 <malloc+0x19ba>
    3a2c:	00002097          	auipc	ra,0x2
    3a30:	1f4080e7          	jalr	500(ra) # 5c20 <unlink>
    3a34:	3e054c63          	bltz	a0,3e2c <subdir+0x78e>
  if(unlink("dd") < 0){
    3a38:	00004517          	auipc	a0,0x4
    3a3c:	a5850513          	addi	a0,a0,-1448 # 7490 <malloc+0x148a>
    3a40:	00002097          	auipc	ra,0x2
    3a44:	1e0080e7          	jalr	480(ra) # 5c20 <unlink>
    3a48:	40054063          	bltz	a0,3e48 <subdir+0x7aa>
}
    3a4c:	60e2                	ld	ra,24(sp)
    3a4e:	6442                	ld	s0,16(sp)
    3a50:	64a2                	ld	s1,8(sp)
    3a52:	6902                	ld	s2,0(sp)
    3a54:	6105                	addi	sp,sp,32
    3a56:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    3a58:	85ca                	mv	a1,s2
    3a5a:	00004517          	auipc	a0,0x4
    3a5e:	a3e50513          	addi	a0,a0,-1474 # 7498 <malloc+0x1492>
    3a62:	00002097          	auipc	ra,0x2
    3a66:	4e6080e7          	jalr	1254(ra) # 5f48 <printf>
    exit(1);
    3a6a:	4505                	li	a0,1
    3a6c:	00002097          	auipc	ra,0x2
    3a70:	164080e7          	jalr	356(ra) # 5bd0 <exit>
    printf("%s: create dd/ff failed\n", s);
    3a74:	85ca                	mv	a1,s2
    3a76:	00004517          	auipc	a0,0x4
    3a7a:	a4250513          	addi	a0,a0,-1470 # 74b8 <malloc+0x14b2>
    3a7e:	00002097          	auipc	ra,0x2
    3a82:	4ca080e7          	jalr	1226(ra) # 5f48 <printf>
    exit(1);
    3a86:	4505                	li	a0,1
    3a88:	00002097          	auipc	ra,0x2
    3a8c:	148080e7          	jalr	328(ra) # 5bd0 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    3a90:	85ca                	mv	a1,s2
    3a92:	00004517          	auipc	a0,0x4
    3a96:	a4650513          	addi	a0,a0,-1466 # 74d8 <malloc+0x14d2>
    3a9a:	00002097          	auipc	ra,0x2
    3a9e:	4ae080e7          	jalr	1198(ra) # 5f48 <printf>
    exit(1);
    3aa2:	4505                	li	a0,1
    3aa4:	00002097          	auipc	ra,0x2
    3aa8:	12c080e7          	jalr	300(ra) # 5bd0 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3aac:	85ca                	mv	a1,s2
    3aae:	00004517          	auipc	a0,0x4
    3ab2:	a6250513          	addi	a0,a0,-1438 # 7510 <malloc+0x150a>
    3ab6:	00002097          	auipc	ra,0x2
    3aba:	492080e7          	jalr	1170(ra) # 5f48 <printf>
    exit(1);
    3abe:	4505                	li	a0,1
    3ac0:	00002097          	auipc	ra,0x2
    3ac4:	110080e7          	jalr	272(ra) # 5bd0 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3ac8:	85ca                	mv	a1,s2
    3aca:	00004517          	auipc	a0,0x4
    3ace:	a7650513          	addi	a0,a0,-1418 # 7540 <malloc+0x153a>
    3ad2:	00002097          	auipc	ra,0x2
    3ad6:	476080e7          	jalr	1142(ra) # 5f48 <printf>
    exit(1);
    3ada:	4505                	li	a0,1
    3adc:	00002097          	auipc	ra,0x2
    3ae0:	0f4080e7          	jalr	244(ra) # 5bd0 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3ae4:	85ca                	mv	a1,s2
    3ae6:	00004517          	auipc	a0,0x4
    3aea:	a9250513          	addi	a0,a0,-1390 # 7578 <malloc+0x1572>
    3aee:	00002097          	auipc	ra,0x2
    3af2:	45a080e7          	jalr	1114(ra) # 5f48 <printf>
    exit(1);
    3af6:	4505                	li	a0,1
    3af8:	00002097          	auipc	ra,0x2
    3afc:	0d8080e7          	jalr	216(ra) # 5bd0 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    3b00:	85ca                	mv	a1,s2
    3b02:	00004517          	auipc	a0,0x4
    3b06:	a9650513          	addi	a0,a0,-1386 # 7598 <malloc+0x1592>
    3b0a:	00002097          	auipc	ra,0x2
    3b0e:	43e080e7          	jalr	1086(ra) # 5f48 <printf>
    exit(1);
    3b12:	4505                	li	a0,1
    3b14:	00002097          	auipc	ra,0x2
    3b18:	0bc080e7          	jalr	188(ra) # 5bd0 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3b1c:	85ca                	mv	a1,s2
    3b1e:	00004517          	auipc	a0,0x4
    3b22:	aaa50513          	addi	a0,a0,-1366 # 75c8 <malloc+0x15c2>
    3b26:	00002097          	auipc	ra,0x2
    3b2a:	422080e7          	jalr	1058(ra) # 5f48 <printf>
    exit(1);
    3b2e:	4505                	li	a0,1
    3b30:	00002097          	auipc	ra,0x2
    3b34:	0a0080e7          	jalr	160(ra) # 5bd0 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3b38:	85ca                	mv	a1,s2
    3b3a:	00004517          	auipc	a0,0x4
    3b3e:	ab650513          	addi	a0,a0,-1354 # 75f0 <malloc+0x15ea>
    3b42:	00002097          	auipc	ra,0x2
    3b46:	406080e7          	jalr	1030(ra) # 5f48 <printf>
    exit(1);
    3b4a:	4505                	li	a0,1
    3b4c:	00002097          	auipc	ra,0x2
    3b50:	084080e7          	jalr	132(ra) # 5bd0 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    3b54:	85ca                	mv	a1,s2
    3b56:	00004517          	auipc	a0,0x4
    3b5a:	aba50513          	addi	a0,a0,-1350 # 7610 <malloc+0x160a>
    3b5e:	00002097          	auipc	ra,0x2
    3b62:	3ea080e7          	jalr	1002(ra) # 5f48 <printf>
    exit(1);
    3b66:	4505                	li	a0,1
    3b68:	00002097          	auipc	ra,0x2
    3b6c:	068080e7          	jalr	104(ra) # 5bd0 <exit>
    printf("%s: chdir dd failed\n", s);
    3b70:	85ca                	mv	a1,s2
    3b72:	00004517          	auipc	a0,0x4
    3b76:	ac650513          	addi	a0,a0,-1338 # 7638 <malloc+0x1632>
    3b7a:	00002097          	auipc	ra,0x2
    3b7e:	3ce080e7          	jalr	974(ra) # 5f48 <printf>
    exit(1);
    3b82:	4505                	li	a0,1
    3b84:	00002097          	auipc	ra,0x2
    3b88:	04c080e7          	jalr	76(ra) # 5bd0 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    3b8c:	85ca                	mv	a1,s2
    3b8e:	00004517          	auipc	a0,0x4
    3b92:	ad250513          	addi	a0,a0,-1326 # 7660 <malloc+0x165a>
    3b96:	00002097          	auipc	ra,0x2
    3b9a:	3b2080e7          	jalr	946(ra) # 5f48 <printf>
    exit(1);
    3b9e:	4505                	li	a0,1
    3ba0:	00002097          	auipc	ra,0x2
    3ba4:	030080e7          	jalr	48(ra) # 5bd0 <exit>
    printf("chdir dd/../../dd failed\n", s);
    3ba8:	85ca                	mv	a1,s2
    3baa:	00004517          	auipc	a0,0x4
    3bae:	ae650513          	addi	a0,a0,-1306 # 7690 <malloc+0x168a>
    3bb2:	00002097          	auipc	ra,0x2
    3bb6:	396080e7          	jalr	918(ra) # 5f48 <printf>
    exit(1);
    3bba:	4505                	li	a0,1
    3bbc:	00002097          	auipc	ra,0x2
    3bc0:	014080e7          	jalr	20(ra) # 5bd0 <exit>
    printf("%s: chdir ./.. failed\n", s);
    3bc4:	85ca                	mv	a1,s2
    3bc6:	00004517          	auipc	a0,0x4
    3bca:	af250513          	addi	a0,a0,-1294 # 76b8 <malloc+0x16b2>
    3bce:	00002097          	auipc	ra,0x2
    3bd2:	37a080e7          	jalr	890(ra) # 5f48 <printf>
    exit(1);
    3bd6:	4505                	li	a0,1
    3bd8:	00002097          	auipc	ra,0x2
    3bdc:	ff8080e7          	jalr	-8(ra) # 5bd0 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    3be0:	85ca                	mv	a1,s2
    3be2:	00004517          	auipc	a0,0x4
    3be6:	aee50513          	addi	a0,a0,-1298 # 76d0 <malloc+0x16ca>
    3bea:	00002097          	auipc	ra,0x2
    3bee:	35e080e7          	jalr	862(ra) # 5f48 <printf>
    exit(1);
    3bf2:	4505                	li	a0,1
    3bf4:	00002097          	auipc	ra,0x2
    3bf8:	fdc080e7          	jalr	-36(ra) # 5bd0 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3bfc:	85ca                	mv	a1,s2
    3bfe:	00004517          	auipc	a0,0x4
    3c02:	af250513          	addi	a0,a0,-1294 # 76f0 <malloc+0x16ea>
    3c06:	00002097          	auipc	ra,0x2
    3c0a:	342080e7          	jalr	834(ra) # 5f48 <printf>
    exit(1);
    3c0e:	4505                	li	a0,1
    3c10:	00002097          	auipc	ra,0x2
    3c14:	fc0080e7          	jalr	-64(ra) # 5bd0 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3c18:	85ca                	mv	a1,s2
    3c1a:	00004517          	auipc	a0,0x4
    3c1e:	af650513          	addi	a0,a0,-1290 # 7710 <malloc+0x170a>
    3c22:	00002097          	auipc	ra,0x2
    3c26:	326080e7          	jalr	806(ra) # 5f48 <printf>
    exit(1);
    3c2a:	4505                	li	a0,1
    3c2c:	00002097          	auipc	ra,0x2
    3c30:	fa4080e7          	jalr	-92(ra) # 5bd0 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    3c34:	85ca                	mv	a1,s2
    3c36:	00004517          	auipc	a0,0x4
    3c3a:	b1a50513          	addi	a0,a0,-1254 # 7750 <malloc+0x174a>
    3c3e:	00002097          	auipc	ra,0x2
    3c42:	30a080e7          	jalr	778(ra) # 5f48 <printf>
    exit(1);
    3c46:	4505                	li	a0,1
    3c48:	00002097          	auipc	ra,0x2
    3c4c:	f88080e7          	jalr	-120(ra) # 5bd0 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    3c50:	85ca                	mv	a1,s2
    3c52:	00004517          	auipc	a0,0x4
    3c56:	b2e50513          	addi	a0,a0,-1234 # 7780 <malloc+0x177a>
    3c5a:	00002097          	auipc	ra,0x2
    3c5e:	2ee080e7          	jalr	750(ra) # 5f48 <printf>
    exit(1);
    3c62:	4505                	li	a0,1
    3c64:	00002097          	auipc	ra,0x2
    3c68:	f6c080e7          	jalr	-148(ra) # 5bd0 <exit>
    printf("%s: create dd succeeded!\n", s);
    3c6c:	85ca                	mv	a1,s2
    3c6e:	00004517          	auipc	a0,0x4
    3c72:	b3250513          	addi	a0,a0,-1230 # 77a0 <malloc+0x179a>
    3c76:	00002097          	auipc	ra,0x2
    3c7a:	2d2080e7          	jalr	722(ra) # 5f48 <printf>
    exit(1);
    3c7e:	4505                	li	a0,1
    3c80:	00002097          	auipc	ra,0x2
    3c84:	f50080e7          	jalr	-176(ra) # 5bd0 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    3c88:	85ca                	mv	a1,s2
    3c8a:	00004517          	auipc	a0,0x4
    3c8e:	b3650513          	addi	a0,a0,-1226 # 77c0 <malloc+0x17ba>
    3c92:	00002097          	auipc	ra,0x2
    3c96:	2b6080e7          	jalr	694(ra) # 5f48 <printf>
    exit(1);
    3c9a:	4505                	li	a0,1
    3c9c:	00002097          	auipc	ra,0x2
    3ca0:	f34080e7          	jalr	-204(ra) # 5bd0 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3ca4:	85ca                	mv	a1,s2
    3ca6:	00004517          	auipc	a0,0x4
    3caa:	b3a50513          	addi	a0,a0,-1222 # 77e0 <malloc+0x17da>
    3cae:	00002097          	auipc	ra,0x2
    3cb2:	29a080e7          	jalr	666(ra) # 5f48 <printf>
    exit(1);
    3cb6:	4505                	li	a0,1
    3cb8:	00002097          	auipc	ra,0x2
    3cbc:	f18080e7          	jalr	-232(ra) # 5bd0 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    3cc0:	85ca                	mv	a1,s2
    3cc2:	00004517          	auipc	a0,0x4
    3cc6:	b4e50513          	addi	a0,a0,-1202 # 7810 <malloc+0x180a>
    3cca:	00002097          	auipc	ra,0x2
    3cce:	27e080e7          	jalr	638(ra) # 5f48 <printf>
    exit(1);
    3cd2:	4505                	li	a0,1
    3cd4:	00002097          	auipc	ra,0x2
    3cd8:	efc080e7          	jalr	-260(ra) # 5bd0 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3cdc:	85ca                	mv	a1,s2
    3cde:	00004517          	auipc	a0,0x4
    3ce2:	b5a50513          	addi	a0,a0,-1190 # 7838 <malloc+0x1832>
    3ce6:	00002097          	auipc	ra,0x2
    3cea:	262080e7          	jalr	610(ra) # 5f48 <printf>
    exit(1);
    3cee:	4505                	li	a0,1
    3cf0:	00002097          	auipc	ra,0x2
    3cf4:	ee0080e7          	jalr	-288(ra) # 5bd0 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3cf8:	85ca                	mv	a1,s2
    3cfa:	00004517          	auipc	a0,0x4
    3cfe:	b6650513          	addi	a0,a0,-1178 # 7860 <malloc+0x185a>
    3d02:	00002097          	auipc	ra,0x2
    3d06:	246080e7          	jalr	582(ra) # 5f48 <printf>
    exit(1);
    3d0a:	4505                	li	a0,1
    3d0c:	00002097          	auipc	ra,0x2
    3d10:	ec4080e7          	jalr	-316(ra) # 5bd0 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3d14:	85ca                	mv	a1,s2
    3d16:	00004517          	auipc	a0,0x4
    3d1a:	b7250513          	addi	a0,a0,-1166 # 7888 <malloc+0x1882>
    3d1e:	00002097          	auipc	ra,0x2
    3d22:	22a080e7          	jalr	554(ra) # 5f48 <printf>
    exit(1);
    3d26:	4505                	li	a0,1
    3d28:	00002097          	auipc	ra,0x2
    3d2c:	ea8080e7          	jalr	-344(ra) # 5bd0 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    3d30:	85ca                	mv	a1,s2
    3d32:	00004517          	auipc	a0,0x4
    3d36:	b7650513          	addi	a0,a0,-1162 # 78a8 <malloc+0x18a2>
    3d3a:	00002097          	auipc	ra,0x2
    3d3e:	20e080e7          	jalr	526(ra) # 5f48 <printf>
    exit(1);
    3d42:	4505                	li	a0,1
    3d44:	00002097          	auipc	ra,0x2
    3d48:	e8c080e7          	jalr	-372(ra) # 5bd0 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    3d4c:	85ca                	mv	a1,s2
    3d4e:	00004517          	auipc	a0,0x4
    3d52:	b7a50513          	addi	a0,a0,-1158 # 78c8 <malloc+0x18c2>
    3d56:	00002097          	auipc	ra,0x2
    3d5a:	1f2080e7          	jalr	498(ra) # 5f48 <printf>
    exit(1);
    3d5e:	4505                	li	a0,1
    3d60:	00002097          	auipc	ra,0x2
    3d64:	e70080e7          	jalr	-400(ra) # 5bd0 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    3d68:	85ca                	mv	a1,s2
    3d6a:	00004517          	auipc	a0,0x4
    3d6e:	b8650513          	addi	a0,a0,-1146 # 78f0 <malloc+0x18ea>
    3d72:	00002097          	auipc	ra,0x2
    3d76:	1d6080e7          	jalr	470(ra) # 5f48 <printf>
    exit(1);
    3d7a:	4505                	li	a0,1
    3d7c:	00002097          	auipc	ra,0x2
    3d80:	e54080e7          	jalr	-428(ra) # 5bd0 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    3d84:	85ca                	mv	a1,s2
    3d86:	00004517          	auipc	a0,0x4
    3d8a:	b8a50513          	addi	a0,a0,-1142 # 7910 <malloc+0x190a>
    3d8e:	00002097          	auipc	ra,0x2
    3d92:	1ba080e7          	jalr	442(ra) # 5f48 <printf>
    exit(1);
    3d96:	4505                	li	a0,1
    3d98:	00002097          	auipc	ra,0x2
    3d9c:	e38080e7          	jalr	-456(ra) # 5bd0 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    3da0:	85ca                	mv	a1,s2
    3da2:	00004517          	auipc	a0,0x4
    3da6:	b8e50513          	addi	a0,a0,-1138 # 7930 <malloc+0x192a>
    3daa:	00002097          	auipc	ra,0x2
    3dae:	19e080e7          	jalr	414(ra) # 5f48 <printf>
    exit(1);
    3db2:	4505                	li	a0,1
    3db4:	00002097          	auipc	ra,0x2
    3db8:	e1c080e7          	jalr	-484(ra) # 5bd0 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3dbc:	85ca                	mv	a1,s2
    3dbe:	00004517          	auipc	a0,0x4
    3dc2:	b9a50513          	addi	a0,a0,-1126 # 7958 <malloc+0x1952>
    3dc6:	00002097          	auipc	ra,0x2
    3dca:	182080e7          	jalr	386(ra) # 5f48 <printf>
    exit(1);
    3dce:	4505                	li	a0,1
    3dd0:	00002097          	auipc	ra,0x2
    3dd4:	e00080e7          	jalr	-512(ra) # 5bd0 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3dd8:	85ca                	mv	a1,s2
    3dda:	00004517          	auipc	a0,0x4
    3dde:	81650513          	addi	a0,a0,-2026 # 75f0 <malloc+0x15ea>
    3de2:	00002097          	auipc	ra,0x2
    3de6:	166080e7          	jalr	358(ra) # 5f48 <printf>
    exit(1);
    3dea:	4505                	li	a0,1
    3dec:	00002097          	auipc	ra,0x2
    3df0:	de4080e7          	jalr	-540(ra) # 5bd0 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3df4:	85ca                	mv	a1,s2
    3df6:	00004517          	auipc	a0,0x4
    3dfa:	b8250513          	addi	a0,a0,-1150 # 7978 <malloc+0x1972>
    3dfe:	00002097          	auipc	ra,0x2
    3e02:	14a080e7          	jalr	330(ra) # 5f48 <printf>
    exit(1);
    3e06:	4505                	li	a0,1
    3e08:	00002097          	auipc	ra,0x2
    3e0c:	dc8080e7          	jalr	-568(ra) # 5bd0 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    3e10:	85ca                	mv	a1,s2
    3e12:	00004517          	auipc	a0,0x4
    3e16:	b8650513          	addi	a0,a0,-1146 # 7998 <malloc+0x1992>
    3e1a:	00002097          	auipc	ra,0x2
    3e1e:	12e080e7          	jalr	302(ra) # 5f48 <printf>
    exit(1);
    3e22:	4505                	li	a0,1
    3e24:	00002097          	auipc	ra,0x2
    3e28:	dac080e7          	jalr	-596(ra) # 5bd0 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3e2c:	85ca                	mv	a1,s2
    3e2e:	00004517          	auipc	a0,0x4
    3e32:	b9a50513          	addi	a0,a0,-1126 # 79c8 <malloc+0x19c2>
    3e36:	00002097          	auipc	ra,0x2
    3e3a:	112080e7          	jalr	274(ra) # 5f48 <printf>
    exit(1);
    3e3e:	4505                	li	a0,1
    3e40:	00002097          	auipc	ra,0x2
    3e44:	d90080e7          	jalr	-624(ra) # 5bd0 <exit>
    printf("%s: unlink dd failed\n", s);
    3e48:	85ca                	mv	a1,s2
    3e4a:	00004517          	auipc	a0,0x4
    3e4e:	b9e50513          	addi	a0,a0,-1122 # 79e8 <malloc+0x19e2>
    3e52:	00002097          	auipc	ra,0x2
    3e56:	0f6080e7          	jalr	246(ra) # 5f48 <printf>
    exit(1);
    3e5a:	4505                	li	a0,1
    3e5c:	00002097          	auipc	ra,0x2
    3e60:	d74080e7          	jalr	-652(ra) # 5bd0 <exit>

0000000000003e64 <rmdot>:
{
    3e64:	1101                	addi	sp,sp,-32
    3e66:	ec06                	sd	ra,24(sp)
    3e68:	e822                	sd	s0,16(sp)
    3e6a:	e426                	sd	s1,8(sp)
    3e6c:	1000                	addi	s0,sp,32
    3e6e:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    3e70:	00004517          	auipc	a0,0x4
    3e74:	b9050513          	addi	a0,a0,-1136 # 7a00 <malloc+0x19fa>
    3e78:	00002097          	auipc	ra,0x2
    3e7c:	dc0080e7          	jalr	-576(ra) # 5c38 <mkdir>
    3e80:	e549                	bnez	a0,3f0a <rmdot+0xa6>
  if(chdir("dots") != 0){
    3e82:	00004517          	auipc	a0,0x4
    3e86:	b7e50513          	addi	a0,a0,-1154 # 7a00 <malloc+0x19fa>
    3e8a:	00002097          	auipc	ra,0x2
    3e8e:	db6080e7          	jalr	-586(ra) # 5c40 <chdir>
    3e92:	e951                	bnez	a0,3f26 <rmdot+0xc2>
  if(unlink(".") == 0){
    3e94:	00003517          	auipc	a0,0x3
    3e98:	99c50513          	addi	a0,a0,-1636 # 6830 <malloc+0x82a>
    3e9c:	00002097          	auipc	ra,0x2
    3ea0:	d84080e7          	jalr	-636(ra) # 5c20 <unlink>
    3ea4:	cd59                	beqz	a0,3f42 <rmdot+0xde>
  if(unlink("..") == 0){
    3ea6:	00003517          	auipc	a0,0x3
    3eaa:	5b250513          	addi	a0,a0,1458 # 7458 <malloc+0x1452>
    3eae:	00002097          	auipc	ra,0x2
    3eb2:	d72080e7          	jalr	-654(ra) # 5c20 <unlink>
    3eb6:	c545                	beqz	a0,3f5e <rmdot+0xfa>
  if(chdir("/") != 0){
    3eb8:	00003517          	auipc	a0,0x3
    3ebc:	54850513          	addi	a0,a0,1352 # 7400 <malloc+0x13fa>
    3ec0:	00002097          	auipc	ra,0x2
    3ec4:	d80080e7          	jalr	-640(ra) # 5c40 <chdir>
    3ec8:	e94d                	bnez	a0,3f7a <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3eca:	00004517          	auipc	a0,0x4
    3ece:	b9e50513          	addi	a0,a0,-1122 # 7a68 <malloc+0x1a62>
    3ed2:	00002097          	auipc	ra,0x2
    3ed6:	d4e080e7          	jalr	-690(ra) # 5c20 <unlink>
    3eda:	cd55                	beqz	a0,3f96 <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3edc:	00004517          	auipc	a0,0x4
    3ee0:	bb450513          	addi	a0,a0,-1100 # 7a90 <malloc+0x1a8a>
    3ee4:	00002097          	auipc	ra,0x2
    3ee8:	d3c080e7          	jalr	-708(ra) # 5c20 <unlink>
    3eec:	c179                	beqz	a0,3fb2 <rmdot+0x14e>
  if(unlink("dots") != 0){
    3eee:	00004517          	auipc	a0,0x4
    3ef2:	b1250513          	addi	a0,a0,-1262 # 7a00 <malloc+0x19fa>
    3ef6:	00002097          	auipc	ra,0x2
    3efa:	d2a080e7          	jalr	-726(ra) # 5c20 <unlink>
    3efe:	e961                	bnez	a0,3fce <rmdot+0x16a>
}
    3f00:	60e2                	ld	ra,24(sp)
    3f02:	6442                	ld	s0,16(sp)
    3f04:	64a2                	ld	s1,8(sp)
    3f06:	6105                	addi	sp,sp,32
    3f08:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3f0a:	85a6                	mv	a1,s1
    3f0c:	00004517          	auipc	a0,0x4
    3f10:	afc50513          	addi	a0,a0,-1284 # 7a08 <malloc+0x1a02>
    3f14:	00002097          	auipc	ra,0x2
    3f18:	034080e7          	jalr	52(ra) # 5f48 <printf>
    exit(1);
    3f1c:	4505                	li	a0,1
    3f1e:	00002097          	auipc	ra,0x2
    3f22:	cb2080e7          	jalr	-846(ra) # 5bd0 <exit>
    printf("%s: chdir dots failed\n", s);
    3f26:	85a6                	mv	a1,s1
    3f28:	00004517          	auipc	a0,0x4
    3f2c:	af850513          	addi	a0,a0,-1288 # 7a20 <malloc+0x1a1a>
    3f30:	00002097          	auipc	ra,0x2
    3f34:	018080e7          	jalr	24(ra) # 5f48 <printf>
    exit(1);
    3f38:	4505                	li	a0,1
    3f3a:	00002097          	auipc	ra,0x2
    3f3e:	c96080e7          	jalr	-874(ra) # 5bd0 <exit>
    printf("%s: rm . worked!\n", s);
    3f42:	85a6                	mv	a1,s1
    3f44:	00004517          	auipc	a0,0x4
    3f48:	af450513          	addi	a0,a0,-1292 # 7a38 <malloc+0x1a32>
    3f4c:	00002097          	auipc	ra,0x2
    3f50:	ffc080e7          	jalr	-4(ra) # 5f48 <printf>
    exit(1);
    3f54:	4505                	li	a0,1
    3f56:	00002097          	auipc	ra,0x2
    3f5a:	c7a080e7          	jalr	-902(ra) # 5bd0 <exit>
    printf("%s: rm .. worked!\n", s);
    3f5e:	85a6                	mv	a1,s1
    3f60:	00004517          	auipc	a0,0x4
    3f64:	af050513          	addi	a0,a0,-1296 # 7a50 <malloc+0x1a4a>
    3f68:	00002097          	auipc	ra,0x2
    3f6c:	fe0080e7          	jalr	-32(ra) # 5f48 <printf>
    exit(1);
    3f70:	4505                	li	a0,1
    3f72:	00002097          	auipc	ra,0x2
    3f76:	c5e080e7          	jalr	-930(ra) # 5bd0 <exit>
    printf("%s: chdir / failed\n", s);
    3f7a:	85a6                	mv	a1,s1
    3f7c:	00003517          	auipc	a0,0x3
    3f80:	48c50513          	addi	a0,a0,1164 # 7408 <malloc+0x1402>
    3f84:	00002097          	auipc	ra,0x2
    3f88:	fc4080e7          	jalr	-60(ra) # 5f48 <printf>
    exit(1);
    3f8c:	4505                	li	a0,1
    3f8e:	00002097          	auipc	ra,0x2
    3f92:	c42080e7          	jalr	-958(ra) # 5bd0 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3f96:	85a6                	mv	a1,s1
    3f98:	00004517          	auipc	a0,0x4
    3f9c:	ad850513          	addi	a0,a0,-1320 # 7a70 <malloc+0x1a6a>
    3fa0:	00002097          	auipc	ra,0x2
    3fa4:	fa8080e7          	jalr	-88(ra) # 5f48 <printf>
    exit(1);
    3fa8:	4505                	li	a0,1
    3faa:	00002097          	auipc	ra,0x2
    3fae:	c26080e7          	jalr	-986(ra) # 5bd0 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3fb2:	85a6                	mv	a1,s1
    3fb4:	00004517          	auipc	a0,0x4
    3fb8:	ae450513          	addi	a0,a0,-1308 # 7a98 <malloc+0x1a92>
    3fbc:	00002097          	auipc	ra,0x2
    3fc0:	f8c080e7          	jalr	-116(ra) # 5f48 <printf>
    exit(1);
    3fc4:	4505                	li	a0,1
    3fc6:	00002097          	auipc	ra,0x2
    3fca:	c0a080e7          	jalr	-1014(ra) # 5bd0 <exit>
    printf("%s: unlink dots failed!\n", s);
    3fce:	85a6                	mv	a1,s1
    3fd0:	00004517          	auipc	a0,0x4
    3fd4:	ae850513          	addi	a0,a0,-1304 # 7ab8 <malloc+0x1ab2>
    3fd8:	00002097          	auipc	ra,0x2
    3fdc:	f70080e7          	jalr	-144(ra) # 5f48 <printf>
    exit(1);
    3fe0:	4505                	li	a0,1
    3fe2:	00002097          	auipc	ra,0x2
    3fe6:	bee080e7          	jalr	-1042(ra) # 5bd0 <exit>

0000000000003fea <dirfile>:
{
    3fea:	1101                	addi	sp,sp,-32
    3fec:	ec06                	sd	ra,24(sp)
    3fee:	e822                	sd	s0,16(sp)
    3ff0:	e426                	sd	s1,8(sp)
    3ff2:	e04a                	sd	s2,0(sp)
    3ff4:	1000                	addi	s0,sp,32
    3ff6:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3ff8:	20000593          	li	a1,512
    3ffc:	00004517          	auipc	a0,0x4
    4000:	adc50513          	addi	a0,a0,-1316 # 7ad8 <malloc+0x1ad2>
    4004:	00002097          	auipc	ra,0x2
    4008:	c0c080e7          	jalr	-1012(ra) # 5c10 <open>
  if(fd < 0){
    400c:	0e054d63          	bltz	a0,4106 <dirfile+0x11c>
  close(fd);
    4010:	00002097          	auipc	ra,0x2
    4014:	be8080e7          	jalr	-1048(ra) # 5bf8 <close>
  if(chdir("dirfile") == 0){
    4018:	00004517          	auipc	a0,0x4
    401c:	ac050513          	addi	a0,a0,-1344 # 7ad8 <malloc+0x1ad2>
    4020:	00002097          	auipc	ra,0x2
    4024:	c20080e7          	jalr	-992(ra) # 5c40 <chdir>
    4028:	cd6d                	beqz	a0,4122 <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    402a:	4581                	li	a1,0
    402c:	00004517          	auipc	a0,0x4
    4030:	af450513          	addi	a0,a0,-1292 # 7b20 <malloc+0x1b1a>
    4034:	00002097          	auipc	ra,0x2
    4038:	bdc080e7          	jalr	-1060(ra) # 5c10 <open>
  if(fd >= 0){
    403c:	10055163          	bgez	a0,413e <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    4040:	20000593          	li	a1,512
    4044:	00004517          	auipc	a0,0x4
    4048:	adc50513          	addi	a0,a0,-1316 # 7b20 <malloc+0x1b1a>
    404c:	00002097          	auipc	ra,0x2
    4050:	bc4080e7          	jalr	-1084(ra) # 5c10 <open>
  if(fd >= 0){
    4054:	10055363          	bgez	a0,415a <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    4058:	00004517          	auipc	a0,0x4
    405c:	ac850513          	addi	a0,a0,-1336 # 7b20 <malloc+0x1b1a>
    4060:	00002097          	auipc	ra,0x2
    4064:	bd8080e7          	jalr	-1064(ra) # 5c38 <mkdir>
    4068:	10050763          	beqz	a0,4176 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    406c:	00004517          	auipc	a0,0x4
    4070:	ab450513          	addi	a0,a0,-1356 # 7b20 <malloc+0x1b1a>
    4074:	00002097          	auipc	ra,0x2
    4078:	bac080e7          	jalr	-1108(ra) # 5c20 <unlink>
    407c:	10050b63          	beqz	a0,4192 <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    4080:	00004597          	auipc	a1,0x4
    4084:	aa058593          	addi	a1,a1,-1376 # 7b20 <malloc+0x1b1a>
    4088:	00002517          	auipc	a0,0x2
    408c:	29850513          	addi	a0,a0,664 # 6320 <malloc+0x31a>
    4090:	00002097          	auipc	ra,0x2
    4094:	ba0080e7          	jalr	-1120(ra) # 5c30 <link>
    4098:	10050b63          	beqz	a0,41ae <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    409c:	00004517          	auipc	a0,0x4
    40a0:	a3c50513          	addi	a0,a0,-1476 # 7ad8 <malloc+0x1ad2>
    40a4:	00002097          	auipc	ra,0x2
    40a8:	b7c080e7          	jalr	-1156(ra) # 5c20 <unlink>
    40ac:	10051f63          	bnez	a0,41ca <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    40b0:	4589                	li	a1,2
    40b2:	00002517          	auipc	a0,0x2
    40b6:	77e50513          	addi	a0,a0,1918 # 6830 <malloc+0x82a>
    40ba:	00002097          	auipc	ra,0x2
    40be:	b56080e7          	jalr	-1194(ra) # 5c10 <open>
  if(fd >= 0){
    40c2:	12055263          	bgez	a0,41e6 <dirfile+0x1fc>
  fd = open(".", 0);
    40c6:	4581                	li	a1,0
    40c8:	00002517          	auipc	a0,0x2
    40cc:	76850513          	addi	a0,a0,1896 # 6830 <malloc+0x82a>
    40d0:	00002097          	auipc	ra,0x2
    40d4:	b40080e7          	jalr	-1216(ra) # 5c10 <open>
    40d8:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    40da:	4605                	li	a2,1
    40dc:	00002597          	auipc	a1,0x2
    40e0:	0dc58593          	addi	a1,a1,220 # 61b8 <malloc+0x1b2>
    40e4:	00002097          	auipc	ra,0x2
    40e8:	b0c080e7          	jalr	-1268(ra) # 5bf0 <write>
    40ec:	10a04b63          	bgtz	a0,4202 <dirfile+0x218>
  close(fd);
    40f0:	8526                	mv	a0,s1
    40f2:	00002097          	auipc	ra,0x2
    40f6:	b06080e7          	jalr	-1274(ra) # 5bf8 <close>
}
    40fa:	60e2                	ld	ra,24(sp)
    40fc:	6442                	ld	s0,16(sp)
    40fe:	64a2                	ld	s1,8(sp)
    4100:	6902                	ld	s2,0(sp)
    4102:	6105                	addi	sp,sp,32
    4104:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    4106:	85ca                	mv	a1,s2
    4108:	00004517          	auipc	a0,0x4
    410c:	9d850513          	addi	a0,a0,-1576 # 7ae0 <malloc+0x1ada>
    4110:	00002097          	auipc	ra,0x2
    4114:	e38080e7          	jalr	-456(ra) # 5f48 <printf>
    exit(1);
    4118:	4505                	li	a0,1
    411a:	00002097          	auipc	ra,0x2
    411e:	ab6080e7          	jalr	-1354(ra) # 5bd0 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    4122:	85ca                	mv	a1,s2
    4124:	00004517          	auipc	a0,0x4
    4128:	9dc50513          	addi	a0,a0,-1572 # 7b00 <malloc+0x1afa>
    412c:	00002097          	auipc	ra,0x2
    4130:	e1c080e7          	jalr	-484(ra) # 5f48 <printf>
    exit(1);
    4134:	4505                	li	a0,1
    4136:	00002097          	auipc	ra,0x2
    413a:	a9a080e7          	jalr	-1382(ra) # 5bd0 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    413e:	85ca                	mv	a1,s2
    4140:	00004517          	auipc	a0,0x4
    4144:	9f050513          	addi	a0,a0,-1552 # 7b30 <malloc+0x1b2a>
    4148:	00002097          	auipc	ra,0x2
    414c:	e00080e7          	jalr	-512(ra) # 5f48 <printf>
    exit(1);
    4150:	4505                	li	a0,1
    4152:	00002097          	auipc	ra,0x2
    4156:	a7e080e7          	jalr	-1410(ra) # 5bd0 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    415a:	85ca                	mv	a1,s2
    415c:	00004517          	auipc	a0,0x4
    4160:	9d450513          	addi	a0,a0,-1580 # 7b30 <malloc+0x1b2a>
    4164:	00002097          	auipc	ra,0x2
    4168:	de4080e7          	jalr	-540(ra) # 5f48 <printf>
    exit(1);
    416c:	4505                	li	a0,1
    416e:	00002097          	auipc	ra,0x2
    4172:	a62080e7          	jalr	-1438(ra) # 5bd0 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    4176:	85ca                	mv	a1,s2
    4178:	00004517          	auipc	a0,0x4
    417c:	9e050513          	addi	a0,a0,-1568 # 7b58 <malloc+0x1b52>
    4180:	00002097          	auipc	ra,0x2
    4184:	dc8080e7          	jalr	-568(ra) # 5f48 <printf>
    exit(1);
    4188:	4505                	li	a0,1
    418a:	00002097          	auipc	ra,0x2
    418e:	a46080e7          	jalr	-1466(ra) # 5bd0 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    4192:	85ca                	mv	a1,s2
    4194:	00004517          	auipc	a0,0x4
    4198:	9ec50513          	addi	a0,a0,-1556 # 7b80 <malloc+0x1b7a>
    419c:	00002097          	auipc	ra,0x2
    41a0:	dac080e7          	jalr	-596(ra) # 5f48 <printf>
    exit(1);
    41a4:	4505                	li	a0,1
    41a6:	00002097          	auipc	ra,0x2
    41aa:	a2a080e7          	jalr	-1494(ra) # 5bd0 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    41ae:	85ca                	mv	a1,s2
    41b0:	00004517          	auipc	a0,0x4
    41b4:	9f850513          	addi	a0,a0,-1544 # 7ba8 <malloc+0x1ba2>
    41b8:	00002097          	auipc	ra,0x2
    41bc:	d90080e7          	jalr	-624(ra) # 5f48 <printf>
    exit(1);
    41c0:	4505                	li	a0,1
    41c2:	00002097          	auipc	ra,0x2
    41c6:	a0e080e7          	jalr	-1522(ra) # 5bd0 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    41ca:	85ca                	mv	a1,s2
    41cc:	00004517          	auipc	a0,0x4
    41d0:	a0450513          	addi	a0,a0,-1532 # 7bd0 <malloc+0x1bca>
    41d4:	00002097          	auipc	ra,0x2
    41d8:	d74080e7          	jalr	-652(ra) # 5f48 <printf>
    exit(1);
    41dc:	4505                	li	a0,1
    41de:	00002097          	auipc	ra,0x2
    41e2:	9f2080e7          	jalr	-1550(ra) # 5bd0 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    41e6:	85ca                	mv	a1,s2
    41e8:	00004517          	auipc	a0,0x4
    41ec:	a0850513          	addi	a0,a0,-1528 # 7bf0 <malloc+0x1bea>
    41f0:	00002097          	auipc	ra,0x2
    41f4:	d58080e7          	jalr	-680(ra) # 5f48 <printf>
    exit(1);
    41f8:	4505                	li	a0,1
    41fa:	00002097          	auipc	ra,0x2
    41fe:	9d6080e7          	jalr	-1578(ra) # 5bd0 <exit>
    printf("%s: write . succeeded!\n", s);
    4202:	85ca                	mv	a1,s2
    4204:	00004517          	auipc	a0,0x4
    4208:	a1450513          	addi	a0,a0,-1516 # 7c18 <malloc+0x1c12>
    420c:	00002097          	auipc	ra,0x2
    4210:	d3c080e7          	jalr	-708(ra) # 5f48 <printf>
    exit(1);
    4214:	4505                	li	a0,1
    4216:	00002097          	auipc	ra,0x2
    421a:	9ba080e7          	jalr	-1606(ra) # 5bd0 <exit>

000000000000421e <iref>:
{
    421e:	7139                	addi	sp,sp,-64
    4220:	fc06                	sd	ra,56(sp)
    4222:	f822                	sd	s0,48(sp)
    4224:	f426                	sd	s1,40(sp)
    4226:	f04a                	sd	s2,32(sp)
    4228:	ec4e                	sd	s3,24(sp)
    422a:	e852                	sd	s4,16(sp)
    422c:	e456                	sd	s5,8(sp)
    422e:	e05a                	sd	s6,0(sp)
    4230:	0080                	addi	s0,sp,64
    4232:	8b2a                	mv	s6,a0
    4234:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    4238:	00004a17          	auipc	s4,0x4
    423c:	9f8a0a13          	addi	s4,s4,-1544 # 7c30 <malloc+0x1c2a>
    mkdir("");
    4240:	00003497          	auipc	s1,0x3
    4244:	4f848493          	addi	s1,s1,1272 # 7738 <malloc+0x1732>
    link("README", "");
    4248:	00002a97          	auipc	s5,0x2
    424c:	0d8a8a93          	addi	s5,s5,216 # 6320 <malloc+0x31a>
    fd = open("xx", O_CREATE);
    4250:	00004997          	auipc	s3,0x4
    4254:	8d898993          	addi	s3,s3,-1832 # 7b28 <malloc+0x1b22>
    4258:	a891                	j	42ac <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    425a:	85da                	mv	a1,s6
    425c:	00004517          	auipc	a0,0x4
    4260:	9dc50513          	addi	a0,a0,-1572 # 7c38 <malloc+0x1c32>
    4264:	00002097          	auipc	ra,0x2
    4268:	ce4080e7          	jalr	-796(ra) # 5f48 <printf>
      exit(1);
    426c:	4505                	li	a0,1
    426e:	00002097          	auipc	ra,0x2
    4272:	962080e7          	jalr	-1694(ra) # 5bd0 <exit>
      printf("%s: chdir irefd failed\n", s);
    4276:	85da                	mv	a1,s6
    4278:	00004517          	auipc	a0,0x4
    427c:	9d850513          	addi	a0,a0,-1576 # 7c50 <malloc+0x1c4a>
    4280:	00002097          	auipc	ra,0x2
    4284:	cc8080e7          	jalr	-824(ra) # 5f48 <printf>
      exit(1);
    4288:	4505                	li	a0,1
    428a:	00002097          	auipc	ra,0x2
    428e:	946080e7          	jalr	-1722(ra) # 5bd0 <exit>
      close(fd);
    4292:	00002097          	auipc	ra,0x2
    4296:	966080e7          	jalr	-1690(ra) # 5bf8 <close>
    429a:	a889                	j	42ec <iref+0xce>
    unlink("xx");
    429c:	854e                	mv	a0,s3
    429e:	00002097          	auipc	ra,0x2
    42a2:	982080e7          	jalr	-1662(ra) # 5c20 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    42a6:	397d                	addiw	s2,s2,-1
    42a8:	06090063          	beqz	s2,4308 <iref+0xea>
    if(mkdir("irefd") != 0){
    42ac:	8552                	mv	a0,s4
    42ae:	00002097          	auipc	ra,0x2
    42b2:	98a080e7          	jalr	-1654(ra) # 5c38 <mkdir>
    42b6:	f155                	bnez	a0,425a <iref+0x3c>
    if(chdir("irefd") != 0){
    42b8:	8552                	mv	a0,s4
    42ba:	00002097          	auipc	ra,0x2
    42be:	986080e7          	jalr	-1658(ra) # 5c40 <chdir>
    42c2:	f955                	bnez	a0,4276 <iref+0x58>
    mkdir("");
    42c4:	8526                	mv	a0,s1
    42c6:	00002097          	auipc	ra,0x2
    42ca:	972080e7          	jalr	-1678(ra) # 5c38 <mkdir>
    link("README", "");
    42ce:	85a6                	mv	a1,s1
    42d0:	8556                	mv	a0,s5
    42d2:	00002097          	auipc	ra,0x2
    42d6:	95e080e7          	jalr	-1698(ra) # 5c30 <link>
    fd = open("", O_CREATE);
    42da:	20000593          	li	a1,512
    42de:	8526                	mv	a0,s1
    42e0:	00002097          	auipc	ra,0x2
    42e4:	930080e7          	jalr	-1744(ra) # 5c10 <open>
    if(fd >= 0)
    42e8:	fa0555e3          	bgez	a0,4292 <iref+0x74>
    fd = open("xx", O_CREATE);
    42ec:	20000593          	li	a1,512
    42f0:	854e                	mv	a0,s3
    42f2:	00002097          	auipc	ra,0x2
    42f6:	91e080e7          	jalr	-1762(ra) # 5c10 <open>
    if(fd >= 0)
    42fa:	fa0541e3          	bltz	a0,429c <iref+0x7e>
      close(fd);
    42fe:	00002097          	auipc	ra,0x2
    4302:	8fa080e7          	jalr	-1798(ra) # 5bf8 <close>
    4306:	bf59                	j	429c <iref+0x7e>
    4308:	03300493          	li	s1,51
    chdir("..");
    430c:	00003997          	auipc	s3,0x3
    4310:	14c98993          	addi	s3,s3,332 # 7458 <malloc+0x1452>
    unlink("irefd");
    4314:	00004917          	auipc	s2,0x4
    4318:	91c90913          	addi	s2,s2,-1764 # 7c30 <malloc+0x1c2a>
    chdir("..");
    431c:	854e                	mv	a0,s3
    431e:	00002097          	auipc	ra,0x2
    4322:	922080e7          	jalr	-1758(ra) # 5c40 <chdir>
    unlink("irefd");
    4326:	854a                	mv	a0,s2
    4328:	00002097          	auipc	ra,0x2
    432c:	8f8080e7          	jalr	-1800(ra) # 5c20 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    4330:	34fd                	addiw	s1,s1,-1
    4332:	f4ed                	bnez	s1,431c <iref+0xfe>
  chdir("/");
    4334:	00003517          	auipc	a0,0x3
    4338:	0cc50513          	addi	a0,a0,204 # 7400 <malloc+0x13fa>
    433c:	00002097          	auipc	ra,0x2
    4340:	904080e7          	jalr	-1788(ra) # 5c40 <chdir>
}
    4344:	70e2                	ld	ra,56(sp)
    4346:	7442                	ld	s0,48(sp)
    4348:	74a2                	ld	s1,40(sp)
    434a:	7902                	ld	s2,32(sp)
    434c:	69e2                	ld	s3,24(sp)
    434e:	6a42                	ld	s4,16(sp)
    4350:	6aa2                	ld	s5,8(sp)
    4352:	6b02                	ld	s6,0(sp)
    4354:	6121                	addi	sp,sp,64
    4356:	8082                	ret

0000000000004358 <openiputtest>:
{
    4358:	7179                	addi	sp,sp,-48
    435a:	f406                	sd	ra,40(sp)
    435c:	f022                	sd	s0,32(sp)
    435e:	ec26                	sd	s1,24(sp)
    4360:	1800                	addi	s0,sp,48
    4362:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    4364:	00004517          	auipc	a0,0x4
    4368:	90450513          	addi	a0,a0,-1788 # 7c68 <malloc+0x1c62>
    436c:	00002097          	auipc	ra,0x2
    4370:	8cc080e7          	jalr	-1844(ra) # 5c38 <mkdir>
    4374:	04054263          	bltz	a0,43b8 <openiputtest+0x60>
  pid = fork();
    4378:	00002097          	auipc	ra,0x2
    437c:	850080e7          	jalr	-1968(ra) # 5bc8 <fork>
  if(pid < 0){
    4380:	04054a63          	bltz	a0,43d4 <openiputtest+0x7c>
  if(pid == 0){
    4384:	e93d                	bnez	a0,43fa <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    4386:	4589                	li	a1,2
    4388:	00004517          	auipc	a0,0x4
    438c:	8e050513          	addi	a0,a0,-1824 # 7c68 <malloc+0x1c62>
    4390:	00002097          	auipc	ra,0x2
    4394:	880080e7          	jalr	-1920(ra) # 5c10 <open>
    if(fd >= 0){
    4398:	04054c63          	bltz	a0,43f0 <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    439c:	85a6                	mv	a1,s1
    439e:	00004517          	auipc	a0,0x4
    43a2:	8ea50513          	addi	a0,a0,-1814 # 7c88 <malloc+0x1c82>
    43a6:	00002097          	auipc	ra,0x2
    43aa:	ba2080e7          	jalr	-1118(ra) # 5f48 <printf>
      exit(1);
    43ae:	4505                	li	a0,1
    43b0:	00002097          	auipc	ra,0x2
    43b4:	820080e7          	jalr	-2016(ra) # 5bd0 <exit>
    printf("%s: mkdir oidir failed\n", s);
    43b8:	85a6                	mv	a1,s1
    43ba:	00004517          	auipc	a0,0x4
    43be:	8b650513          	addi	a0,a0,-1866 # 7c70 <malloc+0x1c6a>
    43c2:	00002097          	auipc	ra,0x2
    43c6:	b86080e7          	jalr	-1146(ra) # 5f48 <printf>
    exit(1);
    43ca:	4505                	li	a0,1
    43cc:	00002097          	auipc	ra,0x2
    43d0:	804080e7          	jalr	-2044(ra) # 5bd0 <exit>
    printf("%s: fork failed\n", s);
    43d4:	85a6                	mv	a1,s1
    43d6:	00002517          	auipc	a0,0x2
    43da:	5fa50513          	addi	a0,a0,1530 # 69d0 <malloc+0x9ca>
    43de:	00002097          	auipc	ra,0x2
    43e2:	b6a080e7          	jalr	-1174(ra) # 5f48 <printf>
    exit(1);
    43e6:	4505                	li	a0,1
    43e8:	00001097          	auipc	ra,0x1
    43ec:	7e8080e7          	jalr	2024(ra) # 5bd0 <exit>
    exit(0);
    43f0:	4501                	li	a0,0
    43f2:	00001097          	auipc	ra,0x1
    43f6:	7de080e7          	jalr	2014(ra) # 5bd0 <exit>
  sleep(1);
    43fa:	4505                	li	a0,1
    43fc:	00002097          	auipc	ra,0x2
    4400:	864080e7          	jalr	-1948(ra) # 5c60 <sleep>
  if(unlink("oidir") != 0){
    4404:	00004517          	auipc	a0,0x4
    4408:	86450513          	addi	a0,a0,-1948 # 7c68 <malloc+0x1c62>
    440c:	00002097          	auipc	ra,0x2
    4410:	814080e7          	jalr	-2028(ra) # 5c20 <unlink>
    4414:	cd19                	beqz	a0,4432 <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    4416:	85a6                	mv	a1,s1
    4418:	00002517          	auipc	a0,0x2
    441c:	7a850513          	addi	a0,a0,1960 # 6bc0 <malloc+0xbba>
    4420:	00002097          	auipc	ra,0x2
    4424:	b28080e7          	jalr	-1240(ra) # 5f48 <printf>
    exit(1);
    4428:	4505                	li	a0,1
    442a:	00001097          	auipc	ra,0x1
    442e:	7a6080e7          	jalr	1958(ra) # 5bd0 <exit>
  wait(&xstatus);
    4432:	fdc40513          	addi	a0,s0,-36
    4436:	00001097          	auipc	ra,0x1
    443a:	7a2080e7          	jalr	1954(ra) # 5bd8 <wait>
  exit(xstatus);
    443e:	fdc42503          	lw	a0,-36(s0)
    4442:	00001097          	auipc	ra,0x1
    4446:	78e080e7          	jalr	1934(ra) # 5bd0 <exit>

000000000000444a <forkforkfork>:
{
    444a:	1101                	addi	sp,sp,-32
    444c:	ec06                	sd	ra,24(sp)
    444e:	e822                	sd	s0,16(sp)
    4450:	e426                	sd	s1,8(sp)
    4452:	1000                	addi	s0,sp,32
    4454:	84aa                	mv	s1,a0
  unlink("stopforking");
    4456:	00004517          	auipc	a0,0x4
    445a:	85a50513          	addi	a0,a0,-1958 # 7cb0 <malloc+0x1caa>
    445e:	00001097          	auipc	ra,0x1
    4462:	7c2080e7          	jalr	1986(ra) # 5c20 <unlink>
  int pid = fork();
    4466:	00001097          	auipc	ra,0x1
    446a:	762080e7          	jalr	1890(ra) # 5bc8 <fork>
  if(pid < 0){
    446e:	04054563          	bltz	a0,44b8 <forkforkfork+0x6e>
  if(pid == 0){
    4472:	c12d                	beqz	a0,44d4 <forkforkfork+0x8a>
  sleep(20); // two seconds
    4474:	4551                	li	a0,20
    4476:	00001097          	auipc	ra,0x1
    447a:	7ea080e7          	jalr	2026(ra) # 5c60 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    447e:	20200593          	li	a1,514
    4482:	00004517          	auipc	a0,0x4
    4486:	82e50513          	addi	a0,a0,-2002 # 7cb0 <malloc+0x1caa>
    448a:	00001097          	auipc	ra,0x1
    448e:	786080e7          	jalr	1926(ra) # 5c10 <open>
    4492:	00001097          	auipc	ra,0x1
    4496:	766080e7          	jalr	1894(ra) # 5bf8 <close>
  wait(0);
    449a:	4501                	li	a0,0
    449c:	00001097          	auipc	ra,0x1
    44a0:	73c080e7          	jalr	1852(ra) # 5bd8 <wait>
  sleep(10); // one second
    44a4:	4529                	li	a0,10
    44a6:	00001097          	auipc	ra,0x1
    44aa:	7ba080e7          	jalr	1978(ra) # 5c60 <sleep>
}
    44ae:	60e2                	ld	ra,24(sp)
    44b0:	6442                	ld	s0,16(sp)
    44b2:	64a2                	ld	s1,8(sp)
    44b4:	6105                	addi	sp,sp,32
    44b6:	8082                	ret
    printf("%s: fork failed", s);
    44b8:	85a6                	mv	a1,s1
    44ba:	00002517          	auipc	a0,0x2
    44be:	6d650513          	addi	a0,a0,1750 # 6b90 <malloc+0xb8a>
    44c2:	00002097          	auipc	ra,0x2
    44c6:	a86080e7          	jalr	-1402(ra) # 5f48 <printf>
    exit(1);
    44ca:	4505                	li	a0,1
    44cc:	00001097          	auipc	ra,0x1
    44d0:	704080e7          	jalr	1796(ra) # 5bd0 <exit>
      int fd = open("stopforking", 0);
    44d4:	00003497          	auipc	s1,0x3
    44d8:	7dc48493          	addi	s1,s1,2012 # 7cb0 <malloc+0x1caa>
    44dc:	4581                	li	a1,0
    44de:	8526                	mv	a0,s1
    44e0:	00001097          	auipc	ra,0x1
    44e4:	730080e7          	jalr	1840(ra) # 5c10 <open>
      if(fd >= 0){
    44e8:	02055463          	bgez	a0,4510 <forkforkfork+0xc6>
      if(fork() < 0){
    44ec:	00001097          	auipc	ra,0x1
    44f0:	6dc080e7          	jalr	1756(ra) # 5bc8 <fork>
    44f4:	fe0554e3          	bgez	a0,44dc <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    44f8:	20200593          	li	a1,514
    44fc:	8526                	mv	a0,s1
    44fe:	00001097          	auipc	ra,0x1
    4502:	712080e7          	jalr	1810(ra) # 5c10 <open>
    4506:	00001097          	auipc	ra,0x1
    450a:	6f2080e7          	jalr	1778(ra) # 5bf8 <close>
    450e:	b7f9                	j	44dc <forkforkfork+0x92>
        exit(0);
    4510:	4501                	li	a0,0
    4512:	00001097          	auipc	ra,0x1
    4516:	6be080e7          	jalr	1726(ra) # 5bd0 <exit>

000000000000451a <killstatus>:
{
    451a:	7139                	addi	sp,sp,-64
    451c:	fc06                	sd	ra,56(sp)
    451e:	f822                	sd	s0,48(sp)
    4520:	f426                	sd	s1,40(sp)
    4522:	f04a                	sd	s2,32(sp)
    4524:	ec4e                	sd	s3,24(sp)
    4526:	e852                	sd	s4,16(sp)
    4528:	0080                	addi	s0,sp,64
    452a:	8a2a                	mv	s4,a0
    452c:	06400913          	li	s2,100
    if(xst != -1) {
    4530:	59fd                	li	s3,-1
    int pid1 = fork();
    4532:	00001097          	auipc	ra,0x1
    4536:	696080e7          	jalr	1686(ra) # 5bc8 <fork>
    453a:	84aa                	mv	s1,a0
    if(pid1 < 0){
    453c:	02054f63          	bltz	a0,457a <killstatus+0x60>
    if(pid1 == 0){
    4540:	c939                	beqz	a0,4596 <killstatus+0x7c>
    sleep(1);
    4542:	4505                	li	a0,1
    4544:	00001097          	auipc	ra,0x1
    4548:	71c080e7          	jalr	1820(ra) # 5c60 <sleep>
    kill(pid1);
    454c:	8526                	mv	a0,s1
    454e:	00001097          	auipc	ra,0x1
    4552:	6b2080e7          	jalr	1714(ra) # 5c00 <kill>
    wait(&xst);
    4556:	fcc40513          	addi	a0,s0,-52
    455a:	00001097          	auipc	ra,0x1
    455e:	67e080e7          	jalr	1662(ra) # 5bd8 <wait>
    if(xst != -1) {
    4562:	fcc42783          	lw	a5,-52(s0)
    4566:	03379d63          	bne	a5,s3,45a0 <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    456a:	397d                	addiw	s2,s2,-1
    456c:	fc0913e3          	bnez	s2,4532 <killstatus+0x18>
  exit(0);
    4570:	4501                	li	a0,0
    4572:	00001097          	auipc	ra,0x1
    4576:	65e080e7          	jalr	1630(ra) # 5bd0 <exit>
      printf("%s: fork failed\n", s);
    457a:	85d2                	mv	a1,s4
    457c:	00002517          	auipc	a0,0x2
    4580:	45450513          	addi	a0,a0,1108 # 69d0 <malloc+0x9ca>
    4584:	00002097          	auipc	ra,0x2
    4588:	9c4080e7          	jalr	-1596(ra) # 5f48 <printf>
      exit(1);
    458c:	4505                	li	a0,1
    458e:	00001097          	auipc	ra,0x1
    4592:	642080e7          	jalr	1602(ra) # 5bd0 <exit>
        getpid();
    4596:	00001097          	auipc	ra,0x1
    459a:	6ba080e7          	jalr	1722(ra) # 5c50 <getpid>
      while(1) {
    459e:	bfe5                	j	4596 <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    45a0:	85d2                	mv	a1,s4
    45a2:	00003517          	auipc	a0,0x3
    45a6:	71e50513          	addi	a0,a0,1822 # 7cc0 <malloc+0x1cba>
    45aa:	00002097          	auipc	ra,0x2
    45ae:	99e080e7          	jalr	-1634(ra) # 5f48 <printf>
       exit(1);
    45b2:	4505                	li	a0,1
    45b4:	00001097          	auipc	ra,0x1
    45b8:	61c080e7          	jalr	1564(ra) # 5bd0 <exit>

00000000000045bc <preempt>:
{
    45bc:	7139                	addi	sp,sp,-64
    45be:	fc06                	sd	ra,56(sp)
    45c0:	f822                	sd	s0,48(sp)
    45c2:	f426                	sd	s1,40(sp)
    45c4:	f04a                	sd	s2,32(sp)
    45c6:	ec4e                	sd	s3,24(sp)
    45c8:	e852                	sd	s4,16(sp)
    45ca:	0080                	addi	s0,sp,64
    45cc:	84aa                	mv	s1,a0
  pid1 = fork();
    45ce:	00001097          	auipc	ra,0x1
    45d2:	5fa080e7          	jalr	1530(ra) # 5bc8 <fork>
  if(pid1 < 0) {
    45d6:	00054563          	bltz	a0,45e0 <preempt+0x24>
    45da:	8a2a                	mv	s4,a0
  if(pid1 == 0)
    45dc:	e105                	bnez	a0,45fc <preempt+0x40>
    for(;;)
    45de:	a001                	j	45de <preempt+0x22>
    printf("%s: fork failed", s);
    45e0:	85a6                	mv	a1,s1
    45e2:	00002517          	auipc	a0,0x2
    45e6:	5ae50513          	addi	a0,a0,1454 # 6b90 <malloc+0xb8a>
    45ea:	00002097          	auipc	ra,0x2
    45ee:	95e080e7          	jalr	-1698(ra) # 5f48 <printf>
    exit(1);
    45f2:	4505                	li	a0,1
    45f4:	00001097          	auipc	ra,0x1
    45f8:	5dc080e7          	jalr	1500(ra) # 5bd0 <exit>
  pid2 = fork();
    45fc:	00001097          	auipc	ra,0x1
    4600:	5cc080e7          	jalr	1484(ra) # 5bc8 <fork>
    4604:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    4606:	00054463          	bltz	a0,460e <preempt+0x52>
  if(pid2 == 0)
    460a:	e105                	bnez	a0,462a <preempt+0x6e>
    for(;;)
    460c:	a001                	j	460c <preempt+0x50>
    printf("%s: fork failed\n", s);
    460e:	85a6                	mv	a1,s1
    4610:	00002517          	auipc	a0,0x2
    4614:	3c050513          	addi	a0,a0,960 # 69d0 <malloc+0x9ca>
    4618:	00002097          	auipc	ra,0x2
    461c:	930080e7          	jalr	-1744(ra) # 5f48 <printf>
    exit(1);
    4620:	4505                	li	a0,1
    4622:	00001097          	auipc	ra,0x1
    4626:	5ae080e7          	jalr	1454(ra) # 5bd0 <exit>
  pipe(pfds);
    462a:	fc840513          	addi	a0,s0,-56
    462e:	00001097          	auipc	ra,0x1
    4632:	5b2080e7          	jalr	1458(ra) # 5be0 <pipe>
  pid3 = fork();
    4636:	00001097          	auipc	ra,0x1
    463a:	592080e7          	jalr	1426(ra) # 5bc8 <fork>
    463e:	892a                	mv	s2,a0
  if(pid3 < 0) {
    4640:	02054e63          	bltz	a0,467c <preempt+0xc0>
  if(pid3 == 0){
    4644:	e525                	bnez	a0,46ac <preempt+0xf0>
    close(pfds[0]);
    4646:	fc842503          	lw	a0,-56(s0)
    464a:	00001097          	auipc	ra,0x1
    464e:	5ae080e7          	jalr	1454(ra) # 5bf8 <close>
    if(write(pfds[1], "x", 1) != 1)
    4652:	4605                	li	a2,1
    4654:	00002597          	auipc	a1,0x2
    4658:	b6458593          	addi	a1,a1,-1180 # 61b8 <malloc+0x1b2>
    465c:	fcc42503          	lw	a0,-52(s0)
    4660:	00001097          	auipc	ra,0x1
    4664:	590080e7          	jalr	1424(ra) # 5bf0 <write>
    4668:	4785                	li	a5,1
    466a:	02f51763          	bne	a0,a5,4698 <preempt+0xdc>
    close(pfds[1]);
    466e:	fcc42503          	lw	a0,-52(s0)
    4672:	00001097          	auipc	ra,0x1
    4676:	586080e7          	jalr	1414(ra) # 5bf8 <close>
    for(;;)
    467a:	a001                	j	467a <preempt+0xbe>
     printf("%s: fork failed\n", s);
    467c:	85a6                	mv	a1,s1
    467e:	00002517          	auipc	a0,0x2
    4682:	35250513          	addi	a0,a0,850 # 69d0 <malloc+0x9ca>
    4686:	00002097          	auipc	ra,0x2
    468a:	8c2080e7          	jalr	-1854(ra) # 5f48 <printf>
     exit(1);
    468e:	4505                	li	a0,1
    4690:	00001097          	auipc	ra,0x1
    4694:	540080e7          	jalr	1344(ra) # 5bd0 <exit>
      printf("%s: preempt write error", s);
    4698:	85a6                	mv	a1,s1
    469a:	00003517          	auipc	a0,0x3
    469e:	64650513          	addi	a0,a0,1606 # 7ce0 <malloc+0x1cda>
    46a2:	00002097          	auipc	ra,0x2
    46a6:	8a6080e7          	jalr	-1882(ra) # 5f48 <printf>
    46aa:	b7d1                	j	466e <preempt+0xb2>
  close(pfds[1]);
    46ac:	fcc42503          	lw	a0,-52(s0)
    46b0:	00001097          	auipc	ra,0x1
    46b4:	548080e7          	jalr	1352(ra) # 5bf8 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    46b8:	660d                	lui	a2,0x3
    46ba:	00008597          	auipc	a1,0x8
    46be:	5be58593          	addi	a1,a1,1470 # cc78 <buf>
    46c2:	fc842503          	lw	a0,-56(s0)
    46c6:	00001097          	auipc	ra,0x1
    46ca:	522080e7          	jalr	1314(ra) # 5be8 <read>
    46ce:	4785                	li	a5,1
    46d0:	02f50363          	beq	a0,a5,46f6 <preempt+0x13a>
    printf("%s: preempt read error", s);
    46d4:	85a6                	mv	a1,s1
    46d6:	00003517          	auipc	a0,0x3
    46da:	62250513          	addi	a0,a0,1570 # 7cf8 <malloc+0x1cf2>
    46de:	00002097          	auipc	ra,0x2
    46e2:	86a080e7          	jalr	-1942(ra) # 5f48 <printf>
}
    46e6:	70e2                	ld	ra,56(sp)
    46e8:	7442                	ld	s0,48(sp)
    46ea:	74a2                	ld	s1,40(sp)
    46ec:	7902                	ld	s2,32(sp)
    46ee:	69e2                	ld	s3,24(sp)
    46f0:	6a42                	ld	s4,16(sp)
    46f2:	6121                	addi	sp,sp,64
    46f4:	8082                	ret
  close(pfds[0]);
    46f6:	fc842503          	lw	a0,-56(s0)
    46fa:	00001097          	auipc	ra,0x1
    46fe:	4fe080e7          	jalr	1278(ra) # 5bf8 <close>
  printf("kill... ");
    4702:	00003517          	auipc	a0,0x3
    4706:	60e50513          	addi	a0,a0,1550 # 7d10 <malloc+0x1d0a>
    470a:	00002097          	auipc	ra,0x2
    470e:	83e080e7          	jalr	-1986(ra) # 5f48 <printf>
  kill(pid1);
    4712:	8552                	mv	a0,s4
    4714:	00001097          	auipc	ra,0x1
    4718:	4ec080e7          	jalr	1260(ra) # 5c00 <kill>
  kill(pid2);
    471c:	854e                	mv	a0,s3
    471e:	00001097          	auipc	ra,0x1
    4722:	4e2080e7          	jalr	1250(ra) # 5c00 <kill>
  kill(pid3);
    4726:	854a                	mv	a0,s2
    4728:	00001097          	auipc	ra,0x1
    472c:	4d8080e7          	jalr	1240(ra) # 5c00 <kill>
  printf("wait... ");
    4730:	00003517          	auipc	a0,0x3
    4734:	5f050513          	addi	a0,a0,1520 # 7d20 <malloc+0x1d1a>
    4738:	00002097          	auipc	ra,0x2
    473c:	810080e7          	jalr	-2032(ra) # 5f48 <printf>
  wait(0);
    4740:	4501                	li	a0,0
    4742:	00001097          	auipc	ra,0x1
    4746:	496080e7          	jalr	1174(ra) # 5bd8 <wait>
  wait(0);
    474a:	4501                	li	a0,0
    474c:	00001097          	auipc	ra,0x1
    4750:	48c080e7          	jalr	1164(ra) # 5bd8 <wait>
  wait(0);
    4754:	4501                	li	a0,0
    4756:	00001097          	auipc	ra,0x1
    475a:	482080e7          	jalr	1154(ra) # 5bd8 <wait>
    475e:	b761                	j	46e6 <preempt+0x12a>

0000000000004760 <reparent>:
{
    4760:	7179                	addi	sp,sp,-48
    4762:	f406                	sd	ra,40(sp)
    4764:	f022                	sd	s0,32(sp)
    4766:	ec26                	sd	s1,24(sp)
    4768:	e84a                	sd	s2,16(sp)
    476a:	e44e                	sd	s3,8(sp)
    476c:	e052                	sd	s4,0(sp)
    476e:	1800                	addi	s0,sp,48
    4770:	89aa                	mv	s3,a0
  int master_pid = getpid();
    4772:	00001097          	auipc	ra,0x1
    4776:	4de080e7          	jalr	1246(ra) # 5c50 <getpid>
    477a:	8a2a                	mv	s4,a0
    477c:	0c800913          	li	s2,200
    int pid = fork();
    4780:	00001097          	auipc	ra,0x1
    4784:	448080e7          	jalr	1096(ra) # 5bc8 <fork>
    4788:	84aa                	mv	s1,a0
    if(pid < 0){
    478a:	02054263          	bltz	a0,47ae <reparent+0x4e>
    if(pid){
    478e:	cd21                	beqz	a0,47e6 <reparent+0x86>
      if(wait(0) != pid){
    4790:	4501                	li	a0,0
    4792:	00001097          	auipc	ra,0x1
    4796:	446080e7          	jalr	1094(ra) # 5bd8 <wait>
    479a:	02951863          	bne	a0,s1,47ca <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    479e:	397d                	addiw	s2,s2,-1
    47a0:	fe0910e3          	bnez	s2,4780 <reparent+0x20>
  exit(0);
    47a4:	4501                	li	a0,0
    47a6:	00001097          	auipc	ra,0x1
    47aa:	42a080e7          	jalr	1066(ra) # 5bd0 <exit>
      printf("%s: fork failed\n", s);
    47ae:	85ce                	mv	a1,s3
    47b0:	00002517          	auipc	a0,0x2
    47b4:	22050513          	addi	a0,a0,544 # 69d0 <malloc+0x9ca>
    47b8:	00001097          	auipc	ra,0x1
    47bc:	790080e7          	jalr	1936(ra) # 5f48 <printf>
      exit(1);
    47c0:	4505                	li	a0,1
    47c2:	00001097          	auipc	ra,0x1
    47c6:	40e080e7          	jalr	1038(ra) # 5bd0 <exit>
        printf("%s: wait wrong pid\n", s);
    47ca:	85ce                	mv	a1,s3
    47cc:	00002517          	auipc	a0,0x2
    47d0:	38c50513          	addi	a0,a0,908 # 6b58 <malloc+0xb52>
    47d4:	00001097          	auipc	ra,0x1
    47d8:	774080e7          	jalr	1908(ra) # 5f48 <printf>
        exit(1);
    47dc:	4505                	li	a0,1
    47de:	00001097          	auipc	ra,0x1
    47e2:	3f2080e7          	jalr	1010(ra) # 5bd0 <exit>
      int pid2 = fork();
    47e6:	00001097          	auipc	ra,0x1
    47ea:	3e2080e7          	jalr	994(ra) # 5bc8 <fork>
      if(pid2 < 0){
    47ee:	00054763          	bltz	a0,47fc <reparent+0x9c>
      exit(0);
    47f2:	4501                	li	a0,0
    47f4:	00001097          	auipc	ra,0x1
    47f8:	3dc080e7          	jalr	988(ra) # 5bd0 <exit>
        kill(master_pid);
    47fc:	8552                	mv	a0,s4
    47fe:	00001097          	auipc	ra,0x1
    4802:	402080e7          	jalr	1026(ra) # 5c00 <kill>
        exit(1);
    4806:	4505                	li	a0,1
    4808:	00001097          	auipc	ra,0x1
    480c:	3c8080e7          	jalr	968(ra) # 5bd0 <exit>

0000000000004810 <sbrkfail>:
{
    4810:	7119                	addi	sp,sp,-128
    4812:	fc86                	sd	ra,120(sp)
    4814:	f8a2                	sd	s0,112(sp)
    4816:	f4a6                	sd	s1,104(sp)
    4818:	f0ca                	sd	s2,96(sp)
    481a:	ecce                	sd	s3,88(sp)
    481c:	e8d2                	sd	s4,80(sp)
    481e:	e4d6                	sd	s5,72(sp)
    4820:	0100                	addi	s0,sp,128
    4822:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    4824:	fb040513          	addi	a0,s0,-80
    4828:	00001097          	auipc	ra,0x1
    482c:	3b8080e7          	jalr	952(ra) # 5be0 <pipe>
    4830:	e901                	bnez	a0,4840 <sbrkfail+0x30>
    4832:	f8040493          	addi	s1,s0,-128
    4836:	fa840a13          	addi	s4,s0,-88
    483a:	89a6                	mv	s3,s1
    if(pids[i] != -1)
    483c:	5afd                	li	s5,-1
    483e:	a08d                	j	48a0 <sbrkfail+0x90>
    printf("%s: pipe() failed\n", s);
    4840:	85ca                	mv	a1,s2
    4842:	00002517          	auipc	a0,0x2
    4846:	29650513          	addi	a0,a0,662 # 6ad8 <malloc+0xad2>
    484a:	00001097          	auipc	ra,0x1
    484e:	6fe080e7          	jalr	1790(ra) # 5f48 <printf>
    exit(1);
    4852:	4505                	li	a0,1
    4854:	00001097          	auipc	ra,0x1
    4858:	37c080e7          	jalr	892(ra) # 5bd0 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    485c:	4501                	li	a0,0
    485e:	00001097          	auipc	ra,0x1
    4862:	3fa080e7          	jalr	1018(ra) # 5c58 <sbrk>
    4866:	064007b7          	lui	a5,0x6400
    486a:	40a7853b          	subw	a0,a5,a0
    486e:	00001097          	auipc	ra,0x1
    4872:	3ea080e7          	jalr	1002(ra) # 5c58 <sbrk>
      write(fds[1], "x", 1);
    4876:	4605                	li	a2,1
    4878:	00002597          	auipc	a1,0x2
    487c:	94058593          	addi	a1,a1,-1728 # 61b8 <malloc+0x1b2>
    4880:	fb442503          	lw	a0,-76(s0)
    4884:	00001097          	auipc	ra,0x1
    4888:	36c080e7          	jalr	876(ra) # 5bf0 <write>
      for(;;) sleep(1000);
    488c:	3e800513          	li	a0,1000
    4890:	00001097          	auipc	ra,0x1
    4894:	3d0080e7          	jalr	976(ra) # 5c60 <sleep>
    4898:	bfd5                	j	488c <sbrkfail+0x7c>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    489a:	0991                	addi	s3,s3,4
    489c:	03498563          	beq	s3,s4,48c6 <sbrkfail+0xb6>
    if((pids[i] = fork()) == 0){
    48a0:	00001097          	auipc	ra,0x1
    48a4:	328080e7          	jalr	808(ra) # 5bc8 <fork>
    48a8:	00a9a023          	sw	a0,0(s3)
    48ac:	d945                	beqz	a0,485c <sbrkfail+0x4c>
    if(pids[i] != -1)
    48ae:	ff5506e3          	beq	a0,s5,489a <sbrkfail+0x8a>
      read(fds[0], &scratch, 1);
    48b2:	4605                	li	a2,1
    48b4:	faf40593          	addi	a1,s0,-81
    48b8:	fb042503          	lw	a0,-80(s0)
    48bc:	00001097          	auipc	ra,0x1
    48c0:	32c080e7          	jalr	812(ra) # 5be8 <read>
    48c4:	bfd9                	j	489a <sbrkfail+0x8a>
  c = sbrk(PGSIZE);
    48c6:	6505                	lui	a0,0x1
    48c8:	00001097          	auipc	ra,0x1
    48cc:	390080e7          	jalr	912(ra) # 5c58 <sbrk>
    48d0:	89aa                	mv	s3,a0
    if(pids[i] == -1)
    48d2:	5afd                	li	s5,-1
    48d4:	a021                	j	48dc <sbrkfail+0xcc>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    48d6:	0491                	addi	s1,s1,4
    48d8:	01448f63          	beq	s1,s4,48f6 <sbrkfail+0xe6>
    if(pids[i] == -1)
    48dc:	4088                	lw	a0,0(s1)
    48de:	ff550ce3          	beq	a0,s5,48d6 <sbrkfail+0xc6>
    kill(pids[i]);
    48e2:	00001097          	auipc	ra,0x1
    48e6:	31e080e7          	jalr	798(ra) # 5c00 <kill>
    wait(0);
    48ea:	4501                	li	a0,0
    48ec:	00001097          	auipc	ra,0x1
    48f0:	2ec080e7          	jalr	748(ra) # 5bd8 <wait>
    48f4:	b7cd                	j	48d6 <sbrkfail+0xc6>
  if(c == (char*)0xffffffffffffffffL){
    48f6:	57fd                	li	a5,-1
    48f8:	04f98163          	beq	s3,a5,493a <sbrkfail+0x12a>
  pid = fork();
    48fc:	00001097          	auipc	ra,0x1
    4900:	2cc080e7          	jalr	716(ra) # 5bc8 <fork>
    4904:	84aa                	mv	s1,a0
  if(pid < 0){
    4906:	04054863          	bltz	a0,4956 <sbrkfail+0x146>
  if(pid == 0){
    490a:	c525                	beqz	a0,4972 <sbrkfail+0x162>
  wait(&xstatus);
    490c:	fbc40513          	addi	a0,s0,-68
    4910:	00001097          	auipc	ra,0x1
    4914:	2c8080e7          	jalr	712(ra) # 5bd8 <wait>
  if(xstatus != -1 && xstatus != 2)
    4918:	fbc42783          	lw	a5,-68(s0)
    491c:	577d                	li	a4,-1
    491e:	00e78563          	beq	a5,a4,4928 <sbrkfail+0x118>
    4922:	4709                	li	a4,2
    4924:	08e79d63          	bne	a5,a4,49be <sbrkfail+0x1ae>
}
    4928:	70e6                	ld	ra,120(sp)
    492a:	7446                	ld	s0,112(sp)
    492c:	74a6                	ld	s1,104(sp)
    492e:	7906                	ld	s2,96(sp)
    4930:	69e6                	ld	s3,88(sp)
    4932:	6a46                	ld	s4,80(sp)
    4934:	6aa6                	ld	s5,72(sp)
    4936:	6109                	addi	sp,sp,128
    4938:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    493a:	85ca                	mv	a1,s2
    493c:	00003517          	auipc	a0,0x3
    4940:	3f450513          	addi	a0,a0,1012 # 7d30 <malloc+0x1d2a>
    4944:	00001097          	auipc	ra,0x1
    4948:	604080e7          	jalr	1540(ra) # 5f48 <printf>
    exit(1);
    494c:	4505                	li	a0,1
    494e:	00001097          	auipc	ra,0x1
    4952:	282080e7          	jalr	642(ra) # 5bd0 <exit>
    printf("%s: fork failed\n", s);
    4956:	85ca                	mv	a1,s2
    4958:	00002517          	auipc	a0,0x2
    495c:	07850513          	addi	a0,a0,120 # 69d0 <malloc+0x9ca>
    4960:	00001097          	auipc	ra,0x1
    4964:	5e8080e7          	jalr	1512(ra) # 5f48 <printf>
    exit(1);
    4968:	4505                	li	a0,1
    496a:	00001097          	auipc	ra,0x1
    496e:	266080e7          	jalr	614(ra) # 5bd0 <exit>
    a = sbrk(0);
    4972:	4501                	li	a0,0
    4974:	00001097          	auipc	ra,0x1
    4978:	2e4080e7          	jalr	740(ra) # 5c58 <sbrk>
    497c:	89aa                	mv	s3,a0
    sbrk(10*BIG);
    497e:	3e800537          	lui	a0,0x3e800
    4982:	00001097          	auipc	ra,0x1
    4986:	2d6080e7          	jalr	726(ra) # 5c58 <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    498a:	874e                	mv	a4,s3
    498c:	3e8007b7          	lui	a5,0x3e800
    4990:	97ce                	add	a5,a5,s3
    4992:	6685                	lui	a3,0x1
      n += *(a+i);
    4994:	00074603          	lbu	a2,0(a4)
    4998:	9cb1                	addw	s1,s1,a2
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    499a:	9736                	add	a4,a4,a3
    499c:	fef71ce3          	bne	a4,a5,4994 <sbrkfail+0x184>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    49a0:	8626                	mv	a2,s1
    49a2:	85ca                	mv	a1,s2
    49a4:	00003517          	auipc	a0,0x3
    49a8:	3ac50513          	addi	a0,a0,940 # 7d50 <malloc+0x1d4a>
    49ac:	00001097          	auipc	ra,0x1
    49b0:	59c080e7          	jalr	1436(ra) # 5f48 <printf>
    exit(1);
    49b4:	4505                	li	a0,1
    49b6:	00001097          	auipc	ra,0x1
    49ba:	21a080e7          	jalr	538(ra) # 5bd0 <exit>
    exit(1);
    49be:	4505                	li	a0,1
    49c0:	00001097          	auipc	ra,0x1
    49c4:	210080e7          	jalr	528(ra) # 5bd0 <exit>

00000000000049c8 <mem>:
{
    49c8:	7139                	addi	sp,sp,-64
    49ca:	fc06                	sd	ra,56(sp)
    49cc:	f822                	sd	s0,48(sp)
    49ce:	f426                	sd	s1,40(sp)
    49d0:	f04a                	sd	s2,32(sp)
    49d2:	ec4e                	sd	s3,24(sp)
    49d4:	0080                	addi	s0,sp,64
    49d6:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    49d8:	00001097          	auipc	ra,0x1
    49dc:	1f0080e7          	jalr	496(ra) # 5bc8 <fork>
    m1 = 0;
    49e0:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    49e2:	6909                	lui	s2,0x2
    49e4:	71190913          	addi	s2,s2,1809 # 2711 <copyinstr3+0x103>
  if((pid = fork()) == 0){
    49e8:	ed39                	bnez	a0,4a46 <mem+0x7e>
    while((m2 = malloc(10001)) != 0){
    49ea:	854a                	mv	a0,s2
    49ec:	00001097          	auipc	ra,0x1
    49f0:	61a080e7          	jalr	1562(ra) # 6006 <malloc>
    49f4:	c501                	beqz	a0,49fc <mem+0x34>
      *(char**)m2 = m1;
    49f6:	e104                	sd	s1,0(a0)
      m1 = m2;
    49f8:	84aa                	mv	s1,a0
    49fa:	bfc5                	j	49ea <mem+0x22>
    while(m1){
    49fc:	c881                	beqz	s1,4a0c <mem+0x44>
      m2 = *(char**)m1;
    49fe:	8526                	mv	a0,s1
    4a00:	6084                	ld	s1,0(s1)
      free(m1);
    4a02:	00001097          	auipc	ra,0x1
    4a06:	57c080e7          	jalr	1404(ra) # 5f7e <free>
    while(m1){
    4a0a:	f8f5                	bnez	s1,49fe <mem+0x36>
    m1 = malloc(1024*20);
    4a0c:	6515                	lui	a0,0x5
    4a0e:	00001097          	auipc	ra,0x1
    4a12:	5f8080e7          	jalr	1528(ra) # 6006 <malloc>
    if(m1 == 0){
    4a16:	c911                	beqz	a0,4a2a <mem+0x62>
    free(m1);
    4a18:	00001097          	auipc	ra,0x1
    4a1c:	566080e7          	jalr	1382(ra) # 5f7e <free>
    exit(0);
    4a20:	4501                	li	a0,0
    4a22:	00001097          	auipc	ra,0x1
    4a26:	1ae080e7          	jalr	430(ra) # 5bd0 <exit>
      printf("couldn't allocate mem?!!\n", s);
    4a2a:	85ce                	mv	a1,s3
    4a2c:	00003517          	auipc	a0,0x3
    4a30:	35450513          	addi	a0,a0,852 # 7d80 <malloc+0x1d7a>
    4a34:	00001097          	auipc	ra,0x1
    4a38:	514080e7          	jalr	1300(ra) # 5f48 <printf>
      exit(1);
    4a3c:	4505                	li	a0,1
    4a3e:	00001097          	auipc	ra,0x1
    4a42:	192080e7          	jalr	402(ra) # 5bd0 <exit>
    wait(&xstatus);
    4a46:	fcc40513          	addi	a0,s0,-52
    4a4a:	00001097          	auipc	ra,0x1
    4a4e:	18e080e7          	jalr	398(ra) # 5bd8 <wait>
    if(xstatus == -1){
    4a52:	fcc42503          	lw	a0,-52(s0)
    4a56:	57fd                	li	a5,-1
    4a58:	00f50663          	beq	a0,a5,4a64 <mem+0x9c>
    exit(xstatus);
    4a5c:	00001097          	auipc	ra,0x1
    4a60:	174080e7          	jalr	372(ra) # 5bd0 <exit>
      exit(0);
    4a64:	4501                	li	a0,0
    4a66:	00001097          	auipc	ra,0x1
    4a6a:	16a080e7          	jalr	362(ra) # 5bd0 <exit>

0000000000004a6e <sharedfd>:
{
    4a6e:	7159                	addi	sp,sp,-112
    4a70:	f486                	sd	ra,104(sp)
    4a72:	f0a2                	sd	s0,96(sp)
    4a74:	eca6                	sd	s1,88(sp)
    4a76:	e8ca                	sd	s2,80(sp)
    4a78:	e4ce                	sd	s3,72(sp)
    4a7a:	e0d2                	sd	s4,64(sp)
    4a7c:	fc56                	sd	s5,56(sp)
    4a7e:	f85a                	sd	s6,48(sp)
    4a80:	f45e                	sd	s7,40(sp)
    4a82:	1880                	addi	s0,sp,112
    4a84:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    4a86:	00003517          	auipc	a0,0x3
    4a8a:	31a50513          	addi	a0,a0,794 # 7da0 <malloc+0x1d9a>
    4a8e:	00001097          	auipc	ra,0x1
    4a92:	192080e7          	jalr	402(ra) # 5c20 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    4a96:	20200593          	li	a1,514
    4a9a:	00003517          	auipc	a0,0x3
    4a9e:	30650513          	addi	a0,a0,774 # 7da0 <malloc+0x1d9a>
    4aa2:	00001097          	auipc	ra,0x1
    4aa6:	16e080e7          	jalr	366(ra) # 5c10 <open>
  if(fd < 0){
    4aaa:	04054a63          	bltz	a0,4afe <sharedfd+0x90>
    4aae:	892a                	mv	s2,a0
  pid = fork();
    4ab0:	00001097          	auipc	ra,0x1
    4ab4:	118080e7          	jalr	280(ra) # 5bc8 <fork>
    4ab8:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4aba:	06300593          	li	a1,99
    4abe:	c119                	beqz	a0,4ac4 <sharedfd+0x56>
    4ac0:	07000593          	li	a1,112
    4ac4:	4629                	li	a2,10
    4ac6:	fa040513          	addi	a0,s0,-96
    4aca:	00001097          	auipc	ra,0x1
    4ace:	f02080e7          	jalr	-254(ra) # 59cc <memset>
    4ad2:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    4ad6:	4629                	li	a2,10
    4ad8:	fa040593          	addi	a1,s0,-96
    4adc:	854a                	mv	a0,s2
    4ade:	00001097          	auipc	ra,0x1
    4ae2:	112080e7          	jalr	274(ra) # 5bf0 <write>
    4ae6:	47a9                	li	a5,10
    4ae8:	02f51963          	bne	a0,a5,4b1a <sharedfd+0xac>
  for(i = 0; i < N; i++){
    4aec:	34fd                	addiw	s1,s1,-1
    4aee:	f4e5                	bnez	s1,4ad6 <sharedfd+0x68>
  if(pid == 0) {
    4af0:	04099363          	bnez	s3,4b36 <sharedfd+0xc8>
    exit(0);
    4af4:	4501                	li	a0,0
    4af6:	00001097          	auipc	ra,0x1
    4afa:	0da080e7          	jalr	218(ra) # 5bd0 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4afe:	85d2                	mv	a1,s4
    4b00:	00003517          	auipc	a0,0x3
    4b04:	2b050513          	addi	a0,a0,688 # 7db0 <malloc+0x1daa>
    4b08:	00001097          	auipc	ra,0x1
    4b0c:	440080e7          	jalr	1088(ra) # 5f48 <printf>
    exit(1);
    4b10:	4505                	li	a0,1
    4b12:	00001097          	auipc	ra,0x1
    4b16:	0be080e7          	jalr	190(ra) # 5bd0 <exit>
      printf("%s: write sharedfd failed\n", s);
    4b1a:	85d2                	mv	a1,s4
    4b1c:	00003517          	auipc	a0,0x3
    4b20:	2bc50513          	addi	a0,a0,700 # 7dd8 <malloc+0x1dd2>
    4b24:	00001097          	auipc	ra,0x1
    4b28:	424080e7          	jalr	1060(ra) # 5f48 <printf>
      exit(1);
    4b2c:	4505                	li	a0,1
    4b2e:	00001097          	auipc	ra,0x1
    4b32:	0a2080e7          	jalr	162(ra) # 5bd0 <exit>
    wait(&xstatus);
    4b36:	f9c40513          	addi	a0,s0,-100
    4b3a:	00001097          	auipc	ra,0x1
    4b3e:	09e080e7          	jalr	158(ra) # 5bd8 <wait>
    if(xstatus != 0)
    4b42:	f9c42983          	lw	s3,-100(s0)
    4b46:	00098763          	beqz	s3,4b54 <sharedfd+0xe6>
      exit(xstatus);
    4b4a:	854e                	mv	a0,s3
    4b4c:	00001097          	auipc	ra,0x1
    4b50:	084080e7          	jalr	132(ra) # 5bd0 <exit>
  close(fd);
    4b54:	854a                	mv	a0,s2
    4b56:	00001097          	auipc	ra,0x1
    4b5a:	0a2080e7          	jalr	162(ra) # 5bf8 <close>
  fd = open("sharedfd", 0);
    4b5e:	4581                	li	a1,0
    4b60:	00003517          	auipc	a0,0x3
    4b64:	24050513          	addi	a0,a0,576 # 7da0 <malloc+0x1d9a>
    4b68:	00001097          	auipc	ra,0x1
    4b6c:	0a8080e7          	jalr	168(ra) # 5c10 <open>
    4b70:	8baa                	mv	s7,a0
  nc = np = 0;
    4b72:	8ace                	mv	s5,s3
  if(fd < 0){
    4b74:	02054563          	bltz	a0,4b9e <sharedfd+0x130>
    4b78:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    4b7c:	06300493          	li	s1,99
      if(buf[i] == 'p')
    4b80:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    4b84:	4629                	li	a2,10
    4b86:	fa040593          	addi	a1,s0,-96
    4b8a:	855e                	mv	a0,s7
    4b8c:	00001097          	auipc	ra,0x1
    4b90:	05c080e7          	jalr	92(ra) # 5be8 <read>
    4b94:	02a05f63          	blez	a0,4bd2 <sharedfd+0x164>
    4b98:	fa040793          	addi	a5,s0,-96
    4b9c:	a01d                	j	4bc2 <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4b9e:	85d2                	mv	a1,s4
    4ba0:	00003517          	auipc	a0,0x3
    4ba4:	25850513          	addi	a0,a0,600 # 7df8 <malloc+0x1df2>
    4ba8:	00001097          	auipc	ra,0x1
    4bac:	3a0080e7          	jalr	928(ra) # 5f48 <printf>
    exit(1);
    4bb0:	4505                	li	a0,1
    4bb2:	00001097          	auipc	ra,0x1
    4bb6:	01e080e7          	jalr	30(ra) # 5bd0 <exit>
        nc++;
    4bba:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4bbc:	0785                	addi	a5,a5,1
    4bbe:	fd2783e3          	beq	a5,s2,4b84 <sharedfd+0x116>
      if(buf[i] == 'c')
    4bc2:	0007c703          	lbu	a4,0(a5) # 3e800000 <base+0x3e7f0388>
    4bc6:	fe970ae3          	beq	a4,s1,4bba <sharedfd+0x14c>
      if(buf[i] == 'p')
    4bca:	ff6719e3          	bne	a4,s6,4bbc <sharedfd+0x14e>
        np++;
    4bce:	2a85                	addiw	s5,s5,1
    4bd0:	b7f5                	j	4bbc <sharedfd+0x14e>
  close(fd);
    4bd2:	855e                	mv	a0,s7
    4bd4:	00001097          	auipc	ra,0x1
    4bd8:	024080e7          	jalr	36(ra) # 5bf8 <close>
  unlink("sharedfd");
    4bdc:	00003517          	auipc	a0,0x3
    4be0:	1c450513          	addi	a0,a0,452 # 7da0 <malloc+0x1d9a>
    4be4:	00001097          	auipc	ra,0x1
    4be8:	03c080e7          	jalr	60(ra) # 5c20 <unlink>
  if(nc == N*SZ && np == N*SZ){
    4bec:	6789                	lui	a5,0x2
    4bee:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0x102>
    4bf2:	00f99763          	bne	s3,a5,4c00 <sharedfd+0x192>
    4bf6:	6789                	lui	a5,0x2
    4bf8:	71078793          	addi	a5,a5,1808 # 2710 <copyinstr3+0x102>
    4bfc:	02fa8063          	beq	s5,a5,4c1c <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4c00:	85d2                	mv	a1,s4
    4c02:	00003517          	auipc	a0,0x3
    4c06:	21e50513          	addi	a0,a0,542 # 7e20 <malloc+0x1e1a>
    4c0a:	00001097          	auipc	ra,0x1
    4c0e:	33e080e7          	jalr	830(ra) # 5f48 <printf>
    exit(1);
    4c12:	4505                	li	a0,1
    4c14:	00001097          	auipc	ra,0x1
    4c18:	fbc080e7          	jalr	-68(ra) # 5bd0 <exit>
    exit(0);
    4c1c:	4501                	li	a0,0
    4c1e:	00001097          	auipc	ra,0x1
    4c22:	fb2080e7          	jalr	-78(ra) # 5bd0 <exit>

0000000000004c26 <fourfiles>:
{
    4c26:	7171                	addi	sp,sp,-176
    4c28:	f506                	sd	ra,168(sp)
    4c2a:	f122                	sd	s0,160(sp)
    4c2c:	ed26                	sd	s1,152(sp)
    4c2e:	e94a                	sd	s2,144(sp)
    4c30:	e54e                	sd	s3,136(sp)
    4c32:	e152                	sd	s4,128(sp)
    4c34:	fcd6                	sd	s5,120(sp)
    4c36:	f8da                	sd	s6,112(sp)
    4c38:	f4de                	sd	s7,104(sp)
    4c3a:	f0e2                	sd	s8,96(sp)
    4c3c:	ece6                	sd	s9,88(sp)
    4c3e:	e8ea                	sd	s10,80(sp)
    4c40:	e4ee                	sd	s11,72(sp)
    4c42:	1900                	addi	s0,sp,176
    4c44:	8caa                	mv	s9,a0
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c46:	00001797          	auipc	a5,0x1
    4c4a:	4aa78793          	addi	a5,a5,1194 # 60f0 <malloc+0xea>
    4c4e:	f6f43823          	sd	a5,-144(s0)
    4c52:	00001797          	auipc	a5,0x1
    4c56:	4a678793          	addi	a5,a5,1190 # 60f8 <malloc+0xf2>
    4c5a:	f6f43c23          	sd	a5,-136(s0)
    4c5e:	00001797          	auipc	a5,0x1
    4c62:	4a278793          	addi	a5,a5,1186 # 6100 <malloc+0xfa>
    4c66:	f8f43023          	sd	a5,-128(s0)
    4c6a:	00001797          	auipc	a5,0x1
    4c6e:	49e78793          	addi	a5,a5,1182 # 6108 <malloc+0x102>
    4c72:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    4c76:	f7040b93          	addi	s7,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    4c7a:	895e                	mv	s2,s7
  for(pi = 0; pi < NCHILD; pi++){
    4c7c:	4481                	li	s1,0
    4c7e:	4a11                	li	s4,4
    fname = names[pi];
    4c80:	00093983          	ld	s3,0(s2)
    unlink(fname);
    4c84:	854e                	mv	a0,s3
    4c86:	00001097          	auipc	ra,0x1
    4c8a:	f9a080e7          	jalr	-102(ra) # 5c20 <unlink>
    pid = fork();
    4c8e:	00001097          	auipc	ra,0x1
    4c92:	f3a080e7          	jalr	-198(ra) # 5bc8 <fork>
    if(pid < 0){
    4c96:	04054563          	bltz	a0,4ce0 <fourfiles+0xba>
    if(pid == 0){
    4c9a:	c12d                	beqz	a0,4cfc <fourfiles+0xd6>
  for(pi = 0; pi < NCHILD; pi++){
    4c9c:	2485                	addiw	s1,s1,1
    4c9e:	0921                	addi	s2,s2,8
    4ca0:	ff4490e3          	bne	s1,s4,4c80 <fourfiles+0x5a>
    4ca4:	4491                	li	s1,4
    wait(&xstatus);
    4ca6:	f6c40513          	addi	a0,s0,-148
    4caa:	00001097          	auipc	ra,0x1
    4cae:	f2e080e7          	jalr	-210(ra) # 5bd8 <wait>
    if(xstatus != 0)
    4cb2:	f6c42503          	lw	a0,-148(s0)
    4cb6:	ed69                	bnez	a0,4d90 <fourfiles+0x16a>
  for(pi = 0; pi < NCHILD; pi++){
    4cb8:	34fd                	addiw	s1,s1,-1
    4cba:	f4f5                	bnez	s1,4ca6 <fourfiles+0x80>
    4cbc:	03000b13          	li	s6,48
    total = 0;
    4cc0:	f4a43c23          	sd	a0,-168(s0)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4cc4:	00008a17          	auipc	s4,0x8
    4cc8:	fb4a0a13          	addi	s4,s4,-76 # cc78 <buf>
    4ccc:	00008a97          	auipc	s5,0x8
    4cd0:	fada8a93          	addi	s5,s5,-83 # cc79 <buf+0x1>
    if(total != N*SZ){
    4cd4:	6d05                	lui	s10,0x1
    4cd6:	770d0d13          	addi	s10,s10,1904 # 1770 <exectest+0x2e>
  for(i = 0; i < NCHILD; i++){
    4cda:	03400d93          	li	s11,52
    4cde:	a23d                	j	4e0c <fourfiles+0x1e6>
      printf("fork failed\n", s);
    4ce0:	85e6                	mv	a1,s9
    4ce2:	00002517          	auipc	a0,0x2
    4ce6:	0f650513          	addi	a0,a0,246 # 6dd8 <malloc+0xdd2>
    4cea:	00001097          	auipc	ra,0x1
    4cee:	25e080e7          	jalr	606(ra) # 5f48 <printf>
      exit(1);
    4cf2:	4505                	li	a0,1
    4cf4:	00001097          	auipc	ra,0x1
    4cf8:	edc080e7          	jalr	-292(ra) # 5bd0 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4cfc:	20200593          	li	a1,514
    4d00:	854e                	mv	a0,s3
    4d02:	00001097          	auipc	ra,0x1
    4d06:	f0e080e7          	jalr	-242(ra) # 5c10 <open>
    4d0a:	892a                	mv	s2,a0
      if(fd < 0){
    4d0c:	04054763          	bltz	a0,4d5a <fourfiles+0x134>
      memset(buf, '0'+pi, SZ);
    4d10:	1f400613          	li	a2,500
    4d14:	0304859b          	addiw	a1,s1,48
    4d18:	00008517          	auipc	a0,0x8
    4d1c:	f6050513          	addi	a0,a0,-160 # cc78 <buf>
    4d20:	00001097          	auipc	ra,0x1
    4d24:	cac080e7          	jalr	-852(ra) # 59cc <memset>
    4d28:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4d2a:	00008997          	auipc	s3,0x8
    4d2e:	f4e98993          	addi	s3,s3,-178 # cc78 <buf>
    4d32:	1f400613          	li	a2,500
    4d36:	85ce                	mv	a1,s3
    4d38:	854a                	mv	a0,s2
    4d3a:	00001097          	auipc	ra,0x1
    4d3e:	eb6080e7          	jalr	-330(ra) # 5bf0 <write>
    4d42:	85aa                	mv	a1,a0
    4d44:	1f400793          	li	a5,500
    4d48:	02f51763          	bne	a0,a5,4d76 <fourfiles+0x150>
      for(i = 0; i < N; i++){
    4d4c:	34fd                	addiw	s1,s1,-1
    4d4e:	f0f5                	bnez	s1,4d32 <fourfiles+0x10c>
      exit(0);
    4d50:	4501                	li	a0,0
    4d52:	00001097          	auipc	ra,0x1
    4d56:	e7e080e7          	jalr	-386(ra) # 5bd0 <exit>
        printf("create failed\n", s);
    4d5a:	85e6                	mv	a1,s9
    4d5c:	00003517          	auipc	a0,0x3
    4d60:	0dc50513          	addi	a0,a0,220 # 7e38 <malloc+0x1e32>
    4d64:	00001097          	auipc	ra,0x1
    4d68:	1e4080e7          	jalr	484(ra) # 5f48 <printf>
        exit(1);
    4d6c:	4505                	li	a0,1
    4d6e:	00001097          	auipc	ra,0x1
    4d72:	e62080e7          	jalr	-414(ra) # 5bd0 <exit>
          printf("write failed %d\n", n);
    4d76:	00003517          	auipc	a0,0x3
    4d7a:	0d250513          	addi	a0,a0,210 # 7e48 <malloc+0x1e42>
    4d7e:	00001097          	auipc	ra,0x1
    4d82:	1ca080e7          	jalr	458(ra) # 5f48 <printf>
          exit(1);
    4d86:	4505                	li	a0,1
    4d88:	00001097          	auipc	ra,0x1
    4d8c:	e48080e7          	jalr	-440(ra) # 5bd0 <exit>
      exit(xstatus);
    4d90:	00001097          	auipc	ra,0x1
    4d94:	e40080e7          	jalr	-448(ra) # 5bd0 <exit>
          printf("wrong char\n", s);
    4d98:	85e6                	mv	a1,s9
    4d9a:	00003517          	auipc	a0,0x3
    4d9e:	0c650513          	addi	a0,a0,198 # 7e60 <malloc+0x1e5a>
    4da2:	00001097          	auipc	ra,0x1
    4da6:	1a6080e7          	jalr	422(ra) # 5f48 <printf>
          exit(1);
    4daa:	4505                	li	a0,1
    4dac:	00001097          	auipc	ra,0x1
    4db0:	e24080e7          	jalr	-476(ra) # 5bd0 <exit>
      total += n;
    4db4:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4db8:	660d                	lui	a2,0x3
    4dba:	85d2                	mv	a1,s4
    4dbc:	854e                	mv	a0,s3
    4dbe:	00001097          	auipc	ra,0x1
    4dc2:	e2a080e7          	jalr	-470(ra) # 5be8 <read>
    4dc6:	02a05363          	blez	a0,4dec <fourfiles+0x1c6>
    4dca:	00008797          	auipc	a5,0x8
    4dce:	eae78793          	addi	a5,a5,-338 # cc78 <buf>
    4dd2:	fff5069b          	addiw	a3,a0,-1
    4dd6:	1682                	slli	a3,a3,0x20
    4dd8:	9281                	srli	a3,a3,0x20
    4dda:	96d6                	add	a3,a3,s5
        if(buf[j] != '0'+i){
    4ddc:	0007c703          	lbu	a4,0(a5)
    4de0:	fa971ce3          	bne	a4,s1,4d98 <fourfiles+0x172>
      for(j = 0; j < n; j++){
    4de4:	0785                	addi	a5,a5,1
    4de6:	fed79be3          	bne	a5,a3,4ddc <fourfiles+0x1b6>
    4dea:	b7e9                	j	4db4 <fourfiles+0x18e>
    close(fd);
    4dec:	854e                	mv	a0,s3
    4dee:	00001097          	auipc	ra,0x1
    4df2:	e0a080e7          	jalr	-502(ra) # 5bf8 <close>
    if(total != N*SZ){
    4df6:	03a91963          	bne	s2,s10,4e28 <fourfiles+0x202>
    unlink(fname);
    4dfa:	8562                	mv	a0,s8
    4dfc:	00001097          	auipc	ra,0x1
    4e00:	e24080e7          	jalr	-476(ra) # 5c20 <unlink>
  for(i = 0; i < NCHILD; i++){
    4e04:	0ba1                	addi	s7,s7,8
    4e06:	2b05                	addiw	s6,s6,1
    4e08:	03bb0e63          	beq	s6,s11,4e44 <fourfiles+0x21e>
    fname = names[i];
    4e0c:	000bbc03          	ld	s8,0(s7)
    fd = open(fname, 0);
    4e10:	4581                	li	a1,0
    4e12:	8562                	mv	a0,s8
    4e14:	00001097          	auipc	ra,0x1
    4e18:	dfc080e7          	jalr	-516(ra) # 5c10 <open>
    4e1c:	89aa                	mv	s3,a0
    total = 0;
    4e1e:	f5843903          	ld	s2,-168(s0)
        if(buf[j] != '0'+i){
    4e22:	000b049b          	sext.w	s1,s6
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4e26:	bf49                	j	4db8 <fourfiles+0x192>
      printf("wrong length %d\n", total);
    4e28:	85ca                	mv	a1,s2
    4e2a:	00003517          	auipc	a0,0x3
    4e2e:	04650513          	addi	a0,a0,70 # 7e70 <malloc+0x1e6a>
    4e32:	00001097          	auipc	ra,0x1
    4e36:	116080e7          	jalr	278(ra) # 5f48 <printf>
      exit(1);
    4e3a:	4505                	li	a0,1
    4e3c:	00001097          	auipc	ra,0x1
    4e40:	d94080e7          	jalr	-620(ra) # 5bd0 <exit>
}
    4e44:	70aa                	ld	ra,168(sp)
    4e46:	740a                	ld	s0,160(sp)
    4e48:	64ea                	ld	s1,152(sp)
    4e4a:	694a                	ld	s2,144(sp)
    4e4c:	69aa                	ld	s3,136(sp)
    4e4e:	6a0a                	ld	s4,128(sp)
    4e50:	7ae6                	ld	s5,120(sp)
    4e52:	7b46                	ld	s6,112(sp)
    4e54:	7ba6                	ld	s7,104(sp)
    4e56:	7c06                	ld	s8,96(sp)
    4e58:	6ce6                	ld	s9,88(sp)
    4e5a:	6d46                	ld	s10,80(sp)
    4e5c:	6da6                	ld	s11,72(sp)
    4e5e:	614d                	addi	sp,sp,176
    4e60:	8082                	ret

0000000000004e62 <concreate>:
{
    4e62:	7135                	addi	sp,sp,-160
    4e64:	ed06                	sd	ra,152(sp)
    4e66:	e922                	sd	s0,144(sp)
    4e68:	e526                	sd	s1,136(sp)
    4e6a:	e14a                	sd	s2,128(sp)
    4e6c:	fcce                	sd	s3,120(sp)
    4e6e:	f8d2                	sd	s4,112(sp)
    4e70:	f4d6                	sd	s5,104(sp)
    4e72:	f0da                	sd	s6,96(sp)
    4e74:	ecde                	sd	s7,88(sp)
    4e76:	1100                	addi	s0,sp,160
    4e78:	89aa                	mv	s3,a0
  file[0] = 'C';
    4e7a:	04300793          	li	a5,67
    4e7e:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    4e82:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    4e86:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    4e88:	4b0d                	li	s6,3
    4e8a:	4a85                	li	s5,1
      link("C0", file);
    4e8c:	00003b97          	auipc	s7,0x3
    4e90:	ffcb8b93          	addi	s7,s7,-4 # 7e88 <malloc+0x1e82>
  for(i = 0; i < N; i++){
    4e94:	02800a13          	li	s4,40
    4e98:	acc1                	j	5168 <concreate+0x306>
      link("C0", file);
    4e9a:	fa840593          	addi	a1,s0,-88
    4e9e:	855e                	mv	a0,s7
    4ea0:	00001097          	auipc	ra,0x1
    4ea4:	d90080e7          	jalr	-624(ra) # 5c30 <link>
    if(pid == 0) {
    4ea8:	a45d                	j	514e <concreate+0x2ec>
    } else if(pid == 0 && (i % 5) == 1){
    4eaa:	4795                	li	a5,5
    4eac:	02f9693b          	remw	s2,s2,a5
    4eb0:	4785                	li	a5,1
    4eb2:	02f90b63          	beq	s2,a5,4ee8 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4eb6:	20200593          	li	a1,514
    4eba:	fa840513          	addi	a0,s0,-88
    4ebe:	00001097          	auipc	ra,0x1
    4ec2:	d52080e7          	jalr	-686(ra) # 5c10 <open>
      if(fd < 0){
    4ec6:	26055b63          	bgez	a0,513c <concreate+0x2da>
        printf("concreate create %s failed\n", file);
    4eca:	fa840593          	addi	a1,s0,-88
    4ece:	00003517          	auipc	a0,0x3
    4ed2:	fc250513          	addi	a0,a0,-62 # 7e90 <malloc+0x1e8a>
    4ed6:	00001097          	auipc	ra,0x1
    4eda:	072080e7          	jalr	114(ra) # 5f48 <printf>
        exit(1);
    4ede:	4505                	li	a0,1
    4ee0:	00001097          	auipc	ra,0x1
    4ee4:	cf0080e7          	jalr	-784(ra) # 5bd0 <exit>
      link("C0", file);
    4ee8:	fa840593          	addi	a1,s0,-88
    4eec:	00003517          	auipc	a0,0x3
    4ef0:	f9c50513          	addi	a0,a0,-100 # 7e88 <malloc+0x1e82>
    4ef4:	00001097          	auipc	ra,0x1
    4ef8:	d3c080e7          	jalr	-708(ra) # 5c30 <link>
      exit(0);
    4efc:	4501                	li	a0,0
    4efe:	00001097          	auipc	ra,0x1
    4f02:	cd2080e7          	jalr	-814(ra) # 5bd0 <exit>
        exit(1);
    4f06:	4505                	li	a0,1
    4f08:	00001097          	auipc	ra,0x1
    4f0c:	cc8080e7          	jalr	-824(ra) # 5bd0 <exit>
  memset(fa, 0, sizeof(fa));
    4f10:	02800613          	li	a2,40
    4f14:	4581                	li	a1,0
    4f16:	f8040513          	addi	a0,s0,-128
    4f1a:	00001097          	auipc	ra,0x1
    4f1e:	ab2080e7          	jalr	-1358(ra) # 59cc <memset>
  fd = open(".", 0);
    4f22:	4581                	li	a1,0
    4f24:	00002517          	auipc	a0,0x2
    4f28:	90c50513          	addi	a0,a0,-1780 # 6830 <malloc+0x82a>
    4f2c:	00001097          	auipc	ra,0x1
    4f30:	ce4080e7          	jalr	-796(ra) # 5c10 <open>
    4f34:	892a                	mv	s2,a0
  n = 0;
    4f36:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f38:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4f3c:	02700b13          	li	s6,39
      fa[i] = 1;
    4f40:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4f42:	a03d                	j	4f70 <concreate+0x10e>
        printf("%s: concreate weird file %s\n", s, de.name);
    4f44:	f7240613          	addi	a2,s0,-142
    4f48:	85ce                	mv	a1,s3
    4f4a:	00003517          	auipc	a0,0x3
    4f4e:	f6650513          	addi	a0,a0,-154 # 7eb0 <malloc+0x1eaa>
    4f52:	00001097          	auipc	ra,0x1
    4f56:	ff6080e7          	jalr	-10(ra) # 5f48 <printf>
        exit(1);
    4f5a:	4505                	li	a0,1
    4f5c:	00001097          	auipc	ra,0x1
    4f60:	c74080e7          	jalr	-908(ra) # 5bd0 <exit>
      fa[i] = 1;
    4f64:	fb040793          	addi	a5,s0,-80
    4f68:	973e                	add	a4,a4,a5
    4f6a:	fd770823          	sb	s7,-48(a4)
      n++;
    4f6e:	2a85                	addiw	s5,s5,1
  while(read(fd, &de, sizeof(de)) > 0){
    4f70:	4641                	li	a2,16
    4f72:	f7040593          	addi	a1,s0,-144
    4f76:	854a                	mv	a0,s2
    4f78:	00001097          	auipc	ra,0x1
    4f7c:	c70080e7          	jalr	-912(ra) # 5be8 <read>
    4f80:	04a05a63          	blez	a0,4fd4 <concreate+0x172>
    if(de.inum == 0)
    4f84:	f7045783          	lhu	a5,-144(s0)
    4f88:	d7e5                	beqz	a5,4f70 <concreate+0x10e>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4f8a:	f7244783          	lbu	a5,-142(s0)
    4f8e:	ff4791e3          	bne	a5,s4,4f70 <concreate+0x10e>
    4f92:	f7444783          	lbu	a5,-140(s0)
    4f96:	ffe9                	bnez	a5,4f70 <concreate+0x10e>
      i = de.name[1] - '0';
    4f98:	f7344783          	lbu	a5,-141(s0)
    4f9c:	fd07879b          	addiw	a5,a5,-48
    4fa0:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4fa4:	faeb60e3          	bltu	s6,a4,4f44 <concreate+0xe2>
      if(fa[i]){
    4fa8:	fb040793          	addi	a5,s0,-80
    4fac:	97ba                	add	a5,a5,a4
    4fae:	fd07c783          	lbu	a5,-48(a5)
    4fb2:	dbcd                	beqz	a5,4f64 <concreate+0x102>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4fb4:	f7240613          	addi	a2,s0,-142
    4fb8:	85ce                	mv	a1,s3
    4fba:	00003517          	auipc	a0,0x3
    4fbe:	f1650513          	addi	a0,a0,-234 # 7ed0 <malloc+0x1eca>
    4fc2:	00001097          	auipc	ra,0x1
    4fc6:	f86080e7          	jalr	-122(ra) # 5f48 <printf>
        exit(1);
    4fca:	4505                	li	a0,1
    4fcc:	00001097          	auipc	ra,0x1
    4fd0:	c04080e7          	jalr	-1020(ra) # 5bd0 <exit>
  close(fd);
    4fd4:	854a                	mv	a0,s2
    4fd6:	00001097          	auipc	ra,0x1
    4fda:	c22080e7          	jalr	-990(ra) # 5bf8 <close>
  if(n != N){
    4fde:	02800793          	li	a5,40
    4fe2:	00fa9763          	bne	s5,a5,4ff0 <concreate+0x18e>
    if(((i % 3) == 0 && pid == 0) ||
    4fe6:	4a8d                	li	s5,3
    4fe8:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4fea:	02800a13          	li	s4,40
    4fee:	a8c9                	j	50c0 <concreate+0x25e>
    printf("%s: concreate not enough files in directory listing\n", s);
    4ff0:	85ce                	mv	a1,s3
    4ff2:	00003517          	auipc	a0,0x3
    4ff6:	f0650513          	addi	a0,a0,-250 # 7ef8 <malloc+0x1ef2>
    4ffa:	00001097          	auipc	ra,0x1
    4ffe:	f4e080e7          	jalr	-178(ra) # 5f48 <printf>
    exit(1);
    5002:	4505                	li	a0,1
    5004:	00001097          	auipc	ra,0x1
    5008:	bcc080e7          	jalr	-1076(ra) # 5bd0 <exit>
      printf("%s: fork failed\n", s);
    500c:	85ce                	mv	a1,s3
    500e:	00002517          	auipc	a0,0x2
    5012:	9c250513          	addi	a0,a0,-1598 # 69d0 <malloc+0x9ca>
    5016:	00001097          	auipc	ra,0x1
    501a:	f32080e7          	jalr	-206(ra) # 5f48 <printf>
      exit(1);
    501e:	4505                	li	a0,1
    5020:	00001097          	auipc	ra,0x1
    5024:	bb0080e7          	jalr	-1104(ra) # 5bd0 <exit>
      close(open(file, 0));
    5028:	4581                	li	a1,0
    502a:	fa840513          	addi	a0,s0,-88
    502e:	00001097          	auipc	ra,0x1
    5032:	be2080e7          	jalr	-1054(ra) # 5c10 <open>
    5036:	00001097          	auipc	ra,0x1
    503a:	bc2080e7          	jalr	-1086(ra) # 5bf8 <close>
      close(open(file, 0));
    503e:	4581                	li	a1,0
    5040:	fa840513          	addi	a0,s0,-88
    5044:	00001097          	auipc	ra,0x1
    5048:	bcc080e7          	jalr	-1076(ra) # 5c10 <open>
    504c:	00001097          	auipc	ra,0x1
    5050:	bac080e7          	jalr	-1108(ra) # 5bf8 <close>
      close(open(file, 0));
    5054:	4581                	li	a1,0
    5056:	fa840513          	addi	a0,s0,-88
    505a:	00001097          	auipc	ra,0x1
    505e:	bb6080e7          	jalr	-1098(ra) # 5c10 <open>
    5062:	00001097          	auipc	ra,0x1
    5066:	b96080e7          	jalr	-1130(ra) # 5bf8 <close>
      close(open(file, 0));
    506a:	4581                	li	a1,0
    506c:	fa840513          	addi	a0,s0,-88
    5070:	00001097          	auipc	ra,0x1
    5074:	ba0080e7          	jalr	-1120(ra) # 5c10 <open>
    5078:	00001097          	auipc	ra,0x1
    507c:	b80080e7          	jalr	-1152(ra) # 5bf8 <close>
      close(open(file, 0));
    5080:	4581                	li	a1,0
    5082:	fa840513          	addi	a0,s0,-88
    5086:	00001097          	auipc	ra,0x1
    508a:	b8a080e7          	jalr	-1142(ra) # 5c10 <open>
    508e:	00001097          	auipc	ra,0x1
    5092:	b6a080e7          	jalr	-1174(ra) # 5bf8 <close>
      close(open(file, 0));
    5096:	4581                	li	a1,0
    5098:	fa840513          	addi	a0,s0,-88
    509c:	00001097          	auipc	ra,0x1
    50a0:	b74080e7          	jalr	-1164(ra) # 5c10 <open>
    50a4:	00001097          	auipc	ra,0x1
    50a8:	b54080e7          	jalr	-1196(ra) # 5bf8 <close>
    if(pid == 0)
    50ac:	08090363          	beqz	s2,5132 <concreate+0x2d0>
      wait(0);
    50b0:	4501                	li	a0,0
    50b2:	00001097          	auipc	ra,0x1
    50b6:	b26080e7          	jalr	-1242(ra) # 5bd8 <wait>
  for(i = 0; i < N; i++){
    50ba:	2485                	addiw	s1,s1,1
    50bc:	0f448563          	beq	s1,s4,51a6 <concreate+0x344>
    file[1] = '0' + i;
    50c0:	0304879b          	addiw	a5,s1,48
    50c4:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    50c8:	00001097          	auipc	ra,0x1
    50cc:	b00080e7          	jalr	-1280(ra) # 5bc8 <fork>
    50d0:	892a                	mv	s2,a0
    if(pid < 0){
    50d2:	f2054de3          	bltz	a0,500c <concreate+0x1aa>
    if(((i % 3) == 0 && pid == 0) ||
    50d6:	0354e73b          	remw	a4,s1,s5
    50da:	00a767b3          	or	a5,a4,a0
    50de:	2781                	sext.w	a5,a5
    50e0:	d7a1                	beqz	a5,5028 <concreate+0x1c6>
    50e2:	01671363          	bne	a4,s6,50e8 <concreate+0x286>
       ((i % 3) == 1 && pid != 0)){
    50e6:	f129                	bnez	a0,5028 <concreate+0x1c6>
      unlink(file);
    50e8:	fa840513          	addi	a0,s0,-88
    50ec:	00001097          	auipc	ra,0x1
    50f0:	b34080e7          	jalr	-1228(ra) # 5c20 <unlink>
      unlink(file);
    50f4:	fa840513          	addi	a0,s0,-88
    50f8:	00001097          	auipc	ra,0x1
    50fc:	b28080e7          	jalr	-1240(ra) # 5c20 <unlink>
      unlink(file);
    5100:	fa840513          	addi	a0,s0,-88
    5104:	00001097          	auipc	ra,0x1
    5108:	b1c080e7          	jalr	-1252(ra) # 5c20 <unlink>
      unlink(file);
    510c:	fa840513          	addi	a0,s0,-88
    5110:	00001097          	auipc	ra,0x1
    5114:	b10080e7          	jalr	-1264(ra) # 5c20 <unlink>
      unlink(file);
    5118:	fa840513          	addi	a0,s0,-88
    511c:	00001097          	auipc	ra,0x1
    5120:	b04080e7          	jalr	-1276(ra) # 5c20 <unlink>
      unlink(file);
    5124:	fa840513          	addi	a0,s0,-88
    5128:	00001097          	auipc	ra,0x1
    512c:	af8080e7          	jalr	-1288(ra) # 5c20 <unlink>
    5130:	bfb5                	j	50ac <concreate+0x24a>
      exit(0);
    5132:	4501                	li	a0,0
    5134:	00001097          	auipc	ra,0x1
    5138:	a9c080e7          	jalr	-1380(ra) # 5bd0 <exit>
      close(fd);
    513c:	00001097          	auipc	ra,0x1
    5140:	abc080e7          	jalr	-1348(ra) # 5bf8 <close>
    if(pid == 0) {
    5144:	bb65                	j	4efc <concreate+0x9a>
      close(fd);
    5146:	00001097          	auipc	ra,0x1
    514a:	ab2080e7          	jalr	-1358(ra) # 5bf8 <close>
      wait(&xstatus);
    514e:	f6c40513          	addi	a0,s0,-148
    5152:	00001097          	auipc	ra,0x1
    5156:	a86080e7          	jalr	-1402(ra) # 5bd8 <wait>
      if(xstatus != 0)
    515a:	f6c42483          	lw	s1,-148(s0)
    515e:	da0494e3          	bnez	s1,4f06 <concreate+0xa4>
  for(i = 0; i < N; i++){
    5162:	2905                	addiw	s2,s2,1
    5164:	db4906e3          	beq	s2,s4,4f10 <concreate+0xae>
    file[1] = '0' + i;
    5168:	0309079b          	addiw	a5,s2,48
    516c:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    5170:	fa840513          	addi	a0,s0,-88
    5174:	00001097          	auipc	ra,0x1
    5178:	aac080e7          	jalr	-1364(ra) # 5c20 <unlink>
    pid = fork();
    517c:	00001097          	auipc	ra,0x1
    5180:	a4c080e7          	jalr	-1460(ra) # 5bc8 <fork>
    if(pid && (i % 3) == 1){
    5184:	d20503e3          	beqz	a0,4eaa <concreate+0x48>
    5188:	036967bb          	remw	a5,s2,s6
    518c:	d15787e3          	beq	a5,s5,4e9a <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    5190:	20200593          	li	a1,514
    5194:	fa840513          	addi	a0,s0,-88
    5198:	00001097          	auipc	ra,0x1
    519c:	a78080e7          	jalr	-1416(ra) # 5c10 <open>
      if(fd < 0){
    51a0:	fa0553e3          	bgez	a0,5146 <concreate+0x2e4>
    51a4:	b31d                	j	4eca <concreate+0x68>
}
    51a6:	60ea                	ld	ra,152(sp)
    51a8:	644a                	ld	s0,144(sp)
    51aa:	64aa                	ld	s1,136(sp)
    51ac:	690a                	ld	s2,128(sp)
    51ae:	79e6                	ld	s3,120(sp)
    51b0:	7a46                	ld	s4,112(sp)
    51b2:	7aa6                	ld	s5,104(sp)
    51b4:	7b06                	ld	s6,96(sp)
    51b6:	6be6                	ld	s7,88(sp)
    51b8:	610d                	addi	sp,sp,160
    51ba:	8082                	ret

00000000000051bc <bigfile>:
{
    51bc:	7139                	addi	sp,sp,-64
    51be:	fc06                	sd	ra,56(sp)
    51c0:	f822                	sd	s0,48(sp)
    51c2:	f426                	sd	s1,40(sp)
    51c4:	f04a                	sd	s2,32(sp)
    51c6:	ec4e                	sd	s3,24(sp)
    51c8:	e852                	sd	s4,16(sp)
    51ca:	e456                	sd	s5,8(sp)
    51cc:	0080                	addi	s0,sp,64
    51ce:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    51d0:	00003517          	auipc	a0,0x3
    51d4:	d6050513          	addi	a0,a0,-672 # 7f30 <malloc+0x1f2a>
    51d8:	00001097          	auipc	ra,0x1
    51dc:	a48080e7          	jalr	-1464(ra) # 5c20 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    51e0:	20200593          	li	a1,514
    51e4:	00003517          	auipc	a0,0x3
    51e8:	d4c50513          	addi	a0,a0,-692 # 7f30 <malloc+0x1f2a>
    51ec:	00001097          	auipc	ra,0x1
    51f0:	a24080e7          	jalr	-1500(ra) # 5c10 <open>
    51f4:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    51f6:	4481                	li	s1,0
    memset(buf, i, SZ);
    51f8:	00008917          	auipc	s2,0x8
    51fc:	a8090913          	addi	s2,s2,-1408 # cc78 <buf>
  for(i = 0; i < N; i++){
    5200:	4a51                	li	s4,20
  if(fd < 0){
    5202:	0a054063          	bltz	a0,52a2 <bigfile+0xe6>
    memset(buf, i, SZ);
    5206:	25800613          	li	a2,600
    520a:	85a6                	mv	a1,s1
    520c:	854a                	mv	a0,s2
    520e:	00000097          	auipc	ra,0x0
    5212:	7be080e7          	jalr	1982(ra) # 59cc <memset>
    if(write(fd, buf, SZ) != SZ){
    5216:	25800613          	li	a2,600
    521a:	85ca                	mv	a1,s2
    521c:	854e                	mv	a0,s3
    521e:	00001097          	auipc	ra,0x1
    5222:	9d2080e7          	jalr	-1582(ra) # 5bf0 <write>
    5226:	25800793          	li	a5,600
    522a:	08f51a63          	bne	a0,a5,52be <bigfile+0x102>
  for(i = 0; i < N; i++){
    522e:	2485                	addiw	s1,s1,1
    5230:	fd449be3          	bne	s1,s4,5206 <bigfile+0x4a>
  close(fd);
    5234:	854e                	mv	a0,s3
    5236:	00001097          	auipc	ra,0x1
    523a:	9c2080e7          	jalr	-1598(ra) # 5bf8 <close>
  fd = open("bigfile.dat", 0);
    523e:	4581                	li	a1,0
    5240:	00003517          	auipc	a0,0x3
    5244:	cf050513          	addi	a0,a0,-784 # 7f30 <malloc+0x1f2a>
    5248:	00001097          	auipc	ra,0x1
    524c:	9c8080e7          	jalr	-1592(ra) # 5c10 <open>
    5250:	8a2a                	mv	s4,a0
  total = 0;
    5252:	4981                	li	s3,0
  for(i = 0; ; i++){
    5254:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    5256:	00008917          	auipc	s2,0x8
    525a:	a2290913          	addi	s2,s2,-1502 # cc78 <buf>
  if(fd < 0){
    525e:	06054e63          	bltz	a0,52da <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    5262:	12c00613          	li	a2,300
    5266:	85ca                	mv	a1,s2
    5268:	8552                	mv	a0,s4
    526a:	00001097          	auipc	ra,0x1
    526e:	97e080e7          	jalr	-1666(ra) # 5be8 <read>
    if(cc < 0){
    5272:	08054263          	bltz	a0,52f6 <bigfile+0x13a>
    if(cc == 0)
    5276:	c971                	beqz	a0,534a <bigfile+0x18e>
    if(cc != SZ/2){
    5278:	12c00793          	li	a5,300
    527c:	08f51b63          	bne	a0,a5,5312 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    5280:	01f4d79b          	srliw	a5,s1,0x1f
    5284:	9fa5                	addw	a5,a5,s1
    5286:	4017d79b          	sraiw	a5,a5,0x1
    528a:	00094703          	lbu	a4,0(s2)
    528e:	0af71063          	bne	a4,a5,532e <bigfile+0x172>
    5292:	12b94703          	lbu	a4,299(s2)
    5296:	08f71c63          	bne	a4,a5,532e <bigfile+0x172>
    total += cc;
    529a:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    529e:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    52a0:	b7c9                	j	5262 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    52a2:	85d6                	mv	a1,s5
    52a4:	00003517          	auipc	a0,0x3
    52a8:	c9c50513          	addi	a0,a0,-868 # 7f40 <malloc+0x1f3a>
    52ac:	00001097          	auipc	ra,0x1
    52b0:	c9c080e7          	jalr	-868(ra) # 5f48 <printf>
    exit(1);
    52b4:	4505                	li	a0,1
    52b6:	00001097          	auipc	ra,0x1
    52ba:	91a080e7          	jalr	-1766(ra) # 5bd0 <exit>
      printf("%s: write bigfile failed\n", s);
    52be:	85d6                	mv	a1,s5
    52c0:	00003517          	auipc	a0,0x3
    52c4:	ca050513          	addi	a0,a0,-864 # 7f60 <malloc+0x1f5a>
    52c8:	00001097          	auipc	ra,0x1
    52cc:	c80080e7          	jalr	-896(ra) # 5f48 <printf>
      exit(1);
    52d0:	4505                	li	a0,1
    52d2:	00001097          	auipc	ra,0x1
    52d6:	8fe080e7          	jalr	-1794(ra) # 5bd0 <exit>
    printf("%s: cannot open bigfile\n", s);
    52da:	85d6                	mv	a1,s5
    52dc:	00003517          	auipc	a0,0x3
    52e0:	ca450513          	addi	a0,a0,-860 # 7f80 <malloc+0x1f7a>
    52e4:	00001097          	auipc	ra,0x1
    52e8:	c64080e7          	jalr	-924(ra) # 5f48 <printf>
    exit(1);
    52ec:	4505                	li	a0,1
    52ee:	00001097          	auipc	ra,0x1
    52f2:	8e2080e7          	jalr	-1822(ra) # 5bd0 <exit>
      printf("%s: read bigfile failed\n", s);
    52f6:	85d6                	mv	a1,s5
    52f8:	00003517          	auipc	a0,0x3
    52fc:	ca850513          	addi	a0,a0,-856 # 7fa0 <malloc+0x1f9a>
    5300:	00001097          	auipc	ra,0x1
    5304:	c48080e7          	jalr	-952(ra) # 5f48 <printf>
      exit(1);
    5308:	4505                	li	a0,1
    530a:	00001097          	auipc	ra,0x1
    530e:	8c6080e7          	jalr	-1850(ra) # 5bd0 <exit>
      printf("%s: short read bigfile\n", s);
    5312:	85d6                	mv	a1,s5
    5314:	00003517          	auipc	a0,0x3
    5318:	cac50513          	addi	a0,a0,-852 # 7fc0 <malloc+0x1fba>
    531c:	00001097          	auipc	ra,0x1
    5320:	c2c080e7          	jalr	-980(ra) # 5f48 <printf>
      exit(1);
    5324:	4505                	li	a0,1
    5326:	00001097          	auipc	ra,0x1
    532a:	8aa080e7          	jalr	-1878(ra) # 5bd0 <exit>
      printf("%s: read bigfile wrong data\n", s);
    532e:	85d6                	mv	a1,s5
    5330:	00003517          	auipc	a0,0x3
    5334:	ca850513          	addi	a0,a0,-856 # 7fd8 <malloc+0x1fd2>
    5338:	00001097          	auipc	ra,0x1
    533c:	c10080e7          	jalr	-1008(ra) # 5f48 <printf>
      exit(1);
    5340:	4505                	li	a0,1
    5342:	00001097          	auipc	ra,0x1
    5346:	88e080e7          	jalr	-1906(ra) # 5bd0 <exit>
  close(fd);
    534a:	8552                	mv	a0,s4
    534c:	00001097          	auipc	ra,0x1
    5350:	8ac080e7          	jalr	-1876(ra) # 5bf8 <close>
  if(total != N*SZ){
    5354:	678d                	lui	a5,0x3
    5356:	ee078793          	addi	a5,a5,-288 # 2ee0 <sbrklast+0x86>
    535a:	02f99363          	bne	s3,a5,5380 <bigfile+0x1c4>
  unlink("bigfile.dat");
    535e:	00003517          	auipc	a0,0x3
    5362:	bd250513          	addi	a0,a0,-1070 # 7f30 <malloc+0x1f2a>
    5366:	00001097          	auipc	ra,0x1
    536a:	8ba080e7          	jalr	-1862(ra) # 5c20 <unlink>
}
    536e:	70e2                	ld	ra,56(sp)
    5370:	7442                	ld	s0,48(sp)
    5372:	74a2                	ld	s1,40(sp)
    5374:	7902                	ld	s2,32(sp)
    5376:	69e2                	ld	s3,24(sp)
    5378:	6a42                	ld	s4,16(sp)
    537a:	6aa2                	ld	s5,8(sp)
    537c:	6121                	addi	sp,sp,64
    537e:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    5380:	85d6                	mv	a1,s5
    5382:	00003517          	auipc	a0,0x3
    5386:	c7650513          	addi	a0,a0,-906 # 7ff8 <malloc+0x1ff2>
    538a:	00001097          	auipc	ra,0x1
    538e:	bbe080e7          	jalr	-1090(ra) # 5f48 <printf>
    exit(1);
    5392:	4505                	li	a0,1
    5394:	00001097          	auipc	ra,0x1
    5398:	83c080e7          	jalr	-1988(ra) # 5bd0 <exit>

000000000000539c <fsfull>:
{
    539c:	7171                	addi	sp,sp,-176
    539e:	f506                	sd	ra,168(sp)
    53a0:	f122                	sd	s0,160(sp)
    53a2:	ed26                	sd	s1,152(sp)
    53a4:	e94a                	sd	s2,144(sp)
    53a6:	e54e                	sd	s3,136(sp)
    53a8:	e152                	sd	s4,128(sp)
    53aa:	fcd6                	sd	s5,120(sp)
    53ac:	f8da                	sd	s6,112(sp)
    53ae:	f4de                	sd	s7,104(sp)
    53b0:	f0e2                	sd	s8,96(sp)
    53b2:	ece6                	sd	s9,88(sp)
    53b4:	e8ea                	sd	s10,80(sp)
    53b6:	e4ee                	sd	s11,72(sp)
    53b8:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    53ba:	00003517          	auipc	a0,0x3
    53be:	c5e50513          	addi	a0,a0,-930 # 8018 <malloc+0x2012>
    53c2:	00001097          	auipc	ra,0x1
    53c6:	b86080e7          	jalr	-1146(ra) # 5f48 <printf>
  for(nfiles = 0; ; nfiles++){
    53ca:	4481                	li	s1,0
    name[0] = 'f';
    53cc:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    53d0:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    53d4:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    53d8:	4b29                	li	s6,10
    printf("writing %s\n", name);
    53da:	00003c97          	auipc	s9,0x3
    53de:	c4ec8c93          	addi	s9,s9,-946 # 8028 <malloc+0x2022>
    int total = 0;
    53e2:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    53e4:	00008a17          	auipc	s4,0x8
    53e8:	894a0a13          	addi	s4,s4,-1900 # cc78 <buf>
    name[0] = 'f';
    53ec:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    53f0:	0384c7bb          	divw	a5,s1,s8
    53f4:	0307879b          	addiw	a5,a5,48
    53f8:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    53fc:	0384e7bb          	remw	a5,s1,s8
    5400:	0377c7bb          	divw	a5,a5,s7
    5404:	0307879b          	addiw	a5,a5,48
    5408:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    540c:	0374e7bb          	remw	a5,s1,s7
    5410:	0367c7bb          	divw	a5,a5,s6
    5414:	0307879b          	addiw	a5,a5,48
    5418:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    541c:	0364e7bb          	remw	a5,s1,s6
    5420:	0307879b          	addiw	a5,a5,48
    5424:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    5428:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    542c:	f5040593          	addi	a1,s0,-176
    5430:	8566                	mv	a0,s9
    5432:	00001097          	auipc	ra,0x1
    5436:	b16080e7          	jalr	-1258(ra) # 5f48 <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    543a:	20200593          	li	a1,514
    543e:	f5040513          	addi	a0,s0,-176
    5442:	00000097          	auipc	ra,0x0
    5446:	7ce080e7          	jalr	1998(ra) # 5c10 <open>
    544a:	892a                	mv	s2,a0
    if(fd < 0){
    544c:	0a055663          	bgez	a0,54f8 <fsfull+0x15c>
      printf("open %s failed\n", name);
    5450:	f5040593          	addi	a1,s0,-176
    5454:	00003517          	auipc	a0,0x3
    5458:	be450513          	addi	a0,a0,-1052 # 8038 <malloc+0x2032>
    545c:	00001097          	auipc	ra,0x1
    5460:	aec080e7          	jalr	-1300(ra) # 5f48 <printf>
  while(nfiles >= 0){
    5464:	0604c363          	bltz	s1,54ca <fsfull+0x12e>
    name[0] = 'f';
    5468:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    546c:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    5470:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    5474:	4929                	li	s2,10
  while(nfiles >= 0){
    5476:	5afd                	li	s5,-1
    name[0] = 'f';
    5478:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    547c:	0344c7bb          	divw	a5,s1,s4
    5480:	0307879b          	addiw	a5,a5,48
    5484:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    5488:	0344e7bb          	remw	a5,s1,s4
    548c:	0337c7bb          	divw	a5,a5,s3
    5490:	0307879b          	addiw	a5,a5,48
    5494:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5498:	0334e7bb          	remw	a5,s1,s3
    549c:	0327c7bb          	divw	a5,a5,s2
    54a0:	0307879b          	addiw	a5,a5,48
    54a4:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    54a8:	0324e7bb          	remw	a5,s1,s2
    54ac:	0307879b          	addiw	a5,a5,48
    54b0:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    54b4:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    54b8:	f5040513          	addi	a0,s0,-176
    54bc:	00000097          	auipc	ra,0x0
    54c0:	764080e7          	jalr	1892(ra) # 5c20 <unlink>
    nfiles--;
    54c4:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    54c6:	fb5499e3          	bne	s1,s5,5478 <fsfull+0xdc>
  printf("fsfull test finished\n");
    54ca:	00003517          	auipc	a0,0x3
    54ce:	b8e50513          	addi	a0,a0,-1138 # 8058 <malloc+0x2052>
    54d2:	00001097          	auipc	ra,0x1
    54d6:	a76080e7          	jalr	-1418(ra) # 5f48 <printf>
}
    54da:	70aa                	ld	ra,168(sp)
    54dc:	740a                	ld	s0,160(sp)
    54de:	64ea                	ld	s1,152(sp)
    54e0:	694a                	ld	s2,144(sp)
    54e2:	69aa                	ld	s3,136(sp)
    54e4:	6a0a                	ld	s4,128(sp)
    54e6:	7ae6                	ld	s5,120(sp)
    54e8:	7b46                	ld	s6,112(sp)
    54ea:	7ba6                	ld	s7,104(sp)
    54ec:	7c06                	ld	s8,96(sp)
    54ee:	6ce6                	ld	s9,88(sp)
    54f0:	6d46                	ld	s10,80(sp)
    54f2:	6da6                	ld	s11,72(sp)
    54f4:	614d                	addi	sp,sp,176
    54f6:	8082                	ret
    int total = 0;
    54f8:	89ee                	mv	s3,s11
      if(cc < BSIZE)
    54fa:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    54fe:	40000613          	li	a2,1024
    5502:	85d2                	mv	a1,s4
    5504:	854a                	mv	a0,s2
    5506:	00000097          	auipc	ra,0x0
    550a:	6ea080e7          	jalr	1770(ra) # 5bf0 <write>
      if(cc < BSIZE)
    550e:	00aad563          	bge	s5,a0,5518 <fsfull+0x17c>
      total += cc;
    5512:	00a989bb          	addw	s3,s3,a0
    while(1){
    5516:	b7e5                	j	54fe <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    5518:	85ce                	mv	a1,s3
    551a:	00003517          	auipc	a0,0x3
    551e:	b2e50513          	addi	a0,a0,-1234 # 8048 <malloc+0x2042>
    5522:	00001097          	auipc	ra,0x1
    5526:	a26080e7          	jalr	-1498(ra) # 5f48 <printf>
    close(fd);
    552a:	854a                	mv	a0,s2
    552c:	00000097          	auipc	ra,0x0
    5530:	6cc080e7          	jalr	1740(ra) # 5bf8 <close>
    if(total == 0)
    5534:	f20988e3          	beqz	s3,5464 <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    5538:	2485                	addiw	s1,s1,1
    553a:	bd4d                	j	53ec <fsfull+0x50>

000000000000553c <run>:
//

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    553c:	7179                	addi	sp,sp,-48
    553e:	f406                	sd	ra,40(sp)
    5540:	f022                	sd	s0,32(sp)
    5542:	ec26                	sd	s1,24(sp)
    5544:	e84a                	sd	s2,16(sp)
    5546:	1800                	addi	s0,sp,48
    5548:	84aa                	mv	s1,a0
    554a:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    554c:	00003517          	auipc	a0,0x3
    5550:	b2450513          	addi	a0,a0,-1244 # 8070 <malloc+0x206a>
    5554:	00001097          	auipc	ra,0x1
    5558:	9f4080e7          	jalr	-1548(ra) # 5f48 <printf>
  if((pid = fork()) < 0) {
    555c:	00000097          	auipc	ra,0x0
    5560:	66c080e7          	jalr	1644(ra) # 5bc8 <fork>
    5564:	02054e63          	bltz	a0,55a0 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    5568:	c929                	beqz	a0,55ba <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    556a:	fdc40513          	addi	a0,s0,-36
    556e:	00000097          	auipc	ra,0x0
    5572:	66a080e7          	jalr	1642(ra) # 5bd8 <wait>
    if(xstatus != 0) 
    5576:	fdc42783          	lw	a5,-36(s0)
    557a:	c7b9                	beqz	a5,55c8 <run+0x8c>
      printf("FAILED\n");
    557c:	00003517          	auipc	a0,0x3
    5580:	b1c50513          	addi	a0,a0,-1252 # 8098 <malloc+0x2092>
    5584:	00001097          	auipc	ra,0x1
    5588:	9c4080e7          	jalr	-1596(ra) # 5f48 <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    558c:	fdc42503          	lw	a0,-36(s0)
  }
}
    5590:	00153513          	seqz	a0,a0
    5594:	70a2                	ld	ra,40(sp)
    5596:	7402                	ld	s0,32(sp)
    5598:	64e2                	ld	s1,24(sp)
    559a:	6942                	ld	s2,16(sp)
    559c:	6145                	addi	sp,sp,48
    559e:	8082                	ret
    printf("runtest: fork error\n");
    55a0:	00003517          	auipc	a0,0x3
    55a4:	ae050513          	addi	a0,a0,-1312 # 8080 <malloc+0x207a>
    55a8:	00001097          	auipc	ra,0x1
    55ac:	9a0080e7          	jalr	-1632(ra) # 5f48 <printf>
    exit(1);
    55b0:	4505                	li	a0,1
    55b2:	00000097          	auipc	ra,0x0
    55b6:	61e080e7          	jalr	1566(ra) # 5bd0 <exit>
    f(s);
    55ba:	854a                	mv	a0,s2
    55bc:	9482                	jalr	s1
    exit(0);
    55be:	4501                	li	a0,0
    55c0:	00000097          	auipc	ra,0x0
    55c4:	610080e7          	jalr	1552(ra) # 5bd0 <exit>
      printf("OK\n");
    55c8:	00003517          	auipc	a0,0x3
    55cc:	ad850513          	addi	a0,a0,-1320 # 80a0 <malloc+0x209a>
    55d0:	00001097          	auipc	ra,0x1
    55d4:	978080e7          	jalr	-1672(ra) # 5f48 <printf>
    55d8:	bf55                	j	558c <run+0x50>

00000000000055da <runtests>:

int
runtests(struct test *tests, char *justone) {
    55da:	1101                	addi	sp,sp,-32
    55dc:	ec06                	sd	ra,24(sp)
    55de:	e822                	sd	s0,16(sp)
    55e0:	e426                	sd	s1,8(sp)
    55e2:	e04a                	sd	s2,0(sp)
    55e4:	1000                	addi	s0,sp,32
    55e6:	84aa                	mv	s1,a0
    55e8:	892e                	mv	s2,a1
  for (struct test *t = tests; t->s != 0; t++) {
    55ea:	6508                	ld	a0,8(a0)
    55ec:	ed09                	bnez	a0,5606 <runtests+0x2c>
        printf("SOME TESTS FAILED\n");
        return 1;
      }
    }
  }
  return 0;
    55ee:	4501                	li	a0,0
    55f0:	a82d                	j	562a <runtests+0x50>
      if(!run(t->f, t->s)){
    55f2:	648c                	ld	a1,8(s1)
    55f4:	6088                	ld	a0,0(s1)
    55f6:	00000097          	auipc	ra,0x0
    55fa:	f46080e7          	jalr	-186(ra) # 553c <run>
    55fe:	cd09                	beqz	a0,5618 <runtests+0x3e>
  for (struct test *t = tests; t->s != 0; t++) {
    5600:	04c1                	addi	s1,s1,16
    5602:	6488                	ld	a0,8(s1)
    5604:	c11d                	beqz	a0,562a <runtests+0x50>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    5606:	fe0906e3          	beqz	s2,55f2 <runtests+0x18>
    560a:	85ca                	mv	a1,s2
    560c:	00000097          	auipc	ra,0x0
    5610:	36a080e7          	jalr	874(ra) # 5976 <strcmp>
    5614:	f575                	bnez	a0,5600 <runtests+0x26>
    5616:	bff1                	j	55f2 <runtests+0x18>
        printf("SOME TESTS FAILED\n");
    5618:	00003517          	auipc	a0,0x3
    561c:	a9050513          	addi	a0,a0,-1392 # 80a8 <malloc+0x20a2>
    5620:	00001097          	auipc	ra,0x1
    5624:	928080e7          	jalr	-1752(ra) # 5f48 <printf>
        return 1;
    5628:	4505                	li	a0,1
}
    562a:	60e2                	ld	ra,24(sp)
    562c:	6442                	ld	s0,16(sp)
    562e:	64a2                	ld	s1,8(sp)
    5630:	6902                	ld	s2,0(sp)
    5632:	6105                	addi	sp,sp,32
    5634:	8082                	ret

0000000000005636 <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    5636:	7139                	addi	sp,sp,-64
    5638:	fc06                	sd	ra,56(sp)
    563a:	f822                	sd	s0,48(sp)
    563c:	f426                	sd	s1,40(sp)
    563e:	f04a                	sd	s2,32(sp)
    5640:	ec4e                	sd	s3,24(sp)
    5642:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    5644:	fc840513          	addi	a0,s0,-56
    5648:	00000097          	auipc	ra,0x0
    564c:	598080e7          	jalr	1432(ra) # 5be0 <pipe>
    5650:	06054863          	bltz	a0,56c0 <countfree+0x8a>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    5654:	00000097          	auipc	ra,0x0
    5658:	574080e7          	jalr	1396(ra) # 5bc8 <fork>

  if(pid < 0){
    565c:	06054f63          	bltz	a0,56da <countfree+0xa4>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    5660:	ed59                	bnez	a0,56fe <countfree+0xc8>
    close(fds[0]);
    5662:	fc842503          	lw	a0,-56(s0)
    5666:	00000097          	auipc	ra,0x0
    566a:	592080e7          	jalr	1426(ra) # 5bf8 <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    566e:	54fd                	li	s1,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    5670:	4985                	li	s3,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    5672:	00001917          	auipc	s2,0x1
    5676:	b4690913          	addi	s2,s2,-1210 # 61b8 <malloc+0x1b2>
      uint64 a = (uint64) sbrk(4096);
    567a:	6505                	lui	a0,0x1
    567c:	00000097          	auipc	ra,0x0
    5680:	5dc080e7          	jalr	1500(ra) # 5c58 <sbrk>
      if(a == 0xffffffffffffffff){
    5684:	06950863          	beq	a0,s1,56f4 <countfree+0xbe>
      *(char *)(a + 4096 - 1) = 1;
    5688:	6785                	lui	a5,0x1
    568a:	953e                	add	a0,a0,a5
    568c:	ff350fa3          	sb	s3,-1(a0) # fff <linktest+0x109>
      if(write(fds[1], "x", 1) != 1){
    5690:	4605                	li	a2,1
    5692:	85ca                	mv	a1,s2
    5694:	fcc42503          	lw	a0,-52(s0)
    5698:	00000097          	auipc	ra,0x0
    569c:	558080e7          	jalr	1368(ra) # 5bf0 <write>
    56a0:	4785                	li	a5,1
    56a2:	fcf50ce3          	beq	a0,a5,567a <countfree+0x44>
        printf("write() failed in countfree()\n");
    56a6:	00003517          	auipc	a0,0x3
    56aa:	a5a50513          	addi	a0,a0,-1446 # 8100 <malloc+0x20fa>
    56ae:	00001097          	auipc	ra,0x1
    56b2:	89a080e7          	jalr	-1894(ra) # 5f48 <printf>
        exit(1);
    56b6:	4505                	li	a0,1
    56b8:	00000097          	auipc	ra,0x0
    56bc:	518080e7          	jalr	1304(ra) # 5bd0 <exit>
    printf("pipe() failed in countfree()\n");
    56c0:	00003517          	auipc	a0,0x3
    56c4:	a0050513          	addi	a0,a0,-1536 # 80c0 <malloc+0x20ba>
    56c8:	00001097          	auipc	ra,0x1
    56cc:	880080e7          	jalr	-1920(ra) # 5f48 <printf>
    exit(1);
    56d0:	4505                	li	a0,1
    56d2:	00000097          	auipc	ra,0x0
    56d6:	4fe080e7          	jalr	1278(ra) # 5bd0 <exit>
    printf("fork failed in countfree()\n");
    56da:	00003517          	auipc	a0,0x3
    56de:	a0650513          	addi	a0,a0,-1530 # 80e0 <malloc+0x20da>
    56e2:	00001097          	auipc	ra,0x1
    56e6:	866080e7          	jalr	-1946(ra) # 5f48 <printf>
    exit(1);
    56ea:	4505                	li	a0,1
    56ec:	00000097          	auipc	ra,0x0
    56f0:	4e4080e7          	jalr	1252(ra) # 5bd0 <exit>
      }
    }

    exit(0);
    56f4:	4501                	li	a0,0
    56f6:	00000097          	auipc	ra,0x0
    56fa:	4da080e7          	jalr	1242(ra) # 5bd0 <exit>
  }

  close(fds[1]);
    56fe:	fcc42503          	lw	a0,-52(s0)
    5702:	00000097          	auipc	ra,0x0
    5706:	4f6080e7          	jalr	1270(ra) # 5bf8 <close>

  int n = 0;
    570a:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    570c:	4605                	li	a2,1
    570e:	fc740593          	addi	a1,s0,-57
    5712:	fc842503          	lw	a0,-56(s0)
    5716:	00000097          	auipc	ra,0x0
    571a:	4d2080e7          	jalr	1234(ra) # 5be8 <read>
    if(cc < 0){
    571e:	00054563          	bltz	a0,5728 <countfree+0xf2>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    5722:	c105                	beqz	a0,5742 <countfree+0x10c>
      break;
    n += 1;
    5724:	2485                	addiw	s1,s1,1
  while(1){
    5726:	b7dd                	j	570c <countfree+0xd6>
      printf("read() failed in countfree()\n");
    5728:	00003517          	auipc	a0,0x3
    572c:	9f850513          	addi	a0,a0,-1544 # 8120 <malloc+0x211a>
    5730:	00001097          	auipc	ra,0x1
    5734:	818080e7          	jalr	-2024(ra) # 5f48 <printf>
      exit(1);
    5738:	4505                	li	a0,1
    573a:	00000097          	auipc	ra,0x0
    573e:	496080e7          	jalr	1174(ra) # 5bd0 <exit>
  }

  close(fds[0]);
    5742:	fc842503          	lw	a0,-56(s0)
    5746:	00000097          	auipc	ra,0x0
    574a:	4b2080e7          	jalr	1202(ra) # 5bf8 <close>
  wait((int*)0);
    574e:	4501                	li	a0,0
    5750:	00000097          	auipc	ra,0x0
    5754:	488080e7          	jalr	1160(ra) # 5bd8 <wait>
  
  return n;
}
    5758:	8526                	mv	a0,s1
    575a:	70e2                	ld	ra,56(sp)
    575c:	7442                	ld	s0,48(sp)
    575e:	74a2                	ld	s1,40(sp)
    5760:	7902                	ld	s2,32(sp)
    5762:	69e2                	ld	s3,24(sp)
    5764:	6121                	addi	sp,sp,64
    5766:	8082                	ret

0000000000005768 <drivetests>:

int
drivetests(int quick, int continuous, char *justone) {
    5768:	711d                	addi	sp,sp,-96
    576a:	ec86                	sd	ra,88(sp)
    576c:	e8a2                	sd	s0,80(sp)
    576e:	e4a6                	sd	s1,72(sp)
    5770:	e0ca                	sd	s2,64(sp)
    5772:	fc4e                	sd	s3,56(sp)
    5774:	f852                	sd	s4,48(sp)
    5776:	f456                	sd	s5,40(sp)
    5778:	f05a                	sd	s6,32(sp)
    577a:	ec5e                	sd	s7,24(sp)
    577c:	e862                	sd	s8,16(sp)
    577e:	e466                	sd	s9,8(sp)
    5780:	e06a                	sd	s10,0(sp)
    5782:	1080                	addi	s0,sp,96
    5784:	8a2a                	mv	s4,a0
    5786:	89ae                	mv	s3,a1
    5788:	8932                	mv	s2,a2
  do {
    printf("usertests starting\n");
    578a:	00003b97          	auipc	s7,0x3
    578e:	9b6b8b93          	addi	s7,s7,-1610 # 8140 <malloc+0x213a>
    int free0 = countfree();
    int free1 = 0;
    if (runtests(quicktests, justone)) {
    5792:	00004b17          	auipc	s6,0x4
    5796:	87eb0b13          	addi	s6,s6,-1922 # 9010 <quicktests>
      if(continuous != 2) {
    579a:	4a89                	li	s5,2
          return 1;
        }
      }
    }
    if((free1 = countfree()) < free0) {
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    579c:	00003c97          	auipc	s9,0x3
    57a0:	9dcc8c93          	addi	s9,s9,-1572 # 8178 <malloc+0x2172>
      if (runtests(slowtests, justone)) {
    57a4:	00004c17          	auipc	s8,0x4
    57a8:	c3cc0c13          	addi	s8,s8,-964 # 93e0 <slowtests>
        printf("usertests slow tests starting\n");
    57ac:	00003d17          	auipc	s10,0x3
    57b0:	9acd0d13          	addi	s10,s10,-1620 # 8158 <malloc+0x2152>
    57b4:	a839                	j	57d2 <drivetests+0x6a>
    57b6:	856a                	mv	a0,s10
    57b8:	00000097          	auipc	ra,0x0
    57bc:	790080e7          	jalr	1936(ra) # 5f48 <printf>
    57c0:	a081                	j	5800 <drivetests+0x98>
    if((free1 = countfree()) < free0) {
    57c2:	00000097          	auipc	ra,0x0
    57c6:	e74080e7          	jalr	-396(ra) # 5636 <countfree>
    57ca:	06954263          	blt	a0,s1,582e <drivetests+0xc6>
      if(continuous != 2) {
        return 1;
      }
    }
  } while(continuous);
    57ce:	06098f63          	beqz	s3,584c <drivetests+0xe4>
    printf("usertests starting\n");
    57d2:	855e                	mv	a0,s7
    57d4:	00000097          	auipc	ra,0x0
    57d8:	774080e7          	jalr	1908(ra) # 5f48 <printf>
    int free0 = countfree();
    57dc:	00000097          	auipc	ra,0x0
    57e0:	e5a080e7          	jalr	-422(ra) # 5636 <countfree>
    57e4:	84aa                	mv	s1,a0
    if (runtests(quicktests, justone)) {
    57e6:	85ca                	mv	a1,s2
    57e8:	855a                	mv	a0,s6
    57ea:	00000097          	auipc	ra,0x0
    57ee:	df0080e7          	jalr	-528(ra) # 55da <runtests>
    57f2:	c119                	beqz	a0,57f8 <drivetests+0x90>
      if(continuous != 2) {
    57f4:	05599863          	bne	s3,s5,5844 <drivetests+0xdc>
    if(!quick) {
    57f8:	fc0a15e3          	bnez	s4,57c2 <drivetests+0x5a>
      if (justone == 0)
    57fc:	fa090de3          	beqz	s2,57b6 <drivetests+0x4e>
      if (runtests(slowtests, justone)) {
    5800:	85ca                	mv	a1,s2
    5802:	8562                	mv	a0,s8
    5804:	00000097          	auipc	ra,0x0
    5808:	dd6080e7          	jalr	-554(ra) # 55da <runtests>
    580c:	d95d                	beqz	a0,57c2 <drivetests+0x5a>
        if(continuous != 2) {
    580e:	03599d63          	bne	s3,s5,5848 <drivetests+0xe0>
    if((free1 = countfree()) < free0) {
    5812:	00000097          	auipc	ra,0x0
    5816:	e24080e7          	jalr	-476(ra) # 5636 <countfree>
    581a:	fa955ae3          	bge	a0,s1,57ce <drivetests+0x66>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    581e:	8626                	mv	a2,s1
    5820:	85aa                	mv	a1,a0
    5822:	8566                	mv	a0,s9
    5824:	00000097          	auipc	ra,0x0
    5828:	724080e7          	jalr	1828(ra) # 5f48 <printf>
      if(continuous != 2) {
    582c:	b75d                	j	57d2 <drivetests+0x6a>
      printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    582e:	8626                	mv	a2,s1
    5830:	85aa                	mv	a1,a0
    5832:	8566                	mv	a0,s9
    5834:	00000097          	auipc	ra,0x0
    5838:	714080e7          	jalr	1812(ra) # 5f48 <printf>
      if(continuous != 2) {
    583c:	f9598be3          	beq	s3,s5,57d2 <drivetests+0x6a>
        return 1;
    5840:	4505                	li	a0,1
    5842:	a031                	j	584e <drivetests+0xe6>
        return 1;
    5844:	4505                	li	a0,1
    5846:	a021                	j	584e <drivetests+0xe6>
          return 1;
    5848:	4505                	li	a0,1
    584a:	a011                	j	584e <drivetests+0xe6>
  return 0;
    584c:	854e                	mv	a0,s3
}
    584e:	60e6                	ld	ra,88(sp)
    5850:	6446                	ld	s0,80(sp)
    5852:	64a6                	ld	s1,72(sp)
    5854:	6906                	ld	s2,64(sp)
    5856:	79e2                	ld	s3,56(sp)
    5858:	7a42                	ld	s4,48(sp)
    585a:	7aa2                	ld	s5,40(sp)
    585c:	7b02                	ld	s6,32(sp)
    585e:	6be2                	ld	s7,24(sp)
    5860:	6c42                	ld	s8,16(sp)
    5862:	6ca2                	ld	s9,8(sp)
    5864:	6d02                	ld	s10,0(sp)
    5866:	6125                	addi	sp,sp,96
    5868:	8082                	ret

000000000000586a <main>:

int
main(int argc, char *argv[])
{
    586a:	1101                	addi	sp,sp,-32
    586c:	ec06                	sd	ra,24(sp)
    586e:	e822                	sd	s0,16(sp)
    5870:	e426                	sd	s1,8(sp)
    5872:	e04a                	sd	s2,0(sp)
    5874:	1000                	addi	s0,sp,32
    5876:	84aa                	mv	s1,a0
  int continuous = 0;
  int quick = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    5878:	4789                	li	a5,2
    587a:	02f50363          	beq	a0,a5,58a0 <main+0x36>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    587e:	4785                	li	a5,1
    5880:	06a7cd63          	blt	a5,a0,58fa <main+0x90>
  char *justone = 0;
    5884:	4601                	li	a2,0
  int quick = 0;
    5886:	4501                	li	a0,0
  int continuous = 0;
    5888:	4481                	li	s1,0
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    exit(1);
  }
  if (drivetests(quick, continuous, justone)) {
    588a:	85a6                	mv	a1,s1
    588c:	00000097          	auipc	ra,0x0
    5890:	edc080e7          	jalr	-292(ra) # 5768 <drivetests>
    5894:	c949                	beqz	a0,5926 <main+0xbc>
    exit(1);
    5896:	4505                	li	a0,1
    5898:	00000097          	auipc	ra,0x0
    589c:	338080e7          	jalr	824(ra) # 5bd0 <exit>
    58a0:	892e                	mv	s2,a1
  if(argc == 2 && strcmp(argv[1], "-q") == 0){
    58a2:	00003597          	auipc	a1,0x3
    58a6:	90658593          	addi	a1,a1,-1786 # 81a8 <malloc+0x21a2>
    58aa:	00893503          	ld	a0,8(s2)
    58ae:	00000097          	auipc	ra,0x0
    58b2:	0c8080e7          	jalr	200(ra) # 5976 <strcmp>
    58b6:	cd39                	beqz	a0,5914 <main+0xaa>
  } else if(argc == 2 && strcmp(argv[1], "-c") == 0){
    58b8:	00003597          	auipc	a1,0x3
    58bc:	94858593          	addi	a1,a1,-1720 # 8200 <malloc+0x21fa>
    58c0:	00893503          	ld	a0,8(s2)
    58c4:	00000097          	auipc	ra,0x0
    58c8:	0b2080e7          	jalr	178(ra) # 5976 <strcmp>
    58cc:	c931                	beqz	a0,5920 <main+0xb6>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    58ce:	00003597          	auipc	a1,0x3
    58d2:	92a58593          	addi	a1,a1,-1750 # 81f8 <malloc+0x21f2>
    58d6:	00893503          	ld	a0,8(s2)
    58da:	00000097          	auipc	ra,0x0
    58de:	09c080e7          	jalr	156(ra) # 5976 <strcmp>
    58e2:	cd0d                	beqz	a0,591c <main+0xb2>
  } else if(argc == 2 && argv[1][0] != '-'){
    58e4:	00893603          	ld	a2,8(s2)
    58e8:	00064703          	lbu	a4,0(a2) # 3000 <execout+0x9e>
    58ec:	02d00793          	li	a5,45
    58f0:	00f70563          	beq	a4,a5,58fa <main+0x90>
  int quick = 0;
    58f4:	4501                	li	a0,0
  int continuous = 0;
    58f6:	4481                	li	s1,0
    58f8:	bf49                	j	588a <main+0x20>
    printf("Usage: usertests [-c] [-C] [-q] [testname]\n");
    58fa:	00003517          	auipc	a0,0x3
    58fe:	8b650513          	addi	a0,a0,-1866 # 81b0 <malloc+0x21aa>
    5902:	00000097          	auipc	ra,0x0
    5906:	646080e7          	jalr	1606(ra) # 5f48 <printf>
    exit(1);
    590a:	4505                	li	a0,1
    590c:	00000097          	auipc	ra,0x0
    5910:	2c4080e7          	jalr	708(ra) # 5bd0 <exit>
  int continuous = 0;
    5914:	84aa                	mv	s1,a0
  char *justone = 0;
    5916:	4601                	li	a2,0
    quick = 1;
    5918:	4505                	li	a0,1
    591a:	bf85                	j	588a <main+0x20>
  char *justone = 0;
    591c:	4601                	li	a2,0
    591e:	b7b5                	j	588a <main+0x20>
    5920:	4601                	li	a2,0
    continuous = 1;
    5922:	4485                	li	s1,1
    5924:	b79d                	j	588a <main+0x20>
  }
  printf("ALL TESTS PASSED\n");
    5926:	00003517          	auipc	a0,0x3
    592a:	8ba50513          	addi	a0,a0,-1862 # 81e0 <malloc+0x21da>
    592e:	00000097          	auipc	ra,0x0
    5932:	61a080e7          	jalr	1562(ra) # 5f48 <printf>
  exit(0);
    5936:	4501                	li	a0,0
    5938:	00000097          	auipc	ra,0x0
    593c:	298080e7          	jalr	664(ra) # 5bd0 <exit>

0000000000005940 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    5940:	1141                	addi	sp,sp,-16
    5942:	e406                	sd	ra,8(sp)
    5944:	e022                	sd	s0,0(sp)
    5946:	0800                	addi	s0,sp,16
  extern int main();
  main();
    5948:	00000097          	auipc	ra,0x0
    594c:	f22080e7          	jalr	-222(ra) # 586a <main>
  exit(0);
    5950:	4501                	li	a0,0
    5952:	00000097          	auipc	ra,0x0
    5956:	27e080e7          	jalr	638(ra) # 5bd0 <exit>

000000000000595a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    595a:	1141                	addi	sp,sp,-16
    595c:	e422                	sd	s0,8(sp)
    595e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    5960:	87aa                	mv	a5,a0
    5962:	0585                	addi	a1,a1,1
    5964:	0785                	addi	a5,a5,1
    5966:	fff5c703          	lbu	a4,-1(a1)
    596a:	fee78fa3          	sb	a4,-1(a5) # fff <linktest+0x109>
    596e:	fb75                	bnez	a4,5962 <strcpy+0x8>
    ;
  return os;
}
    5970:	6422                	ld	s0,8(sp)
    5972:	0141                	addi	sp,sp,16
    5974:	8082                	ret

0000000000005976 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    5976:	1141                	addi	sp,sp,-16
    5978:	e422                	sd	s0,8(sp)
    597a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    597c:	00054783          	lbu	a5,0(a0)
    5980:	cb91                	beqz	a5,5994 <strcmp+0x1e>
    5982:	0005c703          	lbu	a4,0(a1)
    5986:	00f71763          	bne	a4,a5,5994 <strcmp+0x1e>
    p++, q++;
    598a:	0505                	addi	a0,a0,1
    598c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    598e:	00054783          	lbu	a5,0(a0)
    5992:	fbe5                	bnez	a5,5982 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    5994:	0005c503          	lbu	a0,0(a1)
}
    5998:	40a7853b          	subw	a0,a5,a0
    599c:	6422                	ld	s0,8(sp)
    599e:	0141                	addi	sp,sp,16
    59a0:	8082                	ret

00000000000059a2 <strlen>:

uint
strlen(const char *s)
{
    59a2:	1141                	addi	sp,sp,-16
    59a4:	e422                	sd	s0,8(sp)
    59a6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    59a8:	00054783          	lbu	a5,0(a0)
    59ac:	cf91                	beqz	a5,59c8 <strlen+0x26>
    59ae:	0505                	addi	a0,a0,1
    59b0:	87aa                	mv	a5,a0
    59b2:	4685                	li	a3,1
    59b4:	9e89                	subw	a3,a3,a0
    59b6:	00f6853b          	addw	a0,a3,a5
    59ba:	0785                	addi	a5,a5,1
    59bc:	fff7c703          	lbu	a4,-1(a5)
    59c0:	fb7d                	bnez	a4,59b6 <strlen+0x14>
    ;
  return n;
}
    59c2:	6422                	ld	s0,8(sp)
    59c4:	0141                	addi	sp,sp,16
    59c6:	8082                	ret
  for(n = 0; s[n]; n++)
    59c8:	4501                	li	a0,0
    59ca:	bfe5                	j	59c2 <strlen+0x20>

00000000000059cc <memset>:

void*
memset(void *dst, int c, uint n)
{
    59cc:	1141                	addi	sp,sp,-16
    59ce:	e422                	sd	s0,8(sp)
    59d0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    59d2:	ce09                	beqz	a2,59ec <memset+0x20>
    59d4:	87aa                	mv	a5,a0
    59d6:	fff6071b          	addiw	a4,a2,-1
    59da:	1702                	slli	a4,a4,0x20
    59dc:	9301                	srli	a4,a4,0x20
    59de:	0705                	addi	a4,a4,1
    59e0:	972a                	add	a4,a4,a0
    cdst[i] = c;
    59e2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    59e6:	0785                	addi	a5,a5,1
    59e8:	fee79de3          	bne	a5,a4,59e2 <memset+0x16>
  }
  return dst;
}
    59ec:	6422                	ld	s0,8(sp)
    59ee:	0141                	addi	sp,sp,16
    59f0:	8082                	ret

00000000000059f2 <strchr>:

char*
strchr(const char *s, char c)
{
    59f2:	1141                	addi	sp,sp,-16
    59f4:	e422                	sd	s0,8(sp)
    59f6:	0800                	addi	s0,sp,16
  for(; *s; s++)
    59f8:	00054783          	lbu	a5,0(a0)
    59fc:	cb99                	beqz	a5,5a12 <strchr+0x20>
    if(*s == c)
    59fe:	00f58763          	beq	a1,a5,5a0c <strchr+0x1a>
  for(; *s; s++)
    5a02:	0505                	addi	a0,a0,1
    5a04:	00054783          	lbu	a5,0(a0)
    5a08:	fbfd                	bnez	a5,59fe <strchr+0xc>
      return (char*)s;
  return 0;
    5a0a:	4501                	li	a0,0
}
    5a0c:	6422                	ld	s0,8(sp)
    5a0e:	0141                	addi	sp,sp,16
    5a10:	8082                	ret
  return 0;
    5a12:	4501                	li	a0,0
    5a14:	bfe5                	j	5a0c <strchr+0x1a>

0000000000005a16 <gets>:

char*
gets(char *buf, int max)
{
    5a16:	711d                	addi	sp,sp,-96
    5a18:	ec86                	sd	ra,88(sp)
    5a1a:	e8a2                	sd	s0,80(sp)
    5a1c:	e4a6                	sd	s1,72(sp)
    5a1e:	e0ca                	sd	s2,64(sp)
    5a20:	fc4e                	sd	s3,56(sp)
    5a22:	f852                	sd	s4,48(sp)
    5a24:	f456                	sd	s5,40(sp)
    5a26:	f05a                	sd	s6,32(sp)
    5a28:	ec5e                	sd	s7,24(sp)
    5a2a:	1080                	addi	s0,sp,96
    5a2c:	8baa                	mv	s7,a0
    5a2e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    5a30:	892a                	mv	s2,a0
    5a32:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    5a34:	4aa9                	li	s5,10
    5a36:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    5a38:	89a6                	mv	s3,s1
    5a3a:	2485                	addiw	s1,s1,1
    5a3c:	0344d863          	bge	s1,s4,5a6c <gets+0x56>
    cc = read(0, &c, 1);
    5a40:	4605                	li	a2,1
    5a42:	faf40593          	addi	a1,s0,-81
    5a46:	4501                	li	a0,0
    5a48:	00000097          	auipc	ra,0x0
    5a4c:	1a0080e7          	jalr	416(ra) # 5be8 <read>
    if(cc < 1)
    5a50:	00a05e63          	blez	a0,5a6c <gets+0x56>
    buf[i++] = c;
    5a54:	faf44783          	lbu	a5,-81(s0)
    5a58:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    5a5c:	01578763          	beq	a5,s5,5a6a <gets+0x54>
    5a60:	0905                	addi	s2,s2,1
    5a62:	fd679be3          	bne	a5,s6,5a38 <gets+0x22>
  for(i=0; i+1 < max; ){
    5a66:	89a6                	mv	s3,s1
    5a68:	a011                	j	5a6c <gets+0x56>
    5a6a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    5a6c:	99de                	add	s3,s3,s7
    5a6e:	00098023          	sb	zero,0(s3)
  return buf;
}
    5a72:	855e                	mv	a0,s7
    5a74:	60e6                	ld	ra,88(sp)
    5a76:	6446                	ld	s0,80(sp)
    5a78:	64a6                	ld	s1,72(sp)
    5a7a:	6906                	ld	s2,64(sp)
    5a7c:	79e2                	ld	s3,56(sp)
    5a7e:	7a42                	ld	s4,48(sp)
    5a80:	7aa2                	ld	s5,40(sp)
    5a82:	7b02                	ld	s6,32(sp)
    5a84:	6be2                	ld	s7,24(sp)
    5a86:	6125                	addi	sp,sp,96
    5a88:	8082                	ret

0000000000005a8a <stat>:

int
stat(const char *n, struct stat *st)
{
    5a8a:	1101                	addi	sp,sp,-32
    5a8c:	ec06                	sd	ra,24(sp)
    5a8e:	e822                	sd	s0,16(sp)
    5a90:	e426                	sd	s1,8(sp)
    5a92:	e04a                	sd	s2,0(sp)
    5a94:	1000                	addi	s0,sp,32
    5a96:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5a98:	4581                	li	a1,0
    5a9a:	00000097          	auipc	ra,0x0
    5a9e:	176080e7          	jalr	374(ra) # 5c10 <open>
  if(fd < 0)
    5aa2:	02054563          	bltz	a0,5acc <stat+0x42>
    5aa6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5aa8:	85ca                	mv	a1,s2
    5aaa:	00000097          	auipc	ra,0x0
    5aae:	17e080e7          	jalr	382(ra) # 5c28 <fstat>
    5ab2:	892a                	mv	s2,a0
  close(fd);
    5ab4:	8526                	mv	a0,s1
    5ab6:	00000097          	auipc	ra,0x0
    5aba:	142080e7          	jalr	322(ra) # 5bf8 <close>
  return r;
}
    5abe:	854a                	mv	a0,s2
    5ac0:	60e2                	ld	ra,24(sp)
    5ac2:	6442                	ld	s0,16(sp)
    5ac4:	64a2                	ld	s1,8(sp)
    5ac6:	6902                	ld	s2,0(sp)
    5ac8:	6105                	addi	sp,sp,32
    5aca:	8082                	ret
    return -1;
    5acc:	597d                	li	s2,-1
    5ace:	bfc5                	j	5abe <stat+0x34>

0000000000005ad0 <atoi>:

int
atoi(const char *s)
{
    5ad0:	1141                	addi	sp,sp,-16
    5ad2:	e422                	sd	s0,8(sp)
    5ad4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5ad6:	00054603          	lbu	a2,0(a0)
    5ada:	fd06079b          	addiw	a5,a2,-48
    5ade:	0ff7f793          	andi	a5,a5,255
    5ae2:	4725                	li	a4,9
    5ae4:	02f76963          	bltu	a4,a5,5b16 <atoi+0x46>
    5ae8:	86aa                	mv	a3,a0
  n = 0;
    5aea:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    5aec:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    5aee:	0685                	addi	a3,a3,1
    5af0:	0025179b          	slliw	a5,a0,0x2
    5af4:	9fa9                	addw	a5,a5,a0
    5af6:	0017979b          	slliw	a5,a5,0x1
    5afa:	9fb1                	addw	a5,a5,a2
    5afc:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5b00:	0006c603          	lbu	a2,0(a3) # 1000 <linktest+0x10a>
    5b04:	fd06071b          	addiw	a4,a2,-48
    5b08:	0ff77713          	andi	a4,a4,255
    5b0c:	fee5f1e3          	bgeu	a1,a4,5aee <atoi+0x1e>
  return n;
}
    5b10:	6422                	ld	s0,8(sp)
    5b12:	0141                	addi	sp,sp,16
    5b14:	8082                	ret
  n = 0;
    5b16:	4501                	li	a0,0
    5b18:	bfe5                	j	5b10 <atoi+0x40>

0000000000005b1a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5b1a:	1141                	addi	sp,sp,-16
    5b1c:	e422                	sd	s0,8(sp)
    5b1e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5b20:	02b57663          	bgeu	a0,a1,5b4c <memmove+0x32>
    while(n-- > 0)
    5b24:	02c05163          	blez	a2,5b46 <memmove+0x2c>
    5b28:	fff6079b          	addiw	a5,a2,-1
    5b2c:	1782                	slli	a5,a5,0x20
    5b2e:	9381                	srli	a5,a5,0x20
    5b30:	0785                	addi	a5,a5,1
    5b32:	97aa                	add	a5,a5,a0
  dst = vdst;
    5b34:	872a                	mv	a4,a0
      *dst++ = *src++;
    5b36:	0585                	addi	a1,a1,1
    5b38:	0705                	addi	a4,a4,1
    5b3a:	fff5c683          	lbu	a3,-1(a1)
    5b3e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    5b42:	fee79ae3          	bne	a5,a4,5b36 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    5b46:	6422                	ld	s0,8(sp)
    5b48:	0141                	addi	sp,sp,16
    5b4a:	8082                	ret
    dst += n;
    5b4c:	00c50733          	add	a4,a0,a2
    src += n;
    5b50:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    5b52:	fec05ae3          	blez	a2,5b46 <memmove+0x2c>
    5b56:	fff6079b          	addiw	a5,a2,-1
    5b5a:	1782                	slli	a5,a5,0x20
    5b5c:	9381                	srli	a5,a5,0x20
    5b5e:	fff7c793          	not	a5,a5
    5b62:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    5b64:	15fd                	addi	a1,a1,-1
    5b66:	177d                	addi	a4,a4,-1
    5b68:	0005c683          	lbu	a3,0(a1)
    5b6c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    5b70:	fee79ae3          	bne	a5,a4,5b64 <memmove+0x4a>
    5b74:	bfc9                	j	5b46 <memmove+0x2c>

0000000000005b76 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    5b76:	1141                	addi	sp,sp,-16
    5b78:	e422                	sd	s0,8(sp)
    5b7a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    5b7c:	ca05                	beqz	a2,5bac <memcmp+0x36>
    5b7e:	fff6069b          	addiw	a3,a2,-1
    5b82:	1682                	slli	a3,a3,0x20
    5b84:	9281                	srli	a3,a3,0x20
    5b86:	0685                	addi	a3,a3,1
    5b88:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    5b8a:	00054783          	lbu	a5,0(a0)
    5b8e:	0005c703          	lbu	a4,0(a1)
    5b92:	00e79863          	bne	a5,a4,5ba2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    5b96:	0505                	addi	a0,a0,1
    p2++;
    5b98:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    5b9a:	fed518e3          	bne	a0,a3,5b8a <memcmp+0x14>
  }
  return 0;
    5b9e:	4501                	li	a0,0
    5ba0:	a019                	j	5ba6 <memcmp+0x30>
      return *p1 - *p2;
    5ba2:	40e7853b          	subw	a0,a5,a4
}
    5ba6:	6422                	ld	s0,8(sp)
    5ba8:	0141                	addi	sp,sp,16
    5baa:	8082                	ret
  return 0;
    5bac:	4501                	li	a0,0
    5bae:	bfe5                	j	5ba6 <memcmp+0x30>

0000000000005bb0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5bb0:	1141                	addi	sp,sp,-16
    5bb2:	e406                	sd	ra,8(sp)
    5bb4:	e022                	sd	s0,0(sp)
    5bb6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    5bb8:	00000097          	auipc	ra,0x0
    5bbc:	f62080e7          	jalr	-158(ra) # 5b1a <memmove>
}
    5bc0:	60a2                	ld	ra,8(sp)
    5bc2:	6402                	ld	s0,0(sp)
    5bc4:	0141                	addi	sp,sp,16
    5bc6:	8082                	ret

0000000000005bc8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    5bc8:	4885                	li	a7,1
 ecall
    5bca:	00000073          	ecall
 ret
    5bce:	8082                	ret

0000000000005bd0 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5bd0:	4889                	li	a7,2
 ecall
    5bd2:	00000073          	ecall
 ret
    5bd6:	8082                	ret

0000000000005bd8 <wait>:
.global wait
wait:
 li a7, SYS_wait
    5bd8:	488d                	li	a7,3
 ecall
    5bda:	00000073          	ecall
 ret
    5bde:	8082                	ret

0000000000005be0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5be0:	4891                	li	a7,4
 ecall
    5be2:	00000073          	ecall
 ret
    5be6:	8082                	ret

0000000000005be8 <read>:
.global read
read:
 li a7, SYS_read
    5be8:	4895                	li	a7,5
 ecall
    5bea:	00000073          	ecall
 ret
    5bee:	8082                	ret

0000000000005bf0 <write>:
.global write
write:
 li a7, SYS_write
    5bf0:	48c1                	li	a7,16
 ecall
    5bf2:	00000073          	ecall
 ret
    5bf6:	8082                	ret

0000000000005bf8 <close>:
.global close
close:
 li a7, SYS_close
    5bf8:	48d5                	li	a7,21
 ecall
    5bfa:	00000073          	ecall
 ret
    5bfe:	8082                	ret

0000000000005c00 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5c00:	4899                	li	a7,6
 ecall
    5c02:	00000073          	ecall
 ret
    5c06:	8082                	ret

0000000000005c08 <exec>:
.global exec
exec:
 li a7, SYS_exec
    5c08:	489d                	li	a7,7
 ecall
    5c0a:	00000073          	ecall
 ret
    5c0e:	8082                	ret

0000000000005c10 <open>:
.global open
open:
 li a7, SYS_open
    5c10:	48bd                	li	a7,15
 ecall
    5c12:	00000073          	ecall
 ret
    5c16:	8082                	ret

0000000000005c18 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    5c18:	48c5                	li	a7,17
 ecall
    5c1a:	00000073          	ecall
 ret
    5c1e:	8082                	ret

0000000000005c20 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5c20:	48c9                	li	a7,18
 ecall
    5c22:	00000073          	ecall
 ret
    5c26:	8082                	ret

0000000000005c28 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    5c28:	48a1                	li	a7,8
 ecall
    5c2a:	00000073          	ecall
 ret
    5c2e:	8082                	ret

0000000000005c30 <link>:
.global link
link:
 li a7, SYS_link
    5c30:	48cd                	li	a7,19
 ecall
    5c32:	00000073          	ecall
 ret
    5c36:	8082                	ret

0000000000005c38 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    5c38:	48d1                	li	a7,20
 ecall
    5c3a:	00000073          	ecall
 ret
    5c3e:	8082                	ret

0000000000005c40 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    5c40:	48a5                	li	a7,9
 ecall
    5c42:	00000073          	ecall
 ret
    5c46:	8082                	ret

0000000000005c48 <dup>:
.global dup
dup:
 li a7, SYS_dup
    5c48:	48a9                	li	a7,10
 ecall
    5c4a:	00000073          	ecall
 ret
    5c4e:	8082                	ret

0000000000005c50 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    5c50:	48ad                	li	a7,11
 ecall
    5c52:	00000073          	ecall
 ret
    5c56:	8082                	ret

0000000000005c58 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    5c58:	48b1                	li	a7,12
 ecall
    5c5a:	00000073          	ecall
 ret
    5c5e:	8082                	ret

0000000000005c60 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    5c60:	48b5                	li	a7,13
 ecall
    5c62:	00000073          	ecall
 ret
    5c66:	8082                	ret

0000000000005c68 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    5c68:	48b9                	li	a7,14
 ecall
    5c6a:	00000073          	ecall
 ret
    5c6e:	8082                	ret

0000000000005c70 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    5c70:	1101                	addi	sp,sp,-32
    5c72:	ec06                	sd	ra,24(sp)
    5c74:	e822                	sd	s0,16(sp)
    5c76:	1000                	addi	s0,sp,32
    5c78:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    5c7c:	4605                	li	a2,1
    5c7e:	fef40593          	addi	a1,s0,-17
    5c82:	00000097          	auipc	ra,0x0
    5c86:	f6e080e7          	jalr	-146(ra) # 5bf0 <write>
}
    5c8a:	60e2                	ld	ra,24(sp)
    5c8c:	6442                	ld	s0,16(sp)
    5c8e:	6105                	addi	sp,sp,32
    5c90:	8082                	ret

0000000000005c92 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5c92:	7139                	addi	sp,sp,-64
    5c94:	fc06                	sd	ra,56(sp)
    5c96:	f822                	sd	s0,48(sp)
    5c98:	f426                	sd	s1,40(sp)
    5c9a:	f04a                	sd	s2,32(sp)
    5c9c:	ec4e                	sd	s3,24(sp)
    5c9e:	0080                	addi	s0,sp,64
    5ca0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5ca2:	c299                	beqz	a3,5ca8 <printint+0x16>
    5ca4:	0805c863          	bltz	a1,5d34 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    5ca8:	2581                	sext.w	a1,a1
  neg = 0;
    5caa:	4881                	li	a7,0
    5cac:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    5cb0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5cb2:	2601                	sext.w	a2,a2
    5cb4:	00003517          	auipc	a0,0x3
    5cb8:	8bc50513          	addi	a0,a0,-1860 # 8570 <digits>
    5cbc:	883a                	mv	a6,a4
    5cbe:	2705                	addiw	a4,a4,1
    5cc0:	02c5f7bb          	remuw	a5,a1,a2
    5cc4:	1782                	slli	a5,a5,0x20
    5cc6:	9381                	srli	a5,a5,0x20
    5cc8:	97aa                	add	a5,a5,a0
    5cca:	0007c783          	lbu	a5,0(a5)
    5cce:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5cd2:	0005879b          	sext.w	a5,a1
    5cd6:	02c5d5bb          	divuw	a1,a1,a2
    5cda:	0685                	addi	a3,a3,1
    5cdc:	fec7f0e3          	bgeu	a5,a2,5cbc <printint+0x2a>
  if(neg)
    5ce0:	00088b63          	beqz	a7,5cf6 <printint+0x64>
    buf[i++] = '-';
    5ce4:	fd040793          	addi	a5,s0,-48
    5ce8:	973e                	add	a4,a4,a5
    5cea:	02d00793          	li	a5,45
    5cee:	fef70823          	sb	a5,-16(a4)
    5cf2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    5cf6:	02e05863          	blez	a4,5d26 <printint+0x94>
    5cfa:	fc040793          	addi	a5,s0,-64
    5cfe:	00e78933          	add	s2,a5,a4
    5d02:	fff78993          	addi	s3,a5,-1
    5d06:	99ba                	add	s3,s3,a4
    5d08:	377d                	addiw	a4,a4,-1
    5d0a:	1702                	slli	a4,a4,0x20
    5d0c:	9301                	srli	a4,a4,0x20
    5d0e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5d12:	fff94583          	lbu	a1,-1(s2)
    5d16:	8526                	mv	a0,s1
    5d18:	00000097          	auipc	ra,0x0
    5d1c:	f58080e7          	jalr	-168(ra) # 5c70 <putc>
  while(--i >= 0)
    5d20:	197d                	addi	s2,s2,-1
    5d22:	ff3918e3          	bne	s2,s3,5d12 <printint+0x80>
}
    5d26:	70e2                	ld	ra,56(sp)
    5d28:	7442                	ld	s0,48(sp)
    5d2a:	74a2                	ld	s1,40(sp)
    5d2c:	7902                	ld	s2,32(sp)
    5d2e:	69e2                	ld	s3,24(sp)
    5d30:	6121                	addi	sp,sp,64
    5d32:	8082                	ret
    x = -xx;
    5d34:	40b005bb          	negw	a1,a1
    neg = 1;
    5d38:	4885                	li	a7,1
    x = -xx;
    5d3a:	bf8d                	j	5cac <printint+0x1a>

0000000000005d3c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    5d3c:	7119                	addi	sp,sp,-128
    5d3e:	fc86                	sd	ra,120(sp)
    5d40:	f8a2                	sd	s0,112(sp)
    5d42:	f4a6                	sd	s1,104(sp)
    5d44:	f0ca                	sd	s2,96(sp)
    5d46:	ecce                	sd	s3,88(sp)
    5d48:	e8d2                	sd	s4,80(sp)
    5d4a:	e4d6                	sd	s5,72(sp)
    5d4c:	e0da                	sd	s6,64(sp)
    5d4e:	fc5e                	sd	s7,56(sp)
    5d50:	f862                	sd	s8,48(sp)
    5d52:	f466                	sd	s9,40(sp)
    5d54:	f06a                	sd	s10,32(sp)
    5d56:	ec6e                	sd	s11,24(sp)
    5d58:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    5d5a:	0005c903          	lbu	s2,0(a1)
    5d5e:	18090f63          	beqz	s2,5efc <vprintf+0x1c0>
    5d62:	8aaa                	mv	s5,a0
    5d64:	8b32                	mv	s6,a2
    5d66:	00158493          	addi	s1,a1,1
  state = 0;
    5d6a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    5d6c:	02500a13          	li	s4,37
      if(c == 'd'){
    5d70:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    5d74:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    5d78:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    5d7c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5d80:	00002b97          	auipc	s7,0x2
    5d84:	7f0b8b93          	addi	s7,s7,2032 # 8570 <digits>
    5d88:	a839                	j	5da6 <vprintf+0x6a>
        putc(fd, c);
    5d8a:	85ca                	mv	a1,s2
    5d8c:	8556                	mv	a0,s5
    5d8e:	00000097          	auipc	ra,0x0
    5d92:	ee2080e7          	jalr	-286(ra) # 5c70 <putc>
    5d96:	a019                	j	5d9c <vprintf+0x60>
    } else if(state == '%'){
    5d98:	01498f63          	beq	s3,s4,5db6 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    5d9c:	0485                	addi	s1,s1,1
    5d9e:	fff4c903          	lbu	s2,-1(s1)
    5da2:	14090d63          	beqz	s2,5efc <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    5da6:	0009079b          	sext.w	a5,s2
    if(state == 0){
    5daa:	fe0997e3          	bnez	s3,5d98 <vprintf+0x5c>
      if(c == '%'){
    5dae:	fd479ee3          	bne	a5,s4,5d8a <vprintf+0x4e>
        state = '%';
    5db2:	89be                	mv	s3,a5
    5db4:	b7e5                	j	5d9c <vprintf+0x60>
      if(c == 'd'){
    5db6:	05878063          	beq	a5,s8,5df6 <vprintf+0xba>
      } else if(c == 'l') {
    5dba:	05978c63          	beq	a5,s9,5e12 <vprintf+0xd6>
      } else if(c == 'x') {
    5dbe:	07a78863          	beq	a5,s10,5e2e <vprintf+0xf2>
      } else if(c == 'p') {
    5dc2:	09b78463          	beq	a5,s11,5e4a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    5dc6:	07300713          	li	a4,115
    5dca:	0ce78663          	beq	a5,a4,5e96 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    5dce:	06300713          	li	a4,99
    5dd2:	0ee78e63          	beq	a5,a4,5ece <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    5dd6:	11478863          	beq	a5,s4,5ee6 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    5dda:	85d2                	mv	a1,s4
    5ddc:	8556                	mv	a0,s5
    5dde:	00000097          	auipc	ra,0x0
    5de2:	e92080e7          	jalr	-366(ra) # 5c70 <putc>
        putc(fd, c);
    5de6:	85ca                	mv	a1,s2
    5de8:	8556                	mv	a0,s5
    5dea:	00000097          	auipc	ra,0x0
    5dee:	e86080e7          	jalr	-378(ra) # 5c70 <putc>
      }
      state = 0;
    5df2:	4981                	li	s3,0
    5df4:	b765                	j	5d9c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    5df6:	008b0913          	addi	s2,s6,8
    5dfa:	4685                	li	a3,1
    5dfc:	4629                	li	a2,10
    5dfe:	000b2583          	lw	a1,0(s6)
    5e02:	8556                	mv	a0,s5
    5e04:	00000097          	auipc	ra,0x0
    5e08:	e8e080e7          	jalr	-370(ra) # 5c92 <printint>
    5e0c:	8b4a                	mv	s6,s2
      state = 0;
    5e0e:	4981                	li	s3,0
    5e10:	b771                	j	5d9c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5e12:	008b0913          	addi	s2,s6,8
    5e16:	4681                	li	a3,0
    5e18:	4629                	li	a2,10
    5e1a:	000b2583          	lw	a1,0(s6)
    5e1e:	8556                	mv	a0,s5
    5e20:	00000097          	auipc	ra,0x0
    5e24:	e72080e7          	jalr	-398(ra) # 5c92 <printint>
    5e28:	8b4a                	mv	s6,s2
      state = 0;
    5e2a:	4981                	li	s3,0
    5e2c:	bf85                	j	5d9c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    5e2e:	008b0913          	addi	s2,s6,8
    5e32:	4681                	li	a3,0
    5e34:	4641                	li	a2,16
    5e36:	000b2583          	lw	a1,0(s6)
    5e3a:	8556                	mv	a0,s5
    5e3c:	00000097          	auipc	ra,0x0
    5e40:	e56080e7          	jalr	-426(ra) # 5c92 <printint>
    5e44:	8b4a                	mv	s6,s2
      state = 0;
    5e46:	4981                	li	s3,0
    5e48:	bf91                	j	5d9c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    5e4a:	008b0793          	addi	a5,s6,8
    5e4e:	f8f43423          	sd	a5,-120(s0)
    5e52:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    5e56:	03000593          	li	a1,48
    5e5a:	8556                	mv	a0,s5
    5e5c:	00000097          	auipc	ra,0x0
    5e60:	e14080e7          	jalr	-492(ra) # 5c70 <putc>
  putc(fd, 'x');
    5e64:	85ea                	mv	a1,s10
    5e66:	8556                	mv	a0,s5
    5e68:	00000097          	auipc	ra,0x0
    5e6c:	e08080e7          	jalr	-504(ra) # 5c70 <putc>
    5e70:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5e72:	03c9d793          	srli	a5,s3,0x3c
    5e76:	97de                	add	a5,a5,s7
    5e78:	0007c583          	lbu	a1,0(a5)
    5e7c:	8556                	mv	a0,s5
    5e7e:	00000097          	auipc	ra,0x0
    5e82:	df2080e7          	jalr	-526(ra) # 5c70 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5e86:	0992                	slli	s3,s3,0x4
    5e88:	397d                	addiw	s2,s2,-1
    5e8a:	fe0914e3          	bnez	s2,5e72 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    5e8e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    5e92:	4981                	li	s3,0
    5e94:	b721                	j	5d9c <vprintf+0x60>
        s = va_arg(ap, char*);
    5e96:	008b0993          	addi	s3,s6,8
    5e9a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    5e9e:	02090163          	beqz	s2,5ec0 <vprintf+0x184>
        while(*s != 0){
    5ea2:	00094583          	lbu	a1,0(s2)
    5ea6:	c9a1                	beqz	a1,5ef6 <vprintf+0x1ba>
          putc(fd, *s);
    5ea8:	8556                	mv	a0,s5
    5eaa:	00000097          	auipc	ra,0x0
    5eae:	dc6080e7          	jalr	-570(ra) # 5c70 <putc>
          s++;
    5eb2:	0905                	addi	s2,s2,1
        while(*s != 0){
    5eb4:	00094583          	lbu	a1,0(s2)
    5eb8:	f9e5                	bnez	a1,5ea8 <vprintf+0x16c>
        s = va_arg(ap, char*);
    5eba:	8b4e                	mv	s6,s3
      state = 0;
    5ebc:	4981                	li	s3,0
    5ebe:	bdf9                	j	5d9c <vprintf+0x60>
          s = "(null)";
    5ec0:	00002917          	auipc	s2,0x2
    5ec4:	6a890913          	addi	s2,s2,1704 # 8568 <malloc+0x2562>
        while(*s != 0){
    5ec8:	02800593          	li	a1,40
    5ecc:	bff1                	j	5ea8 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    5ece:	008b0913          	addi	s2,s6,8
    5ed2:	000b4583          	lbu	a1,0(s6)
    5ed6:	8556                	mv	a0,s5
    5ed8:	00000097          	auipc	ra,0x0
    5edc:	d98080e7          	jalr	-616(ra) # 5c70 <putc>
    5ee0:	8b4a                	mv	s6,s2
      state = 0;
    5ee2:	4981                	li	s3,0
    5ee4:	bd65                	j	5d9c <vprintf+0x60>
        putc(fd, c);
    5ee6:	85d2                	mv	a1,s4
    5ee8:	8556                	mv	a0,s5
    5eea:	00000097          	auipc	ra,0x0
    5eee:	d86080e7          	jalr	-634(ra) # 5c70 <putc>
      state = 0;
    5ef2:	4981                	li	s3,0
    5ef4:	b565                	j	5d9c <vprintf+0x60>
        s = va_arg(ap, char*);
    5ef6:	8b4e                	mv	s6,s3
      state = 0;
    5ef8:	4981                	li	s3,0
    5efa:	b54d                	j	5d9c <vprintf+0x60>
    }
  }
}
    5efc:	70e6                	ld	ra,120(sp)
    5efe:	7446                	ld	s0,112(sp)
    5f00:	74a6                	ld	s1,104(sp)
    5f02:	7906                	ld	s2,96(sp)
    5f04:	69e6                	ld	s3,88(sp)
    5f06:	6a46                	ld	s4,80(sp)
    5f08:	6aa6                	ld	s5,72(sp)
    5f0a:	6b06                	ld	s6,64(sp)
    5f0c:	7be2                	ld	s7,56(sp)
    5f0e:	7c42                	ld	s8,48(sp)
    5f10:	7ca2                	ld	s9,40(sp)
    5f12:	7d02                	ld	s10,32(sp)
    5f14:	6de2                	ld	s11,24(sp)
    5f16:	6109                	addi	sp,sp,128
    5f18:	8082                	ret

0000000000005f1a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5f1a:	715d                	addi	sp,sp,-80
    5f1c:	ec06                	sd	ra,24(sp)
    5f1e:	e822                	sd	s0,16(sp)
    5f20:	1000                	addi	s0,sp,32
    5f22:	e010                	sd	a2,0(s0)
    5f24:	e414                	sd	a3,8(s0)
    5f26:	e818                	sd	a4,16(s0)
    5f28:	ec1c                	sd	a5,24(s0)
    5f2a:	03043023          	sd	a6,32(s0)
    5f2e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5f32:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5f36:	8622                	mv	a2,s0
    5f38:	00000097          	auipc	ra,0x0
    5f3c:	e04080e7          	jalr	-508(ra) # 5d3c <vprintf>
}
    5f40:	60e2                	ld	ra,24(sp)
    5f42:	6442                	ld	s0,16(sp)
    5f44:	6161                	addi	sp,sp,80
    5f46:	8082                	ret

0000000000005f48 <printf>:

void
printf(const char *fmt, ...)
{
    5f48:	711d                	addi	sp,sp,-96
    5f4a:	ec06                	sd	ra,24(sp)
    5f4c:	e822                	sd	s0,16(sp)
    5f4e:	1000                	addi	s0,sp,32
    5f50:	e40c                	sd	a1,8(s0)
    5f52:	e810                	sd	a2,16(s0)
    5f54:	ec14                	sd	a3,24(s0)
    5f56:	f018                	sd	a4,32(s0)
    5f58:	f41c                	sd	a5,40(s0)
    5f5a:	03043823          	sd	a6,48(s0)
    5f5e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5f62:	00840613          	addi	a2,s0,8
    5f66:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5f6a:	85aa                	mv	a1,a0
    5f6c:	4505                	li	a0,1
    5f6e:	00000097          	auipc	ra,0x0
    5f72:	dce080e7          	jalr	-562(ra) # 5d3c <vprintf>
}
    5f76:	60e2                	ld	ra,24(sp)
    5f78:	6442                	ld	s0,16(sp)
    5f7a:	6125                	addi	sp,sp,96
    5f7c:	8082                	ret

0000000000005f7e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5f7e:	1141                	addi	sp,sp,-16
    5f80:	e422                	sd	s0,8(sp)
    5f82:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5f84:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5f88:	00003797          	auipc	a5,0x3
    5f8c:	4c87b783          	ld	a5,1224(a5) # 9450 <freep>
    5f90:	a805                	j	5fc0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5f92:	4618                	lw	a4,8(a2)
    5f94:	9db9                	addw	a1,a1,a4
    5f96:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5f9a:	6398                	ld	a4,0(a5)
    5f9c:	6318                	ld	a4,0(a4)
    5f9e:	fee53823          	sd	a4,-16(a0)
    5fa2:	a091                	j	5fe6 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5fa4:	ff852703          	lw	a4,-8(a0)
    5fa8:	9e39                	addw	a2,a2,a4
    5faa:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    5fac:	ff053703          	ld	a4,-16(a0)
    5fb0:	e398                	sd	a4,0(a5)
    5fb2:	a099                	j	5ff8 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5fb4:	6398                	ld	a4,0(a5)
    5fb6:	00e7e463          	bltu	a5,a4,5fbe <free+0x40>
    5fba:	00e6ea63          	bltu	a3,a4,5fce <free+0x50>
{
    5fbe:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5fc0:	fed7fae3          	bgeu	a5,a3,5fb4 <free+0x36>
    5fc4:	6398                	ld	a4,0(a5)
    5fc6:	00e6e463          	bltu	a3,a4,5fce <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5fca:	fee7eae3          	bltu	a5,a4,5fbe <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    5fce:	ff852583          	lw	a1,-8(a0)
    5fd2:	6390                	ld	a2,0(a5)
    5fd4:	02059713          	slli	a4,a1,0x20
    5fd8:	9301                	srli	a4,a4,0x20
    5fda:	0712                	slli	a4,a4,0x4
    5fdc:	9736                	add	a4,a4,a3
    5fde:	fae60ae3          	beq	a2,a4,5f92 <free+0x14>
    bp->s.ptr = p->s.ptr;
    5fe2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    5fe6:	4790                	lw	a2,8(a5)
    5fe8:	02061713          	slli	a4,a2,0x20
    5fec:	9301                	srli	a4,a4,0x20
    5fee:	0712                	slli	a4,a4,0x4
    5ff0:	973e                	add	a4,a4,a5
    5ff2:	fae689e3          	beq	a3,a4,5fa4 <free+0x26>
  } else
    p->s.ptr = bp;
    5ff6:	e394                	sd	a3,0(a5)
  freep = p;
    5ff8:	00003717          	auipc	a4,0x3
    5ffc:	44f73c23          	sd	a5,1112(a4) # 9450 <freep>
}
    6000:	6422                	ld	s0,8(sp)
    6002:	0141                	addi	sp,sp,16
    6004:	8082                	ret

0000000000006006 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    6006:	7139                	addi	sp,sp,-64
    6008:	fc06                	sd	ra,56(sp)
    600a:	f822                	sd	s0,48(sp)
    600c:	f426                	sd	s1,40(sp)
    600e:	f04a                	sd	s2,32(sp)
    6010:	ec4e                	sd	s3,24(sp)
    6012:	e852                	sd	s4,16(sp)
    6014:	e456                	sd	s5,8(sp)
    6016:	e05a                	sd	s6,0(sp)
    6018:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    601a:	02051493          	slli	s1,a0,0x20
    601e:	9081                	srli	s1,s1,0x20
    6020:	04bd                	addi	s1,s1,15
    6022:	8091                	srli	s1,s1,0x4
    6024:	0014899b          	addiw	s3,s1,1
    6028:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    602a:	00003517          	auipc	a0,0x3
    602e:	42653503          	ld	a0,1062(a0) # 9450 <freep>
    6032:	c515                	beqz	a0,605e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    6034:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    6036:	4798                	lw	a4,8(a5)
    6038:	02977f63          	bgeu	a4,s1,6076 <malloc+0x70>
    603c:	8a4e                	mv	s4,s3
    603e:	0009871b          	sext.w	a4,s3
    6042:	6685                	lui	a3,0x1
    6044:	00d77363          	bgeu	a4,a3,604a <malloc+0x44>
    6048:	6a05                	lui	s4,0x1
    604a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    604e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    6052:	00003917          	auipc	s2,0x3
    6056:	3fe90913          	addi	s2,s2,1022 # 9450 <freep>
  if(p == (char*)-1)
    605a:	5afd                	li	s5,-1
    605c:	a88d                	j	60ce <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    605e:	0000a797          	auipc	a5,0xa
    6062:	c1a78793          	addi	a5,a5,-998 # fc78 <base>
    6066:	00003717          	auipc	a4,0x3
    606a:	3ef73523          	sd	a5,1002(a4) # 9450 <freep>
    606e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    6070:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    6074:	b7e1                	j	603c <malloc+0x36>
      if(p->s.size == nunits)
    6076:	02e48b63          	beq	s1,a4,60ac <malloc+0xa6>
        p->s.size -= nunits;
    607a:	4137073b          	subw	a4,a4,s3
    607e:	c798                	sw	a4,8(a5)
        p += p->s.size;
    6080:	1702                	slli	a4,a4,0x20
    6082:	9301                	srli	a4,a4,0x20
    6084:	0712                	slli	a4,a4,0x4
    6086:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    6088:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    608c:	00003717          	auipc	a4,0x3
    6090:	3ca73223          	sd	a0,964(a4) # 9450 <freep>
      return (void*)(p + 1);
    6094:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    6098:	70e2                	ld	ra,56(sp)
    609a:	7442                	ld	s0,48(sp)
    609c:	74a2                	ld	s1,40(sp)
    609e:	7902                	ld	s2,32(sp)
    60a0:	69e2                	ld	s3,24(sp)
    60a2:	6a42                	ld	s4,16(sp)
    60a4:	6aa2                	ld	s5,8(sp)
    60a6:	6b02                	ld	s6,0(sp)
    60a8:	6121                	addi	sp,sp,64
    60aa:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    60ac:	6398                	ld	a4,0(a5)
    60ae:	e118                	sd	a4,0(a0)
    60b0:	bff1                	j	608c <malloc+0x86>
  hp->s.size = nu;
    60b2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    60b6:	0541                	addi	a0,a0,16
    60b8:	00000097          	auipc	ra,0x0
    60bc:	ec6080e7          	jalr	-314(ra) # 5f7e <free>
  return freep;
    60c0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    60c4:	d971                	beqz	a0,6098 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    60c6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    60c8:	4798                	lw	a4,8(a5)
    60ca:	fa9776e3          	bgeu	a4,s1,6076 <malloc+0x70>
    if(p == freep)
    60ce:	00093703          	ld	a4,0(s2)
    60d2:	853e                	mv	a0,a5
    60d4:	fef719e3          	bne	a4,a5,60c6 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    60d8:	8552                	mv	a0,s4
    60da:	00000097          	auipc	ra,0x0
    60de:	b7e080e7          	jalr	-1154(ra) # 5c58 <sbrk>
  if(p == (char*)-1)
    60e2:	fd5518e3          	bne	a0,s5,60b2 <malloc+0xac>
        return 0;
    60e6:	4501                	li	a0,0
    60e8:	bf45                	j	6098 <malloc+0x92>
