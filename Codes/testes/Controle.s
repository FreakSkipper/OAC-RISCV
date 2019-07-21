.include "macros3.s"

.data
Controle_x: 	.byte 0
Controle_y: 	.byte 0
Controle_sw: 	.byte 0

.text	
# Confere se um direcional foi pressionado no teclado ou houve movimentacao no analogico
## OBS: Da preferencia para o Keyboard
## Atualiza em Controle_X/Y/SW lendo do teclado (W/A/S/D - P ou do analogico) 
CONTROLE: li a1, 0		# x
	li a2, 0			# y
	li a3, 0			# pause
	#la t0, Controle_x
	#sb zero, 0(t0)
	#la t0, Controle_y
	#sb zero, 0(t0)
	#la t0, Controle_sw
	#sb zero, 0(t0)
	
	addi sp, sp, -8		# pilha
	sw ra, 0(sp)
	sw s0, 4(sp)
	
Keyboard_keys: li s0, 0		# flag para tecla pressionada
	li a0, 0x1D 	# w
	jal KEYBOARD_MAP
	or s0, s0, a0
	beq a0, zero, CASE_A
	li a2, -32
	
CASE_A:	li a0, 0x1C 	# a
	jal KEYBOARD_MAP
	#Printa_int(156, 130)
	or s0, s0, a0
	beq a0, zero, CASE_S
	li a1, -32
	
CASE_S:	li a0, 0x1B 	# s
	jal KEYBOARD_MAP
	or s0, s0, a0
	beq a0, zero, CASE_D
	li a2, 32
	
CASE_D:	li a0, 0x23 	# d
	jal KEYBOARD_MAP
	or s0, s0, a0
	beq a0, zero, CASE_PAUSE
	li a1, 32
	
CASE_PAUSE:	li a0, 0x4D 	# p
	jal KEYBOARD_MAP
	or s0, s0, a0
	beq a0, zero, Keyboard_keys_fim
	li a3, 1			
	
Keyboard_keys_fim:	mv a0, a1
	mv a1, a2
	beq s0, zero, Key_Anag2_X
	j AJUSTE_VELOCIDADE
	
KEYBOARD_EXIT: la t0, Controle_x
	sb a0, 0(t0)
	la t0, Controle_y
	sb a1, 0(t0)
	la t0, Controle_sw
	sb a3, 0(t0)					# pause

	lw ra, 0(sp)
	lw s0, 4(sp)
	addi sp, sp, 8
	
	ret
##################################################


#####################################
# a0 -> tecla a ser lida
# retorna em a0 se a tecla foi pressionada
KEYBOARD_MAP: nop
	# calculo offset
	li t1, 32
	remu t2, a0, t1     # calcular offset do keymap (0, 1, 2, 3, 4)
	#addi t2, t2, -1		# t2 = mascara
	li t3, 1
	sll t2, t3, t2
	
	divu t3, a0, t1		# deslocamento
	slli t3, t3, 2		# deslocamento * 4 (t3 = offset em words para acesso)
	
	li t0, KEYMAP0
	add t0, t0, t3		# deslocamento em words
	lw t4, 0(t0)		# lendo do keymap
	#sw zero, 0(t0)
	and t4, t4, t2		# conferindo se a tecla foi realmente pressionada
	beq t4, t2, key_press
	j key_not_press
	
key_press: li a0, 1
	j KEY_FIM

key_not_press: li a0, 0

KEY_FIM: ret
#####################################################


#################
## Leitura do ADC	
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
	j Key_Anag2_SW				

Key_Anag2_Y_menor: sub t1, t1, t2			# valor - offset								
	li t3, 73							# cte para X menor q offset
	div t1, t1, t3						# t1 velocidade de 0 a -10
	mv a1, t1
	# j Key_Anag2_SW
	 
Key_Anag2_SW: li t0, ADC_CH2
	lw t1, 0(t0)
	li t0, 500
	bgt t1, t0, Key_Anag2_fim
	li a3, 1
	
Key_Anag2_fim: nop						# j AJUSTE_VELOCIDADE
################################################################


########################################
## Argumentos
# a0 -> X
# a1 -> Y
AJUSTE_VELOCIDADE:
	blt a0, zero, Ajuste_x_neg
	li t0, 30			# pos. relativa do analogico (0 - 32)
	blt a0, t0, Ajuste_x_vel_4
	li a0, 8							# velocidade real
	j Ajuste_y
	
Ajuste_x_vel_4: li t0, 24
	blt a0, t0, Ajuste_x_vel_3
	li a0, 6
	j Ajuste_y
	
Ajuste_x_vel_3: li t0, 18			
	blt a0, t0, Ajuste_x_vel_2
	li a0, 4
	j Ajuste_y
	
Ajuste_x_vel_2: li t0, 12
	blt a0, t0, Ajuste_x_vel_1
	li a0, 2
	j Ajuste_y
	
Ajuste_x_vel_1: li t0, 6
	blt a0, t0, Ajuste_x_parado
	li a0, 1		
	j Ajuste_y
	

Ajuste_x_neg: li t0, -30		
	blt t0, a0, Ajuste_x_vel_4_neg
	li a0, -8							# velocidade real
	j Ajuste_y
	
Ajuste_x_vel_4_neg: li t0, -24
	blt t0, a0, Ajuste_x_vel_3_neg
	li a0, -6
	j Ajuste_y
	
Ajuste_x_vel_3_neg: li t0, -18			
	blt t0, a0, Ajuste_x_vel_2_neg
	li a0, -4
	j Ajuste_y
	
Ajuste_x_vel_2_neg: li t0, -12
	blt t0, a0, Ajuste_x_vel_1_neg
	li a0, -2
	j Ajuste_y
	
Ajuste_x_vel_1_neg: li t0, -6
	blt t0, a0, Ajuste_x_parado
	li a0, -1		
	j Ajuste_y

Ajuste_x_parado: li a0, 0

	
Ajuste_y: blt a1, zero, Ajuste_y_neg
Ajuste_y_vel_max: li t0, 30				# pos. relativa do analogico (0 - 32)
	blt a1, t0, Ajuste_y_vel_4
	li a1, 8							# velocidade real
	j AJUSTE_VELOCIDADE_EXIT

Ajuste_y_vel_4: li t0, 24				# pos. relativa do analogico (0 - 32)
	blt a1, t0, Ajuste_y_vel_3
	li a1, 6							# velocidade real
	j AJUSTE_VELOCIDADE_EXIT
	
Ajuste_y_vel_3: li t0, 18				# pos. relativa do analogico (0 - 32)
	blt a1, t0, Ajuste_y_vel_2
	li a1, 4							# velocidade real
	j AJUSTE_VELOCIDADE_EXIT
	
Ajuste_y_vel_2: li t0, 12				# pos. relativa do analogico (0 - 32)
	blt a1, t0, Ajuste_y_vel_1
	li a1, 2							# velocidade real
	j AJUSTE_VELOCIDADE_EXIT
	
Ajuste_y_vel_1: li t0, 6				# pos. relativa do analogico (0 - 32)
	blt a1, t0, Ajuste_y_parado
	li a1, 1							# velocidade real
	j AJUSTE_VELOCIDADE_EXIT
	
	
Ajuste_y_neg: li t0, -30		
	blt t0, a1, Ajuste_y_vel_4_neg
	li a1, -8							# velocidade real
	j AJUSTE_VELOCIDADE_EXIT

Ajuste_y_vel_4_neg: li t0, -24
	blt t0, a1, Ajuste_y_vel_3_neg
	li a1, -6
	j AJUSTE_VELOCIDADE_EXIT
	
Ajuste_y_vel_3_neg: li t0, -18			
	blt t0, a1, Ajuste_y_vel_2_neg
	li a1, -4
	j AJUSTE_VELOCIDADE_EXIT
	
Ajuste_y_vel_2_neg: li t0, -12
	blt t0, a1, Ajuste_y_vel_1_neg
	li a1, -2
	j AJUSTE_VELOCIDADE_EXIT
	
Ajuste_y_vel_1_neg: li t0, -6
	blt t0, a1, Ajuste_y_parado
	li a1, -1		
	j AJUSTE_VELOCIDADE_EXIT
	
Ajuste_y_parado: li a1, 0

AJUSTE_VELOCIDADE_EXIT: j KEYBOARD_EXIT
##############################################



# Compativel com o RARS
#########################################
Keyboard_Ctrl:	li t0, KDMMIO_Ctrl
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
####################################################

# Este teste permite investigar o comportamento das 3 formas de acesso ao teclado
# atrav�s da visualiza��o em tempo real dos registradores associados conforme abaixo
KEYBOARD_DEBUG: nop
	li s0,0xFF200100  	#BUFFER1
	li s1,0xFF200104	#BUFFER2
	li a0,0xFF200520	#KEY0
	li a1,0xFF200524	#KEY1
	li a2,0xFF200528	#KEY2
	li a3,0xFF20052C	#KEY3
	li a4,0xFF200004	#Data
	li a5,0xFF200000	#Ctrl
	
LOOP:	lw s8,0(s0)
	lw s9,0(s1)
	lw s10,0(a0)
	lw s11,0(a1)
	lw t3,0(a2)
	lw t4,0(a3)
	lw t5,0(a4)
	lw t6,0(a5)
	j LOOP

#.include "SYSTEMv14.s"
