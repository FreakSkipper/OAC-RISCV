.include "macros3.s"
.macro tiros_song( %a, %b, %c)
	
li a0,%a # Nota
li a1,%b # Duração da Nota em nanosegundos
li a2,127 # Instrumento
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
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)
tiros_song(62,2000,0)

.include "SYSTEMv14.s"

