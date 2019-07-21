.include "macros3.s"

.macro Printa_int(%xpos, %ypos)
	li a1, %xpos
	li a2, %ypos
	li a3, 0x00FF
	li a4, 0
	li a7, 134
	ecall
.end_macro

.text
MAIN: nop
	RotinaTratamento(exceptionHandling)
	li s0, KEYMAP0	# 00 a 1F
	
MAIN_LOOP:	nop
	lw a0, 0(s0)
	Printa_int(20, 120)
	
	lw a0, 4(s0)
	Printa_int(20, 130)
	
	lw a0, 8(s0)
	Printa_int(20, 140)
	
	lw a0, 12(s0)
	Printa_int(20, 150)
	
	#sw zero, 0(s0)
	#sw zero, 4(s0)
	#sw zero, 8(s0)
	#sw zero, 1y(s0)
	#ebreak
	
	li a0, 0x1D 	# w
	jal KEYBOARD
	mv a2, a0
	# beq a0, zero, CASE_A
	Printa_int(156, 120)
	#ebreak
CASE_A:	li a0, 0x1C			# a
	jal KEYBOARD
	mv a3, a0
	# beq a0, zero, CASE_S
	Printa_int(156, 130)
	#ebreak
CASE_S:	li a0, 0x1B			# s
	jal KEYBOARD
	mv a4, a0
	# beq a0, zero, CASE_D
	Printa_int(156, 140)
	#ebreak
CASE_D:	li a0, 0x23			# d
	jal KEYBOARD
	mv a5, a0
	# beq a0, zero, MAIN_EXIT
	Printa_int(156, 150)
	#ebreak
MAIN_EXIT: j MAIN_LOOP

# a0 -> valor da tecla desejada	
KEYBOARD: nop
	# calculo offset
	li t1, 32
	remu t2, a0, t1     # calcular offset do keymap (0, 1, 2, 3, 4)
	#addi t2, t2, -1		# t2 = mascara
	li t3, 1
	sll t2, t3, t2
	
	divu t3, a0, t1		# deslocamento
	slli t3, t3, 2		# deslocamento * 4 (t3 = offset em words para acesso)
	add t0, s0, t3

	lw t4, 0(t0)		# lendo do keymap
	#sw zero, 0(t0)
	and t4, t4, t2		# conferindo se a tecla foi realmente pressionada
	beq t4, t2, key_press
	j key_not_press
	
key_press: li a0, 1
	j KEY_FIM

key_not_press: li a0, 0

KEY_FIM: ret



# Este teste permite investigar o comportamento das 3 formas de acesso ao teclado
# através da visualização em tempo real dos registradores associados conforme abaixo
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
.include "SYSTEMv14.s"
