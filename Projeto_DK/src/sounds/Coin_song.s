.macro Coin_song( %a, %b, %c)
	
li a0,%a # Nota
li a1,%b # Duração da Nota em nanosegundos
li a2,150  # Instrumento
li a3,100 # Volume da Nota
li a7,131
ecall
li a7,132
li a0 %c # Tempo de espera em nanosegundos para reproduzir a próxima nota
ecall
.end_macro

.text

SOUND_MOEDA: nop
	addi sp, sp, -12
	sw a0, 0(sp)
	sw a1, 4(sp)
	sw a2, 8(sp)
	Coin_song(80,100,0) # E6
	
	lw a0, 0(sp)
	lw a1, 4(sp)
	lw a2, 8(sp)
	addi sp, sp, 12
	
	ret
