
.macro Mario_song( %a, %b, %c)
	
#li a0,%a # Nota
#li a1,%b # Duração da Nota em nanosegundos
#li a2,4  # Instrumento
#li a3,60 # Volume da Nota
#li a7,131
#ecall
#li a7, 132
#li a0 %c # Tempo de espera em nanosegundos para reproduzir a próxima nota
#ecall

li a0, %a
li a1, %b
li a2, %c

sh a0, 0(t0)
sh a1, 0(t1)
sh a2, 0(t2)

addi t0, t0, 2
addi t1, t1, 2
addi t2, t2, 2

.end_macro


.text

MUSICA_MARIO: nop

la t0, PilhaNotas
la t1, PilhaDuracao
la t2, PilhaEspera

Mario_song(88,200,200) # E6
Mario_song(88,200,400) # E6
Mario_song(88,200,400) # E6
Mario_song(84,200,200) # C6
Mario_song(88,200,400) # E6
Mario_song(91,200,800) # G6
Mario_song(67,200,800) # G4
Mario_song(84,200,600) # C6
Mario_song(79,200,600) # G5
Mario_song(76,200,600) # E5
Mario_song(81,200,400) # A5
Mario_song(83,200,400) # B5
Mario_song(82,200,200) # A#5
Mario_song(81,200,400) # A5
Mario_song(79,200,200) # G5
Mario_song(88,200,400) # E6
Mario_song(91,200,200) # G6
Mario_song(93,200,400) # A6
Mario_song(89,200,200) # F6
Mario_song(91,200,400) # G6
Mario_song(88,200,400) # E6
Mario_song(84,200,200) # C6
Mario_song(86,200,200) # D6
Mario_song(83,200,600) # B5
Mario_song(84,200,600) # C6
Mario_song(79,200,600) # G5
Mario_song(76,200,600) # E5
Mario_song(81,200,400) # A5
Mario_song(83,200,400) # B5
Mario_song(82,200,200) # A#5
Mario_song(81,200,400) # A5
Mario_song(79,200,200) # G5
Mario_song(88,200,400) # E6
Mario_song(91,200,200) # G6
Mario_song(93,200,400) # A6
Mario_song(89,200,200) # F6
Mario_song(91,200,400) # G6
Mario_song(88,200,400) # E6
Mario_song(84,200,200) # C6
Mario_song(86,200,200) # D6
Mario_song(83,200,600) # B5
Mario_song(60,200,400) # C4
Mario_song(91,200,200) # G6
Mario_song(90,200,200) # F#6
Mario_song(89,200,200) # F6
Mario_song(87,200,200) # D#6
Mario_song(72,200,200) # C5
Mario_song(88,200,400) # E6
Mario_song(80,200,200) # G#5
Mario_song(81,200,200) # A5
Mario_song(84,200,200) # C6
Mario_song(72,200,200) # C5
Mario_song(81,200,200) # A5
Mario_song(84,200,200) # C6
Mario_song(86,200,200) # D6
Mario_song(60,200,400) # C4
Mario_song(91,200,200) # G6
Mario_song(90,200,200) # F#6
Mario_song(89,200,200) # F6
Mario_song(87,200,200) # D#6
Mario_song(67,200,200) # G4
Mario_song(88,200,400) # E6
Mario_song(96,200,600) # C7
Mario_song(96,200,400) # C7
Mario_song(67,200,400) # G4
Mario_song(60,200,400) # C4
Mario_song(91,200,200) # G6
Mario_song(90,200,200) # F#6
Mario_song(89,200,200) # F6
Mario_song(87,200,200) # D#6
Mario_song(72,200,200) # C5
Mario_song(88,200,200) # E6
Mario_song(65,200,200) # F4
Mario_song(80,200,200) # G#5
Mario_song(81,200,200) # A5
Mario_song(84,200,200) # C6
Mario_song(72,200,200) # C5
Mario_song(81,200,200) # A5
Mario_song(84,200,200) # C6
Mario_song(86,200,200) # D6
Mario_song(60,200,400) # C4
Mario_song(87,200,600) # D#6
Mario_song(86,200,600) # D6
Mario_song(84,200,800) # C6

ret

