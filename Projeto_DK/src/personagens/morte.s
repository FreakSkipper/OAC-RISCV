.data
#.include "..\..\images\mario_morte1_right.s"
.include "..\..\images\mario_morte1_left.s"
.include "..\..\images\mario_morte2.s"
.include "..\..\images\mario_morte3.s"
.include "..\..\images\mario_morte4.s"
.include "..\..\images\mario_morte5.s"
.include "..\..\images\mario_morte6.s"
.include "..\..\images\princesa_morte2.s"
.include "..\..\images\princesa_morte3.s"
.include "..\..\images\princesa_morte4.s"
.include "..\..\images\princesa_morte5.s"
.include "..\..\images\princesa_morte6.s"


.text

MORREU: nop
	#jal zero, FIM_MORTES
	addi sp, sp, -4
	sw ra, 0(sp)
	
	la t0, RESETAR_OBJETOS
	jalr ra, t0, 0
	
	### STRUCTS ###
	la t1, Personagens
	###############
	
	############# VERIFICANDO DIRECAO DA MORTE ############
	la t3, Ultima_Direcao
	lb t3, 0(t3)
	
	beq t3, zero, MORREU_ESQUERDA
	
	la t2, mario_morte1_left
	jal zero, TROCOU_ANIM_MORREU
	
	MORREU_ESQUERDA: nop
	la t2, mario_morte1_left
	
	TROCOU_ANIM_MORREU: nop
	sw t2, 0(t1)
	########################################################
	
	##### ATIVANDO FLAG DE ANIMACAO #####
	li t4, 1
	la t0, Morto
	sb t4, 0(t0)
	
	la t0, Vidas
	lb t4, 0(t0)
	addi t4, t4, -1
	sb t4, 0(t0)
	#######################################
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	FIM_MORTES: nop
	ret

ANIM_MARIO_MORTO: nop
	addi sp, sp, -4
	sw ra, 0(sp)
	
	###### STRUCT MARIO #######
	la t0, Personagens
	lw a0, 0(t0)
	lw a1, 4(t0)
	lw a2, 8(t0)
	li a3, 1	# flag desenhar
	############################
	
	la t2, Fase
	lb s2, 0(t2)
	li t2, 3
	bge s2, t2, PRINCESA_ANIM_MORTE
	
	la t2, mario_morte1_left
	beq a0, t2, MARIO_MORTO2
	la t2, mario_morte1_left
	beq a0, t2, MARIO_MORTO2
	la t2, mario_morte2
	beq a0, t2, MARIO_MORTO3
	la t2, mario_morte3
	beq a0, t2, MARIO_MORTO4
	la t2, mario_morte4
	beq a0, t2, MARIO_MORTO5
	la t2, mario_morte5
	beq a0, t2, MARIO_MORTO6

	PRINCESA_ANIM_MORTE: nop
	
	la t2, mario_morte1_left
	beq a0, t2, MARIO_MORTO2
	la t2, mario_morte1_left
	beq a0, t2, MARIO_MORTO2
	la t2, princesa_morte2
	beq a0, t2, MARIO_MORTO3
	la t2, princesa_morte3
	beq a0, t2, MARIO_MORTO4
	la t2, princesa_morte4
	beq a0, t2, MARIO_MORTO5
	la t2, princesa_morte5
	beq a0, t2, MARIO_MORTO6
	
	jal zero, FIM_ANIM_MARIO_MORTO
	
	MARIO_MORTO2: nop	
	la t2, MUSICA_MORTE1
	jalr ra, t2, 0
	li a4, 0
	li t2, 3
	bge s2, t2, PRINCESA_MORTA2
	la a0, mario_morte2
	jal zero, FIM_ANIM_MARIO_MORTO
	
	PRINCESA_MORTA2: nop
	la a0, princesa_morte2
	jal zero, FIM_ANIM_MARIO_MORTO
	
	MARIO_MORTO3: nop
	la t2, MUSICA_MORTE2
	jalr ra, t2, 0
	li a4, 0
	li t2, 3
	bge s2, t2, PRINCESA_MORTA3
	la a0, mario_morte3
	jal zero, FIM_ANIM_MARIO_MORTO
	
	PRINCESA_MORTA3: nop
	la a0, princesa_morte3
	jal zero, FIM_ANIM_MARIO_MORTO
	
	MARIO_MORTO4: nop
	la t2, MUSICA_MORTE3
	jalr ra, t2, 0
	li a4, 0
	li t2, 3
	bge s2, t2, PRINCESA_MORTA4
	la a0, mario_morte4
	jal zero, FIM_ANIM_MARIO_MORTO
	
	PRINCESA_MORTA4: nop
	la a0, princesa_morte4
	jal zero, FIM_ANIM_MARIO_MORTO
	
	MARIO_MORTO5: nop
	la t2, MUSICA_MORTE4
	jalr ra, t2, 0
	li a4, 0
	li t2, 3
	bge s2, t2, PRINCESA_MORTA5
	la a0, mario_morte5
	jal zero, FIM_ANIM_MARIO_MORTO
	
	PRINCESA_MORTA5: nop
	la a0, princesa_morte5
	jal zero, FIM_ANIM_MARIO_MORTO
	
	MARIO_MORTO6: nop	
	la t2, MUSICA_MORTE5
	jalr ra, t2, 0
	li a4, 0
	li t2, 3
	bge s2, t2, PRINCESA_MORTA6
	la a0, mario_morte6
	jal zero, FIM_ANIM_MARIO_MORTO
	
	PRINCESA_MORTA6: nop
	la a0, princesa_morte6
	FIM_ANIM_MARIO_MORTO: nop
	
	###### STRUCT MARIO #######
	la t0, Personagens
	lw a1, 4(t0)
	lw a2, 8(t0)
	li a3, 1	# flag desenhar
	############################
	
	sw a0, 0(t0)
	
	la t0, CRIAR_QUADRADO
	jalr ra, t0, 0
	
	li a7, 32
	li a0, 200
	ecall
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret
