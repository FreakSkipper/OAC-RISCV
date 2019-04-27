.include "macros2.s"

.data
	N: 			.word 	0
	C:			.space 	160		# 20 casas (words)
	pergunta: 	.string "Insira N:\n"
	case1: 		.string "Reinsira N (N <= 20):\n"

.text
	M_SetEcall(exceptionHandling)
#################### MAIN
MAIN: li a7, 4			# printar pergunta
	la a0, pergunta
	ecall
	
	li t0, 20			# valor limite de N

MAIN_LOOP: li a7, 5			# ler int
	ecall					# a0 = N
	
	blt t0, a0, MAIN_CASE	# t0 (20) < N
	la t0, N
	sw a0, 0(t0)			# salvando a0 (valor lido) em N
	la a1, C 				# vetor de casas

	jal ra, GERAR_COORD

	la a0, N
	la a1, C
	jal ra, DESENHAR_CASA
	
	j MAIN_EXIT

MAIN_CASE: li a7, 4
	la a0, case1
	ecall
	
	j MAIN_LOOP

MAIN_EXIT: li a7, 10
	ecall
##############################

#################### void desenhar_casa(int quantidade_casas, int vetor_casas[])
# a0 -> N
# a1 -> C
DESENHAR_CASA: nop
	lw a0, 0(a0)		# carregando valor de N
	add t0, a0, zero	# contador
	add t1, a1, zero	# vetor
	
FOR1_DESENHAR_CASA: nop
		addi a0, t0, 64	# pega letra no alfabeto
		lw a1, 0(t1)	# posicao X
		lw a2, 4(t1)	# posicao Y
		li a3, 0x3800   # BB GGG RRR
		li a4, 0		# frame 0
		li a7, 111		# print char
		M_Ecall			# printa
		
		addi t0, t0, -1	# Contador--
		addi t1, t1, 8	# proximo word
		
		bne t0, zero, FOR1_DESENHAR_CASA
	ret
##############################

#################### void gerar_coord (int N, int C[])
# a0 -> N (qtd de casas)
# a1 -> C (end. do vetor onde serao armazenados os coord)
GERAR_COORD: li t0, 310		# ncol
	li t1, 230				# nlin
	li t2, 0				# contador
	
	addi sp, sp, -8			# salvando na pilha...
	sw s0, 0(sp)
	sw s1, 4(sp)
	
	mv s0, a0
	mv s1, a1
	
GERAR_COORD_LOOP: bge t2, s0, GERAR_COORD_EXIT		# t2 (cont) >= s0 (qtd) 
	li a7, 41				# rand
	ecall
	mv t3, a0				# t3 = valor aleatorio
	remu t4, t3, t0			# t4 = t0 mod t3
	sw t4, 0(s1)			# coord X (ncol)

	li a7, 41				# rand
	ecall
	mv t3, a0				# t3 = valor aleatorio
	remu t4, t3, t1			# t4 = t1 mod t3
	sw t4, 4(s1)			# coord Y (nlin)
	
	addi s1, s1, 8			# andando 8 bytes no vetor
	addi t2, t2, 1			# contador  ++

	j GERAR_COORD_LOOP

GERAR_COORD_EXIT: lw s0, 0(sp)		# recuperando da pilha..
	lw s1, 4(sp)
	addi sp, sp, 8
	
	ret
###############################

.include "SYSTEMv13.s"