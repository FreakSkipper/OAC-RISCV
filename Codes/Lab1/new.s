.data
	N: 			.word 	0
	C:			.space 	160		# 20 casas ( 40 words)
	D:			.space 	1600	# 20 casas para cada casa ( 400 words )

.text


#################### void ordena (int *N, int *C, int *D)
## ordenar as linhas de D, ordenar C.
# a0 -> end. N
# a1 -> end. C (casas x,y)
# a2 -> end. D (matriz com as distancias de uma casa para a outra)
ORDENA: mv tp, sp
	addi sp, sp, -20
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)
	
	# mv t1, sp
	# slli t0, a0, 2		# indice para cada casa N * 4
	# sub sp, sp, t0		# aumentando pilha
	
	# jal ORDENA_IND

	lw s0, 0(a0)		# N
	mv s1, a1			# end. C
	mv s3, a2			# end. D
	li t0, 0
	li t1, 0			# i
	li t2, 0			# j

	j ORDENA_LOOP

ORDENA_IND: sw t0, 0(t1)	# armazenando indices
	addi t0, t0, 1
	addi t1, t1, 4
	blt t0, a0, ORDENA_IND	# t0 (cont) < a0 (N) ? loop : ret
	ret

ORDENA_LOOP1: bge t1, s0, ORDENA_EXIT    		# t1 (i) >= s0 (N) ? stop : continue
	ORDENA_LOOP2: bge t2, s0, ORDENA_CASE1		# t2 (j) >= s0 (N) ? stop : continue
		addi t3, t2, -1					# k	
		blt t3, zero, ORDENA_CASE2
		
		slli t4, t1, 2					# calculando avanço de linhas
		mul t4, t4, s0					# t4 = i * N (qtd de casas)
		add t4, t4, s3					# andando t4 (i*4*N) linhas em s3 (D)
		addi sp, sp, -4					# guardando valor de t4 na pilha
		sw t4, 0(sp)
			ORDENA_LOOP3: beq t3, zero, ORDENA_CASE3
				slli t5, t3, 2			# andar colunas t5 = k * 4 (word)
				lw t4, 0(sp)			# recuperando valor de t4
				add t4, t4, t5			# andando t4 + (k*4) colunas em s3 (D)

				addi t3, t3, -1

				flw ft5, 0(t4)			# pegando valor de D[i][k]
				flw ft6, 4(t4)			# pegando valor de D[i][k+1]
				flt.s t0, ft6, ft5		# D[i][k+1] < D[i][k] ? t0 = 1 : 0	
				beq t0, zero, ORDENA_LOOP3
				fsw ft6, 0(t4)			# swap
				fsw ft5, 4(t4)
				j ORDENA_LOOP3

ORDENA_CASE3: addi sp, sp, 4
	j ORDENA_LOOP2

ORDENA_CASE2: addi t2, t2, 1
	j ORDENA_LOOP2

ORDENA_CASE1: addi t1, t1, 1
	li t2, 0
	j ORDENA_LOOP1

ORDENA_EXIT: slli t0, a0, 2		# diminuindo pilha dos indices
	add sp, sp, t0

	lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	lw s3, 16(sp)

	addi sp, sp, 20

	ret

#################### void caminho (int *N, int *C, int *D)
## desenhar menor caminho, ordenar C.
# a0 -> N int
# a1 -> C int (casas x,y)
# a2 -> D float (matriz com as distancias de uma casa para a outra)
# a3 -> linha matriz
# a4 -> ponteiro stack
CAMINHO: addi sp, sp, -24
	sw ra, 0(sp)
	sw s0, 4(sp)
	sw s1, 8(sp)
	sw s2, 12(sp)
	sw s3, 16(sp)
	sw s4, 20(sp)

	mv s0, a0
	mv s1, a1
	mv s2, a2
	mv s3, a3
	mv s4, a4

	li t0, 0			# flag
	li t1, 0			# contador (i)
	li t2, 0			# contador (j)

CAMINHO_LOOP: bge t0, s0, CAMINHO_EXIT
	slli t3, t1, 2		# i * 4
	mul t3, t3, s0		# i * 4 * N
	add t3, t3, s2		# D[i][]
	CAMINHO_LOOP2: bge t1, s1, CAMINHO_CASE
		slli t4, t2, 2
		add t4, t4, t3	# t4 = D[i][j]

		flw ft0, 0(t4)
		li t4, 0
		fcvt.s.w ft1, t4
		feq.s t4, ft0, ft1
		beq t4, zero, CAMINHO_LOOP_CASE

CAMINHO_CASE: addi t0, t0, 1
	li t1, 0
	j CAMINHO_LOOP

CAMINHO_ACHOU:


CAMINHO_EXIT: lw ra, 0(sp)
	lw s0, 4(sp)
	lw s1, 8(sp)
	lw s2, 12(sp)
	lw s3, 16(sp)
	lw s4, 20(sp)

	addi sp, sp, 24

	ret