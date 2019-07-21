.include "macros3.s"
.text

RotinaTratamento(exceptionHandling)

MAIN: nop
	li t0, VGAADDRESSINI0	# frame 0
	li t2, VGAADDRESSFIM0	# end
	li t3, 0			# preto
	
	FOR1_MAIN:	beq t0, t2, EXIT_FOR1_MAIN
		sw t3, 0(t0)	# pixel word azul frame 0
		addi t0, t0, 4	# proximo word frame 0
		j FOR1_MAIN
	
	## Printa String de Erro Exception no Frame 0 ##
	EXIT_FOR1_MAIN:

	li s0, 50	# posicao INICIAL X
	li s1, 50	# posicao INICIAL Y

LOOP: li t0, VGAADDRESSINI0
	li t1, 76800
	add t1, t0, t1
	
WHILEW: li t2, 0
	sw t2, 0(t0)
	addi t0, t0, 4
	blt t0, t1, WHILEW

#j LOOP

#li a7, 10
#ecall

WHILE: li t0, STOPWATCH
	#lw t2, 0(t0)
	
	#blt t2, s3, WHILE
	
	jal Keyboard_Analog
	#ebreak
	#srai a0, a0, 2			# dividir por 4
	#srai a1, a1, 2
	#add s0, s0, a0
	#add s1, s1, a1
	#mv a0, s0				# valor do analogico (-32 a 32)
	#mv a1, s1
	#ebreak
	jal ra, CRIAR_QUADRADO
	#ebreak
	li t0, 0xFF200200
	lw a0, 0(t0)
	li a1, 20
	li a2, 20
	li a3, 0x00FF
	li a4, 0
	li a7, 101
	ecall

	li t0, 0xFF200204
	lw a0, 0(t0)
	li a1, 20
	li a2, 40
	li a3, 0x00FF
	li a4, 0
	li a7, 101
	ecall
	
	li t0, 0xFF200510
	lw t2, 0(t0)
	addi s3, t2, 100
	
	jal zero, WHILE

EXIT_WHILE:nop
li a7, 10
ecall
	
### CRIAR QUADRADO ###
## cria um quadrado no frame 0
# a0 -> posicao X
# a1 -> posicao Y
CRIAR_QUADRADO: nop
	addi sp, sp, -4
	sw ra, 0(sp)
	jal QUADRADO_VELOCIDADE						# criar intervalos de velocidade
	#ebreak
	## condicoes de fim de mapa ##
	blt a0, zero, EXCEDEU_CRIAR_QUADRADO_E
	li t0, 300
	bgt a0, t0, EXCEDEU_CRIAR_QUADRADO_D
	blt a1, zero, EXCEDEU_CRIAR_QUADRADO_C
	li t0, 220
	bgt a1, t0, EXCEDEU_CRIAR_QUADRADO_B
	
	li t0, 0xFF000000
	li t2, 320
	mul t2, t2, a1	# 320 * y
	add t2, t2, a0	# 320 * y + x
	add t0, t0, t2	# 320 * y + x + End.Inicial
	
	li t1, 255	# max cores
	mv t4, a0	# save a0
	li a7, 41
	ecall
	remu t1, a0, t1	# cor aleatoria
	mv a0, t4
	
	li t2, 8	# largura
	li t3, 8	# altura
	FOR1_CRIAR_QUADRADO: nop
		beq t3, zero, FIM_CRIAR_QUADRADO
		
		sb t1, 0(t0)
		addi t2, t2, -1
		bne t2, zero, NAO_ENCERROU_LINHA

		li t2, 8			# reseta largura
		addi t0, t0, 320	# proxima linha
		sub t0, t0, t2		# ajusta para inicio da linha
		addi t3, t3, -1		# altura--
		jal zero, FOR1_CRIAR_QUADRADO
		
		NAO_ENCERROU_LINHA: nop
		addi t0, t0, 1
		jal zero, FOR1_CRIAR_QUADRADO
	
	EXCEDEU_CRIAR_QUADRADO_E: nop
	addi a0, a0, 4
	jal zero, FIM_CRIAR_QUADRADO

	EXCEDEU_CRIAR_QUADRADO_D: nop
	addi a0, a0, -4
	jal zero, FIM_CRIAR_QUADRADO
	
	EXCEDEU_CRIAR_QUADRADO_C: nop
	addi a1, a1, 4
	jal zero, FIM_CRIAR_QUADRADO

	EXCEDEU_CRIAR_QUADRADO_B: nop
	addi a1, a1, -4
	
	FIM_CRIAR_QUADRADO: lw ra, 0(sp)
	addi sp, sp, 4
	ret
	
# Confere se um direcional foi pressionado no teclado ou houve movimentacao no analogico
## D� preferencia para o Keyboard
## return:
## - a0 : valor -10 a 10 X
## - a1 : valor -10 a 10 Y
Keyboard_Analog:	li a0, 0
	li a1, 0
	#ebreak
	li t0, KDMMIO_Ctrl
	lw t1, 0(t0)	
	andi t1, t1, 0x001					# mascara o bit menos significativo			
	beq t1, zero, Key_Anag2_X			# se n tiver leitura do teclado
	li t0, KDMMIO_Data
	lw t1, 0(t0)						# tecla pressionada
	sw t1, 8(t0)						# mostrar em 0xff20000c
	
	li t0,  's' 							# seta baixo S
	beq t1, t0, Key_Anag_baixo
	li t0, 'w'							# seta cima W
	beq t1, t0, Key_Anag_cima
	li t0, 'a' 							# seta esquerda A
	beq t1, t0, Key_Anag_esquerda
	li t0, 'd'							# seta direita D
	beq t1, t0, Key_Anag_direita
	
	j Key_Anag2_fim
	
Key_Anag_baixo: li a0, 0
	li a1, 32
	j Key_Anag2_fim
Key_Anag_cima: li a0, 0
	li a1, -32
	j Key_Anag2_fim
Key_Anag_esquerda: li a0, -32
	li a1, 0
	j Key_Anag2_fim
Key_Anag_direita: li a0, 32
	li a1, 0
	j Key_Anag2_fim
	
Key_Anag2_X:	li t0, ADC_CH0				# eixo X
	lw t1, 0(t0)							# valor
	li t2, 0x9A0							# offset
	blt t1, t2, Key_Anag2_X_menor 
Key_Anag2_X_maior: sub t1, t1, t2			# valor - offset								
	li t3, 52							# cte para X maior q offset
	div t1, t1, t3						# t1 velocidade de 0 a 10
	mv a0, t1
	j Key_Anag2_Y						

Key_Anag2_X_menor: sub t1, t1, t2			# valor - offset								
	li t3, 73							# cte para X menor q offset
	div t1, t1, t3						# t1 velocidade de 0 a -10
	mv a0, t1
	j Key_Anag2_Y
	
	
Key_Anag2_Y:	li t0, ADC_CH1				# eixo Y
	lw t1, 0(t0)							# valor
	li t2, 0x9A0							# offset
	blt t1, t2, Key_Anag2_Y_menor 
Key_Anag2_Y_maior: sub t1, t1, t2			# valor - offset								
	li t3, 52							# cte para X maior q offset
	div t1, t1, t3						# t1 velocidade de 0 a 10
	mv a1, t1
	j Key_Anag2_fim					

Key_Anag2_Y_menor: sub t1, t1, t2			# valor - offset								
	li t3, 73							# cte para X menor q offset
	div t1, t1, t3						# t1 velocidade de 0 a -10
	mv a1, t1
	
Key_Anag2_fim: ret

########################################
## Argumentos
# a0 -> X
# a1 -> Y
QUADRADO_VELOCIDADE: blt a0, zero, Quadrado_x_neg
	li t0, 30			# pos. relativa do analogico (0 - 32)
	blt a0, t0, Quadrado_x_vel_4
	li a0, 8							# velocidade real
	j Quadrado_y
	
Quadrado_x_vel_4: li t0, 24
	blt a0, t0, Quadrado_x_vel_3
	li a0, 6
	j Quadrado_y
	
Quadrado_x_vel_3: li t0, 18			
	blt a0, t0, Quadrado_x_vel_2
	li a0, 4
	j Quadrado_y
	
Quadrado_x_vel_2: li t0, 12
	blt a0, t0, Quadrado_x_vel_1
	li a0, 2
	j Quadrado_y
	
Quadrado_x_vel_1: li t0, 6
	blt a0, t0, Quadrado_x_parado
	li a0, 1		
	j Quadrado_y
	

Quadrado_x_neg: li t0, -30		
	blt t0, a0, Quadrado_x_vel_4_neg
	li a0, -8							# velocidade real
	j Quadrado_y
	
Quadrado_x_vel_4_neg: li t0, -24
	blt t0, a0, Quadrado_x_vel_3_neg
	li a0, -6
	j Quadrado_y
	
Quadrado_x_vel_3_neg: li t0, -18			
	blt t0, a0, Quadrado_x_vel_2_neg
	li a0, -4
	j Quadrado_y
	
Quadrado_x_vel_2_neg: li t0, -12
	blt t0, a0, Quadrado_x_vel_1_neg
	li a0, -2
	j Quadrado_y
	
Quadrado_x_vel_1_neg: li t0, -6
	blt t0, a0, Quadrado_x_parado
	li a0, -1		
	j Quadrado_y

Quadrado_x_parado: li a0, 0

	
Quadrado_y: blt a1, zero, Quadrado_y_neg
Quadrado_y_vel_max: li t0, 30			# pos. relativa do analogico (0 - 32)
	blt a1, t0, Quadrado_y_vel_4
	li a1, 8							# velocidade real
	j QUADRADO_VELOCIDADE_EXIT

Quadrado_y_vel_4: li t0, 24				# pos. relativa do analogico (0 - 32)
	blt a1, t0, Quadrado_y_vel_3
	li a1, 6							# velocidade real
	j QUADRADO_VELOCIDADE_EXIT
	
Quadrado_y_vel_3: li t0, 18				# pos. relativa do analogico (0 - 32)
	blt a1, t0, Quadrado_y_vel_2
	li a1, 4							# velocidade real
	j QUADRADO_VELOCIDADE_EXIT
	
Quadrado_y_vel_2: li t0, 12				# pos. relativa do analogico (0 - 32)
	blt a1, t0, Quadrado_y_vel_1
	li a1, 2							# velocidade real
	j QUADRADO_VELOCIDADE_EXIT
	
Quadrado_y_vel_1: li t0, 6				# pos. relativa do analogico (0 - 32)
	blt a1, t0, Quadrado_y_parado
	li a1, 1							# velocidade real
	j QUADRADO_VELOCIDADE_EXIT
	
	
Quadrado_y_neg: li t0, -30		
	blt t0, a1, Quadrado_y_vel_4_neg
	li a1, -8							# velocidade real
	j QUADRADO_VELOCIDADE_EXIT

Quadrado_y_vel_4_neg: li t0, -24
	blt t0, a1, Quadrado_y_vel_3_neg
	li a1, -6
	j QUADRADO_VELOCIDADE_EXIT
	
Quadrado_y_vel_3_neg: li t0, -18			
	blt t0, a1, Quadrado_y_vel_2_neg
	li a1, -4
	j QUADRADO_VELOCIDADE_EXIT
	
Quadrado_y_vel_2_neg: li t0, -12
	blt t0, a1, Quadrado_y_vel_1_neg
	li a1, -2
	j QUADRADO_VELOCIDADE_EXIT
	
Quadrado_y_vel_1_neg: li t0, -6
	blt t0, a1, Quadrado_y_parado
	li a1, -1		
	j QUADRADO_VELOCIDADE_EXIT
	
Quadrado_y_parado: li a1, 0

QUADRADO_VELOCIDADE_EXIT: add s0,s0,a0
	add s1,s1,a1
	mv a0,s0
	mv a1,s1
	ret
########################################
.include "SYSTEMv14.s"
