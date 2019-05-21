.data
.include "..\..\images\mapa.s"
.include "..\..\images\elevador.s"
.include "..\..\images\mola.s"
.include "..\..\images\mola1.s"
.include "..\..\images\barril1.s"
.include "..\..\images\barril2.s"
.include "..\..\images\barril3.s"
.include "..\..\images\barril4.s"
.include "..\..\images\princesa.s"
.include "..\..\images\princesa_walk.s"
.include "..\..\images\mario.s"
#	struct personagens{
#		imagem[],
#		posicaoX,
#		posicaoY,
#		is_jumping,
#		in_escada
#	} Personagens

	# Objetos[20]
	# 20 x 7 = 140
	
#	struct objetos{
#		imagem[],
#		posicaoX,
#		posicaoY,
#		velocidade (pixels),
#		direcao (0 - esquerda; 1 - direita)
#		tipo ( 0 - barril; 1 - mola )
#		is_jumping ( 0 - falso ; > 0 - verdadeiro )
#	} Objetos

	# Objetos[20]
	# 20 x 5 = 100
	Personagens: .word princesa, 0, 200, 0,0, mario, 160, 36,0,0
	
	Objetos: .word 	barril1,0,20,3,1,0,0, barril1,120,0,3,1,0,0, barril1,20,20,3,1,0,0, barril1,40,20,3,1,0,0, barril1,0,125,3,1,0,0
					
	mensagem: .string "Escreva um numero para mover diferente de zero\n"
.text

MAIN: nop
	addi sp, sp, -4
	sw ra, 0(sp)
	
	
	jal ra, CRIAR_MAPA

	la a0, Objetos 			# vetor contendo objetos
	li a1, 5				# quantidade objetos
	jal ra, MOVER_OBJETOS 	# move todos os objetos no vetor

	la a0, Personagens		# Vetor Struct Personagem
	li a1, 2				# Quantidade de personagens a ser impresso
	jal ra, CRIAR_PERSONAGENS
WHILED: nop
	li t0, 'x'
	beq a0, t0, EXIT
	
	li a7, 12
	ecall
	
	la a1, Personagens
	jal ra, MOVER_PERSONAGEM
	
	la a1, Personagens
	lw t0, 0(a1)
	la t1, princesa
	beq t0, t1, ANIMACAO
	sw t1,0(a1)
VOLTA_ANIMACAO: nop
	la a0, Objetos 			# vetor contendo objetos
	li a1, 5				# quantidade objetos
	jal ra, MOVER_OBJETOS
	
	jal zero, WHILED
	
	
EXIT: nop
	li a7 10
	ecall
	
ANIMACAO: nop
	la t1, princesa_walk
	sw t1, 0(a1)
	jal zero, VOLTA_ANIMACAO
##############################

#################### void cria_mapa()
## Poe o mapa no display
CRIAR_MAPA: nop
	li t0, 0xFF000000 	# endereco inicial
	li t1, 0xFF012C00 	# endereco final display
	la s0, mapa 		# imagem
	addi s0, s0, 8 		# erros de pixel

FOR1_CRIAR_MAPA: nop
	lw t2, 0(s0) 				# pega 4 bytes da imagem
	sw t2, 0(t0) 				# poe no display pedaco de 4bytes
	addi s0, s0, 4 				# vai para os proximos 4 bytes na imagem
	addi t0, t0, 4 				# vai para os proximos 4 bytes no display
	bne t0, t1, FOR1_CRIAR_MAPA # repete o for
	ret
##############################

#################### void criar_personagens()
## Cria os personagens do jogo
# a0 -> vetor struct personagens
# a1 -> quantidade de personagens
CRIAR_PERSONAGENS: nop
	addi t0, a0, 0	# t0 = a0
	addi t1, a1, 0	# t1 = a1
	
	addi sp, sp, -4	# inicia pilha
	sw ra, 0(sp)	# salva ra
	
FOR1_CRIAR_PERSONAGENS: nop
		beq t1, zero, EXIT_FOR1_CRIAR_PERSONAGENS
		
		lw a0, 0(t0)	# imagem[] do personagem
		lw a1, 4(t0)	# posicao X
		lw a2, 8(t0)	# posicao Y
		
		addi sp, sp, -8	# inicia pilha
		sw t1, 0(sp)	# salva contador na pilha
		sw t0, 4(sp)	# salva vetor struct na pilha
		
		jal ra, CRIAR_QUADRADO
		
		lw t1, 0(sp)
		lw t0, 4(sp)
		addi sp, sp, 8
		
		addi t0, t0, 20
		addi t1, t1, -1
		
		jal zero, FOR1_CRIAR_PERSONAGENS
EXIT_FOR1_CRIAR_PERSONAGENS: nop
	
	lw ra, 0(sp)	# le ra
	addi sp, sp, 4	# encerra pilha
	ret
####################

#################### void criar_quadrado(int imagem[], int x, int y)
## Cria o quadrado no display
# a0 -> vetor da imagem
# a1 -> posicao X
# a2 -> posicao Y
CRIAR_QUADRADO: nop
	### achando a posicao no display para desenhar ##
	li t0, 320
	mul t0, t0, a2		# 320 * y
	add t0, t0, a1		# 320 * y + x
	li t1, 0xFF000000	# endereço inicial
	add t0, t0, t1		# 320*y + x + end.Inicial

	## atribuicoes da imagem ##
	addi t1, a0, 8			# endereco inicial do quadrado
	lw t2, 4(a0)			# altura da imagem
	lw t3, 0(a0)			# contador largura

FOR1_CRIAR_QUADRADO: nop
	lb t4, 0(t1) 		# le byte da imagem do quadrado
	sb t4, 0(t0) 		# poe no display pedaco de 4 bytes da imagem
	addi t1, t1, 1 		# proximo byte da imagem
	addi t0, t0, 1 		# proximo byte do display
	addi t3, t3, -1 	# contador largura --
	beq t3, zero, PULAR_LINHA_CRIAR_QUADRADO # if (contador == 0)

VOLTA_IF: nop
	bne t2,zero, FOR1_CRIAR_QUADRADO
	ret

PULAR_LINHA_CRIAR_QUADRADO: nop
	lw t3, 0(a0)		# reseta contador largura
	addi t4, zero, 320	# colunas em 1 linha

	sub t4, t4, t3 		# 320 - 60, correcao de posicao
	add t0, t0, t4 		# avanca para proxima linha
	addi t2, t2, -1		# contador altura --
	jal zero, VOLTA_IF
##############################

#################### void apagar_quadrado(int imagem[], int x, int y)
## Apaga o quadrado no display
# a0 -> vetor contendo a imagem
# a1 -> posicao X
# a2 -> posicao Y
APAGAR_QUADRADO: nop	
	### achando a posicao no display para desenhar ##
	li t0, 320
	mul t0, t0, a2		# 320 * y
	add t4, t0, a1		# 320 * y + x
	li t1, 0xFF000000	# endereço inicial
	add t0, t4, t1		# 320*y + x + end.Inicial

	## atribuicoes da imagem ##
	addi t1, a0, 8			# endereco inicial do quadrado
	lw t2, 4(a0)			# altura da imagem
	lw t3, 0(a0)			# contador largura
	
	## achando a posicao no mapa original ##
	la t5, mapa 			# vetor contendo o mapa
	addi t5, t5, 8 			# retira o erro de pixel
	add t5, t5, t4 			# 320*y + x + end.Inicial

FOR1_APAGAR_QUADRADO: nop
	lb t4, 0(t5) 			# le 4 bytes da imagem do quadrado
	sb t4, 0(t0) 			# poe no display pedaco de 4 bytes da imagem
	addi t1, t1, 1 			# proximo byte da imagem
	addi t0, t0, 1 			# proximo byte do display
	addi t5, t5, 1 			# proximo byte do vetor do mapa
	addi t3, t3, -1 		# contador largura --
	beq t3, zero, PULAR_LINHA_APAGAR_QUADRADO # if (contador == 0)

VOLTA_APAGAR_IF: nop
	bne t2, zero, FOR1_APAGAR_QUADRADO
	ret

PULAR_LINHA_APAGAR_QUADRADO: nop
	lw t3, 0(a0)		# reseta contador largura
	addi t4, zero, 320 	# total de 320 colunas em uma linha

	sub t4, t4, t3 		# conserto de distancia 320 - 60
	add t0, t0, t4
	add t5, t5, t4
	addi t2, t2, -1		# contador altura --
	jal zero, VOLTA_APAGAR_IF
##############################

#################### void mover_objetos(struct Objetos[], int quantidade_objetos)
## Move os objetos contidos no vetor
# a0 -> vetor contendo todos os objetos
# a1 -> quantidade de objetos a ser movido
MOVER_OBJETOS: nop
	addi t0, a0, 0	# t0 = a0
	addi t1, a1, 0	# t1, = a1
	
	## salvando retorno pois utilizamos chamada de funções ##
	addi sp, sp, -12# inicia pilha
	sw ra, 0(sp)	# salva retorno
	
	## inicia loop for -> percorrer vetor objetos de acordo com quantidade ##
FOR1_MOVER_OBJETOS: nop
		beq t1, zero, EXIT_FOR1_MOVER_OBJETOS	# if ( i == 0 )
		
		## iniciando pilhagem para chamada de funcao ##
		sw t0, 4(sp)	# salva o endereco onde estao os objetos
		sw t1, 8(sp)	# salva o contador de interacoes
		
		lw a0, 0(t0)		# imagem[]
		lw a1, 4(t0)		# posicao X
		lw a2, 8(t0)		# posicao Y
		
		jal ra, APAGAR_QUADRADO
		
		## chama VERIFICAR CHAO ##
		lw t0, 4(sp)	# struct
		lw a0, 0(t0)		# imagem[]
		lw a1, 4(t0)		# posicao X
		lw a2, 8(t0)		# posicao Y
		li a3, 79
		li a4, 0
		jal ra, VERIFICAR_CHAO
		
		mv a5, a1		# a5 = a1 ( se esta no chao )
		
		## CHAMA MOVER __ OBJETO ## 
		lw t0, 4(sp)	# struct
		lw a0, 0(t0)		# imagem[]
		lw a1, 4(t0)		# posicao X
		lw a2, 8(t0)		# posicao Y
		lw a3, 12(t0)		# velocidade
		lw a4, 16(t0)		# direcao
		
		lw t2, 20(t0)	# le o tipo do objeto
		bne t2, zero, PULA_BARRIL # nao eh barril
		jal ra, MOVER_BARRIL
		jal zero, PULA_MOLA
PULA_BARRIL: nop

		li t3, 1
		bne t2, t3, PULA_MOLA	# nao eh mola

		## verifica posicao ##
		li t3, 200
		blt a1, t3, NAO_IMPEDIR_A5
		li a5, 0	# impede a5 de atrapalhar nossos planos...
NAO_IMPEDIR_A5: nop
		## verifica is_jumping ##		
		lw t3, 24(t0)		# is_jumping ?
		add a5, t3, a5		# se a soma de in_gound com is_jumping = 0, significa que ele esta em queda livre.
		
		beq a5, zero, PULA_ALTERNAR_JUMPING
		
		## is_jumping ++ ## 
		addi t3, t3, 1
		
		li t4, 6			# max saltos, se saltos = 8, reseta e libera queda livre
		blt t3, t4, PULA_ALTERNAR_JUMPING
		
		li t3, 0			# reset
PULA_ALTERNAR_JUMPING: nop
		sw t3, 24(t0)		# ( alterna is_jumping quando necessario )
		jal ra, MOVER_MOLA
PULA_MOLA: nop
		## Salvar novas informacoes ## 
		lw t0, 4(sp)	# struct
		sw a0, 0(t0)		# imagem[]
		sw a1, 4(t0)		# posicao X
		sw a2, 8(t0)		# posicao Y
		sw a3, 16(t0)		# direcao

		jal ra, CRIAR_QUADRADO
		
		## retornando valores apos chamada de funcao ##
		lw t0, 4(sp)
		lw t1, 8(sp)
		
PULAR_MOVIMENTO: nop
		addi t1, t1, -1		# contador i --
		addi t0, t0, 28		# proximo objeto
			
		jal zero, FOR1_MOVER_OBJETOS
		
EXIT_FOR1_MOVER_OBJETOS: nop
	lw ra, 0(sp)			# pega ra
	addi sp, sp, 12			# finaliza pilha
	
	ret
################################

####### mover_barril(int imagem[], int x, int y, int velocidade, int direcao, int in_ground)
## move o barril
# a0 -> imagem[]
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> velocidade
# a4 -> direcao ( 0 - esquerda, 1 - direita )
# a5 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
## retorna novos valores
# a0 -> nova imagem[]
# a1 -> nova posicao X
# a2 -> nova posicao Y
# a3 -> nova direcao
MOVER_BARRIL: nop
	## preparando para chamada de funcoes ##
	addi sp, sp, -16
	sw ra, 0(sp)	# salva retorno
	sw a0, 4(sp)	# salva imagem[]
	sw a2, 8(sp)	# salva posicao Y
	sw a3, 12(sp)	# salva velocidade
	
	## chamando VERIFICAR ESCADA ##
	lw t2, 4(a0)	# altura da imagem
	add a2, a2, t2	# desloca verificacao para baixo do objeto
	addi a2, a2, 4	# desloca +4 para baixo
	li a3, 105
	jal ra, VERIFICAR_ESCADA
	
	mv t2, a0
	
	## retorna valores originais para continuar funcao ##
	lw ra, 0(sp)
	lw a0, 4(sp)
	lw a2, 8(sp)
	lw a3, 12(sp)
	
	beq t2, zero, BARRIL_FORA_ESCADA
	addi a2, a2, 2
	jal zero, PULA_MUDAR_DIRECAO
BARRIL_FORA_ESCADA: nop

	## tratamento de animacao barril ##
	la t2, barril1
	beq a0, t2, ANIMACAO_BARRIL1
	la t2, barril2
	beq a0, t2, ANIMACAO_BARRIL2
	la t2, barril4
	beq a0, t2, ANIMACAO_BARRIL3
	la a0, barril1
	
	jal zero, PULAR_ANIMACAO_BARRIL
ANIMACAO_BARRIL1: nop
	la a0, barril2
	jal zero, PULAR_ANIMACAO_BARRIL
ANIMACAO_BARRIL2: nop
	la a0, barril4
	jal zero, PULAR_ANIMACAO_BARRIL
ANIMACAO_BARRIL3: nop
	la a0, barril3
	jal zero, PULAR_ANIMACAO_BARRIL	
	
	## tratamento de movimento do barril ##
PULAR_ANIMACAO_BARRIL: nop
	## verifica se barril esta no chao ##
	bne a5, zero, PULA_BARRIL_GRAVITY	# se estiver no chao, pula
	addi a2, a2, 2
	
PULA_BARRIL_GRAVITY: nop
	## verifica direcao que deve ir ##
	beq a4, zero, MOVER_ESQUERDA_BARRIL
	
	## movendo para direita ##
	add a1, a1, a3		# proximo X ( direita )
	addi a3, a4, 0		# a3 = a4 ( retorno de direcao )
	
	## se bater no fim do mapa direita ## 
	addi t2, zero, 300	# iniciar verificacao de fim de mapa
	blt a1, t2, PULA_MUDAR_DIRECAO
	
	li a3, 0		# 0 = esquerda
PULA_MUDAR_DIRECAO: nop
	addi sp, sp, 16
	ret
MOVER_ESQUERDA_BARRIL: nop
	## movendo para esquerda ##
	sub a1, a1, a3	# proximo x ( esquerda )
	addi a3, a4, 0		# a3 = a4 ( retorno de direcao )
	
	## se bater no fim do mapa esquerda ##
	addi t2, zero, 2	# iniciar verificacao de fim de mapa
	blt t2, a1, PULA_MUDAR_DIRECAO
	
	li a3, 1		# 1 = direita
	addi sp, sp, 16
	ret
#################################

####### mover_mola(int imagem[], int x, int y, int velocidade, int direcao, int in_ground)
## move a mola
# a0 -> imagem[]
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> velocidade
# a4 -> direcao ( 0 - esquerda, 1 - direita )
# a5 -> in_jumping ( 0 - nao esta pulando, > 0 - esta pulando )
## retorna novos valores
# a0 -> nova imagem[]
# a1 -> nova posicao X
# a2 -> nova posicao Y
# a3 -> nova direcao
MOVER_MOLA: nop
	mv t6, a4
	
	la t2, mola
	bne a0, t2, ANIMACAO_MOLA
	la a0, mola1
	jal zero, PULAR_ANIMACAO_MOLA
ANIMACAO_MOLA: nop
	mv a0, t2
	jal zero, PULAR_ANIMACAO_MOLA
	
PULAR_ANIMACAO_MOLA: nop
	
	## se bater no fim do mapa baixo ##
	addi t2, zero, 200	# iniciar verificacao de fim de mapa
	blt t2, a2, PULA_MUDAR_DIRECAO_MOLA
	
	## verifica se mola esta no pulando ##
	bne a5, zero, MOLA_SALTO	# se estiver pulando, pula
	addi a2, a2, 2	# gravidade
	
PULA_MOLA_GRAVITY: nop
	## verifica direcao que deve ir ##
	beq a4, zero, MOVER_BAIXO_MOLA
	
	## movendo para direita ##
	add a1, a1, a3		# proximo X ( direita )
	
	## se bater no fim do mapa direita ## 
	addi t2, zero, 260	# iniciar verificacao de fim de mapa
	blt a1, t2, PULA_MUDAR_DIRECAO_MOLA
	
	li t6, 0		# 0 = baixo
PULA_MUDAR_DIRECAO_MOLA: nop
	mv a3, t6
	ret
MOVER_BAIXO_MOLA: nop
	## movendo para esquerda ##
	add a2, a2, a3	# proximo y ( baixo )
	
	jal zero, PULA_MUDAR_DIRECAO_MOLA
MOLA_SALTO: nop
	
	sub a2, a2, a3	# proximo y ( cima )
	jal zero PULA_MOLA_GRAVITY
#################################

######################## MOVIMENTO DE PERSONAGEM ###################################

############ int mover_personagem(direcao, struct personagem)
### move o personagem na direcao
## direcao = a move para esquerda
## direcao = d move para direita
## direcao = w move para cima
## direcao = s move para baixo
# a0 -> direcao
# a1 -> struct do personagem
MOVER_PERSONAGEM: nop
	## preparamentos para chamada de funcoes ##
	addi sp, sp, -12	# inicia pilha
	sw ra, 0(sp)	# salva ra
	sw a1, 4(sp)	# salva struct
	sw a0, 8(sp)	# salva direcao
	
	## apagando o personagem atual ##
	lw a0, 0(a1)	# imagem[]
	lw a2, 8(a1)	# posicao Y
	lw a4, 16(a1)	# in_escada
	lw a1, 4(a1)	# posicao X	
	jal ra, APAGAR_QUADRADO
	
	## verificacao de animacao de escada ( subida automatica ) ##
	li t2, 2
	blt a4, t2, PULA_ANIMACAO_SUBIDA
	## forca personagem a subir escada, ate determinada posicao ##
	addi a2, a2, -4
	addi a4, a4, 1
	li a3, 0		# in_jumping = false ( verificar isso dps )
	lw t0, 4(sp)	# struct para salvamentos
	li t2, 8		# posicoes a serem subidas
	blt a4, t2, RETORNA_MOVIMENTO
	li a4, 0		# finaliza animacao
	jal zero, RETORNA_MOVIMENTO
	PULA_ANIMACAO_SUBIDA: nop
	
	## verificando jogador no chao ##
	li a3, 79
	li a4, 0
	jal ra, VERIFICAR_CHAO
	mv t3, a0	# a0 = in_ground ?
	mv t4, a1	# a1 = on_ground ?
	
	## lendo valores do personagem ##
	lw t0, 4(sp)	# struct
	lw a0, 0(t0)	# imagem[]
	lw a1, 4(t0)	# posicao X
	lw a2, 8(t0)	# posicao Y
	lw a3, 12(t0)	# is_jumping
	lw a4, 16(t0)	# in_escada
	
	## tratando gravidade e colisao com chao ##
	beq t3, zero, SEM_COLISAO 	# se nao estiver dentro do chao, ignora
	addi a2, a2, -1		# sobe o jogador em Y para retira-lo do chao
	SEM_COLISAO: nop
	bne t3, zero, SEM_GRAVITY		# se estiver dentro do chao, ignora
	bne a3, zero, IN_JUMPING		# se estiver pulando, ignora
	bne t4, zero, SEM_GRAVITY		# se estiver sobe o chao, ignora

	bne a4, zero, SEM_GRAVITY		# se estiver na escada, ignora
	
	addi a2, a2, 3		# desce o jogador em Y, atribuindo gravidade
	SEM_GRAVITY: nop
	
	## verificando a direcao ##
	lw t1, 8(sp)	# direcao
	## tratando direcao ##
	li t2, 'd'
	beq t1, t2, MOVER_PERSON_DIREITA
	li t2, 'a'
	beq t1, t2, MOVER_PERSON_ESQUERDA
	li t2, 'w'
	beq t1, t2, MOVER_PERSON_CIMA
	li t2, 's'
	beq t1, t2, MOVER_PERSON_BAIXO
RETORNA_MOVIMENTO: nop	
	
	## salvando informacoes novas do personagem ##
	sw a0, 0(t0)
	sw a1, 4(t0)
	sw a2, 8(t0)
	sw a3, 12(t0)
	sw a4, 16(t0)
	## criando o personagem na nova posicao ##
	jal ra, CRIAR_QUADRADO
	
	## encerrando pilhagem e retornando ##
	lw ra, 0(sp)
	addi sp, sp, 12
	
	ret
MOVER_PERSON_DIREITA: nop
	## movendo o personagem em 5 posicoes ##
	addi a1, a1, 5
	li t1, 310	# efeito de comparacao
	li a4, 0
	## verificando se chegou ao fim do mundo da direita
	blt a1, t1, RETORNA_MOVIMENTO
	addi a1, a1, -5	# se chegou, retira o movimento
		
	jal zero, RETORNA_MOVIMENTO
	
MOVER_PERSON_ESQUERDA: nop
	## movendo o personagem em 5 posicoes ##
	addi a1, a1, -5
	li t1, 0	# efeito de comparacao
	li a4, 0
	## verificando se chegou ao fim do mundo da esquerda
	blt t1, a1, RETORNA_MOVIMENTO
	addi a1, a1, 5	# se chegou, retira o movimento
		
	jal zero, RETORNA_MOVIMENTO
MOVER_PERSON_CIMA:nop
	## verificando jogador na escada ##
	li a3, 105
	jal ra, VERIFICAR_ESCADA
	mv t3, a0	# a0 = in_escada ?
	
	## lendo valores do personagem modificado pela funcao ##
	lw t0, 4(sp)	# struct
	lw a0, 0(t0)	# imagem[]
	li a3, 0		# remove jumping ( verificar isso dps )
	## verifica se esta na escada ##
	beq t3, zero, SEM_ESCADA	# se nao estiver na escada, ignora
	
	## verifica se cabeca toca o chao de cima ##
	li a4, 1		# in_escada = true
	li a3, 79
	jal VERIFICAR_CHAO
	
	mv t3, a1	# a1 -> on_ground ? ( touched ground ? )
	
	## lendo valores do personagem modificado pela funcao ##
	lw t0,4(sp)
	lw a0,0(t0)
	lw a1,4(t0)
	li a3, 0		# is_jumping = reset ( verificar isso dps )
	
	## movimento na escada ##
	addi a2, a2, -3	# sobe na escada
	
	## se tocou no chao de cima, ativar animacao automatica de subida ##
	beq t3, zero, RETORNA_MOVIMENTO
	
	li a4, 2
	
	jal zero, RETORNA_MOVIMENTO
	
	## se nao estiver na escada, significa que ele saltou ##
	SEM_ESCADA: nop
	li a3, 1	# is_jumping = true
	jal zero, RETORNA_MOVIMENTO
MOVER_PERSON_BAIXO:nop
	## verificando jogador na escada ##
	li a3, 105
	jal ra, VERIFICAR_ESCADA
	mv t3, a0	# a0 = in_escada ?
	
	## lendo valores do personagem modificado pela funcao ##
	lw t0, 4(sp)	# struct
	lw a0, 0(t0)	# imagem[]
	li a3, 0		# remove jumping ( verificar isso dps )
	## verifica se esta na escada ##
	beq t3, zero, SEM_ESCADA_BAIXO	# se nao estiver na escada, ignora
	
	## verifica se pe toca o chao de baixo ##
	li a4, 0		# baixo = true
	li a3, 79
	jal VERIFICAR_CHAO
	
	mv t3, a1	# a1 -> on_ground ? ( touched ground ? )
	
	## lendo valores do personagem modificado pela funcao ##
	lw t0,4(sp)
	lw a0,0(t0)
	lw a1,4(t0)
	li a3, 0		# is_jumping = reset ( verificar isso dps )
	
	## se tocou no chao de cima, ativar animacao automatica de subida ##
	bne t3, zero, RETORNA_MOVIMENTO

	## movimento na escada ##
	addi a2, a2, 3	# desce na escada
	jal zero, RETORNA_MOVIMENTO
	
	## se nao estiver na escada ##
	SEM_ESCADA_BAIXO: nop
	jal zero, RETORNA_MOVIMENTO
IN_JUMPING: nop
	## diminui y, pulando ##
	addi a2, a2, -5	# sobe 3 posicoes em Y
	addi a3, a3, 1	# jumping++
	li t2, 6		# maximo de saltos
	blt a3, t2, SEM_GRAVITY
	li a3, 0		# is_jumping = false
	jal zero, SEM_GRAVITY
########################

####### bool verificar_chao(imagem[], int x, int y, int cor, int corpo)
## verifica se a imagem toca o chao
# a0 -> vetor imagem
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> cor do chao
# a4 -> parte do corpo a verificar ( 0 - ponta do pe, 1 - ponta da cabeca )
VERIFICAR_CHAO: nop
#	li t6, 0xFF000000
#	li t5, 255

	### achando a posicao no display para desenhar ##
	li t0, 320
	mul t0, t0, a2		# 320 * y
	add t0, t0, a1		# 320 * y + x
	la t1, mapa		# endereço inicial do mapa
	addi t1, t1, 8		# pula struct do mapa
#	add t6, t6, t0		# para debug
	add t0, t0, t1		# 320*y + x + end.Inicial

	bne a4, zero, PONTA_CABECA
	## atribuicoes da imagem caso seja para o pe ##
	lw t1, 4(a0)			# altura da imagem
	li t2, 320				# 320
	addi t1, t1, -1			# subtrai altura por 1
	mul t1, t1, t2			# 320 * (altura - 1)
	jal zero, CONTINUA_VERIFICAR_CHAO
PONTA_CABECA: nop
	li t1, 320	# proxima linha
CONTINUA_VERIFICAR_CHAO: nop
	add t0, t0, t1			# vai para a linha em questao
#	add t6, t6, t1			# para debug
	lw t2, 0(a0)			# largura da imagem
	addi t3, t2, 0			# salva largura

FOR1_VERIFICAR_CHAO: nop
		beq t2, zero, EXIT_FOR1_VERIFICAR_CHAO
		lb t1, 0(t0)	# le o byte do mapa
#		sb t5, 0(t6)	# para debug
		beq t1, a3, ENCONTROU_CHAO
		addi t0, t0, 1	# proximo byte do mapa
#		addi t6, t6, 1	# para debug
		addi t2, t2, -1	# contador largura --	
		jal zero, FOR1_VERIFICAR_CHAO
EXIT_FOR1_VERIFICAR_CHAO: nop
	li a0, 0
	sub t0, t0, t3		# retora t0 ao original
#	li t5, 105			# para debug
#	sub t6, t6, t3		# para debug
#	addi t6, t6, 320	# para debug
	addi t0, t0, 320	# vai para a ultima linha
FOR2_VERIFICAR_CHAO: nop
		beq t3, zero, EXIT_FOR2_VERIFICAR_CHAO
		lb t1, 0(t0)	# le o byte do mapa
#		sb t5, 0(t6)	# para debug
		beq t1, a3, ENCONTROU_CHAO2
		addi t0, t0, 1	# proximo byte do mapa
		addi t3, t3, -1	# contador largura --
#		addi t6, t6, 1	# para debug
		jal zero, FOR2_VERIFICAR_CHAO
EXIT_FOR2_VERIFICAR_CHAO: nop
	li a1, 0
	ret
ENCONTROU_CHAO: nop
	li a0, 1
	sub t0, t0, t3		# retora t0 ao original
	addi t0, t0, 320	# vai para a ultima linha
#	li t5, 105			# para debug
#	sub t6, t6, t3		# para debug
#	addi t6, t6, 320	# para debug
	jal zero, FOR2_VERIFICAR_CHAO
ENCONTROU_CHAO2: nop
	li a1, 1
	ret
	
#######################

####### bool verificar_escada(imagem[], int x, int y, int cor)
## verifica se a imagem toca a escada
# a0 -> vetor imagem
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> cor do chao
VERIFICAR_ESCADA: nop
	#li t6, 0xFF000000 # uso para debug

	### achando a posicao no display para desenhar ##
	li t0, 320
	mul t0, t0, a2		# 320 * y
	add t0, t0, a1		# 320 * y + x
	la t1, mapa		# endereço inicial do mapa
	addi t1, t1, 8		# pula struct do mapa
	#add t6, t6, t0
	add t0, t0, t1		# 320*y + x + end.Inicial
	
	lw t1, 0(a0)			# largura da imagem
	lw t2, 4(a0)			# altura da imagem
	#srai t2, t2, 1			# divide altura por 2, utilizado caso queira apenas metdade do corpo
	#li t5, 248
FOR1_VERIFICAR_ESCADA: nop
		beq t2, zero, EXIT_FOR1_VERIFICAR_ESCADA
		
		## verificar se pixel eh igual a cor ##
		lb t3, 0(t0)
		#sb t5, 0(t6)
		beq t3, a3, ENCONTROU_ESCADA
		
		## verifica quebra de linha ##
		addi t1, t1, -1
		addi t0, t0, 1
		#addi t6, t6, 1
		bne t1, zero, NAO_QUEBRA_LINHA
		## se ja alcancou largura da image, quebra linha ##
		addi t0, t0, 320
		lw t1, 0(a0)
		sub t0, t0, t1
		#addi t6, t6, 320
		#sub t6, t6, t1
		addi t2, t2, -1	# contador de linhas --
NAO_QUEBRA_LINHA: nop
		jal zero, FOR1_VERIFICAR_ESCADA

EXIT_FOR1_VERIFICAR_ESCADA: nop
		li a0, 0
		ret
ENCONTROU_ESCADA: nop
		li a0, 1
		ret
#######################
