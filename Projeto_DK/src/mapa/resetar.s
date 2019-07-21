
.text
RESETAR_FASE: nop
	mv s4, ra
	
	la t0, Bonus
	li t1, 5000
	sb t1, 0(t0)
	
	la t0, Kong_Sinalizou
	sb zero, 0(t0)
	
	la t0, Kong_Chamas
	sb zero, 0(t0)
	
	la t0, RESETAR_PARTICULAS
	jalr ra, t0, 0
	
	la t0, AtivarAnimacao
	sb zero, 0(t0)
	
	### STRUCTS ###
	la t1, Personagens
	###############
	la t3, Fase
	lb t3, 0(t3)

	##### MARIO RESET #####
	la t2, mario_idle_left
	sw t2, 0(t1)
	
	li t4, 2
	beq t3, t4, POS_MARIO_3
	li t4, 3
	beq t3, t4, POS_MARIO_4			
	li t4, 4
	beq t3, t4, POS_MARIO_5
	li t2, 50
	li t5, 210
	jal zero, SALVAR_POS_MARIO
	POS_MARIO_3: nop
	li t2, 12
	li t5, 200
	jal zero, SALVAR_POS_MARIO
	POS_MARIO_4: nop
	la t2, princesa_idle_left
	sw t2, 0(t1)	
	li t2, 18
	li t5, 0
	jal zero, SALVAR_POS_MARIO	
	POS_MARIO_5: nop
	la t2, princesa_idle_left
	sw t2, 0(t1)		
	li t2, 8
	li t5, 160
	SALVAR_POS_MARIO: nop
	sw t2, 4(t1)
	sw t5, 8(t1)
	li t2, 0
	sw t2, 12(t1)
	li t2, 0
	sw t2, 16(t1)
	addi t1, t1, 20
	#######################
	
	##### OIL RESET ######	
	la t2, oil_1
	sw t2, 0(t1)
	
	li t4, 1
	beq t3, t4, COORD_OIL_2
	li t2, 10
	li t5, 198
	jal zero, CONT_OIL_RESET
	COORD_OIL_2: nop
	li t2, 153
	li t5, 90
	CONT_OIL_RESET: nop
	sw t2, 4(t1)
	sw t5, 8(t1)
	li t2, 0
	sw t2, 12(t1)
	li t2, 0
	sw t2, 16(t1)

	addi t1, t1, 20
	########################
	
	####### KONG RESET ########
	la t2, kong_left
	sw t2, 0(t1)
	li t2, 30
	sw t2, 4(t1)
	li t2, 28
	sw t2, 8(t1)
	li t2, 0
	sw t2, 12(t1)
	li t2, 0
	sw t2, 16(t1)
	addi t1, t1, 20
	###########################
	
	######### PRINCESA RESET ########
	la t2, princesa_idle_left
	sw t2, 0(t1)
	li t2, 150
	sw t2, 4(t1)
	li t2, 0
	sw t2, 8(t1)
	li t2, 0
	sw t2, 12(t1)
	li t2, 0
	sw t2, 16(t1)
	###################################
	
	######## CHAO RESET E OBJETOS ##########
	
	## CHAO FASE 1 e 3 ##
	la t1, Chao
	li t2, 79
	sb t2, 0(t1)
	li t2, 79
	sb t2, 1(t1)
	li t2, 79
	sb t2, 2(t1)
	li t2, 79
	sb t2, 3(t1)
	li t2, 79
	sb t2, 4(t1)
	li t2, 79
	sb t2, 5(t1)
	
	beq t3, zero, CRIAR_ITENS_MAPA1
	li t2, 1
	beq t3, t2, CRIAR_FOGO_MAPA_2
	li t2, 2
	beq t3, t2, CRIAR_FOGO_MAPA_3
	li t2, 3
	beq t3, t2, CRIAR_OBJ_MAPA_4
	li t2, 4
	beq t3, t2, DEFINIR_MAPA_5
	jal zero, NAO_CRIAR_FOGO
	
	### ITENS FASE 1 ###
	CRIAR_ITENS_MAPA1: nop
	
	li a0, 8
	li a1, 20 # 130
	li a2, 80 # 75
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	li a0, 8
	li a1, 50 # 130
	li a2, 140 # 75
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	jal zero, NAO_CRIAR_FOGO
	
	## FOGO FASE 2 ##
	CRIAR_FOGO_MAPA_2: nop
	li a0, 1
	li a1, 130 # 130
	li a2, 75 # 75
	li a3, 0
	jal ra, CRIAR_OBJETO
	
	li a0, 8
	li a1, 20 # 130
	li a2, 120 # 75
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	li a0, 8
	li a1, 160 # 130
	li a2, 160 # 75
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	li a0, 9
	li a1, 110 # 130
	li a2, 140 # 75
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	li a0, 10
	li a1, 160 # 130
	li a2, 220 # 75
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	li a0, 11
	li a1, 290 # 130
	li a2, 132 # 75
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	### CHAO FASE 2 ###
	la t1, Chao
	li t2, 47
	sb t2, 0(t1)
	li t2, 15
	sb t2, 1(t1)
	li t2, 47
	sb t2, 2(t1)
	li t2, 15
	sb t2, 3(t1)
	li t2, 47
	sb t2, 4(t1)
	li t2, 15
	sb t2, 5(t1)
	
	jal zero, NAO_CRIAR_FOGO
	CRIAR_FOGO_MAPA_3: nop
	li a0, 1
	li a1, 300 # 130
	li a2, 60 # 75
	li a3, 0
	jal ra, CRIAR_OBJETO
	
	li a1, 110 # 130
	li a2, 75 # 75
	jal ra, CRIAR_OBJETO
	
	li a0, 6
	li a1, 45 # 130
	li a2, 64 # 75
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	li a0, 6
	li a1, 135 # 130
	li a2, 64 # 75
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	jal zero, NAO_CRIAR_FOGO
	CRIAR_OBJ_MAPA_4: nop
	
	la t1, Chao
	li t2, 153
	sb t2, 0(t1)
	li t2, 145
	sb t2, 1(t1)
	li t2, 17
	sb t2, 2(t1)
	li t2, 41
	sb t2, 3(t1)
	li t2, 52
	sb t2, 4(t1)
	li t2, 24
	sb t2, 5(t1)
	
	li a0, 4
	li a1, 140 # 130
	li a2, 100 # 75
	li a3, 0
	jal ra, CRIAR_OBJETO
	
	li a1, 180 # 130
	li a2, 100 # 75
	li a3, 1
	jal ra, CRIAR_OBJETO
	
	li a1, 140 # 130
	li a2, 180 # 75
	li a3, 0
	jal ra, CRIAR_OBJETO
	
	li a1, 60 # 130
	li a2, 180 # 75
	jal ra, CRIAR_OBJETO
	
	li a0, 5
	li a1, 45
	li a2, 25 # 75
	li a3, -5
	li s6, 10
	
	FOR1_RESETAR_FASE: nop
		beq s6, zero, EXIT_FOR1_RESETAR_FASE
		addi a1, a1, 15 # 130	
		jal ra, CRIAR_OBJETO
		addi s6, s6, -1
		jal zero, FOR1_RESETAR_FASE
	EXIT_FOR1_RESETAR_FASE: nop
	
	li s6, 3
	li a1, 0
	li a2, 100 # 75
	
	FOR2_RESETAR_FASE: nop
		beq s6, zero, EXIT_FOR2_RESETAR_FASE
		addi a1, a1, 80 # 130	
		jal ra, CRIAR_OBJETO
		addi s6, s6, -1
		jal zero, FOR2_RESETAR_FASE
	EXIT_FOR2_RESETAR_FASE: nop
	
	li s6, 2
	li a1, 0
	li a2, 175 # 75
	
	FOR3_RESETAR_FASE: nop
		beq s6, zero, NAO_CRIAR_FOGO
		addi a1, a1, 80 # 130	
		jal ra, CRIAR_OBJETO
		addi s6, s6, -1
		jal zero, FOR3_RESETAR_FASE
	
	jal zero, NAO_CRIAR_FOGO
	
	DEFINIR_MAPA_5: nop
	
	la t1, Chao
	li t2, 103
	sb t2, 0(t1)
	li t2, 22
	sb t2, 1(t1)
	li t2, 17
	sb t2, 2(t1)
	li t2, 41
	sb t2, 3(t1)
	li t2, 52
	sb t2, 4(t1)
	li t2, 24
	sb t2, 5(t1)
	
	
	NAO_CRIAR_FOGO: nop
	
	#########################################
	
	la t0, Morto
	li t1, 0
	sb t1, 0(t0)
	
	mv ra, s4
	
	ret
##############################
### CRIAR OBJETO
## cria um objeto
# a0 -> tipo objeto
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> direcao
CRIAR_OBJETO: nop
	la t0, Objetos
	li t1, 20
	
	FOR1_CRIAR_OBJETO: nop
		beq t1, zero, EXIT_FOR1_CRIAR_OBJETO
		
		lw t2, 0(t0)
		beq t2, zero, ADICIONAR_OBJETO
		
		addi t0, t0, 28
		addi t1, t1, -1
		jal zero, FOR1_CRIAR_OBJETO
		EXIT_FOR1_CRIAR_OBJETO: nop
	ret
ADICIONAR_OBJETO: nop
	beq a0, zero, ADD_BARRIL
	li t1, 1
	beq a0, t1, ADD_FOGO
	li t1, 2
	beq a0, t1, ADD_TORTA
	li t1, 3
	beq a0, t1, ADD_MOLA
	li t1, 4
	beq a0, t1, ADD_TARTAGURA
	li t1, 5
	beq a0, t1, ADD_MOEDA
	li t1, 6
	beq a0, t1, ADD_SAIDA_ELEVADOR
	li t1, 7
	beq a0, t1, ADD_ELEVADOR
	li t1, 8
	beq a0, t1, ADD_AK47
	li t1, 9
	beq a0, t1, ADD_CHAPEU
	li t1, 10
	beq a0, t1, ADD_CHAVE
	li t1, 11
	beq a0, t1, ADD_YOSHI
	li t1, 12
	beq a0, t1, ADD_FOGO_BOWSER
	li t1, 13
	beq a0, t1, ADD_BOWSER
	ret
	
	ADD_BARRIL: nop
	la t1, barril1
	li t2, 6
	li t4, 0
	
	jal zero,ENCERRAR_ADICIONAR_OBJETO
	ADD_FOGO: nop
	bne a3, zero, FOG_DIR
	la t1, foguinho1_left
	jal zero, CONT_FOG
	FOG_DIR: nop
	la t1, foguinho1_left
	CONT_FOG: nop
	li t2, 4
	li t4, 50

	jal zero,ENCERRAR_ADICIONAR_OBJETO
	
	ADD_TORTA: nop
	la t1, torta
	li t2, 0
	li t4, 0
	
	jal zero,ENCERRAR_ADICIONAR_OBJETO
	
	ADD_MOLA: nop
	la t1, mola
	li t2, 6
	li t4, 0
	
	jal zero,ENCERRAR_ADICIONAR_OBJETO
	
	ADD_MOEDA: nop
	la t1, moeda2_costa
	li t2, 0
	li t4, -5
	
	jal zero,ENCERRAR_ADICIONAR_OBJETO
	
	ADD_TARTAGURA: nop
	bne a3, zero, TART_DIREITA
	la t1, tartagura1_left
	jal zero, CONTINUAR_TART
	TART_DIREITA: nop
	la t1, tartagura1_left
	CONTINUAR_TART: nop
	li t2, 4
	li t4, 10
	
	jal zero,ENCERRAR_ADICIONAR_OBJETO
	
	ADD_SAIDA_ELEVADOR: nop
	la t1, saida_elevador_cima
	li t2, 0
	li t4, 20
	
	jal zero,ENCERRAR_ADICIONAR_OBJETO
	
	ADD_ELEVADOR: nop
	la t1, elevador
	li t2, 0
	li t4, 0
	
	jal zero, ENCERRAR_ADICIONAR_OBJETO
	
	ADD_AK47: nop
	la t1, ak47
	li t2, 0
	li t4, 0
	
	jal zero, ENCERRAR_ADICIONAR_OBJETO
	
	ADD_CHAPEU: nop
	la t1, chapeu_mario
	li t2, 0
	li t4, 0
	
	jal zero, ENCERRAR_ADICIONAR_OBJETO
	
	ADD_CHAVE: nop
	la t1, chave_fenda
	li t2, 0
	li t4, 0
	
	jal zero, ENCERRAR_ADICIONAR_OBJETO	
	
	ADD_YOSHI: nop
	la t1, yoshi_retrato
	li t2, 0
	li t4, 0
	
	jal zero, ENCERRAR_ADICIONAR_OBJETO		
	ADD_FOGO_BOWSER: nop
	la t1, chama1
	li t2, 0
	li t4, 0
	
	ADD_BOWSER: nop
	la t1, bowser_safado
	li t2, 0
	li t4, 0
	
	ENCERRAR_ADICIONAR_OBJETO: nop
	sw t1, 0(t0)
	sw a1, 4(t0)
	sw a2, 8(t0)
	sw t2, 12(t0)
	sw a3, 16(t0)
	sw a0, 20(t0)
	sw t4, 24(t0)
	
	la t1, Quantidade_Objetos
	lb t2, 0(t1)
	addi t2, t2, 1
	sb t2, 0(t1)
	
	ret
RESETAR_OBJETOS: nop
	### STRUCTS ###
	la t0, Objetos
	la t1, Personagens
	###############

	##### IGNORANDO MARIO #####
	addi t1, t1, 20
	##########################
	
	##### contadores #####
	li t2, 20
	li t3, 3
	######################
	
	############### DESTRUINDO OBJETOS E PERSONAGENS ########################
	FOR1_RESETAR_OBJETOS: nop
		beq t2, zero, EXIT_FOR1_RESETAR_OBJETOS
		
		li t4, 0
		sw t4, 0(t0)	# destroi objeto
		
		beq t3, zero, PULA_RESETAR_OBJETOS_PERSONAGENS
		
		sw t4, 0(t1)	# destroi personagem
		
		addi t1, t1, 20	# proximo personagem
		addi t3, t3, -1	# personagens--
		
		PULA_RESETAR_OBJETOS_PERSONAGENS: nop
		
		addi t0, t0, 28	# proximo objeto
		addi t2, t2, -1	# objetos --
		
		jal zero, FOR1_RESETAR_OBJETOS
	
	EXIT_FOR1_RESETAR_OBJETOS: nop
	##############################################################
	
	###### RESETANDO FLAGs ########
	li t4, 0
	la t0, Morreu
	sb t4, 0(t0)
	
	la t0, Quantidade_Objetos
	sb t4, 0(t0)
	##############################
	
	ret
