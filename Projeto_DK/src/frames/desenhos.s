.text

######## Copiar Objetos()
## Copia as posicoes anteriores dos objetos para auxiliar na hora de apagar
COPIAR_OBJETOS: nop
	la t0, Objetos
	la t1, Copia_Objetos
	la t2, Personagens
	la t3, Copia_Personagens
	
	li t4, 20
	li t5, 4
	
	FOR1_COPIAR_OBJETOS: nop
		beq t4, zero, EXIT_FOR1_COPIAR_OBJETOS
		
		lw t6, 0(t0)
		sw t6, 0(t1)
		lw t6, 4(t0)
		sw t6, 4(t1)
		lw t6, 8(t0)
		sw t6, 8(t1)
		
		beq t5, zero, PULA_COPIA_PERSONAGENS
		
		lw t6, 0(t2)
		sw t6, 0(t3)
		lw t6, 4(t2)
		sw t6, 4(t3)
		lw t6, 8(t2)
		sw t6, 8(t3)
		
		addi t2, t2, 20
		addi t3, t3, 12
		addi t5, t5, -1
		
		PULA_COPIA_PERSONAGENS: nop
		
		addi t0, t0, 28
		addi t1, t1, 12
		addi t4, t4, -1
		
		jal zero, FOR1_COPIAR_OBJETOS
	
	EXIT_FOR1_COPIAR_OBJETOS: nop
	
	ret
#####################

######## APAGAR_OBJETOS()
## apaga objetos no frame
APAGAR_OBJETOS: nop
	addi sp, sp, -4
	sw ra, 0(sp)
	
	## Informacoes do vetor objetos ##
	la s0, Copia_Objetos	# vetor
	li s1, 20
	
	## Informacoes sobre o Vetor Personagens ##
	la s2, Copia_Personagens
	li s3, 4
	
	## Percorrer vetor Objetos e Personagens e Apagar os Existentes do Display ##
	FOR1_APAGAR_OBJETOS: nop
		## Percorre Objetos ##
		beq s1, zero, EXIT_FOR1_APAGAR_OBJETOS
		
		## Se objeto existir, apague ##
		lw a0, 0(s0)	# imagem [] | flag existencia
		beq a0, zero, PULAR_OBJETO_NAO_EXISTENTE
		
		## Apaga o Objeto ##
		lw a1, 4(s0)	# posicao X
		lw a2, 8(s0)	# posicao Y
		li a3, 0		# flag 0 -> apagar
		la t0, CRIAR_QUADRADO
		jalr ra, t0, 0
		
		PULAR_OBJETO_NAO_EXISTENTE: nop
		
		## Percorre Personagens se Ainda nao terminou ##
		beq s3, zero, IGNORA_PERSONAGENS
		
		## Se personagem existir, apague ##
		lw a0, 0(s2)	# imagem [] | flag existencia
		beq a0, zero, PULAR_PERSONAGEM_NAO_EXISTENTE
		
		## Apaga personagem ##
		lw a1, 4(s2)	# posicao X
		lw a2, 8(s2)	# posicao Y
		li a3, 0		# flag 0 -> apagar
		la t0, CRIAR_QUADRADO
		jalr ra, t0, 0

		PULAR_PERSONAGEM_NAO_EXISTENTE: nop
		addi s3, s3, -1	# personagens--
		addi s2, s2, 12	# proximo personagem
		
		IGNORA_PERSONAGENS: nop
		addi s1, s1, -1	# objetos--
		addi s0, s0, 12	# proximo objeto
		
		jal zero, FOR1_APAGAR_OBJETOS
		
	EXIT_FOR1_APAGAR_OBJETOS: nop
	
	lw ra, 0(sp)
	addi sp, sp, 4
	
	ret
######################
