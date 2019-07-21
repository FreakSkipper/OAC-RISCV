.data
	Frame_Desenhar: .word 0xFF000000
	Morreu: .byte 0
	Morto: .byte 0
	Vidas: .byte 5
	Fase: .byte 1
	#Menu: .byte 1
	Chao: .byte 47,15,17,41,52,24
	ChangeMap: .byte 0
	TempoFrame: .word 0
.text

#### RODANDO_JOGO ####
## Roda o Jogo ##
RODANDO_JOGO: nop
	
	addi sp, sp, -4
	sw ra, 0(sp)

	li a7, 130
	ecall
	li t1, 33
	add t1, a0, t1
	la t2, TempoFrame
	sw t1, 0(t2)
	
	LOOP_GAME: nop
	
	li a7, 130
	ecall
	
	la t2, TempoFrame
	lw t1, 0(t2)
	
	blt a0, t1, LOOP_GAME
	
	### VERIFICA TROCA DE MAPA ###
	la t0, ChangeMap
	lb t1, 0(t0)
	beq t1, zero, NotChangeMap
	
	li t1, 0
	sb t1, 0(t0)
	
	la t0, PROXIMO_MAPA
	jalr ra, t0, 0
	
	#############################
	
	NotChangeMap: nop
	######## VERIFICA SOLICITACAO DE MENU ########
	######## CONTROLE ADC ##########
	la t0, Controle_sw	# End
	lb t0, 0(t0)		# botao adc

	################################
	beq t0, zero, MENU_FECHADO
	
	la t0, MENU_JOGO
	jalr ra, t0, 0	
	MENU_FECHADO: nop	
	##################################################

	##### RESET APOS MORTE ###########
	la t0, Personagens
	lw t0, 0(t0)
	la t1, mario_morte6
	beq t0, t1, ENCERRAR_MORTE
	la t1, princesa_morte6
	beq t0, t1, ENCERRAR_MORTE
	jal zero, CONTINUAR_LOOP_GAME
	
	ENCERRAR_MORTE: nop
	la t2, MUSICA_MORTE6
	jalr ra, t2, 0
	la t0, RESETAR_FASE
	jalr ra, t0, 0
	#################################
	
	CONTINUAR_LOOP_GAME: nop
	########## VERIFICA SE JOGADOR ESTA VIVO ############
	la t0, Morreu
	lb t0, 0(t0)
	beq t0, zero, CONTINUAR_JOGO
	##################################################
	
	###### ATRIBUICOES DE MORTE #######
	la t0, MORREU
	jalr ra, t0, 0
	####################################
	
	##### VERIFICACAO DE GAME OVER #####
	la t0, Vidas
	lb t0, 0(t0)
	
	blt t0, zero, ACABOU_VIDAS
	####################################
	
	######## GAME ################
	CONTINUAR_JOGO: nop
	jal ra, FRAME
	
	####### FPS ########
	li a7, 130
	ecall
	li t1, 33
	add t1, a0, t1
	la t2, TempoFrame
	sw t1, 0(t2)
	####################
	
	jal zero, LOOP_GAME
	#############################
	
	######## GAME OVER ############
	ACABOU_VIDAS: nop
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
	###############################
#####################

#### INICIAR JOGO ###
## Inicia o Jogo ##
INICIAR_JOGO: nop
	addi sp, sp, -4
	sw ra, 0(sp)
	####### RESETANDO VARIAVEIS #########
	la t0, Morreu
	li t1, 0
	sb t1, 0(t0)
	
	la t0, Morto
	sb t1, 0(t0)
	
	la t0, Vidas
	li t1, 5
	sb t1, 0(t0)
	
	la t0, Fase
	li t1, 0
	sb t1, 0(t0)
	#####################################
	
	######### RESETANDO OBJETOS E FASE ##########
	la t0, RESETAR_OBJETOS
	jalr ra, t0, 0
	
	la t0, RESETAR_FASE
	jalr ra, t0, 0
	############################################
	
	####### LIMPANDO DISPLAY E MAPA #######
	la t0, APAGAR_MAPA
	jalr ra, t0, 0
	######################################
	
	##### CRIANDO MAPA ########
	la t0, Frame_Desenhar
	la t1, mapa
	addi t1, t1, 8
	sw t1, 0(t0)
	
	la t0, CRIAR_MAPA
	jalr ra, t0, 0
	##########################
	
	####### DESENHANDO MAPA NOS DISPLAY ######
	li t0, 0xFF200604
	li t1, 0
	sw t1, 0(t0)
	
	la t0, Frame_Desenhar
	li t1, 0xFF000000
	sw t1, 0(t0)
	
	la t0, DESENHAR_MAPA
	jalr ra, t0, 0
	
	la t0, Frame_Desenhar
	li t1, 0xFF100000
	sw t1, 0(t0)
	
	la t0, DESENHAR_MAPA
	jalr ra, t0, 0
	##########################################
	
	la t0, RODANDO_JOGO
	jalr ra, t0, 0
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
#####################

#### FRAME ####
## Trata o frame atual ##
FRAME: nop
	addi sp, sp, -4	# inicia pilha
	sw ra, 0(sp)	# salva retorno
	
	##### VERIFICANDO SE JOGADOR ESTA MORTO ####
	la t0, Morto
	lb t0, 0(t0)
	beq t0, zero, JOGADOR_VIVO
	###########################################
	
	### FUNCOES QUANDO JOGADOR ESTA MORTO ###
	la t0, ANIM_MARIO_MORTO
	jalr ra, t0, 0	
	jal zero, JOGADOR_MORTO
	##########################################
	
	#### FUNCOES QUANDO JOGADOR ESTA VIVO ####
	JOGADOR_VIVO: nop
	la t0, AtivarAnimacao
	lb t1, 0(t0)
	li t2, 1
	bne t1, t2, FRAME_NORMAL
	
	la t0, Kong_Sinalizou
	lb t1, 0(t0)
	
	beq t1, zero, NAO_MUDAR_MAPA
	
	li a0, 7000
	li a7, 132
	ecall
	
	la t1, ChangeMap
	li t2, 1
	sb t2, 0(t1)
	
	NAO_MUDAR_MAPA: nop
	la t0, MOVER_KONG
	jalr ra, t0, 0
	
	la t0, MOVER_OBJETOS
	jalr ra, t0, 0
	
	la t0, DESENHAR_PRINCESA ##
	jalr ra, t0, 0
	
	jal zero, JOGADOR_MORTO
	FRAME_NORMAL: nop
	la t0, CONTROLE
	jalr ra, t0, 0
	
	la t0, MOVER_ESTEIRAS ##
	jalr ra, t0, 0
	
	la t0, MOVER_OBJETOS
	jalr ra, t0, 0

	la t0, MOVER_KONG
	jalr ra, t0, 0
	
	la t0, ANIM_OIL ##
	jalr ra, t0, 0
	
	la t0, MOVER_MARIO
	jalr ra, t0, 0
	
	la t0, DESENHAR_PRINCESA ##
	jalr ra, t0, 0
	
	la t0, DESENHAR_VIDAS ##
	jalr ra, t0, 0
	
	######## INICIAR ##########
	la t0, CRIAR_PARTICULA##
	jalr ra, t0, 0
	###########################
	
	la t0, DESENHAR_PARTICULAS ##
	jalr ra, t0, 0
	
	la t0, SCORE ##
	jalr ra, t0, 0
	###########################################
	
	JOGADOR_MORTO: nop
	#### FUNCOES DE FRAME #####
	la t0, TROCAR_FRAME
	jalr ra, t0, 0
	
	la t0, APAGAR_OBJETOS
	jalr ra, t0, 0
	
	la t0, APAGAR_PARTICULAS ##
	jalr ra, t0, 0
	
	la t0, COPIAR_OBJETOS
	jalr ra, t0, 0
	
	la t0, COPIAR_PARTICULAS ##
	jalr ra, t0, 0
	############################
	
	lw ra, 0(sp)	# pega ra
	addi sp, sp, 4	# encerra pilha
	ret				# retorna
#####################

######## Trocar Frame()
## Troca o Frame do display
TROCAR_FRAME: nop				
	li t0, 0xFF200604
	lw t1, 0(t0)
	
	beq t1, zero, FRAME_0
	
	li t3, 0xFF100000
	la t2, Frame_Desenhar
	sw t3, 0(t2)
	
	jal zero, ENCERRAR_TROCA_FRAME
	FRAME_0: nop
	li t3, 0xFF000000
	la t2, Frame_Desenhar
	sw t3, 0(t2)
	
	ENCERRAR_TROCA_FRAME: nop
	
	xori t1, t1, 1
	sw t1, 0(t0)
	ret
##################
