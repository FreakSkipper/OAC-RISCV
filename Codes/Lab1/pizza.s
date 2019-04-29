.include "macros2.s"

.data
	N: 			.word 	0
	C:			.space 	160		# 20 casas ( 40 words)
	D:			.space 	1600	# 20 casas para cada casa ( 400 words )
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
	
	blt t0, a0, MAIN_CASE	# if( N > 20 )
	la t0, N
	sw a0, 0(t0)			# salvando a0 (valor lido) em N
	la a1, C 				# vetor de casas

	jal ra, GERAR_COORD

	la a0, N
	la a1, C
	jal ra, DESENHAR_CASA
	
	la a0, N
	la a1, C
	jal ra, DESENHAR_LINHAS
	
	la a0, N
	la a1, C
	la a2, D
	jal ra, CALCULAR_DISTANCIA
	
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
		addi t1, t1, 8	# proximas 2 word ( 2 coord )
		
		bne t0, zero, FOR1_DESENHAR_CASA
	ret
##############################

### void desenhar_linhas(int quantidade_casas, int vetor_casas[], vetor distancias)
# a0 -> N
# a1 -> C
# a2 -> D
DESENHAR_LINHAS: nop
	lw a0, 0(a0)		# carregando valor de N
	addi t0, a0, -1		# contador i, quantidade
	add t1, a1, zero	# vetor posicao
	addi t2, t1, 8		# j = i+1 ( nao pega o objeto atual )
	
FOR1_DESENHAR_LINHAS: nop
		lw a0, 0(t1)	# endereco X da casa atual
		lw a1, 4(t1)	# endereco Y da casa atual
		add t3, t0, zero# contador = i
	FOR2_DESENHAR_LINHAS: nop
			lw a2, 0(t2)	# endereco X da casa vizinha
			lw a3, 4(t2)	# endereco Y da casa vizinha
			
			li a4, 255		# cor branca
			li a7, 47		# ecall desenhar linha entre dois pontos
			mv t4, a0
			M_Ecall
			
			mv a0, t4
			addi t2, t2, 8		# ligar a proxima casa
			
			addi t3, t3, -1		# contador--
			bne t3, zero, FOR2_DESENHAR_LINHAS
		addi t1, t1, 8	# proxima casa
		addi t2, t1, 8	# proxima casa a partir da atual
		addi t0, t0, -1	# i--
		bne t0, zero, FOR1_DESENHAR_LINHAS
	
	ret
######################

### void calcular_distancia(int *quantidade_casas, int vetor_casas[], float vetor_distancias[])
# a0 -> N
# a1 -> C
# a2 -> D
CALCULAR_DISTANCIA: nop
	lw t0, 0(a0)
	add t1, zero, zero	# i = 0
	addi sp, sp, -8
	sw a2, 0(sp)
	sw a1, 4(sp)
	
FOR1_CALCULAR_DISTANCIA: nop
		lw t2, 4(sp)
		lw t3, 0(t2)	# ci(x)
		lw t4, 4(t2)	# ci(y)
		
		add t2, a1, zero# inicio do vetor
		li t0, 0		# j = 0
		FOR2_CALCULAR_DISTANCIA: nop
			lw t5, 0(t2)	# cj(x)
			lw t6, 4(t2)	# cj(y)
			
			sub t5, t3, t5	# ci(x) - cj(x)
			sub t6, t4, t6	# ci(y) - cj(y)
			
			mul t5, t5, t5	# ( ci(x) - cj(x) )²
			mul t6, t6, t6	# ( ci(y) - cj(y) )²
			
			add t5, t5, t6	# ( ci(x) - cj(x) )² + ( ci(y) - cj(y) )²
			
			fcvt.s.w f5, t5	# IntToFloat
			fsqrt.s f5, f5	# raiz quadrada ( f3 )
			
			lw t5, 0(sp)
			fsw f5, 0(t5)	# salvando no vetor
			addi t5, t5, 4
			sw t5, 0(sp)
			
			addi t2, t2, 8	# proxima casa ( 2 words )
			addi t0, t0, 1	# j++
			lw t5, 0(a0)	# t3 = N
			bne t0, t5, FOR2_CALCULAR_DISTANCIA
		
		lw t2, 4(sp)
		addi t2, t2, 8
		sw t2, 4(sp)
		
		addi t1, t1, 1	# i++
		lw t5, 0(a0)	# t3 = N
		bne t1, t5, FOR1_CALCULAR_DISTANCIA
		
		addi sp, sp, 8
	ret
			

#####################

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
