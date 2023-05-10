
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  write(2, "$ ", 2);
      10:	4609                	li	a2,2
      12:	00001597          	auipc	a1,0x1
      16:	2ee58593          	addi	a1,a1,750 # 1300 <malloc+0xe4>
      1a:	4509                	li	a0,2
      1c:	00001097          	auipc	ra,0x1
      20:	dea080e7          	jalr	-534(ra) # e06 <write>
  memset(buf, 0, nbuf);
      24:	864a                	mv	a2,s2
      26:	4581                	li	a1,0
      28:	8526                	mv	a0,s1
      2a:	00001097          	auipc	ra,0x1
      2e:	bb8080e7          	jalr	-1096(ra) # be2 <memset>
  gets(buf, nbuf);
      32:	85ca                	mv	a1,s2
      34:	8526                	mv	a0,s1
      36:	00001097          	auipc	ra,0x1
      3a:	bf6080e7          	jalr	-1034(ra) # c2c <gets>
  if(buf[0] == 0) // EOF
      3e:	0004c503          	lbu	a0,0(s1)
      42:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      46:	40a00533          	neg	a0,a0
      4a:	60e2                	ld	ra,24(sp)
      4c:	6442                	ld	s0,16(sp)
      4e:	64a2                	ld	s1,8(sp)
      50:	6902                	ld	s2,0(sp)
      52:	6105                	addi	sp,sp,32
      54:	8082                	ret

0000000000000056 <panic>:
  exit(0);
}

void
panic(char *s)
{
      56:	1141                	addi	sp,sp,-16
      58:	e406                	sd	ra,8(sp)
      5a:	e022                	sd	s0,0(sp)
      5c:	0800                	addi	s0,sp,16
      5e:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      60:	00001597          	auipc	a1,0x1
      64:	2a858593          	addi	a1,a1,680 # 1308 <malloc+0xec>
      68:	4509                	li	a0,2
      6a:	00001097          	auipc	ra,0x1
      6e:	0c6080e7          	jalr	198(ra) # 1130 <fprintf>
  exit(1);
      72:	4505                	li	a0,1
      74:	00001097          	auipc	ra,0x1
      78:	d72080e7          	jalr	-654(ra) # de6 <exit>

000000000000007c <fork1>:
}

int
fork1(void)
{
      7c:	1141                	addi	sp,sp,-16
      7e:	e406                	sd	ra,8(sp)
      80:	e022                	sd	s0,0(sp)
      82:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      84:	00001097          	auipc	ra,0x1
      88:	d5a080e7          	jalr	-678(ra) # dde <fork>
  if(pid == -1)
      8c:	57fd                	li	a5,-1
      8e:	00f50663          	beq	a0,a5,9a <fork1+0x1e>
    panic("fork");
  return pid;
}
      92:	60a2                	ld	ra,8(sp)
      94:	6402                	ld	s0,0(sp)
      96:	0141                	addi	sp,sp,16
      98:	8082                	ret
    panic("fork");
      9a:	00001517          	auipc	a0,0x1
      9e:	27650513          	addi	a0,a0,630 # 1310 <malloc+0xf4>
      a2:	00000097          	auipc	ra,0x0
      a6:	fb4080e7          	jalr	-76(ra) # 56 <panic>

00000000000000aa <runcmd>:
{
      aa:	7179                	addi	sp,sp,-48
      ac:	f406                	sd	ra,40(sp)
      ae:	f022                	sd	s0,32(sp)
      b0:	ec26                	sd	s1,24(sp)
      b2:	1800                	addi	s0,sp,48
  if(cmd == 0)
      b4:	c10d                	beqz	a0,d6 <runcmd+0x2c>
      b6:	84aa                	mv	s1,a0
  switch(cmd->type){
      b8:	4118                	lw	a4,0(a0)
      ba:	4795                	li	a5,5
      bc:	02e7e263          	bltu	a5,a4,e0 <runcmd+0x36>
      c0:	00056783          	lwu	a5,0(a0)
      c4:	078a                	slli	a5,a5,0x2
      c6:	00001717          	auipc	a4,0x1
      ca:	34a70713          	addi	a4,a4,842 # 1410 <malloc+0x1f4>
      ce:	97ba                	add	a5,a5,a4
      d0:	439c                	lw	a5,0(a5)
      d2:	97ba                	add	a5,a5,a4
      d4:	8782                	jr	a5
    exit(1);
      d6:	4505                	li	a0,1
      d8:	00001097          	auipc	ra,0x1
      dc:	d0e080e7          	jalr	-754(ra) # de6 <exit>
    panic("runcmd");
      e0:	00001517          	auipc	a0,0x1
      e4:	23850513          	addi	a0,a0,568 # 1318 <malloc+0xfc>
      e8:	00000097          	auipc	ra,0x0
      ec:	f6e080e7          	jalr	-146(ra) # 56 <panic>
    if(ecmd->argv[0] == 0)
      f0:	6508                	ld	a0,8(a0)
      f2:	c515                	beqz	a0,11e <runcmd+0x74>
    exec(ecmd->argv[0], ecmd->argv);
      f4:	00848593          	addi	a1,s1,8
      f8:	00001097          	auipc	ra,0x1
      fc:	d26080e7          	jalr	-730(ra) # e1e <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
     100:	6490                	ld	a2,8(s1)
     102:	00001597          	auipc	a1,0x1
     106:	21e58593          	addi	a1,a1,542 # 1320 <malloc+0x104>
     10a:	4509                	li	a0,2
     10c:	00001097          	auipc	ra,0x1
     110:	024080e7          	jalr	36(ra) # 1130 <fprintf>
  exit(0);
     114:	4501                	li	a0,0
     116:	00001097          	auipc	ra,0x1
     11a:	cd0080e7          	jalr	-816(ra) # de6 <exit>
      exit(1);
     11e:	4505                	li	a0,1
     120:	00001097          	auipc	ra,0x1
     124:	cc6080e7          	jalr	-826(ra) # de6 <exit>
    close(rcmd->fd);
     128:	5148                	lw	a0,36(a0)
     12a:	00001097          	auipc	ra,0x1
     12e:	ce4080e7          	jalr	-796(ra) # e0e <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     132:	508c                	lw	a1,32(s1)
     134:	6888                	ld	a0,16(s1)
     136:	00001097          	auipc	ra,0x1
     13a:	cf0080e7          	jalr	-784(ra) # e26 <open>
     13e:	00054763          	bltz	a0,14c <runcmd+0xa2>
    runcmd(rcmd->cmd);
     142:	6488                	ld	a0,8(s1)
     144:	00000097          	auipc	ra,0x0
     148:	f66080e7          	jalr	-154(ra) # aa <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     14c:	6890                	ld	a2,16(s1)
     14e:	00001597          	auipc	a1,0x1
     152:	1e258593          	addi	a1,a1,482 # 1330 <malloc+0x114>
     156:	4509                	li	a0,2
     158:	00001097          	auipc	ra,0x1
     15c:	fd8080e7          	jalr	-40(ra) # 1130 <fprintf>
      exit(1);
     160:	4505                	li	a0,1
     162:	00001097          	auipc	ra,0x1
     166:	c84080e7          	jalr	-892(ra) # de6 <exit>
    if(fork1() == 0)
     16a:	00000097          	auipc	ra,0x0
     16e:	f12080e7          	jalr	-238(ra) # 7c <fork1>
     172:	e511                	bnez	a0,17e <runcmd+0xd4>
      runcmd(lcmd->left);
     174:	6488                	ld	a0,8(s1)
     176:	00000097          	auipc	ra,0x0
     17a:	f34080e7          	jalr	-204(ra) # aa <runcmd>
    wait(0);
     17e:	4501                	li	a0,0
     180:	00001097          	auipc	ra,0x1
     184:	c6e080e7          	jalr	-914(ra) # dee <wait>
    runcmd(lcmd->right);
     188:	6888                	ld	a0,16(s1)
     18a:	00000097          	auipc	ra,0x0
     18e:	f20080e7          	jalr	-224(ra) # aa <runcmd>
    if(pipe(p) < 0)
     192:	fd840513          	addi	a0,s0,-40
     196:	00001097          	auipc	ra,0x1
     19a:	c60080e7          	jalr	-928(ra) # df6 <pipe>
     19e:	04054363          	bltz	a0,1e4 <runcmd+0x13a>
    if(fork1() == 0){
     1a2:	00000097          	auipc	ra,0x0
     1a6:	eda080e7          	jalr	-294(ra) # 7c <fork1>
     1aa:	e529                	bnez	a0,1f4 <runcmd+0x14a>
      close(1);
     1ac:	4505                	li	a0,1
     1ae:	00001097          	auipc	ra,0x1
     1b2:	c60080e7          	jalr	-928(ra) # e0e <close>
      dup(p[1]);
     1b6:	fdc42503          	lw	a0,-36(s0)
     1ba:	00001097          	auipc	ra,0x1
     1be:	ca4080e7          	jalr	-860(ra) # e5e <dup>
      close(p[0]);
     1c2:	fd842503          	lw	a0,-40(s0)
     1c6:	00001097          	auipc	ra,0x1
     1ca:	c48080e7          	jalr	-952(ra) # e0e <close>
      close(p[1]);
     1ce:	fdc42503          	lw	a0,-36(s0)
     1d2:	00001097          	auipc	ra,0x1
     1d6:	c3c080e7          	jalr	-964(ra) # e0e <close>
      runcmd(pcmd->left);
     1da:	6488                	ld	a0,8(s1)
     1dc:	00000097          	auipc	ra,0x0
     1e0:	ece080e7          	jalr	-306(ra) # aa <runcmd>
      panic("pipe");
     1e4:	00001517          	auipc	a0,0x1
     1e8:	15c50513          	addi	a0,a0,348 # 1340 <malloc+0x124>
     1ec:	00000097          	auipc	ra,0x0
     1f0:	e6a080e7          	jalr	-406(ra) # 56 <panic>
    if(fork1() == 0){
     1f4:	00000097          	auipc	ra,0x0
     1f8:	e88080e7          	jalr	-376(ra) # 7c <fork1>
     1fc:	ed05                	bnez	a0,234 <runcmd+0x18a>
      close(0);
     1fe:	00001097          	auipc	ra,0x1
     202:	c10080e7          	jalr	-1008(ra) # e0e <close>
      dup(p[0]);
     206:	fd842503          	lw	a0,-40(s0)
     20a:	00001097          	auipc	ra,0x1
     20e:	c54080e7          	jalr	-940(ra) # e5e <dup>
      close(p[0]);
     212:	fd842503          	lw	a0,-40(s0)
     216:	00001097          	auipc	ra,0x1
     21a:	bf8080e7          	jalr	-1032(ra) # e0e <close>
      close(p[1]);
     21e:	fdc42503          	lw	a0,-36(s0)
     222:	00001097          	auipc	ra,0x1
     226:	bec080e7          	jalr	-1044(ra) # e0e <close>
      runcmd(pcmd->right);
     22a:	6888                	ld	a0,16(s1)
     22c:	00000097          	auipc	ra,0x0
     230:	e7e080e7          	jalr	-386(ra) # aa <runcmd>
    close(p[0]);
     234:	fd842503          	lw	a0,-40(s0)
     238:	00001097          	auipc	ra,0x1
     23c:	bd6080e7          	jalr	-1066(ra) # e0e <close>
    close(p[1]);
     240:	fdc42503          	lw	a0,-36(s0)
     244:	00001097          	auipc	ra,0x1
     248:	bca080e7          	jalr	-1078(ra) # e0e <close>
    wait(0);
     24c:	4501                	li	a0,0
     24e:	00001097          	auipc	ra,0x1
     252:	ba0080e7          	jalr	-1120(ra) # dee <wait>
    wait(0);
     256:	4501                	li	a0,0
     258:	00001097          	auipc	ra,0x1
     25c:	b96080e7          	jalr	-1130(ra) # dee <wait>
    break;
     260:	bd55                	j	114 <runcmd+0x6a>
    if(fork1() == 0)
     262:	00000097          	auipc	ra,0x0
     266:	e1a080e7          	jalr	-486(ra) # 7c <fork1>
     26a:	ea0515e3          	bnez	a0,114 <runcmd+0x6a>
      runcmd(bcmd->cmd);
     26e:	6488                	ld	a0,8(s1)
     270:	00000097          	auipc	ra,0x0
     274:	e3a080e7          	jalr	-454(ra) # aa <runcmd>

0000000000000278 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     278:	1101                	addi	sp,sp,-32
     27a:	ec06                	sd	ra,24(sp)
     27c:	e822                	sd	s0,16(sp)
     27e:	e426                	sd	s1,8(sp)
     280:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     282:	0a800513          	li	a0,168
     286:	00001097          	auipc	ra,0x1
     28a:	f96080e7          	jalr	-106(ra) # 121c <malloc>
     28e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     290:	0a800613          	li	a2,168
     294:	4581                	li	a1,0
     296:	00001097          	auipc	ra,0x1
     29a:	94c080e7          	jalr	-1716(ra) # be2 <memset>
  cmd->type = EXEC;
     29e:	4785                	li	a5,1
     2a0:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     2a2:	8526                	mv	a0,s1
     2a4:	60e2                	ld	ra,24(sp)
     2a6:	6442                	ld	s0,16(sp)
     2a8:	64a2                	ld	s1,8(sp)
     2aa:	6105                	addi	sp,sp,32
     2ac:	8082                	ret

00000000000002ae <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2ae:	7139                	addi	sp,sp,-64
     2b0:	fc06                	sd	ra,56(sp)
     2b2:	f822                	sd	s0,48(sp)
     2b4:	f426                	sd	s1,40(sp)
     2b6:	f04a                	sd	s2,32(sp)
     2b8:	ec4e                	sd	s3,24(sp)
     2ba:	e852                	sd	s4,16(sp)
     2bc:	e456                	sd	s5,8(sp)
     2be:	e05a                	sd	s6,0(sp)
     2c0:	0080                	addi	s0,sp,64
     2c2:	8b2a                	mv	s6,a0
     2c4:	8aae                	mv	s5,a1
     2c6:	8a32                	mv	s4,a2
     2c8:	89b6                	mv	s3,a3
     2ca:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2cc:	02800513          	li	a0,40
     2d0:	00001097          	auipc	ra,0x1
     2d4:	f4c080e7          	jalr	-180(ra) # 121c <malloc>
     2d8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2da:	02800613          	li	a2,40
     2de:	4581                	li	a1,0
     2e0:	00001097          	auipc	ra,0x1
     2e4:	902080e7          	jalr	-1790(ra) # be2 <memset>
  cmd->type = REDIR;
     2e8:	4789                	li	a5,2
     2ea:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2ec:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     2f0:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     2f4:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     2f8:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     2fc:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     300:	8526                	mv	a0,s1
     302:	70e2                	ld	ra,56(sp)
     304:	7442                	ld	s0,48(sp)
     306:	74a2                	ld	s1,40(sp)
     308:	7902                	ld	s2,32(sp)
     30a:	69e2                	ld	s3,24(sp)
     30c:	6a42                	ld	s4,16(sp)
     30e:	6aa2                	ld	s5,8(sp)
     310:	6b02                	ld	s6,0(sp)
     312:	6121                	addi	sp,sp,64
     314:	8082                	ret

0000000000000316 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     316:	7179                	addi	sp,sp,-48
     318:	f406                	sd	ra,40(sp)
     31a:	f022                	sd	s0,32(sp)
     31c:	ec26                	sd	s1,24(sp)
     31e:	e84a                	sd	s2,16(sp)
     320:	e44e                	sd	s3,8(sp)
     322:	1800                	addi	s0,sp,48
     324:	89aa                	mv	s3,a0
     326:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     328:	4561                	li	a0,24
     32a:	00001097          	auipc	ra,0x1
     32e:	ef2080e7          	jalr	-270(ra) # 121c <malloc>
     332:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     334:	4661                	li	a2,24
     336:	4581                	li	a1,0
     338:	00001097          	auipc	ra,0x1
     33c:	8aa080e7          	jalr	-1878(ra) # be2 <memset>
  cmd->type = PIPE;
     340:	478d                	li	a5,3
     342:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     344:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     348:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     34c:	8526                	mv	a0,s1
     34e:	70a2                	ld	ra,40(sp)
     350:	7402                	ld	s0,32(sp)
     352:	64e2                	ld	s1,24(sp)
     354:	6942                	ld	s2,16(sp)
     356:	69a2                	ld	s3,8(sp)
     358:	6145                	addi	sp,sp,48
     35a:	8082                	ret

000000000000035c <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     35c:	7179                	addi	sp,sp,-48
     35e:	f406                	sd	ra,40(sp)
     360:	f022                	sd	s0,32(sp)
     362:	ec26                	sd	s1,24(sp)
     364:	e84a                	sd	s2,16(sp)
     366:	e44e                	sd	s3,8(sp)
     368:	1800                	addi	s0,sp,48
     36a:	89aa                	mv	s3,a0
     36c:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     36e:	4561                	li	a0,24
     370:	00001097          	auipc	ra,0x1
     374:	eac080e7          	jalr	-340(ra) # 121c <malloc>
     378:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     37a:	4661                	li	a2,24
     37c:	4581                	li	a1,0
     37e:	00001097          	auipc	ra,0x1
     382:	864080e7          	jalr	-1948(ra) # be2 <memset>
  cmd->type = LIST;
     386:	4791                	li	a5,4
     388:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     38a:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     38e:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     392:	8526                	mv	a0,s1
     394:	70a2                	ld	ra,40(sp)
     396:	7402                	ld	s0,32(sp)
     398:	64e2                	ld	s1,24(sp)
     39a:	6942                	ld	s2,16(sp)
     39c:	69a2                	ld	s3,8(sp)
     39e:	6145                	addi	sp,sp,48
     3a0:	8082                	ret

00000000000003a2 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3a2:	1101                	addi	sp,sp,-32
     3a4:	ec06                	sd	ra,24(sp)
     3a6:	e822                	sd	s0,16(sp)
     3a8:	e426                	sd	s1,8(sp)
     3aa:	e04a                	sd	s2,0(sp)
     3ac:	1000                	addi	s0,sp,32
     3ae:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3b0:	4541                	li	a0,16
     3b2:	00001097          	auipc	ra,0x1
     3b6:	e6a080e7          	jalr	-406(ra) # 121c <malloc>
     3ba:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3bc:	4641                	li	a2,16
     3be:	4581                	li	a1,0
     3c0:	00001097          	auipc	ra,0x1
     3c4:	822080e7          	jalr	-2014(ra) # be2 <memset>
  cmd->type = BACK;
     3c8:	4795                	li	a5,5
     3ca:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     3cc:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     3d0:	8526                	mv	a0,s1
     3d2:	60e2                	ld	ra,24(sp)
     3d4:	6442                	ld	s0,16(sp)
     3d6:	64a2                	ld	s1,8(sp)
     3d8:	6902                	ld	s2,0(sp)
     3da:	6105                	addi	sp,sp,32
     3dc:	8082                	ret

00000000000003de <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3de:	7139                	addi	sp,sp,-64
     3e0:	fc06                	sd	ra,56(sp)
     3e2:	f822                	sd	s0,48(sp)
     3e4:	f426                	sd	s1,40(sp)
     3e6:	f04a                	sd	s2,32(sp)
     3e8:	ec4e                	sd	s3,24(sp)
     3ea:	e852                	sd	s4,16(sp)
     3ec:	e456                	sd	s5,8(sp)
     3ee:	e05a                	sd	s6,0(sp)
     3f0:	0080                	addi	s0,sp,64
     3f2:	8a2a                	mv	s4,a0
     3f4:	892e                	mv	s2,a1
     3f6:	8ab2                	mv	s5,a2
     3f8:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     3fa:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     3fc:	00002997          	auipc	s3,0x2
     400:	c0c98993          	addi	s3,s3,-1012 # 2008 <whitespace>
     404:	00b4fd63          	bgeu	s1,a1,41e <gettoken+0x40>
     408:	0004c583          	lbu	a1,0(s1)
     40c:	854e                	mv	a0,s3
     40e:	00000097          	auipc	ra,0x0
     412:	7fa080e7          	jalr	2042(ra) # c08 <strchr>
     416:	c501                	beqz	a0,41e <gettoken+0x40>
    s++;
     418:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     41a:	fe9917e3          	bne	s2,s1,408 <gettoken+0x2a>
  if(q)
     41e:	000a8463          	beqz	s5,426 <gettoken+0x48>
    *q = s;
     422:	009ab023          	sd	s1,0(s5)
  ret = *s;
     426:	0004c783          	lbu	a5,0(s1)
     42a:	00078a9b          	sext.w	s5,a5
  switch(*s){
     42e:	03c00713          	li	a4,60
     432:	06f76563          	bltu	a4,a5,49c <gettoken+0xbe>
     436:	03a00713          	li	a4,58
     43a:	00f76e63          	bltu	a4,a5,456 <gettoken+0x78>
     43e:	cf89                	beqz	a5,458 <gettoken+0x7a>
     440:	02600713          	li	a4,38
     444:	00e78963          	beq	a5,a4,456 <gettoken+0x78>
     448:	fd87879b          	addiw	a5,a5,-40
     44c:	0ff7f793          	andi	a5,a5,255
     450:	4705                	li	a4,1
     452:	06f76c63          	bltu	a4,a5,4ca <gettoken+0xec>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     456:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     458:	000b0463          	beqz	s6,460 <gettoken+0x82>
    *eq = s;
     45c:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     460:	00002997          	auipc	s3,0x2
     464:	ba898993          	addi	s3,s3,-1112 # 2008 <whitespace>
     468:	0124fd63          	bgeu	s1,s2,482 <gettoken+0xa4>
     46c:	0004c583          	lbu	a1,0(s1)
     470:	854e                	mv	a0,s3
     472:	00000097          	auipc	ra,0x0
     476:	796080e7          	jalr	1942(ra) # c08 <strchr>
     47a:	c501                	beqz	a0,482 <gettoken+0xa4>
    s++;
     47c:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     47e:	fe9917e3          	bne	s2,s1,46c <gettoken+0x8e>
  *ps = s;
     482:	009a3023          	sd	s1,0(s4)
  return ret;
}
     486:	8556                	mv	a0,s5
     488:	70e2                	ld	ra,56(sp)
     48a:	7442                	ld	s0,48(sp)
     48c:	74a2                	ld	s1,40(sp)
     48e:	7902                	ld	s2,32(sp)
     490:	69e2                	ld	s3,24(sp)
     492:	6a42                	ld	s4,16(sp)
     494:	6aa2                	ld	s5,8(sp)
     496:	6b02                	ld	s6,0(sp)
     498:	6121                	addi	sp,sp,64
     49a:	8082                	ret
  switch(*s){
     49c:	03e00713          	li	a4,62
     4a0:	02e79163          	bne	a5,a4,4c2 <gettoken+0xe4>
    s++;
     4a4:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     4a8:	0014c703          	lbu	a4,1(s1)
     4ac:	03e00793          	li	a5,62
      s++;
     4b0:	0489                	addi	s1,s1,2
      ret = '+';
     4b2:	02b00a93          	li	s5,43
    if(*s == '>'){
     4b6:	faf701e3          	beq	a4,a5,458 <gettoken+0x7a>
    s++;
     4ba:	84b6                	mv	s1,a3
  ret = *s;
     4bc:	03e00a93          	li	s5,62
     4c0:	bf61                	j	458 <gettoken+0x7a>
  switch(*s){
     4c2:	07c00713          	li	a4,124
     4c6:	f8e788e3          	beq	a5,a4,456 <gettoken+0x78>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4ca:	00002997          	auipc	s3,0x2
     4ce:	b3e98993          	addi	s3,s3,-1218 # 2008 <whitespace>
     4d2:	00002a97          	auipc	s5,0x2
     4d6:	b2ea8a93          	addi	s5,s5,-1234 # 2000 <symbols>
     4da:	0324f563          	bgeu	s1,s2,504 <gettoken+0x126>
     4de:	0004c583          	lbu	a1,0(s1)
     4e2:	854e                	mv	a0,s3
     4e4:	00000097          	auipc	ra,0x0
     4e8:	724080e7          	jalr	1828(ra) # c08 <strchr>
     4ec:	e505                	bnez	a0,514 <gettoken+0x136>
     4ee:	0004c583          	lbu	a1,0(s1)
     4f2:	8556                	mv	a0,s5
     4f4:	00000097          	auipc	ra,0x0
     4f8:	714080e7          	jalr	1812(ra) # c08 <strchr>
     4fc:	e909                	bnez	a0,50e <gettoken+0x130>
      s++;
     4fe:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     500:	fc991fe3          	bne	s2,s1,4de <gettoken+0x100>
  if(eq)
     504:	06100a93          	li	s5,97
     508:	f40b1ae3          	bnez	s6,45c <gettoken+0x7e>
     50c:	bf9d                	j	482 <gettoken+0xa4>
    ret = 'a';
     50e:	06100a93          	li	s5,97
     512:	b799                	j	458 <gettoken+0x7a>
     514:	06100a93          	li	s5,97
     518:	b781                	j	458 <gettoken+0x7a>

000000000000051a <peek>:

int
peek(char **ps, char *es, char *toks)
{
     51a:	7139                	addi	sp,sp,-64
     51c:	fc06                	sd	ra,56(sp)
     51e:	f822                	sd	s0,48(sp)
     520:	f426                	sd	s1,40(sp)
     522:	f04a                	sd	s2,32(sp)
     524:	ec4e                	sd	s3,24(sp)
     526:	e852                	sd	s4,16(sp)
     528:	e456                	sd	s5,8(sp)
     52a:	0080                	addi	s0,sp,64
     52c:	8a2a                	mv	s4,a0
     52e:	892e                	mv	s2,a1
     530:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     532:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     534:	00002997          	auipc	s3,0x2
     538:	ad498993          	addi	s3,s3,-1324 # 2008 <whitespace>
     53c:	00b4fd63          	bgeu	s1,a1,556 <peek+0x3c>
     540:	0004c583          	lbu	a1,0(s1)
     544:	854e                	mv	a0,s3
     546:	00000097          	auipc	ra,0x0
     54a:	6c2080e7          	jalr	1730(ra) # c08 <strchr>
     54e:	c501                	beqz	a0,556 <peek+0x3c>
    s++;
     550:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     552:	fe9917e3          	bne	s2,s1,540 <peek+0x26>
  *ps = s;
     556:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     55a:	0004c583          	lbu	a1,0(s1)
     55e:	4501                	li	a0,0
     560:	e991                	bnez	a1,574 <peek+0x5a>
}
     562:	70e2                	ld	ra,56(sp)
     564:	7442                	ld	s0,48(sp)
     566:	74a2                	ld	s1,40(sp)
     568:	7902                	ld	s2,32(sp)
     56a:	69e2                	ld	s3,24(sp)
     56c:	6a42                	ld	s4,16(sp)
     56e:	6aa2                	ld	s5,8(sp)
     570:	6121                	addi	sp,sp,64
     572:	8082                	ret
  return *s && strchr(toks, *s);
     574:	8556                	mv	a0,s5
     576:	00000097          	auipc	ra,0x0
     57a:	692080e7          	jalr	1682(ra) # c08 <strchr>
     57e:	00a03533          	snez	a0,a0
     582:	b7c5                	j	562 <peek+0x48>

0000000000000584 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     584:	7159                	addi	sp,sp,-112
     586:	f486                	sd	ra,104(sp)
     588:	f0a2                	sd	s0,96(sp)
     58a:	eca6                	sd	s1,88(sp)
     58c:	e8ca                	sd	s2,80(sp)
     58e:	e4ce                	sd	s3,72(sp)
     590:	e0d2                	sd	s4,64(sp)
     592:	fc56                	sd	s5,56(sp)
     594:	f85a                	sd	s6,48(sp)
     596:	f45e                	sd	s7,40(sp)
     598:	f062                	sd	s8,32(sp)
     59a:	ec66                	sd	s9,24(sp)
     59c:	1880                	addi	s0,sp,112
     59e:	8a2a                	mv	s4,a0
     5a0:	89ae                	mv	s3,a1
     5a2:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5a4:	00001b97          	auipc	s7,0x1
     5a8:	dc4b8b93          	addi	s7,s7,-572 # 1368 <malloc+0x14c>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5ac:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     5b0:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     5b4:	a02d                	j	5de <parseredirs+0x5a>
      panic("missing file for redirection");
     5b6:	00001517          	auipc	a0,0x1
     5ba:	d9250513          	addi	a0,a0,-622 # 1348 <malloc+0x12c>
     5be:	00000097          	auipc	ra,0x0
     5c2:	a98080e7          	jalr	-1384(ra) # 56 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5c6:	4701                	li	a4,0
     5c8:	4681                	li	a3,0
     5ca:	f9043603          	ld	a2,-112(s0)
     5ce:	f9843583          	ld	a1,-104(s0)
     5d2:	8552                	mv	a0,s4
     5d4:	00000097          	auipc	ra,0x0
     5d8:	cda080e7          	jalr	-806(ra) # 2ae <redircmd>
     5dc:	8a2a                	mv	s4,a0
    switch(tok){
     5de:	03e00b13          	li	s6,62
     5e2:	02b00a93          	li	s5,43
  while(peek(ps, es, "<>")){
     5e6:	865e                	mv	a2,s7
     5e8:	85ca                	mv	a1,s2
     5ea:	854e                	mv	a0,s3
     5ec:	00000097          	auipc	ra,0x0
     5f0:	f2e080e7          	jalr	-210(ra) # 51a <peek>
     5f4:	c925                	beqz	a0,664 <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     5f6:	4681                	li	a3,0
     5f8:	4601                	li	a2,0
     5fa:	85ca                	mv	a1,s2
     5fc:	854e                	mv	a0,s3
     5fe:	00000097          	auipc	ra,0x0
     602:	de0080e7          	jalr	-544(ra) # 3de <gettoken>
     606:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     608:	f9040693          	addi	a3,s0,-112
     60c:	f9840613          	addi	a2,s0,-104
     610:	85ca                	mv	a1,s2
     612:	854e                	mv	a0,s3
     614:	00000097          	auipc	ra,0x0
     618:	dca080e7          	jalr	-566(ra) # 3de <gettoken>
     61c:	f9851de3          	bne	a0,s8,5b6 <parseredirs+0x32>
    switch(tok){
     620:	fb9483e3          	beq	s1,s9,5c6 <parseredirs+0x42>
     624:	03648263          	beq	s1,s6,648 <parseredirs+0xc4>
     628:	fb549fe3          	bne	s1,s5,5e6 <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     62c:	4705                	li	a4,1
     62e:	20100693          	li	a3,513
     632:	f9043603          	ld	a2,-112(s0)
     636:	f9843583          	ld	a1,-104(s0)
     63a:	8552                	mv	a0,s4
     63c:	00000097          	auipc	ra,0x0
     640:	c72080e7          	jalr	-910(ra) # 2ae <redircmd>
     644:	8a2a                	mv	s4,a0
      break;
     646:	bf61                	j	5de <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     648:	4705                	li	a4,1
     64a:	60100693          	li	a3,1537
     64e:	f9043603          	ld	a2,-112(s0)
     652:	f9843583          	ld	a1,-104(s0)
     656:	8552                	mv	a0,s4
     658:	00000097          	auipc	ra,0x0
     65c:	c56080e7          	jalr	-938(ra) # 2ae <redircmd>
     660:	8a2a                	mv	s4,a0
      break;
     662:	bfb5                	j	5de <parseredirs+0x5a>
    }
  }
  return cmd;
}
     664:	8552                	mv	a0,s4
     666:	70a6                	ld	ra,104(sp)
     668:	7406                	ld	s0,96(sp)
     66a:	64e6                	ld	s1,88(sp)
     66c:	6946                	ld	s2,80(sp)
     66e:	69a6                	ld	s3,72(sp)
     670:	6a06                	ld	s4,64(sp)
     672:	7ae2                	ld	s5,56(sp)
     674:	7b42                	ld	s6,48(sp)
     676:	7ba2                	ld	s7,40(sp)
     678:	7c02                	ld	s8,32(sp)
     67a:	6ce2                	ld	s9,24(sp)
     67c:	6165                	addi	sp,sp,112
     67e:	8082                	ret

0000000000000680 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     680:	7159                	addi	sp,sp,-112
     682:	f486                	sd	ra,104(sp)
     684:	f0a2                	sd	s0,96(sp)
     686:	eca6                	sd	s1,88(sp)
     688:	e8ca                	sd	s2,80(sp)
     68a:	e4ce                	sd	s3,72(sp)
     68c:	e0d2                	sd	s4,64(sp)
     68e:	fc56                	sd	s5,56(sp)
     690:	f85a                	sd	s6,48(sp)
     692:	f45e                	sd	s7,40(sp)
     694:	f062                	sd	s8,32(sp)
     696:	ec66                	sd	s9,24(sp)
     698:	1880                	addi	s0,sp,112
     69a:	8a2a                	mv	s4,a0
     69c:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     69e:	00001617          	auipc	a2,0x1
     6a2:	cd260613          	addi	a2,a2,-814 # 1370 <malloc+0x154>
     6a6:	00000097          	auipc	ra,0x0
     6aa:	e74080e7          	jalr	-396(ra) # 51a <peek>
     6ae:	e905                	bnez	a0,6de <parseexec+0x5e>
     6b0:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     6b2:	00000097          	auipc	ra,0x0
     6b6:	bc6080e7          	jalr	-1082(ra) # 278 <execcmd>
     6ba:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     6bc:	8656                	mv	a2,s5
     6be:	85d2                	mv	a1,s4
     6c0:	00000097          	auipc	ra,0x0
     6c4:	ec4080e7          	jalr	-316(ra) # 584 <parseredirs>
     6c8:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     6ca:	008c0913          	addi	s2,s8,8
     6ce:	00001b17          	auipc	s6,0x1
     6d2:	cc2b0b13          	addi	s6,s6,-830 # 1390 <malloc+0x174>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     6d6:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     6da:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     6dc:	a0b1                	j	728 <parseexec+0xa8>
    return parseblock(ps, es);
     6de:	85d6                	mv	a1,s5
     6e0:	8552                	mv	a0,s4
     6e2:	00000097          	auipc	ra,0x0
     6e6:	1bc080e7          	jalr	444(ra) # 89e <parseblock>
     6ea:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     6ec:	8526                	mv	a0,s1
     6ee:	70a6                	ld	ra,104(sp)
     6f0:	7406                	ld	s0,96(sp)
     6f2:	64e6                	ld	s1,88(sp)
     6f4:	6946                	ld	s2,80(sp)
     6f6:	69a6                	ld	s3,72(sp)
     6f8:	6a06                	ld	s4,64(sp)
     6fa:	7ae2                	ld	s5,56(sp)
     6fc:	7b42                	ld	s6,48(sp)
     6fe:	7ba2                	ld	s7,40(sp)
     700:	7c02                	ld	s8,32(sp)
     702:	6ce2                	ld	s9,24(sp)
     704:	6165                	addi	sp,sp,112
     706:	8082                	ret
      panic("syntax");
     708:	00001517          	auipc	a0,0x1
     70c:	c7050513          	addi	a0,a0,-912 # 1378 <malloc+0x15c>
     710:	00000097          	auipc	ra,0x0
     714:	946080e7          	jalr	-1722(ra) # 56 <panic>
    ret = parseredirs(ret, ps, es);
     718:	8656                	mv	a2,s5
     71a:	85d2                	mv	a1,s4
     71c:	8526                	mv	a0,s1
     71e:	00000097          	auipc	ra,0x0
     722:	e66080e7          	jalr	-410(ra) # 584 <parseredirs>
     726:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     728:	865a                	mv	a2,s6
     72a:	85d6                	mv	a1,s5
     72c:	8552                	mv	a0,s4
     72e:	00000097          	auipc	ra,0x0
     732:	dec080e7          	jalr	-532(ra) # 51a <peek>
     736:	e131                	bnez	a0,77a <parseexec+0xfa>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     738:	f9040693          	addi	a3,s0,-112
     73c:	f9840613          	addi	a2,s0,-104
     740:	85d6                	mv	a1,s5
     742:	8552                	mv	a0,s4
     744:	00000097          	auipc	ra,0x0
     748:	c9a080e7          	jalr	-870(ra) # 3de <gettoken>
     74c:	c51d                	beqz	a0,77a <parseexec+0xfa>
    if(tok != 'a')
     74e:	fb951de3          	bne	a0,s9,708 <parseexec+0x88>
    cmd->argv[argc] = q;
     752:	f9843783          	ld	a5,-104(s0)
     756:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     75a:	f9043783          	ld	a5,-112(s0)
     75e:	04f93823          	sd	a5,80(s2)
    argc++;
     762:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     764:	0921                	addi	s2,s2,8
     766:	fb7999e3          	bne	s3,s7,718 <parseexec+0x98>
      panic("too many args");
     76a:	00001517          	auipc	a0,0x1
     76e:	c1650513          	addi	a0,a0,-1002 # 1380 <malloc+0x164>
     772:	00000097          	auipc	ra,0x0
     776:	8e4080e7          	jalr	-1820(ra) # 56 <panic>
  cmd->argv[argc] = 0;
     77a:	098e                	slli	s3,s3,0x3
     77c:	99e2                	add	s3,s3,s8
     77e:	0009b423          	sd	zero,8(s3)
  cmd->eargv[argc] = 0;
     782:	0409bc23          	sd	zero,88(s3)
  return ret;
     786:	b79d                	j	6ec <parseexec+0x6c>

0000000000000788 <parsepipe>:
{
     788:	7179                	addi	sp,sp,-48
     78a:	f406                	sd	ra,40(sp)
     78c:	f022                	sd	s0,32(sp)
     78e:	ec26                	sd	s1,24(sp)
     790:	e84a                	sd	s2,16(sp)
     792:	e44e                	sd	s3,8(sp)
     794:	1800                	addi	s0,sp,48
     796:	892a                	mv	s2,a0
     798:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     79a:	00000097          	auipc	ra,0x0
     79e:	ee6080e7          	jalr	-282(ra) # 680 <parseexec>
     7a2:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     7a4:	00001617          	auipc	a2,0x1
     7a8:	bf460613          	addi	a2,a2,-1036 # 1398 <malloc+0x17c>
     7ac:	85ce                	mv	a1,s3
     7ae:	854a                	mv	a0,s2
     7b0:	00000097          	auipc	ra,0x0
     7b4:	d6a080e7          	jalr	-662(ra) # 51a <peek>
     7b8:	e909                	bnez	a0,7ca <parsepipe+0x42>
}
     7ba:	8526                	mv	a0,s1
     7bc:	70a2                	ld	ra,40(sp)
     7be:	7402                	ld	s0,32(sp)
     7c0:	64e2                	ld	s1,24(sp)
     7c2:	6942                	ld	s2,16(sp)
     7c4:	69a2                	ld	s3,8(sp)
     7c6:	6145                	addi	sp,sp,48
     7c8:	8082                	ret
    gettoken(ps, es, 0, 0);
     7ca:	4681                	li	a3,0
     7cc:	4601                	li	a2,0
     7ce:	85ce                	mv	a1,s3
     7d0:	854a                	mv	a0,s2
     7d2:	00000097          	auipc	ra,0x0
     7d6:	c0c080e7          	jalr	-1012(ra) # 3de <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     7da:	85ce                	mv	a1,s3
     7dc:	854a                	mv	a0,s2
     7de:	00000097          	auipc	ra,0x0
     7e2:	faa080e7          	jalr	-86(ra) # 788 <parsepipe>
     7e6:	85aa                	mv	a1,a0
     7e8:	8526                	mv	a0,s1
     7ea:	00000097          	auipc	ra,0x0
     7ee:	b2c080e7          	jalr	-1236(ra) # 316 <pipecmd>
     7f2:	84aa                	mv	s1,a0
  return cmd;
     7f4:	b7d9                	j	7ba <parsepipe+0x32>

00000000000007f6 <parseline>:
{
     7f6:	7179                	addi	sp,sp,-48
     7f8:	f406                	sd	ra,40(sp)
     7fa:	f022                	sd	s0,32(sp)
     7fc:	ec26                	sd	s1,24(sp)
     7fe:	e84a                	sd	s2,16(sp)
     800:	e44e                	sd	s3,8(sp)
     802:	e052                	sd	s4,0(sp)
     804:	1800                	addi	s0,sp,48
     806:	892a                	mv	s2,a0
     808:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     80a:	00000097          	auipc	ra,0x0
     80e:	f7e080e7          	jalr	-130(ra) # 788 <parsepipe>
     812:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     814:	00001a17          	auipc	s4,0x1
     818:	b8ca0a13          	addi	s4,s4,-1140 # 13a0 <malloc+0x184>
     81c:	8652                	mv	a2,s4
     81e:	85ce                	mv	a1,s3
     820:	854a                	mv	a0,s2
     822:	00000097          	auipc	ra,0x0
     826:	cf8080e7          	jalr	-776(ra) # 51a <peek>
     82a:	c105                	beqz	a0,84a <parseline+0x54>
    gettoken(ps, es, 0, 0);
     82c:	4681                	li	a3,0
     82e:	4601                	li	a2,0
     830:	85ce                	mv	a1,s3
     832:	854a                	mv	a0,s2
     834:	00000097          	auipc	ra,0x0
     838:	baa080e7          	jalr	-1110(ra) # 3de <gettoken>
    cmd = backcmd(cmd);
     83c:	8526                	mv	a0,s1
     83e:	00000097          	auipc	ra,0x0
     842:	b64080e7          	jalr	-1180(ra) # 3a2 <backcmd>
     846:	84aa                	mv	s1,a0
     848:	bfd1                	j	81c <parseline+0x26>
  if(peek(ps, es, ";")){
     84a:	00001617          	auipc	a2,0x1
     84e:	b5e60613          	addi	a2,a2,-1186 # 13a8 <malloc+0x18c>
     852:	85ce                	mv	a1,s3
     854:	854a                	mv	a0,s2
     856:	00000097          	auipc	ra,0x0
     85a:	cc4080e7          	jalr	-828(ra) # 51a <peek>
     85e:	e911                	bnez	a0,872 <parseline+0x7c>
}
     860:	8526                	mv	a0,s1
     862:	70a2                	ld	ra,40(sp)
     864:	7402                	ld	s0,32(sp)
     866:	64e2                	ld	s1,24(sp)
     868:	6942                	ld	s2,16(sp)
     86a:	69a2                	ld	s3,8(sp)
     86c:	6a02                	ld	s4,0(sp)
     86e:	6145                	addi	sp,sp,48
     870:	8082                	ret
    gettoken(ps, es, 0, 0);
     872:	4681                	li	a3,0
     874:	4601                	li	a2,0
     876:	85ce                	mv	a1,s3
     878:	854a                	mv	a0,s2
     87a:	00000097          	auipc	ra,0x0
     87e:	b64080e7          	jalr	-1180(ra) # 3de <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     882:	85ce                	mv	a1,s3
     884:	854a                	mv	a0,s2
     886:	00000097          	auipc	ra,0x0
     88a:	f70080e7          	jalr	-144(ra) # 7f6 <parseline>
     88e:	85aa                	mv	a1,a0
     890:	8526                	mv	a0,s1
     892:	00000097          	auipc	ra,0x0
     896:	aca080e7          	jalr	-1334(ra) # 35c <listcmd>
     89a:	84aa                	mv	s1,a0
  return cmd;
     89c:	b7d1                	j	860 <parseline+0x6a>

000000000000089e <parseblock>:
{
     89e:	7179                	addi	sp,sp,-48
     8a0:	f406                	sd	ra,40(sp)
     8a2:	f022                	sd	s0,32(sp)
     8a4:	ec26                	sd	s1,24(sp)
     8a6:	e84a                	sd	s2,16(sp)
     8a8:	e44e                	sd	s3,8(sp)
     8aa:	1800                	addi	s0,sp,48
     8ac:	84aa                	mv	s1,a0
     8ae:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     8b0:	00001617          	auipc	a2,0x1
     8b4:	ac060613          	addi	a2,a2,-1344 # 1370 <malloc+0x154>
     8b8:	00000097          	auipc	ra,0x0
     8bc:	c62080e7          	jalr	-926(ra) # 51a <peek>
     8c0:	c12d                	beqz	a0,922 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     8c2:	4681                	li	a3,0
     8c4:	4601                	li	a2,0
     8c6:	85ca                	mv	a1,s2
     8c8:	8526                	mv	a0,s1
     8ca:	00000097          	auipc	ra,0x0
     8ce:	b14080e7          	jalr	-1260(ra) # 3de <gettoken>
  cmd = parseline(ps, es);
     8d2:	85ca                	mv	a1,s2
     8d4:	8526                	mv	a0,s1
     8d6:	00000097          	auipc	ra,0x0
     8da:	f20080e7          	jalr	-224(ra) # 7f6 <parseline>
     8de:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     8e0:	00001617          	auipc	a2,0x1
     8e4:	ae060613          	addi	a2,a2,-1312 # 13c0 <malloc+0x1a4>
     8e8:	85ca                	mv	a1,s2
     8ea:	8526                	mv	a0,s1
     8ec:	00000097          	auipc	ra,0x0
     8f0:	c2e080e7          	jalr	-978(ra) # 51a <peek>
     8f4:	cd1d                	beqz	a0,932 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     8f6:	4681                	li	a3,0
     8f8:	4601                	li	a2,0
     8fa:	85ca                	mv	a1,s2
     8fc:	8526                	mv	a0,s1
     8fe:	00000097          	auipc	ra,0x0
     902:	ae0080e7          	jalr	-1312(ra) # 3de <gettoken>
  cmd = parseredirs(cmd, ps, es);
     906:	864a                	mv	a2,s2
     908:	85a6                	mv	a1,s1
     90a:	854e                	mv	a0,s3
     90c:	00000097          	auipc	ra,0x0
     910:	c78080e7          	jalr	-904(ra) # 584 <parseredirs>
}
     914:	70a2                	ld	ra,40(sp)
     916:	7402                	ld	s0,32(sp)
     918:	64e2                	ld	s1,24(sp)
     91a:	6942                	ld	s2,16(sp)
     91c:	69a2                	ld	s3,8(sp)
     91e:	6145                	addi	sp,sp,48
     920:	8082                	ret
    panic("parseblock");
     922:	00001517          	auipc	a0,0x1
     926:	a8e50513          	addi	a0,a0,-1394 # 13b0 <malloc+0x194>
     92a:	fffff097          	auipc	ra,0xfffff
     92e:	72c080e7          	jalr	1836(ra) # 56 <panic>
    panic("syntax - missing )");
     932:	00001517          	auipc	a0,0x1
     936:	a9650513          	addi	a0,a0,-1386 # 13c8 <malloc+0x1ac>
     93a:	fffff097          	auipc	ra,0xfffff
     93e:	71c080e7          	jalr	1820(ra) # 56 <panic>

0000000000000942 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     942:	1101                	addi	sp,sp,-32
     944:	ec06                	sd	ra,24(sp)
     946:	e822                	sd	s0,16(sp)
     948:	e426                	sd	s1,8(sp)
     94a:	1000                	addi	s0,sp,32
     94c:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     94e:	c521                	beqz	a0,996 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     950:	4118                	lw	a4,0(a0)
     952:	4795                	li	a5,5
     954:	04e7e163          	bltu	a5,a4,996 <nulterminate+0x54>
     958:	00056783          	lwu	a5,0(a0)
     95c:	078a                	slli	a5,a5,0x2
     95e:	00001717          	auipc	a4,0x1
     962:	aca70713          	addi	a4,a4,-1334 # 1428 <malloc+0x20c>
     966:	97ba                	add	a5,a5,a4
     968:	439c                	lw	a5,0(a5)
     96a:	97ba                	add	a5,a5,a4
     96c:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     96e:	651c                	ld	a5,8(a0)
     970:	c39d                	beqz	a5,996 <nulterminate+0x54>
     972:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     976:	67b8                	ld	a4,72(a5)
     978:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     97c:	07a1                	addi	a5,a5,8
     97e:	ff87b703          	ld	a4,-8(a5)
     982:	fb75                	bnez	a4,976 <nulterminate+0x34>
     984:	a809                	j	996 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     986:	6508                	ld	a0,8(a0)
     988:	00000097          	auipc	ra,0x0
     98c:	fba080e7          	jalr	-70(ra) # 942 <nulterminate>
    *rcmd->efile = 0;
     990:	6c9c                	ld	a5,24(s1)
     992:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     996:	8526                	mv	a0,s1
     998:	60e2                	ld	ra,24(sp)
     99a:	6442                	ld	s0,16(sp)
     99c:	64a2                	ld	s1,8(sp)
     99e:	6105                	addi	sp,sp,32
     9a0:	8082                	ret
    nulterminate(pcmd->left);
     9a2:	6508                	ld	a0,8(a0)
     9a4:	00000097          	auipc	ra,0x0
     9a8:	f9e080e7          	jalr	-98(ra) # 942 <nulterminate>
    nulterminate(pcmd->right);
     9ac:	6888                	ld	a0,16(s1)
     9ae:	00000097          	auipc	ra,0x0
     9b2:	f94080e7          	jalr	-108(ra) # 942 <nulterminate>
    break;
     9b6:	b7c5                	j	996 <nulterminate+0x54>
    nulterminate(lcmd->left);
     9b8:	6508                	ld	a0,8(a0)
     9ba:	00000097          	auipc	ra,0x0
     9be:	f88080e7          	jalr	-120(ra) # 942 <nulterminate>
    nulterminate(lcmd->right);
     9c2:	6888                	ld	a0,16(s1)
     9c4:	00000097          	auipc	ra,0x0
     9c8:	f7e080e7          	jalr	-130(ra) # 942 <nulterminate>
    break;
     9cc:	b7e9                	j	996 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     9ce:	6508                	ld	a0,8(a0)
     9d0:	00000097          	auipc	ra,0x0
     9d4:	f72080e7          	jalr	-142(ra) # 942 <nulterminate>
    break;
     9d8:	bf7d                	j	996 <nulterminate+0x54>

00000000000009da <parsecmd>:
{
     9da:	7179                	addi	sp,sp,-48
     9dc:	f406                	sd	ra,40(sp)
     9de:	f022                	sd	s0,32(sp)
     9e0:	ec26                	sd	s1,24(sp)
     9e2:	e84a                	sd	s2,16(sp)
     9e4:	1800                	addi	s0,sp,48
     9e6:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     9ea:	84aa                	mv	s1,a0
     9ec:	00000097          	auipc	ra,0x0
     9f0:	1cc080e7          	jalr	460(ra) # bb8 <strlen>
     9f4:	1502                	slli	a0,a0,0x20
     9f6:	9101                	srli	a0,a0,0x20
     9f8:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     9fa:	85a6                	mv	a1,s1
     9fc:	fd840513          	addi	a0,s0,-40
     a00:	00000097          	auipc	ra,0x0
     a04:	df6080e7          	jalr	-522(ra) # 7f6 <parseline>
     a08:	892a                	mv	s2,a0
  peek(&s, es, "");
     a0a:	00001617          	auipc	a2,0x1
     a0e:	9d660613          	addi	a2,a2,-1578 # 13e0 <malloc+0x1c4>
     a12:	85a6                	mv	a1,s1
     a14:	fd840513          	addi	a0,s0,-40
     a18:	00000097          	auipc	ra,0x0
     a1c:	b02080e7          	jalr	-1278(ra) # 51a <peek>
  if(s != es){
     a20:	fd843603          	ld	a2,-40(s0)
     a24:	00961e63          	bne	a2,s1,a40 <parsecmd+0x66>
  nulterminate(cmd);
     a28:	854a                	mv	a0,s2
     a2a:	00000097          	auipc	ra,0x0
     a2e:	f18080e7          	jalr	-232(ra) # 942 <nulterminate>
}
     a32:	854a                	mv	a0,s2
     a34:	70a2                	ld	ra,40(sp)
     a36:	7402                	ld	s0,32(sp)
     a38:	64e2                	ld	s1,24(sp)
     a3a:	6942                	ld	s2,16(sp)
     a3c:	6145                	addi	sp,sp,48
     a3e:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     a40:	00001597          	auipc	a1,0x1
     a44:	9a858593          	addi	a1,a1,-1624 # 13e8 <malloc+0x1cc>
     a48:	4509                	li	a0,2
     a4a:	00000097          	auipc	ra,0x0
     a4e:	6e6080e7          	jalr	1766(ra) # 1130 <fprintf>
    panic("syntax");
     a52:	00001517          	auipc	a0,0x1
     a56:	92650513          	addi	a0,a0,-1754 # 1378 <malloc+0x15c>
     a5a:	fffff097          	auipc	ra,0xfffff
     a5e:	5fc080e7          	jalr	1532(ra) # 56 <panic>

0000000000000a62 <main>:
{
     a62:	7139                	addi	sp,sp,-64
     a64:	fc06                	sd	ra,56(sp)
     a66:	f822                	sd	s0,48(sp)
     a68:	f426                	sd	s1,40(sp)
     a6a:	f04a                	sd	s2,32(sp)
     a6c:	ec4e                	sd	s3,24(sp)
     a6e:	e852                	sd	s4,16(sp)
     a70:	e456                	sd	s5,8(sp)
     a72:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     a74:	00001497          	auipc	s1,0x1
     a78:	98448493          	addi	s1,s1,-1660 # 13f8 <malloc+0x1dc>
     a7c:	4589                	li	a1,2
     a7e:	8526                	mv	a0,s1
     a80:	00000097          	auipc	ra,0x0
     a84:	3a6080e7          	jalr	934(ra) # e26 <open>
     a88:	00054963          	bltz	a0,a9a <main+0x38>
    if(fd >= 3){
     a8c:	4789                	li	a5,2
     a8e:	fea7d7e3          	bge	a5,a0,a7c <main+0x1a>
      close(fd);
     a92:	00000097          	auipc	ra,0x0
     a96:	37c080e7          	jalr	892(ra) # e0e <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     a9a:	00001497          	auipc	s1,0x1
     a9e:	58648493          	addi	s1,s1,1414 # 2020 <buf.1134>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     aa2:	06300913          	li	s2,99
     aa6:	02000993          	li	s3,32
      if(chdir(buf+3) < 0)
     aaa:	00001a17          	auipc	s4,0x1
     aae:	579a0a13          	addi	s4,s4,1401 # 2023 <buf.1134+0x3>
        fprintf(2, "cannot cd %s\n", buf+3);
     ab2:	00001a97          	auipc	s5,0x1
     ab6:	94ea8a93          	addi	s5,s5,-1714 # 1400 <malloc+0x1e4>
     aba:	a819                	j	ad0 <main+0x6e>
    if(fork1() == 0)
     abc:	fffff097          	auipc	ra,0xfffff
     ac0:	5c0080e7          	jalr	1472(ra) # 7c <fork1>
     ac4:	c925                	beqz	a0,b34 <main+0xd2>
    wait(0);
     ac6:	4501                	li	a0,0
     ac8:	00000097          	auipc	ra,0x0
     acc:	326080e7          	jalr	806(ra) # dee <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ad0:	06400593          	li	a1,100
     ad4:	8526                	mv	a0,s1
     ad6:	fffff097          	auipc	ra,0xfffff
     ada:	52a080e7          	jalr	1322(ra) # 0 <getcmd>
     ade:	06054763          	bltz	a0,b4c <main+0xea>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ae2:	0004c783          	lbu	a5,0(s1)
     ae6:	fd279be3          	bne	a5,s2,abc <main+0x5a>
     aea:	0014c703          	lbu	a4,1(s1)
     aee:	06400793          	li	a5,100
     af2:	fcf715e3          	bne	a4,a5,abc <main+0x5a>
     af6:	0024c783          	lbu	a5,2(s1)
     afa:	fd3791e3          	bne	a5,s3,abc <main+0x5a>
      buf[strlen(buf)-1] = 0;  // chop \n
     afe:	8526                	mv	a0,s1
     b00:	00000097          	auipc	ra,0x0
     b04:	0b8080e7          	jalr	184(ra) # bb8 <strlen>
     b08:	fff5079b          	addiw	a5,a0,-1
     b0c:	1782                	slli	a5,a5,0x20
     b0e:	9381                	srli	a5,a5,0x20
     b10:	97a6                	add	a5,a5,s1
     b12:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     b16:	8552                	mv	a0,s4
     b18:	00000097          	auipc	ra,0x0
     b1c:	33e080e7          	jalr	830(ra) # e56 <chdir>
     b20:	fa0558e3          	bgez	a0,ad0 <main+0x6e>
        fprintf(2, "cannot cd %s\n", buf+3);
     b24:	8652                	mv	a2,s4
     b26:	85d6                	mv	a1,s5
     b28:	4509                	li	a0,2
     b2a:	00000097          	auipc	ra,0x0
     b2e:	606080e7          	jalr	1542(ra) # 1130 <fprintf>
     b32:	bf79                	j	ad0 <main+0x6e>
      runcmd(parsecmd(buf));
     b34:	00001517          	auipc	a0,0x1
     b38:	4ec50513          	addi	a0,a0,1260 # 2020 <buf.1134>
     b3c:	00000097          	auipc	ra,0x0
     b40:	e9e080e7          	jalr	-354(ra) # 9da <parsecmd>
     b44:	fffff097          	auipc	ra,0xfffff
     b48:	566080e7          	jalr	1382(ra) # aa <runcmd>
  exit(0);
     b4c:	4501                	li	a0,0
     b4e:	00000097          	auipc	ra,0x0
     b52:	298080e7          	jalr	664(ra) # de6 <exit>

0000000000000b56 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
     b56:	1141                	addi	sp,sp,-16
     b58:	e406                	sd	ra,8(sp)
     b5a:	e022                	sd	s0,0(sp)
     b5c:	0800                	addi	s0,sp,16
  extern int main();
  main();
     b5e:	00000097          	auipc	ra,0x0
     b62:	f04080e7          	jalr	-252(ra) # a62 <main>
  exit(0);
     b66:	4501                	li	a0,0
     b68:	00000097          	auipc	ra,0x0
     b6c:	27e080e7          	jalr	638(ra) # de6 <exit>

0000000000000b70 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
     b70:	1141                	addi	sp,sp,-16
     b72:	e422                	sd	s0,8(sp)
     b74:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b76:	87aa                	mv	a5,a0
     b78:	0585                	addi	a1,a1,1
     b7a:	0785                	addi	a5,a5,1
     b7c:	fff5c703          	lbu	a4,-1(a1)
     b80:	fee78fa3          	sb	a4,-1(a5)
     b84:	fb75                	bnez	a4,b78 <strcpy+0x8>
    ;
  return os;
}
     b86:	6422                	ld	s0,8(sp)
     b88:	0141                	addi	sp,sp,16
     b8a:	8082                	ret

0000000000000b8c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b8c:	1141                	addi	sp,sp,-16
     b8e:	e422                	sd	s0,8(sp)
     b90:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     b92:	00054783          	lbu	a5,0(a0)
     b96:	cb91                	beqz	a5,baa <strcmp+0x1e>
     b98:	0005c703          	lbu	a4,0(a1)
     b9c:	00f71763          	bne	a4,a5,baa <strcmp+0x1e>
    p++, q++;
     ba0:	0505                	addi	a0,a0,1
     ba2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     ba4:	00054783          	lbu	a5,0(a0)
     ba8:	fbe5                	bnez	a5,b98 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     baa:	0005c503          	lbu	a0,0(a1)
}
     bae:	40a7853b          	subw	a0,a5,a0
     bb2:	6422                	ld	s0,8(sp)
     bb4:	0141                	addi	sp,sp,16
     bb6:	8082                	ret

0000000000000bb8 <strlen>:

uint
strlen(const char *s)
{
     bb8:	1141                	addi	sp,sp,-16
     bba:	e422                	sd	s0,8(sp)
     bbc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     bbe:	00054783          	lbu	a5,0(a0)
     bc2:	cf91                	beqz	a5,bde <strlen+0x26>
     bc4:	0505                	addi	a0,a0,1
     bc6:	87aa                	mv	a5,a0
     bc8:	4685                	li	a3,1
     bca:	9e89                	subw	a3,a3,a0
     bcc:	00f6853b          	addw	a0,a3,a5
     bd0:	0785                	addi	a5,a5,1
     bd2:	fff7c703          	lbu	a4,-1(a5)
     bd6:	fb7d                	bnez	a4,bcc <strlen+0x14>
    ;
  return n;
}
     bd8:	6422                	ld	s0,8(sp)
     bda:	0141                	addi	sp,sp,16
     bdc:	8082                	ret
  for(n = 0; s[n]; n++)
     bde:	4501                	li	a0,0
     be0:	bfe5                	j	bd8 <strlen+0x20>

0000000000000be2 <memset>:

void*
memset(void *dst, int c, uint n)
{
     be2:	1141                	addi	sp,sp,-16
     be4:	e422                	sd	s0,8(sp)
     be6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     be8:	ce09                	beqz	a2,c02 <memset+0x20>
     bea:	87aa                	mv	a5,a0
     bec:	fff6071b          	addiw	a4,a2,-1
     bf0:	1702                	slli	a4,a4,0x20
     bf2:	9301                	srli	a4,a4,0x20
     bf4:	0705                	addi	a4,a4,1
     bf6:	972a                	add	a4,a4,a0
    cdst[i] = c;
     bf8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     bfc:	0785                	addi	a5,a5,1
     bfe:	fee79de3          	bne	a5,a4,bf8 <memset+0x16>
  }
  return dst;
}
     c02:	6422                	ld	s0,8(sp)
     c04:	0141                	addi	sp,sp,16
     c06:	8082                	ret

0000000000000c08 <strchr>:

char*
strchr(const char *s, char c)
{
     c08:	1141                	addi	sp,sp,-16
     c0a:	e422                	sd	s0,8(sp)
     c0c:	0800                	addi	s0,sp,16
  for(; *s; s++)
     c0e:	00054783          	lbu	a5,0(a0)
     c12:	cb99                	beqz	a5,c28 <strchr+0x20>
    if(*s == c)
     c14:	00f58763          	beq	a1,a5,c22 <strchr+0x1a>
  for(; *s; s++)
     c18:	0505                	addi	a0,a0,1
     c1a:	00054783          	lbu	a5,0(a0)
     c1e:	fbfd                	bnez	a5,c14 <strchr+0xc>
      return (char*)s;
  return 0;
     c20:	4501                	li	a0,0
}
     c22:	6422                	ld	s0,8(sp)
     c24:	0141                	addi	sp,sp,16
     c26:	8082                	ret
  return 0;
     c28:	4501                	li	a0,0
     c2a:	bfe5                	j	c22 <strchr+0x1a>

0000000000000c2c <gets>:

char*
gets(char *buf, int max)
{
     c2c:	711d                	addi	sp,sp,-96
     c2e:	ec86                	sd	ra,88(sp)
     c30:	e8a2                	sd	s0,80(sp)
     c32:	e4a6                	sd	s1,72(sp)
     c34:	e0ca                	sd	s2,64(sp)
     c36:	fc4e                	sd	s3,56(sp)
     c38:	f852                	sd	s4,48(sp)
     c3a:	f456                	sd	s5,40(sp)
     c3c:	f05a                	sd	s6,32(sp)
     c3e:	ec5e                	sd	s7,24(sp)
     c40:	1080                	addi	s0,sp,96
     c42:	8baa                	mv	s7,a0
     c44:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c46:	892a                	mv	s2,a0
     c48:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     c4a:	4aa9                	li	s5,10
     c4c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     c4e:	89a6                	mv	s3,s1
     c50:	2485                	addiw	s1,s1,1
     c52:	0344d863          	bge	s1,s4,c82 <gets+0x56>
    cc = read(0, &c, 1);
     c56:	4605                	li	a2,1
     c58:	faf40593          	addi	a1,s0,-81
     c5c:	4501                	li	a0,0
     c5e:	00000097          	auipc	ra,0x0
     c62:	1a0080e7          	jalr	416(ra) # dfe <read>
    if(cc < 1)
     c66:	00a05e63          	blez	a0,c82 <gets+0x56>
    buf[i++] = c;
     c6a:	faf44783          	lbu	a5,-81(s0)
     c6e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     c72:	01578763          	beq	a5,s5,c80 <gets+0x54>
     c76:	0905                	addi	s2,s2,1
     c78:	fd679be3          	bne	a5,s6,c4e <gets+0x22>
  for(i=0; i+1 < max; ){
     c7c:	89a6                	mv	s3,s1
     c7e:	a011                	j	c82 <gets+0x56>
     c80:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     c82:	99de                	add	s3,s3,s7
     c84:	00098023          	sb	zero,0(s3)
  return buf;
}
     c88:	855e                	mv	a0,s7
     c8a:	60e6                	ld	ra,88(sp)
     c8c:	6446                	ld	s0,80(sp)
     c8e:	64a6                	ld	s1,72(sp)
     c90:	6906                	ld	s2,64(sp)
     c92:	79e2                	ld	s3,56(sp)
     c94:	7a42                	ld	s4,48(sp)
     c96:	7aa2                	ld	s5,40(sp)
     c98:	7b02                	ld	s6,32(sp)
     c9a:	6be2                	ld	s7,24(sp)
     c9c:	6125                	addi	sp,sp,96
     c9e:	8082                	ret

0000000000000ca0 <stat>:

int
stat(const char *n, struct stat *st)
{
     ca0:	1101                	addi	sp,sp,-32
     ca2:	ec06                	sd	ra,24(sp)
     ca4:	e822                	sd	s0,16(sp)
     ca6:	e426                	sd	s1,8(sp)
     ca8:	e04a                	sd	s2,0(sp)
     caa:	1000                	addi	s0,sp,32
     cac:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     cae:	4581                	li	a1,0
     cb0:	00000097          	auipc	ra,0x0
     cb4:	176080e7          	jalr	374(ra) # e26 <open>
  if(fd < 0)
     cb8:	02054563          	bltz	a0,ce2 <stat+0x42>
     cbc:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     cbe:	85ca                	mv	a1,s2
     cc0:	00000097          	auipc	ra,0x0
     cc4:	17e080e7          	jalr	382(ra) # e3e <fstat>
     cc8:	892a                	mv	s2,a0
  close(fd);
     cca:	8526                	mv	a0,s1
     ccc:	00000097          	auipc	ra,0x0
     cd0:	142080e7          	jalr	322(ra) # e0e <close>
  return r;
}
     cd4:	854a                	mv	a0,s2
     cd6:	60e2                	ld	ra,24(sp)
     cd8:	6442                	ld	s0,16(sp)
     cda:	64a2                	ld	s1,8(sp)
     cdc:	6902                	ld	s2,0(sp)
     cde:	6105                	addi	sp,sp,32
     ce0:	8082                	ret
    return -1;
     ce2:	597d                	li	s2,-1
     ce4:	bfc5                	j	cd4 <stat+0x34>

0000000000000ce6 <atoi>:

int
atoi(const char *s)
{
     ce6:	1141                	addi	sp,sp,-16
     ce8:	e422                	sd	s0,8(sp)
     cea:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     cec:	00054603          	lbu	a2,0(a0)
     cf0:	fd06079b          	addiw	a5,a2,-48
     cf4:	0ff7f793          	andi	a5,a5,255
     cf8:	4725                	li	a4,9
     cfa:	02f76963          	bltu	a4,a5,d2c <atoi+0x46>
     cfe:	86aa                	mv	a3,a0
  n = 0;
     d00:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     d02:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     d04:	0685                	addi	a3,a3,1
     d06:	0025179b          	slliw	a5,a0,0x2
     d0a:	9fa9                	addw	a5,a5,a0
     d0c:	0017979b          	slliw	a5,a5,0x1
     d10:	9fb1                	addw	a5,a5,a2
     d12:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     d16:	0006c603          	lbu	a2,0(a3)
     d1a:	fd06071b          	addiw	a4,a2,-48
     d1e:	0ff77713          	andi	a4,a4,255
     d22:	fee5f1e3          	bgeu	a1,a4,d04 <atoi+0x1e>
  return n;
}
     d26:	6422                	ld	s0,8(sp)
     d28:	0141                	addi	sp,sp,16
     d2a:	8082                	ret
  n = 0;
     d2c:	4501                	li	a0,0
     d2e:	bfe5                	j	d26 <atoi+0x40>

0000000000000d30 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d30:	1141                	addi	sp,sp,-16
     d32:	e422                	sd	s0,8(sp)
     d34:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     d36:	02b57663          	bgeu	a0,a1,d62 <memmove+0x32>
    while(n-- > 0)
     d3a:	02c05163          	blez	a2,d5c <memmove+0x2c>
     d3e:	fff6079b          	addiw	a5,a2,-1
     d42:	1782                	slli	a5,a5,0x20
     d44:	9381                	srli	a5,a5,0x20
     d46:	0785                	addi	a5,a5,1
     d48:	97aa                	add	a5,a5,a0
  dst = vdst;
     d4a:	872a                	mv	a4,a0
      *dst++ = *src++;
     d4c:	0585                	addi	a1,a1,1
     d4e:	0705                	addi	a4,a4,1
     d50:	fff5c683          	lbu	a3,-1(a1)
     d54:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     d58:	fee79ae3          	bne	a5,a4,d4c <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     d5c:	6422                	ld	s0,8(sp)
     d5e:	0141                	addi	sp,sp,16
     d60:	8082                	ret
    dst += n;
     d62:	00c50733          	add	a4,a0,a2
    src += n;
     d66:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     d68:	fec05ae3          	blez	a2,d5c <memmove+0x2c>
     d6c:	fff6079b          	addiw	a5,a2,-1
     d70:	1782                	slli	a5,a5,0x20
     d72:	9381                	srli	a5,a5,0x20
     d74:	fff7c793          	not	a5,a5
     d78:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     d7a:	15fd                	addi	a1,a1,-1
     d7c:	177d                	addi	a4,a4,-1
     d7e:	0005c683          	lbu	a3,0(a1)
     d82:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     d86:	fee79ae3          	bne	a5,a4,d7a <memmove+0x4a>
     d8a:	bfc9                	j	d5c <memmove+0x2c>

0000000000000d8c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     d8c:	1141                	addi	sp,sp,-16
     d8e:	e422                	sd	s0,8(sp)
     d90:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     d92:	ca05                	beqz	a2,dc2 <memcmp+0x36>
     d94:	fff6069b          	addiw	a3,a2,-1
     d98:	1682                	slli	a3,a3,0x20
     d9a:	9281                	srli	a3,a3,0x20
     d9c:	0685                	addi	a3,a3,1
     d9e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     da0:	00054783          	lbu	a5,0(a0)
     da4:	0005c703          	lbu	a4,0(a1)
     da8:	00e79863          	bne	a5,a4,db8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     dac:	0505                	addi	a0,a0,1
    p2++;
     dae:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     db0:	fed518e3          	bne	a0,a3,da0 <memcmp+0x14>
  }
  return 0;
     db4:	4501                	li	a0,0
     db6:	a019                	j	dbc <memcmp+0x30>
      return *p1 - *p2;
     db8:	40e7853b          	subw	a0,a5,a4
}
     dbc:	6422                	ld	s0,8(sp)
     dbe:	0141                	addi	sp,sp,16
     dc0:	8082                	ret
  return 0;
     dc2:	4501                	li	a0,0
     dc4:	bfe5                	j	dbc <memcmp+0x30>

0000000000000dc6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     dc6:	1141                	addi	sp,sp,-16
     dc8:	e406                	sd	ra,8(sp)
     dca:	e022                	sd	s0,0(sp)
     dcc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     dce:	00000097          	auipc	ra,0x0
     dd2:	f62080e7          	jalr	-158(ra) # d30 <memmove>
}
     dd6:	60a2                	ld	ra,8(sp)
     dd8:	6402                	ld	s0,0(sp)
     dda:	0141                	addi	sp,sp,16
     ddc:	8082                	ret

0000000000000dde <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     dde:	4885                	li	a7,1
 ecall
     de0:	00000073          	ecall
 ret
     de4:	8082                	ret

0000000000000de6 <exit>:
.global exit
exit:
 li a7, SYS_exit
     de6:	4889                	li	a7,2
 ecall
     de8:	00000073          	ecall
 ret
     dec:	8082                	ret

0000000000000dee <wait>:
.global wait
wait:
 li a7, SYS_wait
     dee:	488d                	li	a7,3
 ecall
     df0:	00000073          	ecall
 ret
     df4:	8082                	ret

0000000000000df6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     df6:	4891                	li	a7,4
 ecall
     df8:	00000073          	ecall
 ret
     dfc:	8082                	ret

0000000000000dfe <read>:
.global read
read:
 li a7, SYS_read
     dfe:	4895                	li	a7,5
 ecall
     e00:	00000073          	ecall
 ret
     e04:	8082                	ret

0000000000000e06 <write>:
.global write
write:
 li a7, SYS_write
     e06:	48c1                	li	a7,16
 ecall
     e08:	00000073          	ecall
 ret
     e0c:	8082                	ret

0000000000000e0e <close>:
.global close
close:
 li a7, SYS_close
     e0e:	48d5                	li	a7,21
 ecall
     e10:	00000073          	ecall
 ret
     e14:	8082                	ret

0000000000000e16 <kill>:
.global kill
kill:
 li a7, SYS_kill
     e16:	4899                	li	a7,6
 ecall
     e18:	00000073          	ecall
 ret
     e1c:	8082                	ret

0000000000000e1e <exec>:
.global exec
exec:
 li a7, SYS_exec
     e1e:	489d                	li	a7,7
 ecall
     e20:	00000073          	ecall
 ret
     e24:	8082                	ret

0000000000000e26 <open>:
.global open
open:
 li a7, SYS_open
     e26:	48bd                	li	a7,15
 ecall
     e28:	00000073          	ecall
 ret
     e2c:	8082                	ret

0000000000000e2e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     e2e:	48c5                	li	a7,17
 ecall
     e30:	00000073          	ecall
 ret
     e34:	8082                	ret

0000000000000e36 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     e36:	48c9                	li	a7,18
 ecall
     e38:	00000073          	ecall
 ret
     e3c:	8082                	ret

0000000000000e3e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     e3e:	48a1                	li	a7,8
 ecall
     e40:	00000073          	ecall
 ret
     e44:	8082                	ret

0000000000000e46 <link>:
.global link
link:
 li a7, SYS_link
     e46:	48cd                	li	a7,19
 ecall
     e48:	00000073          	ecall
 ret
     e4c:	8082                	ret

0000000000000e4e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     e4e:	48d1                	li	a7,20
 ecall
     e50:	00000073          	ecall
 ret
     e54:	8082                	ret

0000000000000e56 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     e56:	48a5                	li	a7,9
 ecall
     e58:	00000073          	ecall
 ret
     e5c:	8082                	ret

0000000000000e5e <dup>:
.global dup
dup:
 li a7, SYS_dup
     e5e:	48a9                	li	a7,10
 ecall
     e60:	00000073          	ecall
 ret
     e64:	8082                	ret

0000000000000e66 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     e66:	48ad                	li	a7,11
 ecall
     e68:	00000073          	ecall
 ret
     e6c:	8082                	ret

0000000000000e6e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     e6e:	48b1                	li	a7,12
 ecall
     e70:	00000073          	ecall
 ret
     e74:	8082                	ret

0000000000000e76 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     e76:	48b5                	li	a7,13
 ecall
     e78:	00000073          	ecall
 ret
     e7c:	8082                	ret

0000000000000e7e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     e7e:	48b9                	li	a7,14
 ecall
     e80:	00000073          	ecall
 ret
     e84:	8082                	ret

0000000000000e86 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     e86:	1101                	addi	sp,sp,-32
     e88:	ec06                	sd	ra,24(sp)
     e8a:	e822                	sd	s0,16(sp)
     e8c:	1000                	addi	s0,sp,32
     e8e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
     e92:	4605                	li	a2,1
     e94:	fef40593          	addi	a1,s0,-17
     e98:	00000097          	auipc	ra,0x0
     e9c:	f6e080e7          	jalr	-146(ra) # e06 <write>
}
     ea0:	60e2                	ld	ra,24(sp)
     ea2:	6442                	ld	s0,16(sp)
     ea4:	6105                	addi	sp,sp,32
     ea6:	8082                	ret

0000000000000ea8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     ea8:	7139                	addi	sp,sp,-64
     eaa:	fc06                	sd	ra,56(sp)
     eac:	f822                	sd	s0,48(sp)
     eae:	f426                	sd	s1,40(sp)
     eb0:	f04a                	sd	s2,32(sp)
     eb2:	ec4e                	sd	s3,24(sp)
     eb4:	0080                	addi	s0,sp,64
     eb6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     eb8:	c299                	beqz	a3,ebe <printint+0x16>
     eba:	0805c863          	bltz	a1,f4a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     ebe:	2581                	sext.w	a1,a1
  neg = 0;
     ec0:	4881                	li	a7,0
     ec2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
     ec6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
     ec8:	2601                	sext.w	a2,a2
     eca:	00000517          	auipc	a0,0x0
     ece:	57e50513          	addi	a0,a0,1406 # 1448 <digits>
     ed2:	883a                	mv	a6,a4
     ed4:	2705                	addiw	a4,a4,1
     ed6:	02c5f7bb          	remuw	a5,a1,a2
     eda:	1782                	slli	a5,a5,0x20
     edc:	9381                	srli	a5,a5,0x20
     ede:	97aa                	add	a5,a5,a0
     ee0:	0007c783          	lbu	a5,0(a5)
     ee4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
     ee8:	0005879b          	sext.w	a5,a1
     eec:	02c5d5bb          	divuw	a1,a1,a2
     ef0:	0685                	addi	a3,a3,1
     ef2:	fec7f0e3          	bgeu	a5,a2,ed2 <printint+0x2a>
  if(neg)
     ef6:	00088b63          	beqz	a7,f0c <printint+0x64>
    buf[i++] = '-';
     efa:	fd040793          	addi	a5,s0,-48
     efe:	973e                	add	a4,a4,a5
     f00:	02d00793          	li	a5,45
     f04:	fef70823          	sb	a5,-16(a4)
     f08:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
     f0c:	02e05863          	blez	a4,f3c <printint+0x94>
     f10:	fc040793          	addi	a5,s0,-64
     f14:	00e78933          	add	s2,a5,a4
     f18:	fff78993          	addi	s3,a5,-1
     f1c:	99ba                	add	s3,s3,a4
     f1e:	377d                	addiw	a4,a4,-1
     f20:	1702                	slli	a4,a4,0x20
     f22:	9301                	srli	a4,a4,0x20
     f24:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
     f28:	fff94583          	lbu	a1,-1(s2)
     f2c:	8526                	mv	a0,s1
     f2e:	00000097          	auipc	ra,0x0
     f32:	f58080e7          	jalr	-168(ra) # e86 <putc>
  while(--i >= 0)
     f36:	197d                	addi	s2,s2,-1
     f38:	ff3918e3          	bne	s2,s3,f28 <printint+0x80>
}
     f3c:	70e2                	ld	ra,56(sp)
     f3e:	7442                	ld	s0,48(sp)
     f40:	74a2                	ld	s1,40(sp)
     f42:	7902                	ld	s2,32(sp)
     f44:	69e2                	ld	s3,24(sp)
     f46:	6121                	addi	sp,sp,64
     f48:	8082                	ret
    x = -xx;
     f4a:	40b005bb          	negw	a1,a1
    neg = 1;
     f4e:	4885                	li	a7,1
    x = -xx;
     f50:	bf8d                	j	ec2 <printint+0x1a>

0000000000000f52 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     f52:	7119                	addi	sp,sp,-128
     f54:	fc86                	sd	ra,120(sp)
     f56:	f8a2                	sd	s0,112(sp)
     f58:	f4a6                	sd	s1,104(sp)
     f5a:	f0ca                	sd	s2,96(sp)
     f5c:	ecce                	sd	s3,88(sp)
     f5e:	e8d2                	sd	s4,80(sp)
     f60:	e4d6                	sd	s5,72(sp)
     f62:	e0da                	sd	s6,64(sp)
     f64:	fc5e                	sd	s7,56(sp)
     f66:	f862                	sd	s8,48(sp)
     f68:	f466                	sd	s9,40(sp)
     f6a:	f06a                	sd	s10,32(sp)
     f6c:	ec6e                	sd	s11,24(sp)
     f6e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
     f70:	0005c903          	lbu	s2,0(a1)
     f74:	18090f63          	beqz	s2,1112 <vprintf+0x1c0>
     f78:	8aaa                	mv	s5,a0
     f7a:	8b32                	mv	s6,a2
     f7c:	00158493          	addi	s1,a1,1
  state = 0;
     f80:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     f82:	02500a13          	li	s4,37
      if(c == 'd'){
     f86:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
     f8a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
     f8e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
     f92:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     f96:	00000b97          	auipc	s7,0x0
     f9a:	4b2b8b93          	addi	s7,s7,1202 # 1448 <digits>
     f9e:	a839                	j	fbc <vprintf+0x6a>
        putc(fd, c);
     fa0:	85ca                	mv	a1,s2
     fa2:	8556                	mv	a0,s5
     fa4:	00000097          	auipc	ra,0x0
     fa8:	ee2080e7          	jalr	-286(ra) # e86 <putc>
     fac:	a019                	j	fb2 <vprintf+0x60>
    } else if(state == '%'){
     fae:	01498f63          	beq	s3,s4,fcc <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
     fb2:	0485                	addi	s1,s1,1
     fb4:	fff4c903          	lbu	s2,-1(s1)
     fb8:	14090d63          	beqz	s2,1112 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
     fbc:	0009079b          	sext.w	a5,s2
    if(state == 0){
     fc0:	fe0997e3          	bnez	s3,fae <vprintf+0x5c>
      if(c == '%'){
     fc4:	fd479ee3          	bne	a5,s4,fa0 <vprintf+0x4e>
        state = '%';
     fc8:	89be                	mv	s3,a5
     fca:	b7e5                	j	fb2 <vprintf+0x60>
      if(c == 'd'){
     fcc:	05878063          	beq	a5,s8,100c <vprintf+0xba>
      } else if(c == 'l') {
     fd0:	05978c63          	beq	a5,s9,1028 <vprintf+0xd6>
      } else if(c == 'x') {
     fd4:	07a78863          	beq	a5,s10,1044 <vprintf+0xf2>
      } else if(c == 'p') {
     fd8:	09b78463          	beq	a5,s11,1060 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
     fdc:	07300713          	li	a4,115
     fe0:	0ce78663          	beq	a5,a4,10ac <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     fe4:	06300713          	li	a4,99
     fe8:	0ee78e63          	beq	a5,a4,10e4 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
     fec:	11478863          	beq	a5,s4,10fc <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     ff0:	85d2                	mv	a1,s4
     ff2:	8556                	mv	a0,s5
     ff4:	00000097          	auipc	ra,0x0
     ff8:	e92080e7          	jalr	-366(ra) # e86 <putc>
        putc(fd, c);
     ffc:	85ca                	mv	a1,s2
     ffe:	8556                	mv	a0,s5
    1000:	00000097          	auipc	ra,0x0
    1004:	e86080e7          	jalr	-378(ra) # e86 <putc>
      }
      state = 0;
    1008:	4981                	li	s3,0
    100a:	b765                	j	fb2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    100c:	008b0913          	addi	s2,s6,8
    1010:	4685                	li	a3,1
    1012:	4629                	li	a2,10
    1014:	000b2583          	lw	a1,0(s6)
    1018:	8556                	mv	a0,s5
    101a:	00000097          	auipc	ra,0x0
    101e:	e8e080e7          	jalr	-370(ra) # ea8 <printint>
    1022:	8b4a                	mv	s6,s2
      state = 0;
    1024:	4981                	li	s3,0
    1026:	b771                	j	fb2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1028:	008b0913          	addi	s2,s6,8
    102c:	4681                	li	a3,0
    102e:	4629                	li	a2,10
    1030:	000b2583          	lw	a1,0(s6)
    1034:	8556                	mv	a0,s5
    1036:	00000097          	auipc	ra,0x0
    103a:	e72080e7          	jalr	-398(ra) # ea8 <printint>
    103e:	8b4a                	mv	s6,s2
      state = 0;
    1040:	4981                	li	s3,0
    1042:	bf85                	j	fb2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1044:	008b0913          	addi	s2,s6,8
    1048:	4681                	li	a3,0
    104a:	4641                	li	a2,16
    104c:	000b2583          	lw	a1,0(s6)
    1050:	8556                	mv	a0,s5
    1052:	00000097          	auipc	ra,0x0
    1056:	e56080e7          	jalr	-426(ra) # ea8 <printint>
    105a:	8b4a                	mv	s6,s2
      state = 0;
    105c:	4981                	li	s3,0
    105e:	bf91                	j	fb2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    1060:	008b0793          	addi	a5,s6,8
    1064:	f8f43423          	sd	a5,-120(s0)
    1068:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    106c:	03000593          	li	a1,48
    1070:	8556                	mv	a0,s5
    1072:	00000097          	auipc	ra,0x0
    1076:	e14080e7          	jalr	-492(ra) # e86 <putc>
  putc(fd, 'x');
    107a:	85ea                	mv	a1,s10
    107c:	8556                	mv	a0,s5
    107e:	00000097          	auipc	ra,0x0
    1082:	e08080e7          	jalr	-504(ra) # e86 <putc>
    1086:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1088:	03c9d793          	srli	a5,s3,0x3c
    108c:	97de                	add	a5,a5,s7
    108e:	0007c583          	lbu	a1,0(a5)
    1092:	8556                	mv	a0,s5
    1094:	00000097          	auipc	ra,0x0
    1098:	df2080e7          	jalr	-526(ra) # e86 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    109c:	0992                	slli	s3,s3,0x4
    109e:	397d                	addiw	s2,s2,-1
    10a0:	fe0914e3          	bnez	s2,1088 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    10a4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    10a8:	4981                	li	s3,0
    10aa:	b721                	j	fb2 <vprintf+0x60>
        s = va_arg(ap, char*);
    10ac:	008b0993          	addi	s3,s6,8
    10b0:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    10b4:	02090163          	beqz	s2,10d6 <vprintf+0x184>
        while(*s != 0){
    10b8:	00094583          	lbu	a1,0(s2)
    10bc:	c9a1                	beqz	a1,110c <vprintf+0x1ba>
          putc(fd, *s);
    10be:	8556                	mv	a0,s5
    10c0:	00000097          	auipc	ra,0x0
    10c4:	dc6080e7          	jalr	-570(ra) # e86 <putc>
          s++;
    10c8:	0905                	addi	s2,s2,1
        while(*s != 0){
    10ca:	00094583          	lbu	a1,0(s2)
    10ce:	f9e5                	bnez	a1,10be <vprintf+0x16c>
        s = va_arg(ap, char*);
    10d0:	8b4e                	mv	s6,s3
      state = 0;
    10d2:	4981                	li	s3,0
    10d4:	bdf9                	j	fb2 <vprintf+0x60>
          s = "(null)";
    10d6:	00000917          	auipc	s2,0x0
    10da:	36a90913          	addi	s2,s2,874 # 1440 <malloc+0x224>
        while(*s != 0){
    10de:	02800593          	li	a1,40
    10e2:	bff1                	j	10be <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    10e4:	008b0913          	addi	s2,s6,8
    10e8:	000b4583          	lbu	a1,0(s6)
    10ec:	8556                	mv	a0,s5
    10ee:	00000097          	auipc	ra,0x0
    10f2:	d98080e7          	jalr	-616(ra) # e86 <putc>
    10f6:	8b4a                	mv	s6,s2
      state = 0;
    10f8:	4981                	li	s3,0
    10fa:	bd65                	j	fb2 <vprintf+0x60>
        putc(fd, c);
    10fc:	85d2                	mv	a1,s4
    10fe:	8556                	mv	a0,s5
    1100:	00000097          	auipc	ra,0x0
    1104:	d86080e7          	jalr	-634(ra) # e86 <putc>
      state = 0;
    1108:	4981                	li	s3,0
    110a:	b565                	j	fb2 <vprintf+0x60>
        s = va_arg(ap, char*);
    110c:	8b4e                	mv	s6,s3
      state = 0;
    110e:	4981                	li	s3,0
    1110:	b54d                	j	fb2 <vprintf+0x60>
    }
  }
}
    1112:	70e6                	ld	ra,120(sp)
    1114:	7446                	ld	s0,112(sp)
    1116:	74a6                	ld	s1,104(sp)
    1118:	7906                	ld	s2,96(sp)
    111a:	69e6                	ld	s3,88(sp)
    111c:	6a46                	ld	s4,80(sp)
    111e:	6aa6                	ld	s5,72(sp)
    1120:	6b06                	ld	s6,64(sp)
    1122:	7be2                	ld	s7,56(sp)
    1124:	7c42                	ld	s8,48(sp)
    1126:	7ca2                	ld	s9,40(sp)
    1128:	7d02                	ld	s10,32(sp)
    112a:	6de2                	ld	s11,24(sp)
    112c:	6109                	addi	sp,sp,128
    112e:	8082                	ret

0000000000001130 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    1130:	715d                	addi	sp,sp,-80
    1132:	ec06                	sd	ra,24(sp)
    1134:	e822                	sd	s0,16(sp)
    1136:	1000                	addi	s0,sp,32
    1138:	e010                	sd	a2,0(s0)
    113a:	e414                	sd	a3,8(s0)
    113c:	e818                	sd	a4,16(s0)
    113e:	ec1c                	sd	a5,24(s0)
    1140:	03043023          	sd	a6,32(s0)
    1144:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1148:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    114c:	8622                	mv	a2,s0
    114e:	00000097          	auipc	ra,0x0
    1152:	e04080e7          	jalr	-508(ra) # f52 <vprintf>
}
    1156:	60e2                	ld	ra,24(sp)
    1158:	6442                	ld	s0,16(sp)
    115a:	6161                	addi	sp,sp,80
    115c:	8082                	ret

000000000000115e <printf>:

void
printf(const char *fmt, ...)
{
    115e:	711d                	addi	sp,sp,-96
    1160:	ec06                	sd	ra,24(sp)
    1162:	e822                	sd	s0,16(sp)
    1164:	1000                	addi	s0,sp,32
    1166:	e40c                	sd	a1,8(s0)
    1168:	e810                	sd	a2,16(s0)
    116a:	ec14                	sd	a3,24(s0)
    116c:	f018                	sd	a4,32(s0)
    116e:	f41c                	sd	a5,40(s0)
    1170:	03043823          	sd	a6,48(s0)
    1174:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1178:	00840613          	addi	a2,s0,8
    117c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    1180:	85aa                	mv	a1,a0
    1182:	4505                	li	a0,1
    1184:	00000097          	auipc	ra,0x0
    1188:	dce080e7          	jalr	-562(ra) # f52 <vprintf>
}
    118c:	60e2                	ld	ra,24(sp)
    118e:	6442                	ld	s0,16(sp)
    1190:	6125                	addi	sp,sp,96
    1192:	8082                	ret

0000000000001194 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1194:	1141                	addi	sp,sp,-16
    1196:	e422                	sd	s0,8(sp)
    1198:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    119a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    119e:	00001797          	auipc	a5,0x1
    11a2:	e727b783          	ld	a5,-398(a5) # 2010 <freep>
    11a6:	a805                	j	11d6 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    11a8:	4618                	lw	a4,8(a2)
    11aa:	9db9                	addw	a1,a1,a4
    11ac:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    11b0:	6398                	ld	a4,0(a5)
    11b2:	6318                	ld	a4,0(a4)
    11b4:	fee53823          	sd	a4,-16(a0)
    11b8:	a091                	j	11fc <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    11ba:	ff852703          	lw	a4,-8(a0)
    11be:	9e39                	addw	a2,a2,a4
    11c0:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    11c2:	ff053703          	ld	a4,-16(a0)
    11c6:	e398                	sd	a4,0(a5)
    11c8:	a099                	j	120e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11ca:	6398                	ld	a4,0(a5)
    11cc:	00e7e463          	bltu	a5,a4,11d4 <free+0x40>
    11d0:	00e6ea63          	bltu	a3,a4,11e4 <free+0x50>
{
    11d4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11d6:	fed7fae3          	bgeu	a5,a3,11ca <free+0x36>
    11da:	6398                	ld	a4,0(a5)
    11dc:	00e6e463          	bltu	a3,a4,11e4 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11e0:	fee7eae3          	bltu	a5,a4,11d4 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    11e4:	ff852583          	lw	a1,-8(a0)
    11e8:	6390                	ld	a2,0(a5)
    11ea:	02059713          	slli	a4,a1,0x20
    11ee:	9301                	srli	a4,a4,0x20
    11f0:	0712                	slli	a4,a4,0x4
    11f2:	9736                	add	a4,a4,a3
    11f4:	fae60ae3          	beq	a2,a4,11a8 <free+0x14>
    bp->s.ptr = p->s.ptr;
    11f8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    11fc:	4790                	lw	a2,8(a5)
    11fe:	02061713          	slli	a4,a2,0x20
    1202:	9301                	srli	a4,a4,0x20
    1204:	0712                	slli	a4,a4,0x4
    1206:	973e                	add	a4,a4,a5
    1208:	fae689e3          	beq	a3,a4,11ba <free+0x26>
  } else
    p->s.ptr = bp;
    120c:	e394                	sd	a3,0(a5)
  freep = p;
    120e:	00001717          	auipc	a4,0x1
    1212:	e0f73123          	sd	a5,-510(a4) # 2010 <freep>
}
    1216:	6422                	ld	s0,8(sp)
    1218:	0141                	addi	sp,sp,16
    121a:	8082                	ret

000000000000121c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    121c:	7139                	addi	sp,sp,-64
    121e:	fc06                	sd	ra,56(sp)
    1220:	f822                	sd	s0,48(sp)
    1222:	f426                	sd	s1,40(sp)
    1224:	f04a                	sd	s2,32(sp)
    1226:	ec4e                	sd	s3,24(sp)
    1228:	e852                	sd	s4,16(sp)
    122a:	e456                	sd	s5,8(sp)
    122c:	e05a                	sd	s6,0(sp)
    122e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1230:	02051493          	slli	s1,a0,0x20
    1234:	9081                	srli	s1,s1,0x20
    1236:	04bd                	addi	s1,s1,15
    1238:	8091                	srli	s1,s1,0x4
    123a:	0014899b          	addiw	s3,s1,1
    123e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    1240:	00001517          	auipc	a0,0x1
    1244:	dd053503          	ld	a0,-560(a0) # 2010 <freep>
    1248:	c515                	beqz	a0,1274 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    124a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    124c:	4798                	lw	a4,8(a5)
    124e:	02977f63          	bgeu	a4,s1,128c <malloc+0x70>
    1252:	8a4e                	mv	s4,s3
    1254:	0009871b          	sext.w	a4,s3
    1258:	6685                	lui	a3,0x1
    125a:	00d77363          	bgeu	a4,a3,1260 <malloc+0x44>
    125e:	6a05                	lui	s4,0x1
    1260:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1264:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1268:	00001917          	auipc	s2,0x1
    126c:	da890913          	addi	s2,s2,-600 # 2010 <freep>
  if(p == (char*)-1)
    1270:	5afd                	li	s5,-1
    1272:	a88d                	j	12e4 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    1274:	00001797          	auipc	a5,0x1
    1278:	e1478793          	addi	a5,a5,-492 # 2088 <base>
    127c:	00001717          	auipc	a4,0x1
    1280:	d8f73a23          	sd	a5,-620(a4) # 2010 <freep>
    1284:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1286:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    128a:	b7e1                	j	1252 <malloc+0x36>
      if(p->s.size == nunits)
    128c:	02e48b63          	beq	s1,a4,12c2 <malloc+0xa6>
        p->s.size -= nunits;
    1290:	4137073b          	subw	a4,a4,s3
    1294:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1296:	1702                	slli	a4,a4,0x20
    1298:	9301                	srli	a4,a4,0x20
    129a:	0712                	slli	a4,a4,0x4
    129c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    129e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    12a2:	00001717          	auipc	a4,0x1
    12a6:	d6a73723          	sd	a0,-658(a4) # 2010 <freep>
      return (void*)(p + 1);
    12aa:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    12ae:	70e2                	ld	ra,56(sp)
    12b0:	7442                	ld	s0,48(sp)
    12b2:	74a2                	ld	s1,40(sp)
    12b4:	7902                	ld	s2,32(sp)
    12b6:	69e2                	ld	s3,24(sp)
    12b8:	6a42                	ld	s4,16(sp)
    12ba:	6aa2                	ld	s5,8(sp)
    12bc:	6b02                	ld	s6,0(sp)
    12be:	6121                	addi	sp,sp,64
    12c0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    12c2:	6398                	ld	a4,0(a5)
    12c4:	e118                	sd	a4,0(a0)
    12c6:	bff1                	j	12a2 <malloc+0x86>
  hp->s.size = nu;
    12c8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    12cc:	0541                	addi	a0,a0,16
    12ce:	00000097          	auipc	ra,0x0
    12d2:	ec6080e7          	jalr	-314(ra) # 1194 <free>
  return freep;
    12d6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    12da:	d971                	beqz	a0,12ae <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    12dc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    12de:	4798                	lw	a4,8(a5)
    12e0:	fa9776e3          	bgeu	a4,s1,128c <malloc+0x70>
    if(p == freep)
    12e4:	00093703          	ld	a4,0(s2)
    12e8:	853e                	mv	a0,a5
    12ea:	fef719e3          	bne	a4,a5,12dc <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    12ee:	8552                	mv	a0,s4
    12f0:	00000097          	auipc	ra,0x0
    12f4:	b7e080e7          	jalr	-1154(ra) # e6e <sbrk>
  if(p == (char*)-1)
    12f8:	fd5518e3          	bne	a0,s5,12c8 <malloc+0xac>
        return 0;
    12fc:	4501                	li	a0,0
    12fe:	bf45                	j	12ae <malloc+0x92>
