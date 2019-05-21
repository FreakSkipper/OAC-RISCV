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
#		is_jumping
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
	Personagens: .word princesa, 0, 200, 0, mario, 160, 36,0
	
	Objetos: .word 	mola,0,20,3,1,1,0, barril1,120,0,3,1,0,0, mola,20,20,3,1,1,0, mola,40,20,3,1,1,0, barril1,0,125,3,1,0,0
					
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
		
		addi t0, t0, 16
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

		## CHAMA MOVER __ OBJETO ## 
		lw t0, 4(sp)	# struct
		lw a0, 0(t0)		# imagem[]
		lw a1, 4(t0)		# posicao X
		lw a2, 8(t0)		# posicao Y
		lw a3, 12(t0)		# velocidade
		lw a4, 16(t0)		# direcao
		
		lw t2, 20(t0)	# le o tipo do objeto
		bne t2, zero, PULA_BARRIL
		jal ra, MOVER_BARRIL	
PULA_BARRIL: nop

		li t3, 1
		bne t2, t3, PULA_MOLA

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
		#jal ra, MOVER_MOLA
PULA_MOLA: nop
		## Salvar novas informacoes ## 
		lw t0, 4(sp)	# struct
		sw a0, 0(t0)		# imagem[]
		sw a1, 4(t0)		# posicao X
		sw a2, 8(t0)		# posicao Y
		sw a3, 16(t0)		# direcao
		
		## chama VERIFICAR CHAO ##
		lw t0, 4(sp)	# struct
		li a3, 79
		jal ra, VERIFICAR_CHAO
		
		## pega posicao Y para verificacao de gravidade ##
		lw t0, 4(sp)	# struct
		lw t2, 8(t0)	# posicao Y
		
		## verifica se objeto esta no chao ##
		bne a1, zero, PULAR_GRAVITY_OBJETO # if( in_ground )
		
		## se nao estiver no chao, seta gravidade ##
		addi t2, t2, 2	# gravidade em 1 unidade
		sw t2, 8(t0)	# salva posicao Y atualizada
		
PULAR_GRAVITY_OBJETO: nop
		
		## CHAMA CRIAR QUADRADO ## 
		lw t0, 4(sp)	# struct
		lw a0, 0(t0)		# imagem[]
		lw a1, 4(t0)		# posicao X
		mv a2, t2			# posicao Y
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
	
PULAR_ANIMACAO_BARRIL: nop

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
	ret
MOVER_ESQUERDA_BARRIL: nop
	## movendo para esquerda ##
	sub a1, a1, a3	# proximo x ( esquerda )
	addi a3, a4, 0		# a3 = a4 ( retorno de direcao )
	
	## se bater no fim do mapa esquerda ##
	addi t2, zero, 2	# iniciar verificacao de fim de mapa
	blt t2, a1, PULA_MUDAR_DIRECAO
	
	li a3, 1		# 1 = direita
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
## direcao = 0 move para esquerda
## direcao = 1 move para direita
## direcao = 2 move para cima
## direcao = 3 move para baixo
# a0 -> direcao
# a1 -> struct do personagem
MOVER_PERSONAGEM: nop
	addi sp, sp, -4	# inicia pilha
	sw ra, 0(sp)	# salva ra
	
	addi t0, a1, 0	# t0 = a1
	
	## salvando em pilha para chamada de funcao ## 
	addi sp, sp, -8
	sw a0, 0(sp)
	sw t0, 4(sp)
	
	lw a0, 0(t0)	# imagem[] do personagem
	lw a1, 4(t0)	# posicao X
	lw a2, 8(t0)	# posicao Y

	jal ra, APAGAR_QUADRADO

	## retornando valores salvos ##
	lw a0, 0(sp)
	lw t0, 4(sp)	
	addi sp, sp, 8

	li t1, 'd'
	beq a0, t1, MOVER_PERSONAGEM_DIREITA
	
	li t1, 'a'
	beq a0, t1, MOVER_PERSONAGEM_ESQUERDA
	
	li t1, 'w'
	beq a0, t1, MOVER_PERSONAGEM_CIMA
	
	li t1, 's'
	beq a0, t1, MOVER_PERSONAGEM_BAIXO
	
VOLTAR_MOVER: nop
	## salvando em pilha para chamada de funcao ## 
	addi sp, sp, -4
	sw t0, 0(sp)
	
	## prepara para entrar em funcao ## 
	lw a0, 0(t0)	# imagem[] do personagem
	lw a1, 4(t0)	# posicao X
	lw a2, 8(t0)	# posicao Y
	li a3, 79
	jal ra, VERIFICAR_CHAO
	
	## retornando valores salvos ##
	lw t0,0(sp)
	addi sp, sp, 4

	## se estiver normalizado no chao
	beq a0, zero, PULAR_AJUSTE_BUG
	
	lw t1, 8(t0)	# posicao Y
	addi t1, t1, -1	# ajusta em -1
	sw t1, 8(t0)	# salva novo Y
	
PULAR_AJUSTE_BUG: nop
	lw t1, 12(t0)	# verifica se personagem ta pulando
	bne t1, zero, IN_JUMPING
	
	## se estiver normalizado no chao
	bne a0, zero, PULAR_AJUSTE_GRAVITY
	bne a1, zero, PULAR_AJUSTE_GRAVITY
	
	lw t1, 8(t0)	# posicao Y
	addi t1, t1, 1	# ajusta em 1
	sw t1, 8(t0)	# salva novo Y
	
PULAR_AJUSTE_GRAVITY: nop

	## prepara para entrar em funcao ## 
	lw a0, 0(t0)	# imagem[] do personagem
	lw a1, 4(t0)	# posicao X
	lw a2, 8(t0)	# posicao Y
	jal ra, CRIAR_QUADRADO

	## prepara retorno de funcao ## 
	lw ra, 0(sp)	# le ra
	addi sp, sp, 4	# encerra pilha

	ret
MOVER_PERSONAGEM_DIREITA: nop
	lw t1, 4(t0)
	addi t1, t1, 4
	
	li t2, 310
	blt t2, t1, VOLTAR_MOVER
	
	sw t1, 4(t0)
	jal zero, VOLTAR_MOVER
MOVER_PERSONAGEM_ESQUERDA: nop
	lw t1, 4(t0)
	addi t1, t1, -4
	
	li t2, 1
	blt t1, t2, VOLTAR_MOVER
	
	sw t1, 4(t0)
	jal zero, VOLTAR_MOVER
MOVER_PERSONAGEM_CIMA: nop
	li t1, 1
	sw t1, 12(t0)	# is_jumping = true
	
	jal zero, VOLTAR_MOVER
MOVER_PERSONAGEM_BAIXO: nop
	jal zero, VOLTAR_MOVER
	
IN_JUMPING: nop
	lw t2, 8(t0)	# posicao Y
	addi t2, t2, -1	# ajusta em -1
	sw t2, 8(t0)	# salva novo Y
	
	addi t1, t1, 1	# quantidade de saltos
	sw t1, 12(t0)	# salva numero do salto
	li t2, 16		# maximo de saltos
	bne t1, t2, PULAR_AJUSTE_GRAVITY
	li t1, 0
	sw t1, 12(t0)	# IN_JUMPING = false (0)
	jal zero, PULAR_AJUSTE_GRAVITY
########################

####### bool verificar_chao(imagem[], int x, int y, int cor)
## verifica se a imagem toca o chao
# a0 -> vetor imagem
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> cor do chao
VERIFICAR_CHAO: nop
	### achando a posicao no display para desenhar ##
	li t0, 320
	mul t0, t0, a2		# 320 * y
	add t0, t0, a1		# 320 * y + x
	la t1, mapa		# endereço inicial do mapa
	addi t1, t1, 8
	add t0, t0, t1		# 320*y + x + end.Inicial


	## atribuicoes da imagem ##
	lw t1, 4(a0)			# altura da imagem
	li t2, 320				# 320
	addi t1, t1, -1			# subtrai altura por 1
	mul t1, t1, t2			# 320 * (altura - 1)
	add t0, t0, t1			# vai para a linha em questao
	
	lw t2, 0(a0)			# largura da imagem
	addi t3, t2, 0			# salva largura
FOR1_VERIFICAR_CHAO: nop
		beq t2, zero, EXIT_FOR1_VERIFICAR_CHAO
		lb t1, 0(t0)	# le o byte do mapa

		beq t1, a3, ENCONTROU_CHAO
		addi t0, t0, 1	# proximo byte do mapa
		addi t2, t2, -1	# contador largura --	
		jal zero, FOR1_VERIFICAR_CHAO
EXIT_FOR1_VERIFICAR_CHAO: nop
	li a0, 0
	sub t0, t0, t3		# retora t0 ao original
	addi t0, t0, 320	# vai para a ultima linha
FOR2_VERIFICAR_CHAO: nop
		beq t3, zero, EXIT_FOR2_VERIFICAR_CHAO
		lb t1, 0(t0)	# le o byte do mapa		
		beq t1, a3, ENCONTROU_CHAO2
		addi t0, t0, 1	# proximo byte do mapa
		addi t3, t3, -1	# contador largura --	
		jal zero, FOR2_VERIFICAR_CHAO
EXIT_FOR2_VERIFICAR_CHAO: nop
	li a1, 0
	ret
ENCONTROU_CHAO: nop
	li a0, 1
	sub t0, t0, t3		# retora t0 ao original
	addi t0, t0, 320	# vai para a ultima linha
	jal zero, FOR2_VERIFICAR_CHAO
ENCONTROU_CHAO2: nop
	li a1, 1
	ret
	
#######################
