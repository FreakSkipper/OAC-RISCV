.data
.include "..\..\..\images\maca.s"
.include "..\..\..\images\yoshi_menu.s"
	ResumeGame: .string "Resume Game"
	ProximoMapa: .string "Proximo Mapa"
	ResetLevel: .string "Reset Level"
	Quit: .string "Quit Game"
	Selected: .byte 1
.text

MENU_JOGO: nop
	#### SAVE FRAME ATUAL ####
	li t0, 0xFF200604
	lw s0, 0(t0)
	li t1, 0
	sw t1, 0(t0)
	###########################
	
	####### CRIAR BACKGROUND ###########
	mv s2, ra
	li a0, 1
	jal ra, BACKGROUND_MENU
	####################################
	
	## FPS MENU ##
	li a7, 130
	ecall
	li t1, 66
	add s10, a0, t1
	##############
	
	######### PARAR JOGO NO MENU ################
	####### AGUARDA SELECIONAR ITEM ###########
	LOOP_SELECT_MENU: nop
	
	la t0, CONTROLE
	jalr ra, t0, 0
	
	li a7, 130
	ecall

	blt a0, s10, LOOP_SELECT_MENU
	
	######## CONTROLE ADC ##########
	la t0, Controle_y	# Direcao Y
	lb t2, 0(t0)		# up?
	la t0, Controle_sw
	lb t3, 0(t0)
	################################
	
	la t5, Selected
	lb t0, 0(t5)	# le valor selecionado
	
	bne t3, zero, SELECIONOU_MENU
	
	######### VERIFICA SE MOVEU SELECAO ################
	li t4, -1
	beq t2, t4, CONTINUA_MENU
	bgt t2, zero, DESCER_MENU
	blt t2, zero, SUBIR_MENU
	jal zero, CONTINUA_MENU
	##################################################
	
	########## MOVEU PARA CIMA ############
	SUBIR_MENU: nop
	addi t0, t0, -1
	bne t0, zero, CONTINUA_MENU
	li t0, 1
	jal zero CONTINUA_MENU
	########################################
	
	######### MOVEU PARA BAIXO ############
	DESCER_MENU: nop
	addi t0, t0, 1
	mv s9, t0
	
	la t0, SOUND_BOTAO
	jalr ra, t0, 0
	
	mv t0, s9
	
	li t1, 5
	bne t0, t1, CONTINUA_MENU
	li t0, 4
	########################################
	
	######### ITENS MENU ###################
	CONTINUA_MENU: nop
	la t5, Selected
	sb t0, 0(t5)
	
	#### ATRIBUICOES GERAIS #####
	li a7, 104
	li a1, 130
	li a4, 0

	#### RESUME GAME ####
	la a0, ResumeGame
	li a2, 95
	li t1, 1
	beq t0, t1, SELECTED1
	li a3, 0x2700
	jal zero, NOT_1
	SELECTED1: li a3,0x2F07
	NOT_1:	ecall
	
	#### NEXT MAP #####
	la a0, ProximoMapa
	li a2, 110
	li t1, 2
	beq t0, t1, SELECTED2
	li a3, 0x2700
	jal zero, NOT_2
	SELECTED2: li a3,0x2F07
	NOT_2:	ecall
	
	#### RESET LEVEL ####
	la a0, ResetLevel
	li a2, 125
	li t1, 3
	beq t0, t1, SELECTED3
	li a3, 0x2700
	jal zero, NOT_3
	SELECTED3: li a3,0x2F07
	NOT_3:	ecall
	
	#### QUIT GAME ######
	la a0, Quit
	li a2, 140
	li t1, 4
	beq t0, t1, SELECTED4
	li a3, 0x2700 #00 101 111
	jal zero, NOT_4
	SELECTED4: li a3, 0x2F07
	NOT_4:	ecall
	#####################
	
	## FPS MENU ##
	li a7, 130
	ecall
	li t1, 66
	add s10, a0, t1
	##############
	
	##### REPETE ATE SELECIONAR ALGO #####
	jal zero, LOOP_SELECT_MENU
	
	SELECIONOU_MENU: nop
	
	######## APOS SELECIONAR ALGO ############
	
	li a0, 0
	jal ra, BACKGROUND_MENU
	
	la t0, Selected
	lb t0, 0(t0)
	
	li t1, 1
	beq t0, t1, RESUME_GAME
	li t1, 2
	beq t0, t1, NEXT_MAP
	li t1, 3
	beq t0, t1, RESET_MAP
	li t1, 4
	beq t0, t1, QUIT_GAME
	
	RESUME_GAME: nop
	#### RETORNA FRAME ATUAL ####
	li t0, 0xFF200604
	sw s0, 0(t0)
	###########################
	ENCERRA_MENU: nop
	
	mv ra, s2
	ret
NEXT_MAP: nop
	la t0, PROXIMO_MAPA
	jalr ra, t0, 0
	
	jal zero, ENCERRA_MENU
RESET_MAP: nop
	la t0, RESETAR_OBJETOS
	jalr ra, t0, 0
	la t0, RESETAR_FASE
	jalr ra, t0, 0
	jal zero, RESUME_GAME
QUIT_GAME: nop
	la t0, APAGAR_MAPA
	jalr ra, t0, 0
	li a7, 10
	ecall
#######################################

###### BACKGROUND DO MENU #######
## fundo do menu
# a0 -> flag open ( 0 - close, 1 - open )
BACKGROUND_MENU: nop
	addi sp, sp, -8
	sw ra, 0(sp)
	
	mv s3, a0
	
	#### FRAME A ABRIR MENU ####
	li t0, 0xFF000000
	###########################
	
	#### MAPA ####
	la t5, mapa
	addi t5, t5, 8
	#############
	
	############# COORDENADAS ############
	li t2, 110		# posicao X no display
	li t3, 120		# posicao Y no display
	#######################################
	
	#### ENCONTRANDO POSICAO EXATA ####
	li t4, 320
	mul t3, t3, t4	# 320 * y
	add t2, t2, t3	# 320 * y + x
	add t0, t0, t2	# 320 * y + x + End.Inicial
	addi t1, t0, 320# linha abaixo do final
	add t5, t5, t2
	addi t6, t5, 320
	##################################
	
	##### DIMENSOES DO MENU #####
	li t2, 130	# largura
	li t3, 40	# altura
	mv s1, t2	# salva largura
	#############################
	
	####### DESENHAR LINHA ############
	FOR1_MENU_JOGO: nop
		beq t3, zero, EXIT_FOR1_MENU_JOGO
		
		#### PINTA PIXEL ####
		beq s3, zero, FECHANDO_MENU
		
		li t4, 0x27# 00 100 111
		sb t4, 0(t0)
		sb t4, 0(t1)
		jal zero, PINTOU_MENU
		
		FECHANDO_MENU: nop
		lb t4, 0(t5)
		sb t4, 0(t0)
		lb t4, 0(t6)
		sb t4, 0(t1)		
		
		PINTOU_MENU: nop
		addi t0, t0, 1	# proximo pixel para cima
		addi t1, t1, 1	# proximo pixel para baixo
		addi t5, t5, 1	# proximo pixel para cima
		addi t6, t6, 1	# proximo pixel para baixo
		addi t2, t2, -1	# largura--
		
		bne t2, zero, FOR1_MENU_JOGO
		
		mv t2, s1	# reset largura
		
		addi t0, t0, -320	# sobe uma linha
		sub t0, t0, t2		# ajusta erro de largura
		
		addi t1, t1, 320	# desce uma linha
		sub t1, t1, t2		# ajusta erro de largura
		
		addi t5, t5, -320	# sobe uma linha
		sub t5, t5, t2		# ajusta erro de largura
		
		addi t6, t6, 320	# desce uma linha
		sub t6, t6, t2		# ajusta erro de largura
		
		addi t3, t3, -1		# altura --
		
		### WAIT ###
		li a7, 32
		li a0, 10
		ecall
		
		jal zero, FOR1_MENU_JOGO
	EXIT_FOR1_MENU_JOGO: nop
	######################################
	
	#### TROCA FRAME FRAME ATUAL ####
	li t0, 0xFF200604
	li t1, 1
	sw t1, 0(t0)
	
	la t0, Frame_Desenhar
	lw t1, 0(t0)
	sw t1, 4(sp)
	li t1, 0xFF000000
	sw t1, 0(t0)
	###########################
	
	#### FRAME A ABRIR MENU ####
	li t0, 0xFF000000
	###########################
	
	#### MAPA ####
	la t5, mapa
	addi t5, t5, 8
	#############
	
	############# COORDENADAS ############
	li t2, 110		# posicao X no display
	li t3, 120		# posicao Y no display
	#######################################
	
	#### ENCONTRANDO POSICAO EXATA ####
	li t4, 320
	mul t3, t3, t4	# 320 * y
	add t2, t2, t3	# 320 * y + x
	add t0, t0, t2	# 320 * y + x + End.Inicial
	add t5, t5, t2	# mapa position
	##################################
	mv a3, s3
	la t6, DESENHAR_QUADRADO
	la a0, maca
	li a1, 105
	li a2, 70
	li a4, 1
	li a5, 8
	la s5, CRIAR_QUADRADO
	jalr ra, t6, 0
	
	li a4, 0
	li a5, 11
	la t6, DESENHAR_QUADRADO
	jalr ra, t6, 0
	
	li a1, 235
	li a2, 70
	li a4, 1
	li a5, 8
	la t6, DESENHAR_QUADRADO
	jalr ra, t6, 0
	
	la a0, yoshi_menu
	li a1, 165
	li a2, 68
	li a4, 1
	li a5, 8
	jalr ra, s5, 0
	
	#### TROCA FRAME FRAME ATUAL ####
	li t0, 0xFF200604
	li t1, 0
	sw t1, 0(t0)
	
	la t0, Frame_Desenhar
	lw t1, 4(sp)
	sw t1, 0(t0)
	###########################
	
	lw ra, 0(sp)
	addi sp, sp, 8
	
	ret
########################################################
