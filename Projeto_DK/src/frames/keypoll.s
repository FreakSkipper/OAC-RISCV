#################################################
#  Programa de exemplo para Poll do teclado   	#
#  usando o Keyboard Display MMIO Tool		#
#  ISC Abr 2018				      	#
#  Marcus Vinicius			      	#
#################################################
# escolha e descomente um dos dois jals no programa 
#

.text

# Polling do teclado e echo na tela
	li s0,0			# zera o contador
CONTA:  addi s0,s0,1		# incrementa o contador

	addi sp, sp, -4
	sw ra, 0(sp)

#	call KEY		# le o teclado	com wait
	call KEY2       	# le o teclado 	sem wait

	### EDITADO POR NÓS ####
	la t0, TRATAR_FRAME
	jalr ra, t0, 0
	########################

	## configuracao de frame ##
	li t0, 0

	FOR1_CONTA: nop
	beq t0, zero, CONTA
	addi t0, t0, -1
	jal zero, FOR1_CONTA
	#############################

	j CONTA			# volta ao loop

### Espera o usuário pressionar uma tecla
KEY: 	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP: 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP		# não tem tecla pressionada então volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
  	sw t2,12(t1)  			# escreve a tecla pressionada no display
	ret				# retorna

### Apenas verifica se há tecla apertada
KEY2:	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se não há tecla pressionada então vai para FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
	sw t2,12(t1)  			# escreve a tecla pressionada no display

	### EDITADO POR NÓS ######
	addi sp, sp, -4	# inicia pilha
	sw ra, 0(sp)	# salva ra
	
	mv a0, t2		# argumento tecla
	la t2, TRATAR_TECLA
	jalr ra, t2, 0	# vai para o tratamento de tecla 
	
	lw ra, 0(sp)	# pega ra
	addi sp, sp, 4	# encerra pilha
	#########################
FIM:	ret				# retorna

.data
.include "tratamentos.s"
