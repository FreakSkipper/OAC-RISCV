.data
V: .word 100,90,80,70,60,50,40,30,10,9,8,7,6,5,4,3,2,1,0
N: .word 19
.text
MAIN: la a0, V
	la a1, N
	lw a1, 0(a1)
	
	jal SORT
	
	la a0, V
	la a1, N
	lw a1, 0(a1)
	
	jal PRINT
	
	li a7, 10
	ecall
	
SWAP: slli a1, a1, 2
	add a0, a0, a1
	flw ft0, 0(a0)
	flw ft1, 4(a0)
	fsw ft0, 4(a0)
	fsw ft1, 0(a0)
	ret
	
SORT: addi sp, sp, -12
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	
	addi s1, a1, -1			# N - 1
	
SORT_WHILE: addi t0, zero, 0
	addi t1, zero,0
	SORT_FOR: slli t2, t1, 2
		add t2, t2, a0
		flw ft0, 0(t2)			# ft0 = v[i]
		flw ft1, 4(t2)			# ft1 = v[i+1]
		
		flt.s t2, ft1, ft0
		bne t2, zero, SORT_SWAP
	SORT_FOR_FIM: addi t1, t1, 1
		blt t1, s1, SORT_FOR
	bne t0, zero, SORT_WHILE
	
	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	addi sp, sp, 12
	ret
		
SORT_SWAP: add a1, zero, t1
	jal ra, SWAP
	addi t0, zero, 1
	j SORT_FOR_FIM


####################  PRINT (20 # + 2 espaacos + <nome>)
## Printa vetor int 		(## + <breve descricao>)
# a0 -> end. vetor int		(# + argumentos)
# a1 -> tam. vetor
PRINT: nop		
	addi a7, zero, 2			# print float
	addi sp, sp, -4
	sw s0, 0(sp)
	
	add s0, zero, a0
	add t0, zero, zero
			
PRINT_LOOP: nop
	beq t0, a1, PRINT_EXIT		# t0 = i
	slli t2, t0, 2				# t2 anda t0 words
	add t2, t2, s0
	flw fa0, 0(t2)					# a0 = v[i] (t2)
	ecall
			
	addi a0, zero, ' '
	addi a7, zero, 11
	ecall
		
	addi t0, t0, 1
	addi a7, zero, 2
	jal zero, PRINT_LOOP

PRINT_EXIT: nop
	add a0, zero, s0
	
	lw s0, 0(sp)
	addi sp, sp, 4
	jalr zero, ra, 0
