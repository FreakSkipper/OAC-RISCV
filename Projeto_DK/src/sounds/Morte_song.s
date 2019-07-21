
.macro Morte_song( %a, %b, %c)
	
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
MUSICA_MORTE1: nop
Morte_song(83,200,200) # B5
ret
MUSICA_MORTE2: nop
Morte_song(89,200,300) # F6
ret
MUSICA_MORTE3: nop
Morte_song(89,200,200) # F6
ret
MUSICA_MORTE4: nop
Morte_song(89,100,200) # F6
ret
MUSICA_MORTE5: nop
Morte_song(88,100,200) # E6
ret
MUSICA_MORTE6: nop
Morte_song(86,100,200) # D6
Morte_song(84,200,200) # C6
Morte_song(76,200,200) # E5
Morte_song(67,200,200) # G4
Morte_song(76,200,200) # E5
Morte_song(72,200,200) # C5


ret
