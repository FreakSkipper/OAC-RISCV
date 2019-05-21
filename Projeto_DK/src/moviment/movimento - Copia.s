.data
.include "..\..\images\mapa2.s"
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
	
	Objetos: .word 	mola,0,0,3,1,1,0, barril1,120,0,3,1,0,0, elevador,130,0,3,1,2,0
					
	mensagem: .string "Escreva um numero para mover diferente de zero\n"
.text

MAIN: nop
	addi sp, sp, -4
	sw ra, 0(sp)
	
	
	jal ra, CRIAR_MAPA

	la a0, Objetos 			# vetor contendo objetos
	li a1, 3				# quantidade objetos
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
	li a1, 2				# quantidade objetos
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
	la s0, mapa2 		# imagem
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
	la t5, mapa2 			# vetor contendo o mapa
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
	addi sp, sp, -20# inicia pilha
	sw ra, 0(sp)	# salva retorno
	
	## inicia loop for -> percorrer vetor objetos de acordo com quantidade ##
FOR1_MOVER_OBJETOS: nop
		beq t1, zero, EXIT_FOR1_MOVER_OBJETOS	# if ( i == 0 )
		
		lw t2, 20(t0)	# le o tipo do objeto
		beq t2, zero, MOVER_BARRIL
		
		li t3, 1
		beq t2, t3, MOVER_MOLA
		
		li t3, 2
		#beq t2, t3, MOVER_ELEVADOR
		
		jal zero, PULAR_MOVIMENTO
VOLTA_MOVER_BARRIL: nop
		## iniciando pilhagem para chamada de funcao ##
		sw t0, 4(sp)	# salva o endereco onde estao os objetos
		sw t1, 8(sp)	# salva o contador de interacoes
		sw t2, 12(sp)	# salva o novo X
		sw t5, 16(sp)	# salva o novo Y
		
		lw a0, 0(t0)		# imagem[]
		lw a1, 4(t0)		# posicao X
		lw a2, 8(t0)		# posicao Y
		
		jal ra, APAGAR_QUADRADO
		
		## pegando valores para chamada de funcao ##
		lw t0, 4(sp)
		lw a1, 12(sp)		# pega na pilha novo X
		sw a1, 4(t0)		# salva novo X no objeto
		
		lw a2, 16(sp)		# posicao Y	
		sw a2, 8(t0)		# salva novo Y no objeto
		
		lw a0, 0(t0)		# imagem[]
		
		li a3, 79
		jal ra, VERIFICAR_CHAO
		
		## pegando valores para chamada de funcao ##
		lw t0, 4(sp)		# struct objeto
		lw a2, 8(t0)		# posicao Y
		
		li t2, 1
		lw t3, 20(t0)
		bne t2, t3, NAO_SALTA
		bne a1, zero, INICIAR_SALTO
NAO_SALTA: nop
		bne a1, zero, PULA_GRAVIDADE_OBJETO
		lw t3, 24(t0)		# is_jumping ?
		bne t3, zero, PULA_GRAVIDADE_OBJETO # se for verdade ( is_jumping )
		addi a2, a2, 3		# seta gravidade
		sw a2, 8(t0)		# salva novo Y
PULA_GRAVIDADE_OBJETO: nop
		lw a0, 0(t0)		# imagem[]
		lw a1, 4(t0)		# le novo posicao X
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
	addi sp, sp, 20			# finaliza pilha
	
	ret
# --- funcoes para barril --- #
####### mover_barril(int imagem[], int x, int y, int velocidade, int direcao)
## move o barril
# a0 -> struct do barril
MOVER_BARRIL: nop
	la t2, barril1
	lw t3, 0(t0)
	beq t2, t3, ANIMACAO_MOV1_BARRIL
	la t2, barril2
	beq t2, t3, ANIMACAO_MOV2_BARRIL
	la t2, barril4
	beq t2, t3, ANIMACAO_MOV3_BARRIL
	
	la t2, barril1
VOLTA_ANIMACAO_BARRIL: nop
	sw t2, 0(t0)		# salva imagem
	## pegando e atualizando informacoes do objeto atual ##
	lw t2, 4(t0)		# posicao X
	lw t5, 8(t0)		# posicao Y
	lw t3, 12(t0)		# velocidade
	lw t4, 16(t0)		# direcao do objeto
	beq t4, zero, MOVER_ESQUERDA_BARRIL
	add t2, t2, t3		# proximo X ( direita )
	addi t4, zero, 310	# iniciar verificacao de fim de mapa
	blt t4, t2, MUDAR_DIRECAO_BARRIL
	jal zero, VOLTA_MOVER_BARRIL
MOVER_ESQUERDA_BARRIL: nop
	sub t2, t2, t3	# proximo x ( esquerda )
	addi t4, zero, 2	# iniciar verificacao de fim de mapa
	blt t4, t2, VOLTA_MOVER_BARRIL
	li t4, 1		# 1 = direita
	sw t4, 16(t0)	# alterna a direcao
	jal zero, PULAR_MOVIMENTO
MUDAR_DIRECAO_BARRIL: nop
	li t4, 0		# 0 = esquerda
	sw t4, 16(t0)	# alterna a direcao
	jal zero, PULAR_MOVIMENTO
ANIMACAO_MOV1_BARRIL: nop
	la t2, barril2	
	jal zero, VOLTA_ANIMACAO_BARRIL
ANIMACAO_MOV2_BARRIL: nop
	la t2, barril4
	jal zero, VOLTA_ANIMACAO_BARRIL
ANIMACAO_MOV3_BARRIL: nop
	la t2, barril3	
	jal zero, VOLTA_ANIMACAO_BARRIL
# --- funcoes para mola --- #
MOVER_MOLA: nop
	la t2, mola
	lw t3, 0(t0)
	beq t2, t3, ANIMACAO_MOV1_MOLA
	sw t2, 0(t0)
VOLTA_ANIMACAO_MOLA:nop
	## pegando e atualizando informacoes do objeto atual ##
	lw t2, 4(t0)		# posicao X
	lw t5, 8(t0)		# posicao Y
	lw t3, 12(t0)		# velocidade
	lw t4, 16(t0)		# direcao do objeto
	beq t4, zero, MOVER_BAIXO_MOLA
	
	lw t4, 24(t0)		# is_jumping ?
	beq t4, zero, PULA_JUMPING_MOLA
	addi t5, t5, -3		# move em Y ( salta )
	addi t4, t4, 1		# is_jumping = true

	slti t6, t4, 8
	bne t6, zero, PULA_JUMPING_MOLA	# if ( is_jumping >= 6 )
	li t4, 0			# is_jumping = false
PULA_JUMPING_MOLA: nop
	sw t4, 24(t0)		# is_jumping salvo
	add t2, t2, t3		# proximo X ( direita )
	addi t4, zero, 260	# iniciar verificacao de fim de mapa
	blt t4, t2, MUDAR_DIRECAO_BARRIL
	jal zero, VOLTA_MOVER_BARRIL
MOVER_BAIXO_MOLA: nop
	add t5, t5, t3	# move para baixo

	addi t4, zero, 220	# iniciar verificacao de fim de mapa
	blt t5, t4, VOLTA_MOVER_BARRIL
	jal zero, PULAR_MOVIMENTO
INICIAR_SALTO: nop
	li t2, 1
	sw t2, 24(t0)	# is_jumping = true
	jal zero, NAO_SALTA
ANIMACAO_MOV1_MOLA: nop
	la t2, mola1
	sw t2, 0(t0)
	jal zero, VOLTA_ANIMACAO_MOLA
	
##############################

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
	la t1, mapa2		# endereço inicial do mapa
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
