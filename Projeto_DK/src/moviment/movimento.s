.data
.include "..\..\images\isc.s"
.include "..\..\images\barril.s"
	#Quadrado: .space 3600 	# quadrado simulando personagem
#	struct objetos{
#		imagem[],
#		tamanho,
#		posicao,
#		largura,
#		velocidade (pixels),
#		direcao (0 - esquerda; 1 - direita)
#	} Objetos

	# Objetos[20]
	# 20 x 6 = 120
	Objetos: .word 	barril,256,0,16,4,1,barril,256,38400,16,32,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	
	mensagem: .string "Escreva um numero para mover diferente de zero\n"
.text

MAIN: nop
	jal ra, CRIAR_MAPA
	
WHILE1_MAIN: nop
	li a7, 4 # mostrar uma string
	la a0, mensagem
	ecall

	li a7, 5 # ler inteiro do teclado
	ecall
	
	beq a0, zero, FORA_WHILE1_MAIN # if ( num != 0)

	la a0, Objetos 			# vetor contendo objetos
	li a1, 120				# tamanho do vetor
	jal ra, MOVER_OBJETOS 	# move todos os objetos no vetor
	
	jal zero, WHILE1_MAIN

FORA_WHILE1_MAIN:
	addi a7, zero, 10 # encerra o programa
	ecall
##############################

#################### void cria_mapa()
## Poe o mapa no display
CRIAR_MAPA: nop
	li t0, 0xFF000000 	# endereco inicial
	li t1, 0xFF012C00 	# endereco final display
	la s0, frame1 		# imagem
	addi s0, s0, 8 		# erros de pixel

FOR1_CRIAR_MAPA: nop
	lw t2, 0(s0) 				# pega 4 bytes da imagem
	sw t2, 0(t0) 				# poe no display pedaco de 4bytes
	addi s0, s0, 4 				# vai para os proximos 4 bytes na imagem
	addi t0, t0, 4 				# vai para os proximos 4 bytes no display
	bne t0, t1, FOR1_CRIAR_MAPA # repete o for
	ret
##############################

#################### void criar_quadrado(int imagem[], int tamanho, int posicaoInicial, int colunas)
## Cria o quadrado no display
# a0 -> vetor da imagem
# a1 -> tamanho do vetor imagem
# a2 -> posicao Inicial
# a3 -> largura da imagem
CRIAR_QUADRADO: nop
	# quadrado 60x60, 3600 posicoes na memoria
	# 3600 posicoes / 4 bytes = 900 iteracoes
	# 60 colunas / 4 bytes = 15 iteracoes por linha
	
	li t0, 0xFF000000 	# endereco inicial
	add t0, t0, a2  	# aumenta linhas e colunas para posicao exata
	addi t1, a0, 0 		# endereco inicial do quadrado
	add t2, a1, zero	# posicoes do vetor do quadrado
	add t2, t1, t2 		# endereco final do quadrado
	
	add t3, zero, a3  	# contador

FOR1_CRIAR_QUADRADO: nop
	lw t4, 0(t1) 		# le 4 bytes da imagem do quadrado
	sw t4, 0(t0) 		# poe no display pedaco de 4 bytes da imagem
	addi t1, t1, 4 		# proximos 4 bytes da imagem
	addi t0, t0, 4 		# proximos 4 bytes do display
	addi t3, t3, -4 	# contador --
	beq t3, zero, PULAR_LINHA_CRIAR_QUADRADO # if (contador == 0)

VOLTA_IF: nop
	bne t1, t2, FOR1_CRIAR_QUADRADO
	ret

PULAR_LINHA_CRIAR_QUADRADO: nop
	addi t4, zero, 320	# colunas em 1 linha
	sub t4, t4, a3 		# 320 - 60, correcao de posicao
	add t0, t0, t4 		# avanca para proxima linha
	add t3, zero, a3 	# reseta contador
	jal zero, VOLTA_IF
##############################

#################### void apagar_quadrado(int imagem[], int tamanho, int posicaoInicial, int colunas)
## Cria o quadrado no display
# a0 -> vetor contendo a imagem
# a1 -> tamanho do vetor de imagem
# a2 -> posicao inicial no Display
# a3 -> a quantidade de colunas que a imagem ocupa em bytes
APAGAR_QUADRADO: nop
	# quadrado 60x60, 3600 posicoes na memoria
	# 3600 posicoes / 4 bytes = 900 iteracoes
	# 60 colunas / 4 bytes = 15 iteracoes por linha
	
	li t0, 0xFF000000 		# endereco inicial
	add t0, t0, a2  		# aumenta linhas e colunas para posicao exata
	addi t1, a0, 0 			# endereco inicial do quadrado
	add t2, a1, zero 		# tamanho do vetor do quadrado
	add t2, t1, t2 			# endereco final do quadrado

	add t3, zero, a3 		# contador para quebra de linha
	
	la t5, frame1 			# vetor contendo o mapa
	addi t5, t5, 8 			# retira o erro de pixel
	add t5, t5, a2 			# aumenta linhas e colunas para posicao exata

FOR1_APAGAR_QUADRADO: nop
	lw t4, 0(t5) 			# le 4 bytes da imagem do quadrado
	sw t4, 0(t0) 			# poe no display pedaco de 4 bytes da imagem
	addi t1, t1, 4 			# proximos 4 bytes da imagem
	addi t0, t0, 4 			# proximos 4 bytes do display
	addi t5, t5, 4 			# proximos 4 bytes do vetor do mapa
	addi t3, t3, -4 		# contador --
	beq t3, zero, PULAR_LINHA_APAGAR_QUADRADO # if (contador == 0)

VOLTA_APAGAR_IF: nop
	bne t1, t2, FOR1_APAGAR_QUADRADO
	ret

PULAR_LINHA_APAGAR_QUADRADO: nop
	addi t4, zero, 320 	# total de 320 colunas em uma linha
	sub t4, t4, a3 		# conserto de distancia 320 - 60
	add t0, t0, t4
	add t5, t5, t4
	add t3, zero, a3 	# reseta contador
	jal zero, VOLTA_APAGAR_IF
##############################

#################### int mover_quadrado(int imagem[], int tamanho, int posicaoInicial, int colunas, int velocidade)
## Move o quadrado no display
# a0 -> vetor contendo a imagem
# a1 -> tamanho do vetor de imagem
# a2 -> posicao inicial no Display
# a3 -> a quantidade de colunas que a imagem ocupa em bytes
# a4 -> velocidade
## retorna a nova posicao
# a0 -> nova posicao
MOVER_QUADRADO: nop
	addi sp, sp, -4 		# inicia pilha
	sw ra, 0(sp) 			# salva retorno na pilha
	
	jal ra, APAGAR_QUADRADO # Apaga o anterior
	add a2, a2, a4			# adiciona as posicoes necessarias
	jal ra, CRIAR_QUADRADO	# cria o objeto
	
	lw ra, 0(sp) 			# le o valor de retorno
	addi sp, sp, 4 			# encerra pilha
	
	addi a0, a2, 0			# nova posicao do objeto
	ret
##############################

#################### void mover_objetos(int Objetos[], int tamanho)
## Move os objetos contidos no vetor
# a0 -> vetor contendo todos os objetos
# a1 -> tamanho do vetor que contem os objetos
MOVER_OBJETOS: nop
	addi sp, sp, -4		# inicia pilha
	sw ra, 0(sp) 		# salva retorno na pilha
	
	addi t0, a0, 0 		# salva a0 em t0
	addi t1, a1, 0 		# salva a1 em t1
	
	add t2, zero, a1 	# i = tamanho vetor;

FOR1_MOVER_OBJETOS: nop
	lw a0, 0(t0) 	# pega a imagem no vetor objetos
	bne a0, zero, OBJETO_ENCONTRADO # verifica se o objeto existe (imagem != 0)

VOLTA_IF1_MOVER_OBJETOS: nop
	addi t2, t2, -6 # i-- 
	addi t0, t0, 24 # move 6 posicoes no vetor
	bne t2, zero, FOR1_MOVER_OBJETOS # if ( i != 0 )
	
	lw ra, 0(sp) 		# pega o retorno na pilha
	addi sp, sp, 4 		# libera a pilha
	ret
	
OBJETO_ENCONTRADO:
	lw a1, 4(t0) 	# pega o tamanho no vetor
	lw a2, 8(t0) 	# pega a posicao no vetor
	lw a3, 12(t0) 	# pega a largura no vetor
	lw a4, 16(t0) 	# pega a velocidade no vetor
	
	addi sp, sp, -12 # inicia pilha
	sw t0, 0(sp) 	# salva t0 na pilha
	sw t1, 4(sp) 	# salva t1 na pilha
	sw t2, 8(sp)	# salva t2 na pilha
	
	jal ra, MOVER_QUADRADO # Move o quadrado
	
	lw t0, 0(sp) 	# pega na pilha o valor de t0
	lw t1, 4(sp) 	# pega na pilha o valor de t1
	lw t2, 8(sp) 	# pega na pilha o valor de t2
	
	sw a0, 8(t0) 	# salva a nova posicao no vetor
	
	addi sp, sp, 12 # libera pilha
	
	jal zero, VOLTA_IF1_MOVER_OBJETOS
##############################
