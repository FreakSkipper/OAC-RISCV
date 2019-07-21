#############################################
######### MOVIMENTO DE PERSONAGENS ##########
#############################################

.data
.include "..\..\images\kong_left.s"
#.include "..\..\images\kong_right.s"
.include "..\..\images\kong_center.s"
.include "..\..\images\Kong_fogo.s"
.include "..\..\images\oil_1.s"
.include "..\..\images\oil_2.s"
.include "..\..\images\oil_3.s"
.include "..\..\images\oil_4.s"
	
	Personagens: .word mario_idle_left, 60, 210, 0,0, oil_1, 10, 198,0,0, kong_left, 30, 28,0,0, princesa_idle_left, 30, 28,0,0
	Copia_Personagens: .space 48
	Kong_Chamas: .byte 0
	Kong_Dir: .byte 0
	Kong_Sinalizou: .byte 0
	
.text

######################## MOVIMENTO DO KONG #####################################
##### mover_kong()
MOVER_KONG: nop
	addi sp, sp, -4
	sw ra, 0(sp)

	la t0, Personagens
	addi t0, t0, 40
	
	lw a0, 0(t0)	# imagem kong[]
	beq a0, zero, FIM_MOV_KONG
	lw a1, 4(t0)	# posicao X kong
	lw a2, 8(t0)	# posicao Y kong
	
	la t1, Fase
	lb t1, 0(t1)
	## Se for fase 01, tratar movimentos como fase 1 ##
	beq t1, zero, KONG_FASE1
	li t2, 1
	beq t1, t2, KONG_FASE2
	li t2, 2
	beq t1, t2, KONG_FASE3
	jal zero, FIM_MOV_KONG
	
	## Fase 03 ##
	KONG_FASE3: nop
	la t2, Kong_Chamas
	lb t2, 0(t2)
	bne t2, zero, KONG_CHAMAS
	
	la a0, kong_center
	li t2, 0
	
	## is_something eh considerado como sendo contagem de frames para soltar barril ##
	lw t2, 12(t0)	# is_something ( frames )
	addi t2, t2, 1
	sw t2, 12(t0)
	
	li t3, 40
	bge  t2, t3, CRIAR_MOLA
	jal zero, ENCERRA_ANIM_KONG
	
	CRIAR_MOLA: nop	
	mv s4, t0
	
	## Define posicao X no inicio ##
	li a1, 0
	
	## Define posicao Y no meio do Kong ##
	lw t3, 4(a0)	# altura kong
	srai t3, t3, 1	# metade da altura Kong
	add a2, a2, t3	# posicao Y kong + metade altura Kong
	
	## Define direcao da Mola ##
	li a3, 1
	
	## Define o tipo do objeto ##
	li a0, 3	# 0 = barril
	la t0, CRIAR_OBJETO
	jalr ra, t0, 0
	
	mv t0, s4
	la a0, kong_center
	lw a1, 4(t0)
	lw a2, 8(t0)
	li a4, 0
	jal zero, ENCERRA_ANIM_KONG
	
	KONG_CHAMAS: nop
	
	la a0, Kong_fogo
	lw a1, 4(t0)
	lw a2, 8(t0)
	la t1, Kong_Dir
	lb a4, 0(t1)
	xori a4, a4, 1
	sb a4, 0(t1)
	
	li t1, 175
	blt a1, t1, MOV_KONG_CHAMA
	la t1, Kong_Sinalizou
	li t2, 1
	sb t2, 0(t1)
	jal zero, SALVAR_POS_KONG
	MOV_KONG_CHAMA: nop
	addi a1, a1, 3
	SALVAR_POS_KONG: nop
	sw a1, 4(t0)
			
	jal zero, ENCERRA_ANIM_KONG
	## Fase 02 ##
	KONG_FASE2: nop
	la a0, kong_center
	li t2, 0
	li a4, 0
	jal zero, ENCERRA_ANIM_KONG
	
	## Fase 01 ##
	KONG_FASE1: nop
	mv s4, t0
	## is_something eh considerado como sendo contagem de frames para soltar barril ##
	lw t2, 12(t0)	# is_something ( frames )
	addi t2, t2, 1
	
	## Trata a animacao de acordo com a contagem ##
	li t3, 10
	blt t2, t3, KONG_LEFT_01
	li t3, 20
	blt t2, t3, KONG_CENTER_01
	li t3, 30
	blt t2, t3, KONG_RIGHT_01
	
	## Define posicao X na frente do Kong ##
	lw t5, 0(a0)	# largura imagem kong
	add a1, a1, t5	# posicao X kong + Largura Kong
	
	## Define posicao Y na frente do Kong ##
	lw t3, 4(a0)	# altura kong
	srai t3, t3, 1	# metade da altura Kong
	add a2, a2, t3	# posicao Y kong + metade altura Kong
	
	## Define direcao do barril ##
	li a3, 1
	
	## Define o tipo do objeto ##
	li a0, 0	# 0 = barril
	
	la t0, CRIAR_OBJETO
	jalr ra, t0, 0
	
	li t2, 0 # reset (volta esquerda)	
	mv t0, s4
	
	KONG_LEFT_01: nop
	la a0, kong_left
	li a4, 0
	jal zero, ENCERRA_ANIM_KONG
	KONG_CENTER_01: nop
	la a0, kong_center
	li a4, 0
	jal zero, ENCERRA_ANIM_KONG
	KONG_RIGHT_01: nop
	la a0, kong_left
	li a4, 1
	ENCERRA_ANIM_KONG: nop
	
	lw a1, 4(t0)
	lw a2, 8(t0)
	sw t2, 12(t0)	# is_something ( frames )
	
	sw a0, 0(t0)	# salva animacao imagem[]
	li a3, 1		# flag desenhar
	jal ra, CRIAR_QUADRADO
	
	la t1, kong_center
	bne a0, t1, FIM_MOV_KONG
	
	la t0, Fase
	lb t0, 0(t0)
	
	bne t0, zero, FIM_MOV_KONG
	
	la a0, barril_escada1
	lw t1, 0(a0)
	srai t1, t1, 1
	add a1, a1, t1
	addi a1, a1, 5
	
	lw t1, 4(a0)
	srai t1, t1, 1
	addi t1, t1, 12
	add a2, a2, t1
	jal ra, CRIAR_QUADRADO
	
	FIM_MOV_KONG: nop
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
####################

#################################################################################
###################### ANIMACAO OIL #######################################
#### void anim_oil()
ANIM_OIL: nop
	la t0, Fase
	lb t0, 0(t0)
	li t1, 2
	bge t0, t1, FIM_ANIM_OIL
	
	la t0, Personagens
	addi t0, t0, 20 # posicao do oil na struct
	
	lw a0, 0(t0)
	beq a0, zero, FIM_ANIM_OIL
	
	## Le informacoes do fogo atual ##
	lw t1, 16(t0)	# contagem frames
	addi t1, t1, -1 # Pausa de frames para troca de fogo
	sw t1, 16(t0)
	bge t1, zero, ENCERRA_FUNCAO_ANIM_OIL
	
	li t1, 2	# reset contagem frames
	sw t1, 16(t0)
	
	## Trata a animacao do Fogo ##
	la t1, oil_1
	beq a0, t1, ANIM_FOGO_OIL_2
	
	la t1, oil_2
	beq a0, t1, ANIM_FOGO_OIL_3
	
	la t1, oil_3
	beq a0, t1, ANIM_FOGO_OIL_4
	
	la a0, oil_1
	
	jal zero, ENCERRAR_ANIM_FOGO_OIL
	
	ANIM_FOGO_OIL_2: nop
	la a0, oil_2
	jal zero, ENCERRAR_ANIM_FOGO_OIL
		
	ANIM_FOGO_OIL_3: nop
	la a0, oil_3	
	jal zero, ENCERRAR_ANIM_FOGO_OIL
	
	ANIM_FOGO_OIL_4: nop
	la a0, oil_4			
	
	ENCERRAR_ANIM_FOGO_OIL: nop
	sw a0, 0(t0)
	
	ENCERRA_FUNCAO_ANIM_OIL: nop	
	lw a0, 0(t0)
	lw a1, 4(t0)
	lw a2, 8(t0)
	li a3, 1
	li a4, 0
	mv s5, ra
	jal ra, CRIAR_QUADRADO
	mv ra, s5
	
	FIM_ANIM_OIL: nop
	ret
######################################################################
DESENHAR_PRINCESA: nop
	la t0, Fase
	lb t0, 0(t0)
	li t1, 3
	bge t0, t1, ENCERRA_DESENHAR_PRINCESA

	addi sp, sp, -4
	sw ra, 0(sp)
	
	la a0, Personagens
	addi a0, a0, 60 # posicao da princesa na struct
	
	la t0, GRAVIDADE
	jalr ra, t0,0
	
	la t0, Personagens
	addi t0, t0, 60
	lw a0, 0(t0)
	
	li a3, 1
	li a4, 0
	la t0, CRIAR_QUADRADO
	jalr ra, t0, 0
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	ENCERRA_DESENHAR_PRINCESA: nop
	ret
