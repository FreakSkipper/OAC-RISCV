.text

######## tratar_tecla(int tecla)
## verifica a tecla pressionada e faz o tratamento necessário
# a0 -> tecla, t2
TRATAR_TECLA: nop
	addi sp, sp, -4	# inicia pilha
	sw ra, 0(sp)	# salva retorno
	
	la a1, Personagens
	la t0, MOVER_PERSONAGEM
	jalr ra, t0, 0
	
	la t0, Desvio_padrao
	li t1, 0
	sb t1, 0(t0)
	
	lw ra, 0(sp)	# pega ra
	addi sp, sp, 4	# encerra pilha
	ret				# retorna
#############################
	
######## tratar_frame()
## trata todos os objetos no frame
TRATAR_FRAME: nop
	addi sp, sp, -4	# inicia pilha
	sw ra, 0(sp)	# salva retorno
	
	la a0, Objetos
	li a1, 5
	la t0, MOVER_OBJETOS
	jalr ra, t0, 0

	li a0, 0	# sem tecla
	la a1, Personagens
	la t0, MOVER_PERSONAGEM
	jalr ra, t0, 0
	
	lw ra, 0(sp)	# pega ra
	addi sp, sp, 4	# encerra pilha
	ret				# retorna
#####################
