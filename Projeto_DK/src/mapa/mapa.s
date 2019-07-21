.data
.include "..\..\images\mapa.s"

.text

##### APAGAR_MAPA ######
## apaga todo o vetor mapa e limpa tela ##
APAGAR_MAPA: nop
	la t0, mapa
	addi t0, t0, 8	# pula struct
	li t1, 76800	# tamanho total
	add t1, t1, t0	# endereco final do mapa
	
	la t2, Fase
	lb t2, 0(t2)
	
	li t3, 4
	beq t3, t2, CEU_AZUL
	li t2, 0		# preto
	jal zero, NOT_CEU_AZUL
	CEU_AZUL: nop
	li t2, 0xEAEAEAEA
	
	NOT_CEU_AZUL: nop
	li t3, 0xFF000000
	li t4, 0xFF100000
	
	FOR1_ATUALIZAR_MAPA: nop
		beq t0, t1, EXIT_FOR1_ATUALIZAR_MAPA
		
		sw t2, 0(t0)
		sw t2, 0(t3)
		sw t2, 0(t4)
		
		addi t0, t0, 4
		addi t3, t3, 4
		addi t4, t4, 4
		
		jal zero, FOR1_ATUALIZAR_MAPA
	EXIT_FOR1_ATUALIZAR_MAPA: nop		
	
	ret
###############################################

##### APAGAR_MAPA_FRAME ######
## apaga todo o frame ##
APAGAR_MAPA_FRAME: nop
	li t0, 0xFF000000
	
	li t1, 0xFF200604
	lw t1, 0(t1)
	
	bne t1, zero, INICIAR_APAGAR_MAPA_FRAME
	li t0, 0xFF100000
	INICIAR_APAGAR_MAPA_FRAME: nop
	li t1, 76800
	add t1, t1, t0
	li t2, 0
	FOR1_APAGAR_MAPA_FRAME: nop
		beq t0, t1, EXIT_FOR1_APAGAR_MAPA_FRAME
		
		sw t2, 0(t0)
		
		addi t0, t0, 4
		
		jal zero, FOR1_APAGAR_MAPA_FRAME
	EXIT_FOR1_APAGAR_MAPA_FRAME: nop		
	
	ret
###############################################

#### DESENHAR_MAPA #######
## desenha todo o mapa no display ##
DESENHAR_MAPA: nop
	la t0, mapa
	addi t0, t0, 8	# pula struct
	li t1, 76800	# tamanho total
	add t1, t1, t0	# endereco final do mapa
	
	la t3, Frame_Desenhar
	lw t3, 0(t3)	# frame
	
	FOR1_DESENHAR_MAPA: nop
		beq t0, t1, EXIT_FOR1_DESENHAR_MAPA
		
		lw t2, 0(t0)
		sw t2, 0(t3)
		addi t0, t0, 4
		addi t3, t3, 4
		
		jal zero, FOR1_DESENHAR_MAPA
	EXIT_FOR1_DESENHAR_MAPA: nop		
	
	ret
##############################################

#### PROXIMO_MAPA #######
## avanca para o proximo mapa 
PROXIMO_MAPA: nop
	mv s10, ra

	######## SETA NOVA FASE #######
	la t0, Fase
	lb t1, 0(t0)
	addi t1, t1, 1
	sb t1, 0(t0)
	#################################
	
	######### APAGA DISPLAY E MAPA ########
	la t0, APAGAR_MAPA
	jalr ra, t0, 0
	######################################
	
	####### RESETA OBJETOS E PERSONAGENS #########
	la t0, RESETAR_OBJETOS
	jalr ra, t0, 0
	############################################
	
	####### RESETA A FASE ########
	la t0, RESETAR_FASE
	jalr ra, t0, 0
	###############################
	
	######## ATRIBUI AO VETOR DE MAPA #########
	la t0, Frame_Desenhar
	la t1, mapa
	addi t1, t1, 8
	sw t1, 0(t0)
	###########################################
	
	####### VERIFICA QUAL FASE SERA DESENHADA ########
	la t0, Fase
	lb t1, 0(t0)
	
	li t2, 1
	beq t1, t2, EH_MAPA2
	li t2, 2
	beq t1, t2, EH_MAPA3
	li t2, 3
	beq t1, t2, EH_MAPA4
	li t2, 4
	beq t1, t2, EH_MAPA5
	
	la t0, CRIAR_MAPA
	jalr ra, t0, 0
	jal zero, CONTINUAR_NEXT_LEVEL
	
	
	EH_MAPA2: nop
	la t0, CRIAR_MAPA3
	jalr ra, t0, 0
	jal zero, CONTINUAR_NEXT_LEVEL
	EH_MAPA3: nop
	la t0, CRIAR_MAPA2
	jalr ra, t0, 0
	jal zero, CONTINUAR_NEXT_LEVEL
	EH_MAPA4: nop
	la t0, CRIAR_MAPA4
	jalr ra, t0, 0
	jal zero, CONTINUAR_NEXT_LEVEL
	EH_MAPA5: nop
	la t0, CRIAR_MAPA5
	jalr ra, t0, 0
	##################################################
	
	CONTINUAR_NEXT_LEVEL:nop
	###### DESENHA O MAPA NO FRAME 0 e 1 #####
	li t0, 0xFF200604
	li t1, 0
	sw t1, 0(t0)
	
	la t0, Frame_Desenhar
	li t1, 0xFF000000
	sw t1, 0(t0)
	
	la t0, DESENHAR_MAPA
	jalr ra, t0, 0
	
	la t0, Frame_Desenhar
	li t1, 0xFF100000
	sw t1, 0(t0)
	
	la t0, DESENHAR_MAPA
	jalr ra, t0, 0
	
	la t0, Fase
	lb t1, 0(t0)
	
	li t2, 3
	beq t1, t2, EH_MUSICA_ESGOTO
	li t2, 4
	beq t1, t2, EH_MUSICA_CASTELO
	jal zero, FIM_PROXIMO_MAPA
	
	EH_MUSICA_ESGOTO: nop
	la t0, MUSICA_ESGOTO
	jalr ra, t0, 0
	jal zero, FIM_PROXIMO_MAPA
	
	EH_MUSICA_CASTELO: nop
	la t0, MUSICA_CASTELO
	jalr ra, t0, 0	
	##########################################
	
	
	###### VOLTA AO JOGO ########
	FIM_PROXIMO_MAPA: nop
	mv ra, s10
	ret
###################################################
