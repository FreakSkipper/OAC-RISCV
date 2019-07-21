.macro Esgoto_song( %a, %b, %c)
	
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

MUSICA_ESGOTO: nop
Esgoto_song(72,200,200) # C5
Esgoto_song(84,200,200) # C6
Esgoto_song(69,200,200) # A4 
Esgoto_song(81,200,200) # A5
Esgoto_song(70,200,200) # A#4
Esgoto_song(82,200,600) # A#5
Esgoto_song(72,200,200) # C5
Esgoto_song(84,200,200) # C6
Esgoto_song(69,200,200) # A4 
Esgoto_song(81,200,200) # A5
Esgoto_song(70,200,200) # A#4
Esgoto_song(82,200,600) # A#5
Esgoto_song(65,200,200) # F4
Esgoto_song(77,200,200) # F5
Esgoto_song(62,200,200) # D4 
Esgoto_song(74,200,200) # D5
Esgoto_song(63,200,200) # D#4
Esgoto_song(75,200,600) # D#5
Esgoto_song(65,200,200) # F4
Esgoto_song(77,200,200) # F5
Esgoto_song(62,200,200) # D4 
Esgoto_song(74,200,200) # D5
Esgoto_song(63,200,200) # D#4
Esgoto_song(75,200,600) # D#5
Esgoto_song(75,100,100) # D#5
Esgoto_song(74,100,100) # D5
Esgoto_song(73,100,100) # C#5
Esgoto_song(72,300,400) # C5
Esgoto_song(75,300,400) # D#5
Esgoto_song(74,300,400) # D5
Esgoto_song(68,300,400) # G#4
Esgoto_song(67,300,400) # G4
Esgoto_song(73,300,400) # C#5
Esgoto_song(72,200,200) # C5
Esgoto_song(78,100,100) # F#5
Esgoto_song(77,200,200) # F5
Esgoto_song(76,200,200) # E5
Esgoto_song(82,100,100) # A#5
Esgoto_song(81,200,200) # A5
Esgoto_song(80,200,300) # G#5
Esgoto_song(75,200,300) # D#5
Esgoto_song(71,200,300) # B4
Esgoto_song(70,200,300) # A#4
Esgoto_song(69,200,300) # A4
Esgoto_song(68,200,300) # G#4

ret
