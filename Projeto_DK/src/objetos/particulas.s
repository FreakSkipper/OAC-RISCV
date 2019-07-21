.data

.include "..\..\images\bala.s"

	Particulas: .space 360
	Copia_Particulas: .space 240
	TempoParticulas: .word 0
.text

CRIAR_PARTICULA: nop
	la t0, Municao
	lbu t1, 0(t0)
	beq t1, zero, EXIT_FOR1_CRIAR_PARTICULA
	
	addi t1, t1, -1
	sb t1, 0(t0)
	
	la t0, Particulas
	li t1, 60
	
	FOR1_CRIAR_PARTICULA: nop
		beq t1, zero, EXIT_FOR1_CRIAR_PARTICULA
		
		lhu t2, 0(t0)
		beq t2, zero, ENCONTROU_PARTICULA_LIVRE
		
		addi t0, t0, 6
		addi t1, t1, -1
		jal zero, FOR1_CRIAR_PARTICULA
	EXIT_FOR1_CRIAR_PARTICULA: nop
	ret
	
ENCONTROU_PARTICULA_LIVRE: nop
	la t5, Personagens
	lw t1, 4(t5)
	lw t2, 8(t5)
	
	lw t3, 0(t5)
	lw t4, 4(t3)	# altura
	
	srai t4, t4, 1	# altura / 2
	
	add t2, t2, t4
	
	la t5, Ultima_Direcao
	lb t5, 0(t5)
	
	beq t5, zero, DISPARAR_ESQUERDA
	
	lw t4, 0(t3)	# largura
	add t1, t1, t4	
	li t4, 1	# direita
	jal zero, CONTINUAR_DISPARO
	DISPARAR_ESQUERDA: nop
	li t4, 0	# esquerda
	CONTINUAR_DISPARO: nop
	sh t1, 0(t0)
	sh t2, 2(t0)
	sh t4, 4(t0)
	
	ret
	
DESENHAR_PARTICULAS: nop
	la t0, Municao
	lbu t0, 0(t0)
	beq t0, zero, ENCERRA_DESENHAR_PARTICULAS

	mv s5, ra
	
	la s7, Particulas
	li s6, 60
	FOR1_DESENHAR_PARTICULAS: nop
		beq s6, zero, EXIT_FOR1_DESENHAR_PARTICULAS
		
		lhu t2, 0(s7)
		beq t2, zero, PULAR_PARTICULA
		
		la a0, bala
		lhu a1, 0(s7)
		lhu a2, 2(s7)
		lhu t4, 4(s7)
		
		beq t4, zero, DISPARO_ESQUERDA
		addi a1, a1, 10
		jal zero, DISPARADO
		
		DISPARO_ESQUERDA: nop
		addi a1, a1, -10
		
		DISPARADO: nop
		jal ra, VERIFICAR_CHAO_PARTICULA
		
		li t4, 300
		bgt a1, t4, DESTRUIR_PARTICULA
		li t4, 2
		blt a1, t4, DESTRUIR_PARTICULA
		
		sh a1, 0(s7)
		
		li a3, 1
		li a4, 0
		la t3, CRIAR_QUADRADO
		jalr ra, t3, 0
		
		PULAR_PARTICULA: nop
		addi s7, s7, 6
		addi s6, s6, -1
		jal zero, FOR1_DESENHAR_PARTICULAS
	EXIT_FOR1_DESENHAR_PARTICULAS: nop
	
	mv ra, s5
	ENCERRA_DESENHAR_PARTICULAS: nop
	ret

DESTRUIR_PARTICULA: nop
	lhu t4, 4(s7)
	beq t4, zero, DISPARO_ESQUERDA2
	addi a1, a1, 10
	jal zero, DISPARADO2
		
	DISPARO_ESQUERDA2: nop
	addi a1, a1, -10
	
	DISPARADO2: nop
	li a3, 0
	li a4, 0
	la t3, CRIAR_QUADRADO
	jalr ra, t3, 0
	
	li a1, 0
	sh a1, 0(s7)
	
	jal zero, PULAR_PARTICULA

COPIAR_PARTICULAS: nop
	la t0, Particulas
	li t1, 60
	la t2, Copia_Particulas
	FOR1_COPIAR_PARTICULAS: nop
		beq t1, zero, EXIT_FOR1_COPIAR_PARTICULAS
		
		lhu t3, 0(t0)
		lhu t4, 2(t0)
		
		sh t3, 0(t2)
		sh t4, 2(t2)
		
		addi t2, t2, 4
		addi t0, t0, 6
		addi t1, t1, -1
		jal zero, FOR1_COPIAR_PARTICULAS
	EXIT_FOR1_COPIAR_PARTICULAS: nop
	
	ret
	
APAGAR_PARTICULAS: nop
	mv s5, ra
	
	la s7, Copia_Particulas
	li s6, 60
	FOR1_APAGAR_PARTICULAS: nop
		beq s6, zero, EXIT_FOR1_APAGAR_PARTICULAS
		
		lhu t2, 0(s7)
		beq t2, zero, PULAR_PARTICULA_APAGAR
		
		la a0, bala
		lhu a1, 0(s7)
		lhu a2, 2(s7)
		li a3, 0
		li a4, 0
		la t3, CRIAR_QUADRADO
		jalr ra, t3, 0
		
		jal ra, VERIFICAR_COLISAO_PARTICULA
		
		PULAR_PARTICULA_APAGAR: nop
		addi s7, s7, 4
		addi s6, s6, -1
		jal zero, FOR1_APAGAR_PARTICULAS
	EXIT_FOR1_APAGAR_PARTICULAS: nop
	
	mv ra, s5
	ret

##########################################################
# a0 -> imagem
# a1 -> posicao X
# a2 -> posicao Y
VERIFICAR_COLISAO_PARTICULA: nop
	la t0, Municao
	lb t0, 0(t0)
	beq t0, zero, EVITAR_COLISAO_PARTICULAS

	addi sp, sp, -24
	sw ra, 0(sp)
	la t0, Objetos
	li t1, 20
	
	lw t2, 0(a0)	# largura imagem[]
	add t2, t2, a1	# x final meu
	
	lw t3, 4(a0)	# altura imagem[]
	add t3, t3, a2	# y final meu
	FOR1_COLISAO_PARTICULA: nop
		beq t1, zero, EXIT_FOR1_COLISAO_PARTICULA
		
		lw t5, 0(t0)
		beq t5, zero, NAO_ACHOU_COLISAO_PARTICULA
		
		## colisao em X
		lw t4, 4(t0)	# x inicial dele
		blt t4, a1, FALHA_1_P
		bge t2, t4, SUCESSO_X_P
		FALHA_1_P: nop
		bgt t4, a1, NAO_ACHOU_COLISAO_PARTICULA
		lw t5, 0(t0)	# imagem[]
		lw t6, 0(t5)	# largura dele
		add t6, t6, t4	# x final dele
		bge t6, a1, SUCESSO_X_P
		jal zero, NAO_ACHOU_COLISAO_PARTICULA
		
		SUCESSO_X_P: nop
		## colisao em Y
		lw t4, 8(t0)	# y inicial dele
		blt t4, a2, FALHA_2_P
		bge t3, t4, COLIDIU_PARTICULA
		FALHA_2_P: nop
		bgt t4, a2, NAO_ACHOU_COLISAO_PARTICULA
		lw t5, 0(t0)	# imagem[]
		lw t6, 4(t5)	# altura dele
		add t6, t6, t4	# y final dele
		bge t6, a2, COLIDIU_PARTICULA
		jal zero, NAO_ACHOU_COLISAO_PARTICULA
		
		NAO_ACHOU_COLISAO_PARTICULA: nop
		
		addi t0, t0, 28
		addi t1, t1, -1
		jal zero, FOR1_COLISAO_PARTICULA
	EXIT_FOR1_COLISAO_PARTICULA: nop
	
	lw ra, 0(sp)
	addi sp, sp, 24
	EVITAR_COLISAO_PARTICULAS: nop
	ret
COLIDIU_PARTICULA : nop
	
	sw t0, 4(sp)
	sw t1, 8(sp)
	sw a0, 12(sp)
	sw a1, 16(sp)
	sw a2, 20(sp)
	
	jal ra, INVERTER_FRAME_DESENHAR
	
	li a3, 0
	li a4, 0
	la t4, CRIAR_QUADRADO
	jalr ra, t4, 0
	
	lw t0, 4(sp)
	lw a0, 0(t0)
	lw a1, 4(t0)
	lw a2, 8(t0)
	
	li t4, 0
	sw t4, 0(t0)
	
	la t4, Quantidade_Objetos
	lb t5, 0(t4)
	addi t5, t5, -1
	sb t5, 0(t4)
	
	li a3, 0
	li a4, 0
	la t4, CRIAR_QUADRADO
	jalr ra, t4, 0
	
	jal ra, INVERTER_FRAME_DESENHAR
	
	la t0, Pontuacao
	lhu t1, 0(t0)
	addi t1, t1, 350
	sh t1, 0(t0)
	
	lw t0, 4(sp)
	lw t1, 8(sp)
	lw a0, 12(sp)
	lw a1, 16(sp)
	lw a2, 20(sp)
	
	jal zero, NAO_ACHOU_COLISAO_PARTICULA
################################################
INVERTER_FRAME_DESENHAR: nop
	la t6, Frame_Desenhar
	lw t5, 0(t6)
	
	li t4, 0xFF000000
	beq t5, t4, FRAME_D_1
	
	li t4, 0xFF000000
	sw t4, 0(t6)
	ret
	
	FRAME_D_1:nop
	li t4, 0xFF100000
	sw t4, 0(t6)
	
	ret
###############################################			
RESETAR_PARTICULAS: nop	
	la t4, Particulas
	li t5, 60
	FOR1_RESETAR_PARTICULAS: nop
		beq t5, zero, EXIT_FOR1_RESETAR_PARTICULAS
		
		li t3, 0
		sh t3, 0(t4)
		
		addi t4, t4, 6
		addi t5, t5, -1
		jal zero, FOR1_RESETAR_PARTICULAS
	EXIT_FOR1_RESETAR_PARTICULAS: nop
	
	ret

####### bool verificar_chao_particula(int x, int y)
## verifica se a imagem toca a escada
# a0 -> posicao X
# a1 -> posicao Y
VERIFICAR_CHAO_PARTICULA: nop
	### achando a posicao no display para desenhar ##
	li t0, 320
	mul t0, t0, a2		# 320 * y
	add t0, t0, a1		# 320 * y + x
	la t1, mapa		# endereço inicial do mapa
	addi t1, t1, 8		# pula struct do mapa

	add t0, t0, t1		# 320*y + x + end.Inicial
	
	la t6, bala
	lw t1, 0(t6)			# largura da imagem
	lw t2, 4(t6)			# altura da imagem
FOR1_VERIFICAR_CHAO_PARTICULA: nop
		beq t2, zero, EXIT_FOR1_VERIFICAR_CHAO_PARTICULA
		
		## verificar se pixel eh igual a cor ##
		lb t3, 0(t0)
		
		la t4, Chao
		lb t5, 0(t4)
		beq t3, t5, ENCONTROU_CHAO_PARTICULA
		lb t5, 1(t4)
		beq t3, t5, ENCONTROU_CHAO_PARTICULA
		lb t5, 2(t4)
		beq t3, t5, ENCONTROU_CHAO_PARTICULA
		lb t5, 3(t4)
		beq t3, t5, ENCONTROU_CHAO_PARTICULA
		lb t5, 4(t4)
		beq t3, t5, ENCONTROU_CHAO_PARTICULA
		lb t5, 5(t4)
		beq t3, t5, ENCONTROU_CHAO_PARTICULA
		
		## verifica quebra de linha ##
		addi t1, t1, -1
		addi t0, t0, 1
		#addi t6, t6, 1	# debug
		bne t1, zero, NAO_QUEBRA_LINHA_PART
		## se ja alcancou largura da imagem, quebra linha ##
		addi t0, t0, 320
		lw t1, 0(t6)
		sub t0, t0, t1
		#addi t6, t6, 320	# debug
		#sub t6, t6, t1		# debug
		addi t2, t2, -1	# contador de linhas --
NAO_QUEBRA_LINHA_PART: nop
		jal zero, FOR1_VERIFICAR_CHAO_PARTICULA

EXIT_FOR1_VERIFICAR_CHAO_PARTICULA: nop
		ret
ENCONTROU_CHAO_PARTICULA: nop
		jal zero, DESTRUIR_PARTICULA
#######################
