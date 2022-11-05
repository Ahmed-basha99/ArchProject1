.globl main

main:	
	lui t1, 12 # 49152 stored in t1
	auipc t1, 1 # pc(4) + 1 << 12 -> t1 = 4+4096 = 4100
	beq x0, x0, branch # jump back to branch, new_pc = 12
branch:
	bne x0, x0, branch # fails to jump, pc+4
	blt x0, t1, t1greater # 0 < 4100 --> jumps
t1greater:
	bge x0, t1, t1greater # fails to jump, pc+4
	bltu x0, x0 t1greater # fails to jump, pc+4
	bgeu x0, x0, donewithbranches # jumps, pc + 8
	nop
donewithbranches:
	addi t1, x0, -1  # t1 = 0 + (-1) t1 = 0
	addi s0, x0, 1024 # s0 = 0 + 1024 = 1024
	sb t1, 0(s0)  #store 0xFF
	sh t1, 4(s0)  #store 0xFFFF
	sw t1, 8(s0)  #store 0xFFFF FFFF
	lw t1, 8(s0)  #loads -1
	lh t1, 4(s0)  #loads -1
	lb t1, 0(s0)  #loads -1
	lhu t1, 4(s0) # loads 65535
	lbu t1, 0(s0) # loads 511
	addi t2, x0, -1 #t2 = 1
	slti s0, t2, 100 # sets s0 = 1, as t2 has 1 which < 100
	sltiu s0, t2, 100 # doesnt change s0, as -1 unsigned becomes way larger than 100
	xori t1, x0, 1  # t1 becomes 1 as 0^1 = 1
	
	