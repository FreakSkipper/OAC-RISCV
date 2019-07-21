.include "macros3.s"

.data
.include "DK_ta_pegando_fogo_bixo.s"
.include "castelinho.s"

.text
# struct kong
# .word address
# .word x
# .word y
# .word is_something
# .word ....
# a0 -> pos X
# a1 -> pos Y
DK_Cinzou: addi sp, sp, -4
	sw ra, 0(sp)
	
	jal CLS
	li a0, 132
	li a1, 60
	jal DK_Cinzou_printa
	#jal DK_Cinzando
	j DK_Cinzou_exit
	
DK_Cinzou_printa:	la t0, castelinho
	li t3, VGAADDRESSINI0
	li t1, 320
	mul t1, a1, t1	# deslocando Y linhas
	add t1, t1, a0	# somando X
	
	add t3, t3, t1
	
	lw t1, 0(t0)	# X
	lw t2, 4(t0)	# Y
	#mul t2, t1, t2
	addi t0, t0, 8
	li t4, 0		# contador linha
	li t5, 0		# contador coluna
	
DK_Cinzou_printa_loop:	beq t4, t1, DK_Cinzou_quebra_linha
	lb t6, 0(t0)
	sb t6, 0(t3)
	
	addi t0, t0, 1	# imagem
	addi t3, t3, 1	# vga
	addi t4, t4, 1  # contador linha
	j DK_Cinzou_printa_loop
	
DK_Cinzou_quebra_linha: addi t5, t5, 1
	li t4, 0
	addi t3, t3, 320
	sub t3, t3, t1
	
	beq t5, t2, DK_Cinzou_printa_fim
	j DK_Cinzou_printa_loop
	
DK_Cinzou_printa_fim: ebreak



DK_Cinzando: #la t0, Personagens
	#addi t0, t0, 40
		   
	#lw t1, 0(t0)		# endereço da imagem
	#lw t2, 4(t0)		# X
	#lw t3, 8(t0)		# Y
	
	#la t0, DK_ta_pegando_fogo_bixo
	
	
	
DK_Cinzou_exit:	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret
############################################

CLS: li t0, VGAADDRESSINI0
	li t1, VGAADDRESSFIM0
	li t2, 0
CLS_LOOP: sb t2, 0(t0)
	addi t0, t0, 1
	bge t1, t0, CLS_LOOP
	ret
		   
