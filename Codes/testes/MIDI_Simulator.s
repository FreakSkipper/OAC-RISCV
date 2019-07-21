.include "macros3.s"

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
	
MAIN_LOOP: jal CLS
		
	la a0, S_saudacoes
	String(a0, 72, 4, 255)
	
	
	la a0, S_instr
	String(a0, 4, 20, 255)
	
	li a7, 105
	ecall			# ler instrumeto
	mv t0, a0
	print_int(a0, 4, 30, 255)
	
	la a0, S_nota
	String(a0, 4, 40, 255)
	
	li a7, 105
	ecall			# ler nota
	mv t1, a0
	print_int(a0, 4, 50, 255)
	
	la a0, S_duracao
	String(a0, 4, 60, 255)
	
	li a7, 105
	ecall			# ler duracao
	mv t2, a0
	print_int(a0, 4, 70, 255)
	########
	
	Song(t0, t1, t2)
	j MAIN_LOOP
	

CLS: li t0, VGAADDRESSINI0
	li t1, VGAADDRESSFIM0
	li t2, 0
CLS_LOOP: sb t2, 0(t0)
	addi t0, t0, 1
	bge t1, t0, CLS_LOOP
	ret
	
.include "SYSTEMv14.s"
