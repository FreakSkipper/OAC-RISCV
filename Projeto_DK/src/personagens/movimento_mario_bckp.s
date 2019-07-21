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
.text

#################### MOVIMENTO DO MARIO ###########################

MOVER_MARIO: nop
	

# a0 -> struct mario
# a1 -> tipo ( 0 - walk, 1 - jump, 2 - escada, 3 - force subida, 4 - force descida )
## retorna a nova skin
ANIMACAO_MARIO: nop
	lw t0, 0(a0)
	beq a1, zero, ANIMACOES_WALK
	li t1, 1
	beq a1, zero, ANIMACOES_JUMP
	li t1, 2
	beq a1, zero, ANIMACOES_ESCADA
	li t1, 3
	beq a1, zero, ANIMACOES_SUBIDA
	li t1, 4
	beq a1, zero, ANIMACOES_DESCIDA
	
	FINALIZA_ANIM_MARIO: nop
	
	sw t0, 0(a0)
	
	ret

ANIMACOES_WALK: nop
	la t1, Armada
	lb t1, 0(t1)
	
	bne t1, zero, WALK_ARMADA
	
	la t1, mario_idle_left
	beq t0, t1, MARIO_WALK
	la t1, mario_walk_left
	beq t0, t1, MARIO_RUN
	
	la t0, mario_idle_left
	jal zero, FINALIZA_ANIM_MARIO
	
	MARIO_WALK: nop
	la t0, mario_walk_left
	jal zero, FINALIZA_ANIM_MARIO
	MARIO_RUN: nop
	la t0, mario_run_left
	jal zero, FINALIZA_ANIM_MARIO
	
	WALK_ARMADA: nop
	
	la t1, mario_martelinho_idle_left
	beq t0, t1, MARIO_WALK_ARMADA
	la t1, mario_martelinho_walk_left
	beq t0, t1, MARIO_RUN_ARMADA
	
	la t0, mario_martelinho_idle_left
	jal zero, FINALIZA_ANIM_MARIO
	
	MARIO_WALK_ARMADA: nop
	la t0, mario_martelinho_walk_left
	jal zero, FINALIZA_ANIM_MARIO
	MARIO_RUN_ARMADA: nop
	la t0, mario_martelinho_run_left
	jal zero, FINALIZA_ANIM_MARIO
	
ANIMACOES_JUMP: nop
	la t1, Armada
	lb t1, 0(t1)
	
	bne t1, zero, JUMP_ARMADA
	
	lw t1, 16(a0)
	li t2, 3
	blt t1, t2, MARIO_JUMP1
	li t2, 4
	blt t1, t2, MARIO_JUMP2
	la t0, mario_jump3_left
	jal zero, FINALIZA_ANIM_MARIO
	
	MARIO_JUMP1: nop
	la t0, mario_jump1_left
	jal zero, FINALIZA_ANIM_MARIO
	MARIO_JUMP2: nop
	la t0, mario_jump2_left
	jal zero, FINALIZA_ANIM_MARIO
				
	JUMP_ARMADA: nop
	la t0, mario_martelinho_jump_left	
	jal zero, FINALIZA_ANIM_MARIO
	
ANIMACOES_ESCADA: nop
	la t0, mario_escada
	jal zero, FINALIZA_ANIM_MARIO
ANIMACOES_SUBIDA: nop
	la t1, mario_finish_escada1
	la t1, mario_finish_escada1
	la t1, mario_finish_escada1
	la t1, mario_finish_escada1
	la t1, mario_finish_escada1
	jal zero, FINALIZA_ANIM_MARIO
ANIMACOES_DESCIDA: nop
	jal zero, FINALIZA_ANIM_MARIO
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
	
	la t1, Chao
	lb a3,0(t1)
	lb t5, 1(t1)
	lb t6, 2(t1)
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
		beq t1, a3, ENCONTROU_CHAO_MARIO
		beq t1, t5, ENCONTROU_CHAO_MARIO
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
		beq t1, a3, ENCONTROU_CHAO2_MARIO
		beq t1, t5, ENCONTROU_CHAO2_MARIO
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
