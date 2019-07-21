.data
.include "..\..\images\mario_idle_left.s"
#.include "..\..\images\mario_idle_right.s"
.include "..\..\images\mario_walk_left.s"
#.include "..\..\images\mario_walk_right.s"
.include "..\..\images\mario_run_left.s"
#.include "..\..\images\mario_run_right.s"
.include "..\..\images\mario_jump1_left.s"
#.include "..\..\images\mario_jump1_right.s"
.include "..\..\images\mario_jump2_left.s"
#.include "..\..\images\mario_jump2_right.s"
.include "..\..\images\mario_jump3_left.s"
#.include "..\..\images\mario_jump3_right.s"
.include "..\..\images\mario_escada.s"
#.include "..\..\images\mario_escada2.s"
.include "..\..\images\mario_finish_escada1.s"
.include "..\..\images\mario_finish_escada2.s"
.include "..\..\images\mario_finish_escada3.s"
.include "..\..\images\mario_finish_escada4.s"
.include "..\..\images\mario_finish_escada5.s"
.include "..\..\images\princesa_idle_left.s"
#.include "..\..\images\princesa_idle_right.s"
.include "..\..\images\princesa_walk_left.s"
#.include "..\..\images\princesa_walk_right.s"
.include "..\..\images\princesa_run_left.s"
#.include "..\..\images\princesa_run_right.s"
.include "..\..\images\princesa_jump_left.s"
#.include "..\..\images\princesa_jump_right.s"
.include "..\..\images\princesa_escada.s"
#.include "..\..\images\princesa_escada2.s"
.include "..\..\images\princesa_finish_escada1.s"
.include "..\..\images\princesa_finish_escada2.s"
.include "..\..\images\princesa_finish_escada3.s"
.include "..\..\images\princesa_finish_escada4.s"
.include "..\..\images\princesa_finish_escada5.s"
.include "..\..\images\mario_martelinho_idle_left.s"
.include "..\..\images\mario_martelinho_walk_left.s"
.include "..\..\images\mario_martelinho_run_left.s"
.include "..\..\images\mario_martelinho_jump_left.s"


	Ultima_Direcao: .byte 1
	Tempo_Animacao: .word 0
	Armada: .byte 0
	Municao: .byte 0
	AtivarAnimacao: .byte 0
.text

#################### MOVIMENTO DO MARIO ###########################

MOVER_MARIO: nop
	##### SALVANDO RETORNO #####
	addi sp, sp, -12
	sw ra, 0(sp)
	############################
	la t0, Personagens
	lw a1, 4(t0)
	li t1, 175
	bge a1, t1, VERIFICAR_FIM_JOGO_MARIO
	
	NAO_INICIOU_CREDITOS: nop	

	la t1, Municao
	lb t1, 0(t1)
	beq t1, zero, RESET_ARMADA
	jal zero, CONTINUAR_M_M
	
	RESET_ARMADA: nop
	la t1, Armada
	li t2, 0
	sb t2, 0(t1)
	
	CONTINUAR_M_M: nop
	
	##### APLICANDO GRAVIDADE #####
	APLICACAO_GRAVIDADE: nop
	la a0, Personagens		# struct	
	lw t1, 8(a0)			# posicao Y inicial
	sw t1, 8(sp)			# salva para uso em escadas
	
	la t0, GRAVIDADE		# gravity
	jalr ra, t0, 0
	sw a0, 4(sp)			# on_ground ? 
	####### FIM GRAVIDADE ###############
	
	######## CONTROLE ADC ##########	
	la t0, Controle_x	# Direcao X
	lb t1, 0(t0)		# is_walking?
	la t0, Controle_y	# Direcao Y
	lb t2, 0(t0)		# up?
	#lw t3, 8(t0)
	################################
	
	###### STRUCT MARIO #######
	la t0, Personagens	# struct
	lw a0, 0(t0)		# imagem[]
	lw a1, 4(t0)		# posicao X
	lw a2, 8(t0)		# posicao Y
	lw t4, 12(t0)		# is_jumping?
	#############################
	
	###### VERIFICA FORCE SUBIDA #########
	lw t3, 16(t0)
	li t5, 2
	beq t3, t5, FORCE_SUBIDA_BARRA
	li t5, 3
	beq t3, t5, FORCE_DESCIDA_BARRA
	#####################################
	
	###### MOVER PARA OS LADOS ######
	bgt t1, zero, MOVE_MARIO_DIREITA
	li t3, -1
	blt t1, t3, MOVE_MARIO_ESQUERDA
	
	la t3, Ultima_Direcao
	lb a4, 0(t3)
	#################################
	
	##### MOVER PARA CIMA/BAIXO #####
	VOLTA_MOVIMENTO_X: nop
	bne t4, zero, MARIO_IS_JUMPING	# se is jumping, ignora
	
	bgt t2, zero, MOVE_MARIO_BAIXO
	li t3, -1
	blt t2, t3, MOVE_MARIO_CIMA
	################################
	
	VOLTA_MOVIMENTO_Y: nop
	
	##### ATUALIZANDO STRUCT ####
	la t0, Personagens
	sw a0, 0(t0)
	
	la t2, Fase
	lb t2, 0(t2)
	li t1, 3
	beq t2, t1, VERIFICA_CANO_MAPA4
	li t1, 4
	beq t2, t1, CONTINUA_JOGO_MOVER_MARIO
	li t1, 4
	bge a2, t1, CONTINUA_JOGO_MOVER_MARIO
	
	li t1, 2
	bne t1, t2, NAO_POE_ANIM_MAPA3
	
	li a0, 12
	li a1, 270
	li a2, 30
	li a3, -5
	la t0, CRIAR_OBJETO
	jalr ra, t0, 0
	
	li a0, 13
	li a1, 30
	li a2, 30
	li a3, 0
	la t0, CRIAR_OBJETO
	jalr ra, t0, 0
	
	###### STRUCT MARIO #######
	la t0, Personagens	# struct
	lw a0, 0(t0)		# imagem[]
	lw a1, 4(t0)		# posicao X
	lw a2, 8(t0)		# posicao Y
	
	la t1, AtivarAnimacao
	lb t2, 0(t1)
	bne t2, zero, CONTINUA_JOGO_MOVER_MARIO
	
	li t2, 1
	sb t2, 0(t1)
	jal zero, CONTINUA_JOGO_MOVER_MARIO
	
	NAO_POE_ANIM_MAPA3: nop
	la t1, ChangeMap
	li t2, 1
	sb t2, 0(t1)
	jal zero, CONTINUA_JOGO_MOVER_MARIO
	VERIFICA_CANO_MAPA4: nop
	li t2, 150
	bgt a2, t2, VERIFICAR_X_CANO
	jal zero ,CONTINUA_JOGO_MOVER_MARIO
	VERIFICAR_X_CANO: nop
	li t2, 235
	blt a1, t2, CONTINUA_JOGO_MOVER_MARIO
	la t1, ChangeMap
	li t2, 1
	sb t2, 0(t1)	
	CONTINUA_JOGO_MOVER_MARIO: nop
	
	######### VERIFICA FIM DE MAPA ############
	li t1, 300
	bgt a1, t1, FIM_MAPA_MARIO_RIGHT
	li t1, 2
	blt a1, t1, FIM_MAPA_MARIO_LEFT
	jal zero, CONTINUAR_VERIFICA_FIM_MAPA
	FIM_MAPA_MARIO_RIGHT: nop
	li a1, 300
	jal zero, CONTINUAR_VERIFICA_FIM_MAPA
	FIM_MAPA_MARIO_LEFT: nop
	li a1, 2
	CONTINUAR_VERIFICA_FIM_MAPA: nop
	############################################
	
	li t1, 2
	blt a2, t1, FIM_MAPA_MARIO_CIMA
	li t1, 215
	bgt a2, t1, FIM_MAPA_MARIO_BAIXO
	jal zero, SALVAR_INFOS_MARIO
	FIM_MAPA_MARIO_CIMA: nop
	li a2, 2
	jal zero, SALVAR_INFOS_MARIO
	FIM_MAPA_MARIO_BAIXO: nop
	li a2, 217	
	SALVAR_INFOS_MARIO: nop
	la t0, Personagens
	sw a1, 4(t0)
	sw a2, 8(t0)
	
	############################
	
	DESENHAR_MARIOO:nop
	##### DESENHANDO NO DISPLAY #####	
	la t0, CRIAR_QUADRADO
	li a3, 1	# desenhar
	jalr ra, t0, 0
	
	lw ra, 0(sp)
	addi sp, sp, 12
	#################################
	
	ret
#####################################

VERIFICAR_FIM_JOGO_MARIO: nop
	la t1, Fase
	lb t1, 0(t1)
	li t2, 4
	bne t1, t2, NAO_INICIOU_CREDITOS
	
	la t1, Personagens		# struct
	lw a0, 0(t1)
	lw a1, 4(t1)
	lw a2, 8(t1)
	li a4, 1
	li t2, 270
	bge a1, t2, FINALIZAR_JOGO
	
	li t2, 190
	blt a2, t2, DESCER_VARA
	addi a1, a1, 3
	sw a1, 4(t1)
	
	la t5, princesa_idle_left
	beq a0, t5, PRINCESA_WALK_LEFT_FIM
	la t5, princesa_walk_left
	beq a0, t5, PRINCESA_RUN_LEFT_FIM
	la a0, princesa_idle_left
	jal zero, VOLTA_FIM_X
	PRINCESA_WALK_LEFT_FIM: nop
	la a0, princesa_walk_left
	jal zero, VOLTA_FIM_X
	PRINCESA_RUN_LEFT_FIM: nop
	la a0, princesa_run_left
	jal zero, VOLTA_FIM_X
	VOLTA_FIM_X: nop
	sw a0, 0(t1)
	
	jal zero, DESENHAR_MARIOO
	DESCER_VARA: nop
	la a0, princesa_idle_left
	addi a2, a2, 1
	sw a2, 8(t1)
	jal zero, DESENHAR_MARIOO

	FINALIZAR_JOGO: nop
	la t1, SINC_CREDITOS
	jalr zero, t1, 0
## MOVIMENTO PARA DIREITA ##
MOVE_MARIO_DIREITA: nop
	add a1, a1, t1	# move
	
	la t3, Fase
	lb t3, 0(t3)
	li t5, 3
	blt t3, t5, PULA_EVITAR_ANDAR
	
	la t3, Fase
	lb t3, 0(t3)
	li t5, 3
	bne t3, t5, EVITA_BLOQUEIO
	
	li t3, 280
	blt a1, t3, EVITA_BLOQUEIO
	
	sub a1, a1, t1
	jal zero, PULA_EVITAR_ANDAR
	
	EVITA_BLOQUEIO: nop
	addi sp, sp, -24
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw a2, 8(sp)
	sw a3, 12(sp)
	sw a4, 16(sp)
	sw t1, 20(sp)
	
	li a4, 1
	la t1, VERIFICAR_CHAO_MARIO
	jalr ra, t1, 0
	lw a1, 4(sp)
	lw t1, 20(sp)
	
	beq a0, zero, NAO_EVITA_ANDAR
	
	sub a1, a1, t1
	
	NAO_EVITA_ANDAR: nop
	lw a0, 0(sp)
	lw a2, 8(sp)
	lw a3, 12(sp)
	lw a4, 16(sp)

	addi sp, sp, 24
	PULA_EVITAR_ANDAR: nop
	###### SALVA ULTIMA DIRECAO PARA JUMP ######
	la t3, Ultima_Direcao
	li t5, 1
	sb t5, 0(t3)
	li a4, 1
	############################################
	la t0, Personagens
	li t3, 0		# flag stop correcao bug and force subida
	sw t3, 16(t0)
	
	la t3, Fase
	lb t3, 0(t3)
	
	jal zero, ATRIBUIR_ANIMACAO_WALK
	
## MOVIMENTO PARA ESQUERDA ##
MOVE_MARIO_ESQUERDA: nop
	add a1, a1, t1
	
	la t3, Fase
	lb t3, 0(t3)
	
	li t5, 3
	blt t3, t5, PULA_EVITAR_ANDAR2
	
	la t3, Fase
	lb t3, 0(t3)
	li t5, 3
	bne t3, t5, EVITA_BLOQUEIO2
	
	li t3, 15
	bgt a1, t3, EVITA_BLOQUEIO2
	
	sub a1, a1, t1
	jal zero, PULA_EVITAR_ANDAR2
	
	EVITA_BLOQUEIO2: nop
	
	addi sp, sp, -24
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw a2, 8(sp)
	sw a3, 12(sp)
	sw a4, 16(sp)
	sw t1, 20(sp)
	
	li a4, 1
	la t1, VERIFICAR_CHAO_MARIO
	jalr ra, t1, 0
	lw a1, 4(sp)
	lw t1, 20(sp)
	
	beq a0, zero, NAO_EVITA_ANDAR2
	
	sub a1, a1, t1
	
	NAO_EVITA_ANDAR2: nop
	lw a0, 0(sp)
	lw a2, 8(sp)
	lw a3, 12(sp)
	lw a4, 16(sp)

	addi sp, sp, 24
	PULA_EVITAR_ANDAR2: nop
	###### SALVA ULTIMA DIRECAO PARA JUMP ######
	la t3, Ultima_Direcao
	li t5, 0
	sb t5, 0(t3)
	li a4, 0
	############################################	
	
	la t0, Personagens
	li t3, 0		# flag stop correcao bug and force subida
	sw t3, 16(t0)
	
	la t3, Fase
	lb t3, 0(t3)
	
	jal zero, ATRIBUIR_ANIMACAO_WALK
	
	
## MOVIMENTO PARA CIMA ##
MOVE_MARIO_CIMA: nop
	la t1, Armada
	lb t1, 0(t1)
	bne t1, zero, SOMENTE_PULOS
	
	mv s1, a0
	mv s2, t0
	###### VERIFICANDO SE ESTA NA ESCADA #######
	la t0, VERIFICAR_ESCADA
	li a3, 105		# escada verde
	jalr ra, t0, 0	
	mv t1, a0
	mv a0, s1
	mv t0, s2
	#############################################
	
	##### SE ESTIVER NA ESCADA #####
	li t2, 30
	bge t1, t2, MOVER_ESCADA_MARIO_CIMA
	################################
	SOMENTE_PULOS: nop
	##### PULA #######
	li t2, 1
	sw t2, 12(t0)
	addi a2, a2, -4
	
	la t2, SOUND_PULO
	jalr ra, t2, 0
	##################
	
	jal zero, VOLTA_MOVIMENTO_Y
	#########################

## MOVIMENTO PARA BAIXO ##
MOVE_MARIO_BAIXO: nop
	la t1, Armada
	lb t1, 0(t1)
	bne t1, zero, PULA_FORCE_DESCIDA
	
	mv s1, a0
	mv s2, t0
	###### VERIFICANDO SE ESTA NA ESCADA #######
	la t0, VERIFICAR_ESCADA
	li a3, 105		# escada verde
	jalr ra, t0, 0	
	mv t1, a0
	mv a0, s1
	mv t0, s2
	#############################################
	
	##### SE ESTIVER NA ESCADA #####
	li t2, 30
	bge t1, t2, MOVER_ESCADA_MARIO_BAIXO
	################################
	
	mv s1, a0
	mv s2, t0
	###### VERIFICANDO SE ESTA NA ESCADA #######
	la t0, VERIFICAR_ESCADA
	addi a2, a2, 20
	li a3, 105		# escada verde
	jalr ra, t0, 0	
	mv t1, a0
	mv a0, s1
	mv t0, s2
	addi a2, a2, -20
	#############################################
	
	##### SE ESTIVER NA ESCADA #####
	li t2, 20
	blt t1, t2, PULA_FORCE_DESCIDA
	################################
	
	############ FORCA MARIO A DESCER BARRA #################
	li t3, 3		# flag stop correcao bug and force subida
	sw t3, 16(t0)
	#########################################################
	
	PULA_FORCE_DESCIDA: nop
	jal zero, VOLTA_MOVIMENTO_Y
	
## MARIO PULANDO ##
MARIO_IS_JUMPING: nop
	############## ANIMACAO JUMP ###############
	la t3, Ultima_Direcao
	lb t5, 0(t3)
	
	la t3, Fase
	lb t3, 0(t3)
	
	li t6, 3
	bge t3, t6, ANIMACOES_PRINCESA_JUMP
	
	la t6, Armada
	lb t6, 0(t6)
	bne t6, zero, ANIM_MARIO_JUMP_PUTASSA
	
	#### ANIMACAO ESQUERDA JUMP ####
	bne t5, zero, ANIM_MARIO_JUMP_DIREITA
	li a4, 0
	
	li t3, 3
	blt t4, t3, MARIO_JUMP1_LEFT
	li t3, 4
	blt t4, t3, MARIO_JUMP2_LEFT
	la a0, mario_jump3_left
	jal zero, CONTINUAR_JUMP
	MARIO_JUMP2_LEFT: nop
	la a0, mario_jump2_left
	jal zero, CONTINUAR_JUMP
	MARIO_JUMP1_LEFT: nop
	la a0, mario_jump1_left
	jal zero, CONTINUAR_JUMP
	###############################
	ANIM_MARIO_JUMP_DIREITA: nop
	li a4, 1
	
	#### ANIMACAO DIREITA JUMP ####
	li t3, 3
	blt t4, t3, MARIO_JUMP1_RIGHT
	li t3, 4
	blt t4, t3, MARIO_JUMP2_RIGHT
	la a0, mario_jump3_left
	jal zero, CONTINUAR_JUMP
	MARIO_JUMP2_RIGHT: nop
	la a0, mario_jump2_left
	jal zero, CONTINUAR_JUMP
	MARIO_JUMP1_RIGHT: nop
	la a0, mario_jump1_left
	jal zero, CONTINUAR_JUMP
	###########################################
	
	ANIM_MARIO_JUMP_PUTASSA: nop
	
	#### ANIMACAO ESQUERDA JUMP ####
	bne t5, zero, ANIM_MARIO_JUMP_DIREITA_PUTASSA
	li a4, 0
	la a0, mario_martelinho_jump_left
	jal zero, CONTINUAR_JUMP
	###############################
	ANIM_MARIO_JUMP_DIREITA_PUTASSA: nop
	li a4, 1
	la a0, mario_martelinho_jump_left
	jal zero, CONTINUAR_JUMP
	###########################################
	
	ANIMACOES_PRINCESA_JUMP: nop
	bne t5, zero, ANIM_PRINCESA_JUMP_DIREITA
	li a4, 0
	la a0, princesa_jump_left
	jal zero, CONTINUAR_JUMP
	ANIM_PRINCESA_JUMP_DIREITA: nop
	li a4, 1
	la a0, princesa_jump_left
	
	CONTINUAR_JUMP: nop
	lw a2, 8(sp)
	
	### VERIFICA SE DEVE COMECAR A CAIR ###
	li t3, 4
	bge t4, t3, FIM_IS_JUMPING_MARIO
	#######################################
	
	addi t4, t4, 1	# jumping++
	sw t4, 12(t0)
	
	### SUBINDO MARIO ###
	addi a2, a2, -3
	jal zero, VOLTA_MOVIMENTO_Y
	#####################
	
	### FAZ MARIO ENCERRAR SUBIDA E COMECA A CAIR ###
	FIM_IS_JUMPING_MARIO: nop
	mv s1, a0
	mv s2, a1
	li a3, 79
	li a4, 0
	jal ra, VERIFICAR_CHAO_MARIO
	la t0, Personagens
	mv t3, a1
	mv a0, s1
	mv a1, s2
	li a3, 1
	
	la t5, Ultima_Direcao
	lb t5, 0(t5)
	
	beq t5, zero, FALLING_LEFT
	
	la t5, Armada
	lb a4, 0(t5)
	
	jal zero, EXIT_FALLING_DIR
	FALLING_LEFT: nop
	
	la t5, Armada
	lb t5, 0(t5)

	xori a4, t5, 1
	EXIT_FALLING_DIR: nop
	
	bne t3, zero, ENCERRA_PULO

	addi a2, a2, 3
	jal zero, VOLTA_MOVIMENTO_Y
	
	ENCERRA_PULO:nop
	li t3, 0	# is_jumping = false
	sw t3, 12(t0)
	
	###### ANIMACAO PARADA DE PULO ####
	la t3, Fase
	lb t3, 0(t3)
	
	li t6, 3
	bge t3, t6, ANIMACOES_PRINCESA_PARADA_PULO
	la t6, Armada
	lb t6, 0(t6)
	
	bne t6, zero, IDLE_PUTASSA
	la a0, mario_idle_left	
	jal zero, ENCERROU_PULO
	IDLE_PUTASSA: nop
	la a0, mario_martelinho_idle_left
	jal zero, ENCERROU_PULO
	ANIMACOES_PRINCESA_PARADA_PULO: nop
	la a0, princesa_idle_left
	ENCERROU_PULO: nop
	bne t5, zero, FIM_PULO_DIREITA
	li a4, 0
	jal zero, VOLTA_MOVIMENTO_Y
	FIM_PULO_DIREITA:nop
	li a4, 1
	jal zero, VOLTA_MOVIMENTO_Y
	################################################
	
##### MOVER MARIO NA ESCADA #####
MOVER_ESCADA_MARIO_CIMA: nop
	lw a2, 8(sp)	# valor original sem ajuste de bug
	addi a2, a2, -1
	
	### VERIFICA SE TOCOU NA BARRA DE FERRO ###
	mv s1, a0
	mv s2, a1
	#li a3, 79
	li a4, 1
	jal ra, VERIFICAR_CHAO_MARIO
	la t0, Personagens
	mv t3, a0
	mv a0, s1
	mv a1, s2
	li a3, 1
	
	beq t3, zero, ANIM_MARIO_ESCADA_NORMAL
	#############################################
	
	############ FORCA MARIO A SUBIR BARRA #################
	li t3, 2		# flag stop correcao bug and force subida
	sw t3, 16(t0)
	addi a2, a2, -4
	jal zero, VOLTA_MOVIMENTO_Y
	########################################################
MOVER_ESCADA_MARIO_BAIXO: nop
	lw a2, 8(sp)	# valor original sem ajuste de bug
	addi a2, a2, 1
	
	### VERIFICA SE TOCOU NA BARRA DE FERRO ###
	mv s1, a0
	mv s2, a1
	#li a3, 79
	li a4, 0
	jal ra, VERIFICAR_CHAO_MARIO
	la t0, Personagens
	mv t3, a0
	mv a0, s1
	mv a1, s2
	li a3, 1
	
	beq t3, zero, ANIM_MARIO_ESCADA_NORMAL
	#############################################
	addi a2, a2, -1
	jal zero, VOLTA_MOVIMENTO_Y
	
AQUI: nop
	####### ANIMACAO DE SUBIDA ESCADA #######
	ANIM_MARIO_ESCADA_NORMAL: nop
	li t3, -5		# flag stop correcao bug and force subida
	sw t3, 16(t0)
	
	mv t3, a0
	li a7, 130
	ecall
	mv t1, a0
	mv a0, t3
	
	la t3, Tempo_Animacao
	lw t3, 0(t3)
	
	bgt t1, t3, CONT_ANIM_MARIO_ESCADA
	jal zero, VOLTA_MOVIMENTO_Y
	
	CONT_ANIM_MARIO_ESCADA: nop
	addi t1, t1, 200
	la t3, Tempo_Animacao
	sw t1, 0(t3)
	
	la t1, Fase
	lb t1, 0(t1)
	
	li t3, 3
	bge t1, t3, ESCADA_ANIM_PRINCESA
	
	la a0, mario_escada
	
	beq a4, zero, TROCAR_ANIM_ESCADA
	li a4, 0
	jal zero, VOLTA_MOVIMENTO_Y
	TROCAR_ANIM_ESCADA: nop
	li a4, 1
	jal zero, VOLTA_MOVIMENTO_Y
	#########################################
	ESCADA_ANIM_PRINCESA: nop
	la a0, princesa_escada
	
	beq a4, zero, TROCAR_ANIM_ESCADA2
	li a4, 0
	jal zero, VOLTA_MOVIMENTO_Y
	TROCAR_ANIM_ESCADA2: nop
	li a4, 1
	jal zero, VOLTA_MOVIMENTO_Y
#################################

FORCE_SUBIDA_BARRA:nop
	lw a2, 8(sp)
	addi a2, a2, -3
	
	la t1, Fase
	lb t1, 0(t1)
	
	li t3, 3
	bge t1, t3, ANIM_FORCE_PRINCESA
	
	######## ANIMACAO DE SUBIDA FERRO #######
	la t1, mario_finish_escada1
	beq a0,t1, MARIO_FINISH_2
	la t1, mario_finish_escada2
	beq a0,t1, MARIO_FINISH_3
	la t1, mario_finish_escada3
	beq a0,t1, MARIO_FINISH_4
	la t1, mario_finish_escada4
	beq a0,t1, MARIO_FINISH_5
	la a0, mario_finish_escada1
	jal zero, VOLTA_MOVIMENTO_Y
	MARIO_FINISH_2: nop
	la a0, mario_finish_escada2
	jal zero, VOLTA_MOVIMENTO_Y
	MARIO_FINISH_3: nop
	la a0, mario_finish_escada3
	jal zero, VOLTA_MOVIMENTO_Y
	MARIO_FINISH_4: nop
	la a0, mario_finish_escada4
	jal zero, VOLTA_MOVIMENTO_Y
	MARIO_FINISH_5: nop
	la a0, mario_finish_escada5
	jal zero, ENCERRA_FORCE_SUBIDA_W
	
	ANIM_FORCE_PRINCESA: nop
	
	######## ANIMACAO DE SUBIDA FERRO #######
	la t1, princesa_finish_escada1
	beq a0,t1, PRINCESA_FINISH_2
	la t1, princesa_finish_escada2
	beq a0,t1, PRINCESA_FINISH_3
	la t1, princesa_finish_escada3
	beq a0,t1, PRINCESA_FINISH_4
	la t1, princesa_finish_escada4
	beq a0,t1, PRINCESA_FINISH_5
	la a0, princesa_finish_escada1
	jal zero, VOLTA_MOVIMENTO_Y
	PRINCESA_FINISH_2: nop
	la a0, princesa_finish_escada2
	jal zero, VOLTA_MOVIMENTO_Y
	PRINCESA_FINISH_3: nop
	la a0, princesa_finish_escada3
	jal zero, VOLTA_MOVIMENTO_Y
	PRINCESA_FINISH_4: nop
	la a0, princesa_finish_escada4
	jal zero, VOLTA_MOVIMENTO_Y
	PRINCESA_FINISH_5: nop
	la a0, princesa_finish_escada5
	
	ENCERRA_FORCE_SUBIDA_W: nop
	#### ENCERRANDO FORCE ####
	li t1, 0
	sw t1, 16(t0)
	addi a2, a2, -4
	jal zero, VOLTA_MOVIMENTO_Y

	########################################
FORCE_DESCIDA_BARRA:nop
	lw a2, 8(sp)
	addi a2, a2, 3
	
	la t1, Fase
	lb t1, 0(t1)
	
	li t3, 3
	bge t1, t3, ANIM_DESCIDA_PRINCESA
	
	######## ANIMACAO DE SUBIDA FERRO #######
	la t1, mario_finish_escada5
	beq a0,t1, MARIO_FINISH_3
	la t1, mario_finish_escada3
	beq a0,t1, MARIO_FINISH_4
	la t1, mario_finish_escada4
	beq a0,t1, MARIO_FINISH_2
	la t1, mario_finish_escada2
	beq a0,t1, MARIO_FINISH_1
	la a0, mario_finish_escada5
	jal zero, VOLTA_MOVIMENTO_Y

	MARIO_FINISH_1: nop
	la a0, mario_finish_escada1
	jal zero, ENCERRA_DESCIDA_FORCE
	
	ANIM_DESCIDA_PRINCESA: nop
	
	######## ANIMACAO DE SUBIDA FERRO #######
	la t1, princesa_finish_escada5
	beq a0,t1, PRINCESA_FINISH_3
	la t1, princesa_finish_escada3
	beq a0,t1, PRINCESA_FINISH_4
	la t1, princesa_finish_escada4
	beq a0,t1, PRINCESA_FINISH_2
	la t1, princesa_finish_escada2
	beq a0,t1, PRINCESA_FINISH_1
	la a0, princesa_finish_escada5
	jal zero, VOLTA_MOVIMENTO_Y

	PRINCESA_FINISH_1: nop
	la a0, princesa_finish_escada1
	
	ENCERRA_DESCIDA_FORCE: nop
	#### ENCERRANDO FORCE ####
	li t1, -5
	sw t1, 16(t0)

	jal zero, VOLTA_MOVIMENTO_Y

	########################################

#### ANIMACAO ESQUERDA JUMP ####
ATRIBUIR_ANIMACAO_WALK: nop
	li t6, 3
	bge t3, t6, ANIMACOES_PRINCESA_ESQUERDA
	
	la t3, Armada
	lb t3, 0(t3)
	
	bne t3, zero, PRINCESA_PUTASSA
	
	beq t4, zero, ANIM_MARIO_ESQUERDA
	li t3, 3
	blt t4, t3, MARIO_JUMP1_LEFT_D
	li t3, 4
	blt t4, t3, MARIO_JUMP2_LEFT_D
	la a0, mario_jump3_left
	jal zero, VOLTA_MOVIMENTO_X
	MARIO_JUMP2_LEFT_D: nop
	la a0, mario_jump2_left
	jal zero, VOLTA_MOVIMENTO_X
	MARIO_JUMP1_LEFT_D: nop
	la a0, mario_jump1_left
	jal zero, VOLTA_MOVIMENTO_X
	###############################
	
	##### ANIMACAO ESQUERDA #####
	ANIM_MARIO_ESQUERDA:nop
	la t5, mario_idle_left
	beq a0, t5, MARIO_WALK_LEFT
	la t5, mario_walk_left
	beq a0, t5, MARIO_RUN_LEFT
	la a0, mario_idle_left
	jal zero, VOLTA_MOVIMENTO_X
	MARIO_WALK_LEFT: nop
	la a0, mario_walk_left
	jal zero, VOLTA_MOVIMENTO_X
	MARIO_RUN_LEFT: nop
	la a0, mario_run_left
	jal zero, VOLTA_MOVIMENTO_X
	############################
	
	PRINCESA_PUTASSA: nop
	beq t4, zero, ANIM_MARIO_ESQUERDA_PUTASSA
	la a0, mario_martelinho_jump_left
	jal zero, VOLTA_MOVIMENTO_X
	###############################
	
	##### ANIMACAO ESQUERDA #####
	ANIM_MARIO_ESQUERDA_PUTASSA:nop
	la t5, mario_martelinho_idle_left
	beq a0, t5, MARIO_WALK_LEFT_PUTASSA
	la t5, mario_martelinho_walk_left
	beq a0, t5, MARIO_RUN_LEFT_PUTASSA
	la a0, mario_martelinho_idle_left
	jal zero, VOLTA_MOVIMENTO_X
	MARIO_WALK_LEFT_PUTASSA: nop
	la a0, mario_martelinho_walk_left
	jal zero, VOLTA_MOVIMENTO_X
	MARIO_RUN_LEFT_PUTASSA: nop
	la a0, mario_martelinho_run_left
	jal zero, VOLTA_MOVIMENTO_X
	############################
	
	ANIMACOES_PRINCESA_ESQUERDA: nop
	
	#### ANIMACAO ESQUERDA JUMP ####
	beq t4, zero, ANIM_PRINCESA_ESQUERDA
	la a0, princesa_jump_left
	jal zero, VOLTA_MOVIMENTO_X
	###############################
	
	##### ANIMACAO ESQUERDA #####
	ANIM_PRINCESA_ESQUERDA:nop
	la t5, princesa_idle_left
	beq a0, t5, PRINCESA_WALK_LEFT
	la t5, princesa_walk_left
	beq a0, t5, PRINCESA_RUN_LEFT
	la a0, princesa_idle_left
	jal zero, VOLTA_MOVIMENTO_X
	PRINCESA_WALK_LEFT: nop
	la a0, princesa_walk_left
	jal zero, VOLTA_MOVIMENTO_X
	PRINCESA_RUN_LEFT: nop
	la a0, princesa_run_left
	jal zero, VOLTA_MOVIMENTO_X
	############################

####### bool verificar_chao(imagem[], int x, int y, int cor, int corpo)
## verifica se a imagem toca o chao
# a0 -> vetor imagem
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> cor do chao
# a4 -> parte do corpo a verificar ( 0 - ponta do pe, 1 - ponta da cabeca )
VERIFICAR_CHAO_MARIO: nop
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
	jal zero, CONTINUA_VERIFICAR_CHAO_MARIO
PONTA_CABECA: nop
	li t1, 320	# proxima linha
CONTINUA_VERIFICAR_CHAO_MARIO: nop
	add t0, t0, t1			# vai para a linha em questao
#	add t6, t6, t1			# para debug
	lw t2, 0(a0)			# largura da imagem
	addi t3, t2, 0			# salva largura

FOR1_VERIFICAR_CHAO_MARIO: nop
		beq t2, zero, EXIT_FOR1_VERIFICAR_CHAO_MARIO
		lb t1, 0(t0)	# le o byte do mapa
#		sb t5, 0(t6)	# para debug
		la t5, Chao
		lb t6, 0(t5)
		beq t1, t6, ENCONTROU_CHAO_MARIO
		lb t6, 1(t5)
		beq t1, t6, ENCONTROU_CHAO_MARIO
		lb t6, 2(t5)
		beq t1, t6, ENCONTROU_CHAO_MARIO
		lb t6, 3(t5)
		beq t1, t6, ENCONTROU_CHAO_MARIO
		lb t6, 4(t5)
		beq t1, t6, ENCONTROU_CHAO_MARIO
		lb t6, 5(t5)
		beq t1, t6, ENCONTROU_CHAO_MARIO
		addi t0, t0, 1	# proximo byte do mapa
#		addi t6, t6, 1	# para debug
		addi t2, t2, -1	# contador largura --	
		jal zero, FOR1_VERIFICAR_CHAO_MARIO
EXIT_FOR1_VERIFICAR_CHAO_MARIO: nop
	li a0, 0
	sub t0, t0, t3		# retora t0 ao original
#	li t5, 105			# para debug
#	sub t6, t6, t3		# para debug
#	addi t6, t6, 320	# para debug
	addi t0, t0, 320	# vai para a ultima linha
FOR2_VERIFICAR_CHAO_MARIO: nop
		beq t3, zero, EXIT_FOR2_VERIFICAR_CHAO_MARIO
		lb t1, 0(t0)	# le o byte do mapa
#		sb t5, 0(t6)	# para debug
		la t5, Chao
		lb t6, 0(t5)
		beq t1, t6, ENCONTROU_CHAO2_MARIO
		lb t6, 1(t5)
		beq t1, t6, ENCONTROU_CHAO2_MARIO
		lb t6, 2(t5)
		beq t1, t6, ENCONTROU_CHAO2_MARIO
		lb t6, 3(t5)
		beq t1, t6, ENCONTROU_CHAO2_MARIO
		lb t6, 4(t5)
		beq t1, t6, ENCONTROU_CHAO2_MARIO
		lb t6, 5(t5)
		beq t1, t6, ENCONTROU_CHAO2_MARIO
		addi t0, t0, 1	# proximo byte do mapa
		addi t3, t3, -1	# contador largura --
#		addi t6, t6, 1	# para debug
		jal zero, FOR2_VERIFICAR_CHAO_MARIO
EXIT_FOR2_VERIFICAR_CHAO_MARIO: nop
	li a1, 0
	ret
ENCONTROU_CHAO_MARIO: nop
	li a0, 1
	sub t0, t0, t3		# retora t0 ao original
	addi t0, t0, 320	# vai para a ultima linha
#	li t5, 105			# para debug
#	sub t6, t6, t3		# para debug
#	addi t6, t6, 320	# para debug
	jal zero, FOR2_VERIFICAR_CHAO_MARIO
ENCONTROU_CHAO2_MARIO: nop
	li a1, 1
	ret
	
#######################
