.data
	PilhaNotas: .space 166
	PilhaDuracao: .space 166
	PilhaEspera: .space 166
.text

### empilha uma nota
# a0 -> Parte
## retorna o tempo de espera
# a0 -> Tempo de Espera
TOCAR_MUSICA: nop
	slli a0, a0, 1
	la t0, PilhaNotas
	add t0, t0, a0
	la t1, PilhaDuracao
	add t1, t1, a0
	la t2, PilhaEspera
	add t2, t2, a0
	
	lhu a0,0(t0) # Nota
	lhu a1,0(t1) # Duração da Nota em nanosegundos
	
	li a2,4  # Instrumento
	li a3,60 # Volume da Nota
	li a7,131
	ecall
	
	lhu a0, 0(t2)
	
	ret
	