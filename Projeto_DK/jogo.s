.include "sistema\macros3.s"

.text
RotinaTratamento(exceptionHandling)

MAIN: nop
	#### RESET PONTUACAO ###
	la t0, HighPontuacao
	li t1, 0
	sh t1, 0(t0)
	#########################

	JOGO: nop
	la t0, TELA_INICIAL
	jalr ra, t0, 0
	
	#### RESET PONTUACAO ###
	la t0, Pontuacao
	li t1, 0
	sh t1, 0(t0)
	#########################
	
	### RESET TEMPO ANIMACAO PULO MARIO ###
	li a7, 130
	ecall
	
	la t3, Tempo_Animacao
	sw a0, 0(t3)
	la t3, TempoBonus
	sw a0, 0(t3)
	#####################################
	
	######## INICIAR ##########
	la t0, INICIAR_JOGO
	jalr ra, t0, 0
	###########################
	
	jal zero, JOGO
	
	li a7, 10
	ecall
	
.include "src\frames\frame.s"
.include "src\frames\desenhos.s"
.include "src\sounds\Castelo_song.s"
.include "src\sounds\Esgoto_song.s"
.include "src\sounds\Coin_song.s"
.include "src\sounds\Pulo_song.s"
.include "src\sounds\Botao_song.s"
.include "src\sounds\Mario_song_2.0.s"
.include "src\sounds\Morte_song.s"
.include "src\sounds\Reprodutor_Notas.s"
.include "src\mapa\mapa.s"
.include "src\mapa\resetar.s"
.include "src\mapa\criar_mapa.s"
.include "src\mapa\criar_mapa2.s"
.include "src\mapa\criar_mapa3.s"
.include "src\mapa\criar_mapa4.s"
.include "src\mapa\criar_mapa5.s"
.include "src\personagens\movimento.s"
.include "src\personagens\movimento_mario.s"
.include "src\personagens\morte.s"
.include "src\objetos\movimento.s"
.include "src\objetos\esteiras.s"
.include "src\objetos\particulas.s"
.include "src\UI\menu\menu_jogo.s"
.include "src\UI\score\score.s"
.include "src\UI\tela\tela_inicial.s"
.include "src\UI\tela\vidas.s"
.include "src\UI\creditos\creditos.s"
.include "sistema\Controle.s"
.include "sistema\sistema.s"
