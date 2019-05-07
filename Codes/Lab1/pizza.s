.include "macros2.s"

.data
	N: 					.word 	0
	C:					.space 	160		# 20 casas ( 40 words)
	C_copy:				.space 	160		# ""
	D:					.space 	1600	# 20 casas para cada casa ( 400 words )
	pergunta: 			.string "Insira N:\n"
	msg_vetor:			.string "Vetor C ordenado:\n"
	msg_matriz: 		.string "Matriz de distancias ordenada:\n"
	case1: 				.string "Reinsira N (N <= 20):\n"

.text
	M_SetEcall(exceptionHandling)
#################### MAIN
MAIN: li a7, 4			# printar pergunta
	la a0, pergunta
	ecall
	
	li t0, 20			# valor limite de N

MAIN_LOOP: li a7, 5			# ler int
	ecall					# a0 = N
	
	blt t0, a0, MAIN_CASE	# if ( 20 < N )
	bge zero, a0, MAIN_CASE	# if ( 0 >= N )
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

	# la a0, N
	# la a1, C
	# jal ra, PRINTAR_VETOR

	# la a0, N
	# la a1, C_copy
	# jal ra, PRINTAR_VETOR
	
	la a0, N
	la a1, C
	la a2, D
	jal ra, CALCULAR_DISTANCIA
	
	la a0, N
	la a1, C
	la a2, D
	jal ra, MENOR_CAMINHO

	li a7, 11
	li a0, '\n'
	ecall
	
	li a7, 4			# printar msg
	la a0, msg_matriz
	ecall
	la a0, N
	la a1, D
	jal ra, PRINTAR_MATRIZ
	
	li a7, 4			# printar msg
	la a0, msg_vetor
	ecall
	la a0, N
	la a1, C
	jal ra, PRINTAR_VETOR

	# la a0, N
	# la a1, C_copy
	# jal ra, PRINTAR_VETOR

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
	li t0, 2
	bge a0, t0, CONTINUAR_DESENHAR_LINHAS
	ret
	
CONTINUAR_DESENHAR_LINHAS: nop
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
			
			mul t5, t5, t5	# ( ci(x) - cj(x) )?
			mul t6, t6, t6	# ( ci(y) - cj(y) )?
			
			add t5, t5, t6	# ( ci(x) - cj(x) )? + ( ci(y) - cj(y) )?
			
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

#################### int menor_caminho(int *quantidadeVertices, int coordenadas[], float vetorDistancias[])
## calcular o caixeiro viajante
# a0 -> N
# a1 -> C
# a2 -> D
MENOR_CAMINHO: nop
	lw t0, 0(a0)	# quantidade vertices
	li t1, 2
	bge t0, t1, CONTINUAR_MENOR_CAMINHO
	ret
CONTINUAR_MENOR_CAMINHO: nop
	addi sp, sp, -8	# inicia pilha
	sw ra, 0(sp)
	sw s0, 4(sp)	# salva frame pointer
	addi s0, sp, -4	# inicia frame pointer
	
	addi t1, zero, 0# i = 0
	addi t5, zero, 1# iteracoes = 1
	
FOR1_MENOR_CAMINHO: nop
	addi t2, zero, 1		# j = 1
	
	addi t3, zero, 900		# aux = 900
	fcvt.s.w f3, t3			# aux = 900.0
	
	addi t4, a2, 0			# D
	mul t3, t0, t1			# N * i
	slli t3, t3, 2			# N * i * 4 bytes
	add t4, t4, t3			# linha correspondende em D
	
	FOR2_MENOR_CAMINHO: nop
		addi t4, t4, 4			# coluna correspondende em D
		
		# verificando se valor ? menor do que o menor encontrado
		flw fa0, 0(t4)			# distancia ponto flutuante
		flt.s t3, fa0, f3		# if ( valorAtual < aux )
		bne t3, zero, NOVO_MENOR# se verdadeiro, aux = valor
				
VOLTA_NOVO_MENOR: nop
	addi t2, t2, 1	# j++
	lw t0, 0(a0)	# volta valor de N
	bne t2, t0, FOR2_MENOR_CAMINHO
		
	addi t5, t5, 1	# iteracao++
	addi t1, t6, 0	# i = j
	
	addi sp, sp, -4	# add pilha
	sw t6, 0(sp)	# salva na pilha posicao visitada
	
	li t3, 0
	fcvt.s.w f1, t3
	fadd.s fa0, f3, f1	# mv fa0, f3
	
	bne t5, t0, FOR1_MENOR_CAMINHO
	
	###### Ordenar C
	
	addi t3, a1, 0	# vetor C
	
	lw t1, 0(s0)	# ordenado por indice	
	slli t1, t1, 3	# multiplica p * 8
	add t1, t3, t1	# vai na posicao exata de C a partir da pilha
	
	li a7, 32
	li a0, 500
	ecall
	
	## F at? o mais proximo
	lw a0, 0(t3)	# coord XF
	lw a1, 4(t3)	# coord YF
	lw a2, 0(t1)	# coord Xp
	lw a3, 4(t1)	# coord Yp
	li a4, 7		# cor vermelha
	li a7, 47		# desenhar linha
	M_Ecall
	
	la a0, N
	lw a0, 0(a0)
	li t2, 2
	
	beq a0, t2, MENOR_ORDENAR
	
	addi s0, s0, -4	# proximo indice ordenado
MENOR_WHILE2: nop
		li a7, 32
		li a0, 500
		ecall
		
		lw t1, 0(s0)	# ordenado por indice
		
		# encontrando a posicao do indice no vetor C
		slli t1, t1, 3	# multiplica p * 8
		add t1, t3, t1	# vai na posicao exata de C a partir da pilha
		
		# lendo X e Y do indice
		lw a0, 0(t1)
		lw a1, 4(t1)
		
		# encontrando a posicao do proximo indice no vetor C
		lw t1, 4(s0)	# ordenado por indice
		
		slli t1, t1, 3	# multiplica p * 8
		add t1, t3, t1	# vai na posicao exata de C a partir da pilha
		
		# pintar linha entre casas proximas
		lw a2, 0(t1)
		lw a3, 4(t1)
		li a4, 7	# cor vermelha
		li a7, 47
		M_Ecall
		
		addi s0, s0, -4 	# proximo indice
		bge s0, sp, MENOR_WHILE2 	# if ( nao tiver finalizado de ler a pilha )
	
	# DESENHAR LINHA ENTRE F e o ULTIMO INDICE
	addi s0, s0, 4	# volta ao indice anterior ( ultimo indice ordenado )
	lw t1, 0(s0)
	
	# encontrar X e Y do ultimo indice no vetor C
	slli t1, t1, 3	# multiplica p * 8
	add t1, t3, t1	# vai na posicao exata de C a partir da pilha
	
	li a7, 32
	li a0, 500
	ecall
	
	lw a0, 0(t3)
	lw a1, 4(t3)
	lw a2, 0(t1)
	lw a3, 4(t1)
	li a4, 7	# cor vermelha
	li a7, 47	# desenha linha entre F e ultimo indice na pilha
	M_Ecall
	
	j MENOR_ORDENAR
	

NOVO_MENOR: nop
			beq t1, t2, VOLTA_NOVO_MENOR # if ( j == i ) ignora
			
			mv t0, s0	# frame pointer
			# Percorre a pilha para verificar se indice ja foi visitado
			WHILE: nop
				lw t3, 0(t0)					# if ( ja_visitado[j] )
				beq t3, t2, VOLTA_NOVO_MENOR	# ignora
				addi t0, t0, -4					# proximo indice a ser verificado na pilha
				bge t0, sp, WHILE				# enquanto nao tiver percorrida a pilha inteira
			
			# movendo valor flutuante
			li t3, 0
			fcvt.s.w f1, t3
			fadd.s f3, f1, fa0	# mv f3, fa0
			
			addi t6, t2, 0	# posicao da menor			
			
			jal zero, VOLTA_NOVO_MENOR


MENOR_ORDENAR: nop
	addi sp, sp, -8		# aumentando pilha
	sw s1, 0(sp)		# guardando S1
	sw s2, 4(sp)		# guardando S2
	
	mv s1, t0			# carregando N
	mv t0, s0			# end. stack
	
	addi t1, s1, -2 	# N - 2 (tira origem, come?a de 0)
	slli t1, t1, 2		# (N-2)*4
	add t0, t0, t1		# final da pilha (topo)
	#slli s2, s1, 3		# t3 = N * 8 (2 words)
	#add s2, s2, a1		# s2 (end. final C) = N*8 + C


	li t2, 0			# contador ordenou
	la t3, C
	la t6, C_copy

MENOR_ORDENAR_LOOP1: addi s1, s1, -1
	bge t2, s1, MENOR_ORDENAR_CASE1		# t2 >= N - 1 ? fim da stack 
	lw t1, 0(t0) 						# indice na stack

	la t3, C
	slli t4, t1, 3						# t4 = t1 (i) * 8
	add t3, t3, t4						# t3 = C + i*8
	lw t4, 0(t3)						# carregando de C
	sw t4, 0(t6)						# salvando em C_Copy
	lw t4, 4(t3)
	sw t4, 4(t6)

	addi t0, t0, -4						# andando na stack
	addi t6, t6, 8 						# andando em C_Copy
	
	addi t2, t2, 1						# contador i
	addi s1, s1, 1 						# corrigindo valor de s1

	j MENOR_ORDENAR_LOOP1
	# MENOR_ORDENAR_LOOP2: addi s1, s1, 1
	# bge t3, s2, MENOR_ORDENAR_CASE2		# t3 >= N ? percorreu todo o C
	# lw t4, 0(t3)						# carregando C
	
# C_copy montado, copiar para C.
MENOR_ORDENAR_CASE1: li t2, 1							# contador C, n queremos a origem
	li t4, 0											# contador C_copy
	addi s1, s1, 1
	MENOR_ORDENAR_CASE1_LOOP1: bge t2, s1, MENOR_ORDENAR_CASE2		# t2 (cont i) >= s1 (N) ? stop
		la t0, C
		slli t3, t2, 3					# t3 = i * 4
		add t0, t0, t3					# t0 = C + i*4

		la t1, C_copy
		slli t3, t4, 3					# t3 = j * 4
		add t1, t1, t3					# t1 = C_copy + i*4

		lw t5, 0(t1)					# t1 = C_copy[j]
		sw t5, 0(t0)					# C[i] = t1
		lw t5, 4(t1)					
		sw t5, 4(t0)					

		addi t2, t2, 1					# i++
		addi t4, t4, 1					# j++
		j MENOR_ORDENAR_CASE1_LOOP1

# C ordenado, refazer matriz D.
MENOR_ORDENAR_CASE2: la a0, N
	la a1, C
	la a2, D
	
	jal CALCULAR_DISTANCIA

	lw s1, 0(sp)		# carregando S1
	lw s2, 4(sp)		# carregando S2
	addi sp, sp, 8		# aumentando pilha
	
	# j MENOR_EXIT

MENOR_EXIT: nop
	# Limpando memoria usada
	lw t0, 0(a0)	# N
	addi t0, t0, -1	# N - 1
	slli t1, t0, 2	# multiplica por 4
	add sp, sp, t1	# encerra pilha com tamanho de N - 1
	
	# Retornando o valor original de s0
	lw ra, 0(sp)	
	lw s0, 4(sp)	# retorna o frame pointer
	addi sp, sp, 8	# libera pilha
	
	# return 
	ret
##############################

#################### void printar_vetor(int N, int vetor[])
# a0 -> quantidade
# a1 -> matriz D
PRINTAR_VETOR: nop
	lw t0, 0(a0)
	mv t1, a1
FOR2: nop
		lw a0, 0(t1)
		li a7, 1
		ecall
		
		li a0, ' '
		li a7, 11
		ecall
		
		lw a0, 4(t1)
		li a7, 1
		ecall
		
		li a0, ' '
		li a7, 11
		ecall
		
		addi t1, t1, 8
		addi t0, t0, -1
		bne t0, zero, FOR2
	li a0, '\n'
	li a7, 11
	ecall
	ret
##############################

#################### void printar_matriz(int N, float matriz[][])
# a0 -> quantidade
# a1 -> matriz D
PRINTAR_MATRIZ: nop
	lw t2, 0(a0)
	lw t0, 0(a0)
	mv t1, a1
	
	mul t0, t0, t0
FOR: nop
		flw fa0, 0(t1)
		li a7, 2
		ecall
		
		li a0, ' '
		li a7, 11
		ecall
		
		addi t1, t1, 4
		addi t0, t0, -1
		addi t2, t2, -1
		
		beq t2, zero, QUEBRA_LINHA
	VOLTA_FOR:
		bne t0, zero, FOR
		jal zero, EXIT_FOR
QUEBRA_LINHA: nop
	li a0, '\n'
	li a7, 11
	ecall
	la t2, N
	lw t2,0(t2)
	jal zero, VOLTA_FOR
EXIT_FOR:li a0, '\n'
	li a7, 11
	ecall
	#jal ra, VOLTA_PRINTAR_MATRIZ
	ret
##############################
.include "SYSTEMv13.s"