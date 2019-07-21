.data
.include "..\..\..\images\titulo.s"

	StringButton: .string "Press Start Button"
	StringGrupo: .string "(c) 2019 Grupo 01 - OAC"
	StringUnB: .string "Universidade de Brasilia - UnB"
.text

TELA_INICIAL: nop
	mv s10, ra
	
	la t0, Frame_Desenhar
	li t1, 0xFF000000
	sw t1, 0(t0)
	
	la t0, Fase
	li t1, 0
	sb t1,0(t0)
	
	### FRAME ZERO ###
	li t0, 0xFF200604
	li t1, 0
	sw t1, 0(t0)
	
	la t0, APAGAR_MAPA
	jalr ra, t0, 0
	
	la a0, chao_3
	li a3, 1
	la s5, CRIAR_QUADRADO
	
	li a1, 0
	li a2, 0
	li a4, 0
	li a5, 37
	la t0, DESENHAR_QUADRADO
	jalr ra, t0, 0

	la a0, shis
	li a4, 1
	li a5, 25
	la t0, DESENHAR_QUADRADO
	jalr ra, t0, 0
	
	li a1, 8
	li a2, 0
	la t0, DESENHAR_QUADRADO
	jalr ra, t0, 0
	
	la a0, chao_3
	li a1, 0
	li a2, 208
	li a4,0
	li a5, 37
	la t0, DESENHAR_QUADRADO
	jalr ra, t0, 0
	
	la a0, kong_center
	li a1, 140
	li a2, 40
	li a3, 1
	la t0, CRIAR_QUADRADO
	jalr ra, t0, 0
	
	la a0, titulo
	li a1, 100
	li a2, 80
	li a3, 1
	la t0, CRIAR_QUADRADO
	jalr ra, t0, 0
	
	la a0, StringGrupo
	li a1, 60
	li a2, 220
	li a3, 0x00FF
	li a4, 0
	li a7, 104
	ecall
	
	la a0, StringUnB
	li a1, 40
	li a2, 228
	li a3, 0x00FF
	li a4, 0
	li a7, 104
	ecall
	
	la a0, StringButton
	li a1, 90
	li a2, 150
	li a3, 0x00FF
	li a4, 0
	li a7, 104
	ecall
	
	#### AGUARDA START BUTTON ####
	LOOP1_TELA_INICIAL: nop
	la t0, CONTROLE
	jalr ra, t0, 0
	
	#### DETECTA CLICK BOTAO ADC ####
	la t0, Controle_sw	# Direcao X
	lb t1, 0(t0)		# botao adc
	
	li t2, 1
	beq t1, t2, EXIT_LOOP1_TELA_INICIAL	
	jal zero, LOOP1_TELA_INICIAL
	EXIT_LOOP1_TELA_INICIAL: nop
	###############################
	
	
	mv ra, s10
	ret
