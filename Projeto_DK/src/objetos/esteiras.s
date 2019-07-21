.data
.include "..\..\images\roda_esteira.s"
.include "..\..\images\roda_esteira2.s"
.include "..\..\images\roda_esteira3.s"
#.include "..\..\images\roda_esteira_right.s"
#.include "..\..\images\roda_esteira2_right.s"
#.include "..\..\images\roda_esteira3_right.s"
	Esteiras: .word roda_esteira, 15, 189,287, 0, 0, roda_esteira, 172, 104,140,1, 0, roda_esteira, 15, 62,287,1, 0
	Frames_Troca: .byte 250
.text

MOVER_ESTEIRAS: nop
	la t0, Fase
	lb t0, 0(t0)
	li t1, 1
	bne t0, t1, FIM_MOVER_ESTEIRAS
	
	mv s1, ra
	
	la s3, Esteiras
	li s2, 3
	FOR1_MOVER_ESTEIRAS: nop
		beq s2, zero, EXIT_FOR1_MOVER_ESTEIRAS
		lw a0, 0(s3)
		lw a1, 4(s3)
		lw a2, 8(s3)
		li a3, 1
		li a4, 0
		la t1, CRIAR_QUADRADO
		jalr ra, t1, 0
		
		li a4, 1
		la t1, roda_esteira
		beq a0, t1, RODA_ESTEIRA1
		
		la t1, roda_esteira2
		beq a0, t1, RODA_ESTEIRA3
		
		la a0, roda_esteira2
		jal zero, DESENHAR_ESTEIRA
		
		RODA_ESTEIRA1: nop
		la a0, roda_esteira
		jal zero, DESENHAR_ESTEIRA
		
		RODA_ESTEIRA3: nop
		la a0, roda_esteira3
		
		DESENHAR_ESTEIRA: nop
		lw a1, 12(s3)
		
		la t1, CRIAR_QUADRADO
		jalr ra, t1, 0
		
		lw a0, 0(s3)
		lw a1, 4(s3)
		
		lw t1, 20(s3)
		addi t1, t1, -1
		
		bgt t1, zero, NAO_CRIA_TORTA
		li t1, 1
		beq s2, t1, NAO_CRIA_TORTA
		
		li t1, 20
		li a7, 41
		ecall
		
		remu t1, a0, t1
		addi t1, t1, 50
		sw t1, 20(s3)
		
		jal ra, CRIAR_TORTA
		jal zero, IGNORAR_SAVE_TORTA
		NAO_CRIA_TORTA: nop
		sw t1, 20(s3)
		IGNORAR_SAVE_TORTA: nop
		lw t3, 16(s3)

		beq t3, zero, MOV_ESTEIRA_ESQUERDA
		jal zero, MOV_ESTEIRA_DIREITA
		
		CONTINUAR_MOVER_ESTEIRA: nop
		
		la t1, Frames_Troca
		lbu t2, 0(t1)
		addi t2, t2, -1
		bgt t2, zero, NAO_TROCOU_ESTEIRA
		
		li t2, 250
		lw t3, 16(s3)
		xori t3, t3, 1
		sw t3, 16(s3)
		
		NAO_TROCOU_ESTEIRA: nop
		sb t2, 0(t1)
		
		addi s2, s2, -1
		addi s3, s3, 24
		jal zero, FOR1_MOVER_ESTEIRAS
	EXIT_FOR1_MOVER_ESTEIRAS: nop
	mv ra, s1
	FIM_MOVER_ESTEIRAS: nop
	ret
	
MOV_ESTEIRA_ESQUERDA: nop
	la t2, roda_esteira
	beq a0, t2, ESTEIRA3
	la t2, roda_esteira3
	beq a0, t2, ESTEIRA2
	la a0, roda_esteira
	jal zero, FIM_ANIM_ESTEIRA_ESQ
	
	ESTEIRA3: nop
	la a0, roda_esteira3
	jal zero, FIM_ANIM_ESTEIRA_ESQ
	ESTEIRA2: nop
	la a0, roda_esteira2
	
	FIM_ANIM_ESTEIRA_ESQ: nop
	sw a0, 0(s3)
	
	li t6, -1
	
	jal zero, ESTEIRAR_OBJETOS
	
MOV_ESTEIRA_DIREITA: nop
	la t2, roda_esteira
	beq a0, t2, ESTEIRA2_DIR
	la t2, roda_esteira2
	beq a0, t2, ESTEIRA3_DIR
	la a0, roda_esteira
	jal zero, FIM_ANIM_ESTEIRA_DIR
	
	ESTEIRA3_DIR: nop
	la a0, roda_esteira3
	jal zero, FIM_ANIM_ESTEIRA_DIR
	ESTEIRA2_DIR: nop
	la a0, roda_esteira2
	
	FIM_ANIM_ESTEIRA_DIR: nop
	sw a0, 0(s3)
	
	li t6, 1
	
######## ESTEIRAR_OBJETOS()
ESTEIRAR_OBJETOS: nop	
	la t0, Personagens
	la t1, Objetos
	
	li t2, 3
	li t3, 20
	
	lw t5, 8(s3)
	FOR1_ESTEIRAR_OBJETOS: nop
		## Percorre Objetos ##
		beq t3, zero, EXIT_FOR1_ESTEIRAR_OBJETOS
		
		lw a0, 0(t1)	# imagem [] | flag existencia
		beq a0, zero, PULAR_OBJETO_NAO_EXISTENTE_ESTEIRAR
		
		lw a2, 8(t1)	# posicao Y
		lw t4, 4(a0)
		add a2, a2, t4
		addi a2, a2, -2
		bne t5, a2, PULAR_OBJETO_NAO_EXISTENTE_ESTEIRAR
		lw a1, 4(t1)
		add a1, a1, t6
		sw a1, 4(t1)
		
		PULAR_OBJETO_NAO_EXISTENTE_ESTEIRAR: nop
		
		beq t2, zero, IGNORA_PERSONAGENS_ESTEIRAR
		
		lw a0, 0(t0)	# imagem [] | flag existencia
		beq a0, zero, PULAR_PERSONAGEM_NAO_EXISTENTE_ESTEIRAR
		
		lw a2, 8(t0)	# posicao Y
		lw t4, 4(a0)
		add a2, a2, t4
		addi a2, a2, -3
		bne a2, t5, NAO_ENCONTROU_1
		NAO_ENCONTROU_1: nop
		addi a2, a2, 1
		bne a2, t5, PULAR_PERSONAGEM_NAO_EXISTENTE_ESTEIRAR
		lw a1, 4(t0)
		add a1, a1, t6
		sw a1, 4(t0)
		
		PULAR_PERSONAGEM_NAO_EXISTENTE_ESTEIRAR: nop
		addi t2, t2, -1	# personagens--
		addi t0, t0, 20	# proximo personagem
		
		IGNORA_PERSONAGENS_ESTEIRAR: nop
		addi t3, t3, -1	# objetos--
		addi t1, t1, 28	# proximo objeto
		
		jal zero, FOR1_ESTEIRAR_OBJETOS
		
	EXIT_FOR1_ESTEIRAR_OBJETOS: nop
	
	jal zero, CONTINUAR_MOVER_ESTEIRA
######################

CRIAR_TORTA: nop	
	mv s4, ra
	
	lw a3, 16(s3)
	bne a3, zero, CRIAR_TORTA_ESQUERDA
	li a1, 272	
	jal zero, CONTINUAR_CRIAR_TORTAS
	CRIAR_TORTA_ESQUERDA: nop
	li a1, 30
	CONTINUAR_CRIAR_TORTAS: nop

	addi a2, a2, -7
	li a0, 2
	la t3, CRIAR_OBJETO
	jalr ra, t3, 0
	
	mv ra, s4
	ret
