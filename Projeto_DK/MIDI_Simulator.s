.include "sistema/macros3.s"

.macro return()
	li a0, '\n'		# return
	li a7, 111
	ecall
.end_macro

.macro tab()
	li a0, '\t'		# tab
	li a7, 111
	ecall
.end_macro

.macro String(%string, %coluna, %linha, %cor)
	mv a0, %string
	li a1, %coluna
	li a2, %linha
	li a3, %cor
	li a4, 0
	li a7, 104
	ecall
.end_macro

.macro print_int(%int, %coluna, %linha, %cor)
	mv a0, %int
	li a1, %coluna
	li a2, %linha
	li a3, %cor
	li a4, 0
	li a7, 101
	ecall
.end_macro

.macro Song( %a, %b, %c)
	mv a0,%b # Nota
	mv a1,%c # Duração da Nota em nanosegundos
	mv a2,%a  # Instrumento
	li a3,100 # Volume da Nota
	li a7,131
	ecall
	
	#li a7,132
	#li a0 %c # Tempo de espera em nanosegundos para reproduzir a próxima nota	
	#ecall
.end_macro

.data
S_saudacoes:	.string "Super MIDI Simulator"
S_instr:		.string "Instrumento desejado: "
S_duracao:		.string "Duracao da nota: "
S_nota:			.string "Nota desejada: "

.text
MAIN: RotinaTratamento(exceptionHandling)
	
MAIN_LOOP: li a0, 0x00	# CLEAR
	li a7, 148
	ecall
		
	la a0, S_saudacoes
	String(a0, 72, 4, 255)
	
	
	la a0, S_instr
	String(a0, 0, 20, 255)
	
	li a7, 105
	ecall			# ler instrumeto
	mv t0, a0
	print_int(a0, 0, 30, 255)
	
	la a0, S_nota
	String(a0, 0, 40, 255)
	
	li a7, 105
	ecall			# ler nota
	mv t1, a0
	print_int(a0, 0, 50, 255)
	
	la a0, S_duracao
	String(a0, 0, 60, 255)
	
	li a7, 105
	ecall			# ler duracao
	mv t2, a0
	print_int(a0, 0, 70, 255)
	########
	
	Song(t0, t1, t2)
	j MAIN_LOOP
	


.include "sistema/SYSTEMv14.s"
