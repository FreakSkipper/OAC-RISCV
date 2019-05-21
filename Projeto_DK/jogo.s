.data
.include "images\mapa.s"
.include "images\elevador.s"
.include "images\mola.s"
.include "images\mola1.s"
.include "images\barril1.s"
.include "images\barril2.s"
.include "images\barril3.s"
.include "images\barril4.s"
.include "images\barril_escada1.s"
.include "images\barril_escada2.s"
.include "images\princesa.s"
.include "images\princesa_walk.s"
.include "images\mario_idle_left.s"
.include "images\mario_idle_right.s"
.include "images\mario_walk_left.s"
.include "images\mario_walk_right.s"
.include "images\mario_run_left.s"
.include "images\mario_run_right.s"
.include "images\mario_jump_left.s"
.include "images\mario_jump_right.s"
.include "images\mario_escada.s"
.include "images\mario_escada2.s"
.include "images\mario_finish_escada1.s"
.include "images\mario_finish_escada2.s"
.include "images\mario_finish_escada3.s"
.include "images\mario_finish_escada4.s"
.include "images\mario_finish_escada5.s"
#	struct personagens{
#		imagem[],
#		posicaoX,
#		posicaoY,
#		is_jumping,
#		in_escada
#	} Personagens
	
#	struct objetos{
#		imagem[],
#		posicaoX,
#		posicaoY,
#		velocidade (pixels),
#		direcao (0 - esquerda; 1 - direita)
#		tipo ( 0 - barril; 1 - mola )
#		is_something ( 0 - falso ; > 0 - verdadeiro )
#	} Objetos

	# Objetos[20]
	# 20 x 7 = 140
	Personagens: .word mario_idle_right, 0, 200, 0,0, princesa, 160, 36,0,0
	Ultima_direcao: .byte 'd'
	Desvio_padrao: .byte 0
	Objetos: .word 	barril1,0,20,3,1,0,0, barril1,120,0,3,1,0,0, barril1,20,20,3,1,0,0, barril1,40,20,3,1,0,0, barril1,0,125,3,1,0,0
	
							
	mensagem: .string "Escreva um numero para mover diferente de zero\n"
	
.text
##### int main()
MAIN: nop
	la t0, CRIAR_MAPA
	jalr ra, t0, 0
	
	la t0, CRIAR_PERSONAGENS
	la a0, Personagens		# Vetor Struct Personagem
	li a1, 2				# Quantidade de personagens a ser impresso
	jalr ra, t0, 0
	
	la t0, CONTA
	jalr ra, t0, 0
	
	li a7, 10
	ecall
###############

.include "src/frames/keypoll.s"
.include "src/moviment/movimento.s"
