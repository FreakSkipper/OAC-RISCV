.text

######## tratar_tecla(int tecla)
## verifica a tecla pressionada e faz o tratamento necessário
# a0 -> tecla, t2
TRATAR_TECLA: nop
	addi sp, sp, -4	# inicia pilha
	sw ra, 0(sp)	# salva retorno
	
	li a7, 11
	ecall
	
	lw ra, 0(sp)	# pega ra
	addi sp, sp, 4	# encerra pilha
	ret				# retorna
#####################