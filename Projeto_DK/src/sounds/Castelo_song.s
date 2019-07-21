
.macro Castelo_song( %a, %b, %c)
	
li a0,%a # Nota
li a1,%b # Duração da Nota em nanosegundos
li a2,4  # Instrumento
li a3,60 # Volume da Nota
li a7,131
ecall
li a7,132
li a0 %c # Tempo de espera em nanosegundos para reproduzir a próxima nota
ecall
.end_macro

.text
#M_SetEcall(exceptionHandling)	# Macro de SetEcall - não tem ainda na DE1-SoC
RotinaTratamento(exceptionHandling)	# Macro de SetEcall

MUSICA_CASTELO: nop
Castelo_song(86,150,150) # D6
Castelo_song(79,150,150) # G5
Castelo_song(85,150,150) # C#6
Castelo_song(79,150,150) # G5
Castelo_song(84,150,150) # C6
Castelo_song(79,150,150) # G5
Castelo_song(85,150,150) # C#6
Castelo_song(79,150,150) # G5
Castelo_song(86,150,150) # D6
Castelo_song(79,150,150) # G5
Castelo_song(87,150,150) # D#6
Castelo_song(79,150,150) # G5
Castelo_song(86,150,150) # D6
Castelo_song(79,150,150) # G5
Castelo_song(85,150,150) # C#6
Castelo_song(79,150,150) # G5
Castelo_song(86,150,150) # D6
Castelo_song(79,150,150) # G5
Castelo_song(85,150,150) # C#6
Castelo_song(79,150,150) # G5
Castelo_song(84,150,150) # C6
Castelo_song(79,150,150) # G5
Castelo_song(85,150,150) # C#6
Castelo_song(79,150,150) # G5
Castelo_song(86,150,150) # D6
Castelo_song(79,150,150) # G5
Castelo_song(87,150,150) # D#6
Castelo_song(79,150,150) # G5
Castelo_song(86,150,150) # D6
Castelo_song(79,150,150) # G5
Castelo_song(85,150,150) # C#6
Castelo_song(79,150,150) # G5
Castelo_song(85,150,150) # C#6
Castelo_song(78,150,150) # F#5
Castelo_song(85,150,150) # C#6
Castelo_song(78,150,150) # F#5
Castelo_song(86,150,150) # D6
Castelo_song(78,150,150) # F#5
Castelo_song(85,150,150) # C#6
Castelo_song(78,150,150) # F#5
Castelo_song(86,150,150) # D6
Castelo_song(78,150,150) # F#5
Castelo_song(85,150,150) # C#6
Castelo_song(78,150,150) # F#5
Castelo_song(84,150,150) # C6
Castelo_song(78,150,150) # F#5
Castelo_song(85,150,150) # C#6
Castelo_song(78,150,150) # F#5
Castelo_song(84,150,150) # C6
Castelo_song(78,150,150) # F#5
Castelo_song(85,150,150) # C#6
Castelo_song(78,150,150) # F#5
Castelo_song(86,150,150) # D6
Castelo_song(78,150,150) # F#5
Castelo_song(85,150,150) # C#6
Castelo_song(78,150,150) # F#5
Castelo_song(86,150,150) # D6
Castelo_song(78,150,150) # F#5
Castelo_song(85,150,150) # C#6
Castelo_song(78,150,150) # F#5
Castelo_song(84,150,150) # C6
Castelo_song(78,150,150) # F#5
Castelo_song(89,150,150) # F6
Castelo_song(82,150,150) # A#5
Castelo_song(90,150,150) # F#6
Castelo_song(82,150,150) # A#5
Castelo_song(89,150,150) # F6
Castelo_song(82,150,150) # A#5
Castelo_song(88,150,150) # E6
Castelo_song(82,150,150) # A#5
Castelo_song(89,150,150) # F6
Castelo_song(82,150,150) # A#5
Castelo_song(88,150,150) # E6
Castelo_song(82,150,150) # A#5
Castelo_song(87,150,150) # D#6
Castelo_song(82,150,150) # A#5
Castelo_song(88,150,150) # E6
Castelo_song(82,150,150) # A#5
Castelo_song(89,150,150) # F6
Castelo_song(82,150,150) # A#5
Castelo_song(90,150,150) # F#6
Castelo_song(82,150,150) # A#5
Castelo_song(89,150,150) # F6
Castelo_song(82,150,150) # A#5
Castelo_song(88,150,150) # E6
Castelo_song(82,150,150) # A#5
Castelo_song(89,150,150) # F6
Castelo_song(82,150,150) # A#5
Castelo_song(88,150,150) # E6
Castelo_song(82,150,150) # A#5
Castelo_song(87,150,150) # D#6
Castelo_song(82,150,150) # A#5
Castelo_song(88,150,150) # E6
Castelo_song(82,150,150) # A#5
Castelo_song(86,150,150) # D6

ret