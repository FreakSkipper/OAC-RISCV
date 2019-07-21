.macro Pulo_song( %a, %b)
	
li a0,%a # Nota
li a1,%b # Duração da Nota em nanosegundos
li a2,118  # Instrumento
li a3,60 # Volume da Nota
li a7,131
ecall
.end_macro

.text

SOUND_PULO: nop
	addi sp, sp, -16
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw a2, 8(sp)
	sw a3, 12(sp)
	
	Pulo_song(70,300)
	
	lw a0, 0(sp)
	lw a1, 4(sp)
	lw a2, 8(sp)
	lw a3, 12(sp)
	addi sp, sp, 16
	
	ret