#############################################
######### MOVIMENTO DE OBJETOS ##########
#############################################

.data
.include "..\..\images\barril1.s"
.include "..\..\images\barril2.s"
.include "..\..\images\barril3.s"
.include "..\..\images\barril4.s"
.include "..\..\images\barril_escada1.s"
.include "..\..\images\barril_escada2.s"
#.include "..\..\images\foguinho1_right.s"
.include "..\..\images\foguinho1_left.s"
#.include "..\..\images\foguinho1_jump_right.s"
.include "..\..\images\foguinho1_jump_left.s"
.include "..\..\images\torta.s"
.include "..\..\images\mola.s"
.include "..\..\images\mola1.s"
.include "..\..\images\tartagura1_left.s"
.include "..\..\images\tartagura2_left.s"
#.include "..\..\images\tartagura1_right.s"
#.include "..\..\images\tartagura2_right.s"
.include "..\..\images\tartagura_morta.s"
.include "..\..\images\moeda2_costa.s"
.include "..\..\images\moeda2_lado.s"
.include "..\..\images\moeda2_lado2.s"
.include "..\..\images\moeda2_frente.s"
.include "..\..\images\saida_elevador_cima.s"
.include "..\..\images\saida_elevador_baixo.s"
.include "..\..\images\elevador.s"
.include "..\..\images\ak47.s"
.include "..\..\images\chapeu_mario.s"
.include "..\..\images\chave_fenda.s"
.include "..\..\images\yoshi_retrato.s"
.include "..\..\images\chama1.s"
.include "..\..\images\chama2.s"
.include "..\..\images\bowser_safado.s"
	Objetos: .word 	0,150,200,4,1,0,10, 0,120,0,2,1,0,0, 0,20,20,2,1,0,0, 0,40,20,2,1,0,0, 0,0,125,2,1,0,0,
					0,0,20,2,1,0,0, 0,120,0,2,1,0,0, 0,20,20,2,1,0,0, 0,40,20,2,1,0,0, 0,0,125,2,1,0,0,
					0,0,20,2,1,0,0, 0,120,0,2,1,0,0, 0,20,20,2,1,0,0, 0,40,20,2,1,0,0, 0,0,125,2,1,0,0,
					0,0,20,2,1,0,0, 0,120,0,2,1,0,0, 0,20,20,2,1,0,0, 0,40,20,2,1,0,0, 0,0,125,2,1,0,0
					
	Copia_Objetos: .space 240	
	Quantidade_Objetos: .byte 0
	Tempo_Score: .word 0
	TempoMorteTartagura: .word 0

.text

#################### void criar_quadrado(int imagem[], int x, int y, int flag)
## Cria o quadrado no display
# a0 -> vetor da imagem
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> flag ( 0 - apaga, 1 - crie )
CRIAR_QUADRADO: nop
	addi sp, sp, -4
	
	## posicao no display e Mapa ##
	la t0, Frame_Desenhar
	lw t0, 0(t0)	
	
	DEFINIU_FRAME: nop
	################################
	la t6, mapa
	addi t6, t6, 8
	
	li t1, 320
	mul t1, t1, a2	# 320 * y
	add t1, t1, a1 	# 320 * y + x
	add t0, t0, t1	# 320 * y + x + End. I
	add t6, t6, t1	# mapa position
	#################################
	
	###### contadores ######
	lw t1, 0(a0)	# largura
	lw t2, 4(a0)	# altura
	mul t2, t2, t1	# contador geral
	sw t1, 0(sp)
	##########################
	
	mv t3, a0
	addi t3, t3, 8	# pula struct da imagem
	
	beq a4, zero, FOR1_CRIAR_QUADRADO
	
	add t3, t3, t1
	addi t3, t3, -1
	
	FOR1_CRIAR_QUADRADO: nop
		beq t2, zero, EXIT_FOR1_CRIAR_QUADRADO
		
		li t4, 0xFF000000
		blt t0, t4, PULO_CONDICIONAL
		li t4, 0xFF112C00
		bgt t0, t4, PULO_CONDICIONAL
		li t4, 0x10010000
		blt t3, t4, PULO_CONDICIONAL
		li t4, 0x1002FFFF
		bgt t3, t4, PULO_CONDICIONAL 
		
		SEM_EXCEP: nop
		lb t4, 0(t3)	# le pixel da imagem
		li t5, 0xffffffc7
		beq a3, zero, APAGA_DE
		bne t4, t5, PINTA_NORMAL
		lb t4, 0(t0)	# le o pixel do mapa ( c7 )
		jal zero, PINTA_NORMAL
		APAGA_DE: nop
		lb t4, 0(t6)	# le o pixel do mapa ( c7 )
		PINTA_NORMAL: nop
		sb t4, 0(t0)	# salva no display
		
		PULO_CONDICIONAL2: nop
		addi t1, t1, -1	# largura --
		addi t2, t2, -1	# contador geral --
		addi t0, t0, 1	# proximo byte do display
		addi t6, t6, 1	# proximo byte do mapa
		
		beq a4, zero, PECORRE_NORMAL
		addi t3, t3, -1	# proximo byte da imagem
		jal zero, CONTINUA_PECORRE
		
		PECORRE_NORMAL: nop
		addi t3, t3, 1	# proximo byte da imagem
		
		CONTINUA_PECORRE: nop
		beq t1, zero, QUEBRAR_LINHA
		
		jal zero, FOR1_CRIAR_QUADRADO
	EXIT_FOR1_CRIAR_QUADRADO: nop
	
	addi sp, sp, 4
	ret

QUEBRAR_LINHA: nop
	lw t1, 0(sp)	# recarrega contador largura
	
	sub t0, t0, t1	# quebra e subtrai largura ( display )
	sub t6, t6, t1	# quebra e subtrai largura ( mapa )
	
	addi t0, t0, 320# proxima linha
	addi t6, t6, 320# proxima linha
	
	beq a4, zero, FOR1_CRIAR_QUADRADO
	
	add t3, t3, t1
	add t3, t3, t1
	
	jal zero, FOR1_CRIAR_QUADRADO
##############################

PULO_CONDICIONAL: nop
	li t4, 0x10010000
	blt t3, t4, EXCEP
	li t4, 0x1002FFFF
	bgt t3, t4, EXCEP
	
	jal zero, SEM_EXCEP
	
	EXCEP: nop
	#ebreak
	jal zero, PULO_CONDICIONAL2
#################### void mover_objetos()
## Move os objetos contidos no vetor
MOVER_OBJETOS: nop
	addi sp, sp -4
	sw ra, 0(sp)
	
	## Evitar usar pilha ##
	la s0, Objetos
	la s1, Quantidade_Objetos
	lb s1, 0(s1)
	
	## Percorrer Objetos ##
	FOR1_MOVER_OBJETOS: nop
		beq s1, zero, EXIT_FOR1_MOVER_OBJETOS
		
		## Le informacoes do Objeto e verifica existencia ##
		lw t0, 0(s0)	# imagem[] | flag existencia
		beq t0, zero, NAO_MOVE_OBJETO_INEXISTENTE
		
		## Se existir ##
		## Atribui gravidade e debug ##
		mv a0, s0
		jal ra, GRAVIDADE
		
		mv a2, a1	# retorno de gravidade
		mv a1, a0	# retorno de gravidade
		mv a0, s0	# struct
		
		## Verifica e move o tipo do Objeto ##
		lw t0, 20(s0)	# tipo
		
		## ------ BARRIL ----- ##
		bne t0, zero, NAO_BARRIL
		jal ra, MOVER_BARRIL
		jal zero, SALVAR_VALORES
		NAO_BARRIL: nop
		
		## ---- FOGUINHO ----- ##
		li t1, 1
		bne t0, t1, NAO_FOGUINHO
		jal ra, MOVER_FOGUINHO
		jal zero, SALVAR_VALORES
		NAO_FOGUINHO: nop
		
		## ---- TORTA ----- ##
		li t1, 2
		bne t0, t1, NAO_TORTA
		jal ra, MOVER_TORTA
		jal zero, SALVAR_VALORES
		NAO_TORTA: nop
		
		## ---- MOLA ----- ##
		li t1, 3
		bne t0, t1, NAO_MOLA
		jal ra, MOVER_MOLA
		jal zero, SALVAR_VALORES
		NAO_MOLA: nop
		
		## ---- TARTARUGA ----- ##
		li t1, 4
		bne t0, t1, NAO_TARTARUGA
		jal ra, MOVER_TARTARUGA
		jal zero, SALVAR_VALORES
		NAO_TARTARUGA: nop
		
		## ---- MOEDA ----- ##
		li t1, 5
		bne t0, t1, NAO_MOEDA
		jal ra, MOVER_MOEDA
		jal zero, SALVAR_VALORES
		NAO_MOEDA: nop
		
		## ---- SAIDA ELEVADOR ----- ##
		li t1, 6
		bne t0, t1, NAO_SAIDA_ELEVADOR
		jal ra, MOVER_SAIDA_ELEVADOR
		jal zero, SALVAR_VALORES
		NAO_SAIDA_ELEVADOR: nop
		
		## ---- ELEVADOR ----- ##
		li t1, 7
		bne t0, t1, NAO_ELEVADOR
		jal ra, MOVER_ELEVADOR
		jal zero, SALVAR_VALORES
		NAO_ELEVADOR: nop
		
		## ---- AK47 ----- ##
		li t1, 8
		bne t0, t1, NAO_AK47
		jal ra, MOVER_AK47
		jal zero, SALVAR_VALORES
		NAO_AK47: nop
		
		## ---- CHAPEU MARIO ----- ##
		li t1, 9
		bne t0, t1, NAO_CHAPEU
		jal ra, MOVER_AK47
		jal zero, SALVAR_VALORES
		NAO_CHAPEU: nop
		
		## ---- CHAVE FENDA ----- ##
		li t1, 10
		bne t0, t1, NAO_CHAVE
		jal ra, MOVER_AK47
		jal zero, SALVAR_VALORES
		NAO_CHAVE: nop
		
		## ---- CHAVE FENDA ----- ##
		li t1, 11
		bne t0, t1, NAO_YOSHI
		jal ra, MOVER_AK47
		jal zero, SALVAR_VALORES
		NAO_YOSHI: nop
		
		## ---- FOGO BOWSER ----- ##
		li t1, 12
		bne t0, t1, NAO_FOGO_BOWSER
		jal ra, MOVER_FOGO_BOWSER
		jal zero, SALVAR_VALORES
		NAO_FOGO_BOWSER: nop
		
		la t1, Kong_Sinalizou
		lb t1, 0(t1)
		beq t1, zero, NAO_DESTRUIU_OBJETO
		## ---- BOWSER ----- ##
		li t1, 13
		bne t0, t1, NAO_BOWSER
		jal ra, MOVER_BOWSER
		jal zero, SALVAR_VALORES
		NAO_BOWSER: nop
		
		jal zero, NAO_DESTRUIU_OBJETO
		
		SALVAR_VALORES: nop
		## Salva Valores do Objeto Atualizado ##
		sw a0, 0(s0)
		sw a1, 4(s0)
		sw a2, 8(s0)
		sw a3, 16(s0)
		sw a4, 24(s0)
		
		mv a0, s0
		lw a3, 20(s0)	# tipo objeto
		jal ra, TRATAR_COLISAO
		
		lw a4, 16(s0)
		## Desenha o objeto ##
		jal ra, CRIAR_QUADRADO
		
		bne a3, zero, NAO_DESTRUIU_OBJETO
		
		li a0, 0
		sw a0, 0(s0)
		
		la t1, Quantidade_Objetos
		lb t2, 0(t1)
		addi t2, t2, -1
		sb t2, 0(t1)
		
		NAO_DESTRUIU_OBJETO: nop
		
		addi s1, s1, -1	# contador --
		
		NAO_MOVE_OBJETO_INEXISTENTE: nop
		addi s0, s0, 28	# proximo objeto
		jal zero, FOR1_MOVER_OBJETOS
		
	EXIT_FOR1_MOVER_OBJETOS: nop
	
	lw ra, 0(sp)
	addi sp, sp, 4
	ret
################################

###### Gravidade(struct objeto)
## atribui gravidade a um objeto
# a0 -> struct contendo imagem[], x, y
## retorna on_ground e in_ground
# a0 -> in_ground ?
# a1 -> on_ground ?
GRAVIDADE: nop
	## Salva valores importantes para a funcao ##
	addi sp, sp, -8
	sw ra, 0(sp)
	sw a0, 4(sp)
	
	## Pegando informacoes do objeto ##
	lw a1, 4(a0)
	lw a2, 8(a0)
	lw a0, 0(a0)
	#li a3, 79
	jal ra, VERIFICAR_CHAO
	
	## Pegando valores perdidos pela funcao ##
	mv t1, a0
	lw t0, 4(sp)
	lw a0, 0(t0)
	
	#### VERIFICA OCASIAO PARA GRAVIDADE ####
	lw t3, 16(t0)	# direcao
	
	### VERIFICA SE DEVE IGNORAR VERIFICAR BUG ###
	li t2, -5
	bne t3, t2, APLICAR_NORMAL	# obriga a nao aplicar nada
	li a0, 0
	jal zero, NAO_APLICAR_NADA
	APLICAR_NORMAL: nop
	################################################
	
	## Verifica se precisa de gravidade ##
	bne t1, zero, VERIFICAR_BUG
	
	li t2, 2
	bge t3, t2, VERIFICAR_BUG	# obriga a nao aplicar gravidade
	#########################################
	
	addi a2, a2, 4
	
	## Verifica se possui bug ( dentro do chao ) ##
	VERIFICAR_BUG: nop
	lw t2, 0(a0)	# largura imagem[]
	bge t2, t1, NAO_HA_BUG
	
	addi a2, a2, -1
	
	jal ra, VERIFICAR_CHAO
	mv t1, a0
	lw t0, 4(sp)
	lw a0, 0(t0)
	
	jal zero, VERIFICAR_BUG
	
	NAO_HA_BUG: nop
	lw t0, 4(sp)	# acresccentado
	sw a2, 8(t0)
	mv a0, t1
	
	NAO_APLICAR_NADA: nop
	lw ra, 0(sp)
	addi sp, sp, 8
	
	ret
#####################

####### mover_barril(struct objeto, int in_ground)
## move o barril
# a0 -> struct objeto
# a1 -> in_ground
## retorna novas informacoes sobre o objeto
# a0 -> imagem[]
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> direcao
# a4 -> is_something
MOVER_BARRIL: nop
	## salva valores importantes para funcao ##
	addi sp, sp, -12
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a1, 8(sp)

	## Carregando Valores do Objeto ##
	mv t0, a0	# struct
	lw a0, 0(t0)
	lw a1, 4(t0)
	lw a2, 8(t0)
	lw a3, 16(t0)
	lw a4, 24(t0)
	
	bne a4, zero, MOVER_BARRIL_ESCADA
	
	lw t1, 4(a0)	# altura imagem[]
	## Verificar Escada ##
	add a2, a2, t1	# desloca para baixo do objeto
	addi a2, a2, 15	# desloca 10 casas para baixo do objeto
	li a3, 105
	jal ra, VERIFICAR_ESCADA
	
	mv t2, a0
	
	## Recupera valores perdido na funcao ##
	lw t0, 4(sp)
	lw a0, 0(t0)
	lw a2, 8(t0)
	lw a3, 16(t0)
	
	## Toma decisao sobre escada ##
	li t1, 30
	bge t2, t1, TOMAR_DECISAO_BARRIL
	jal zero, MOVIMENTAR_BARRIL
	
	ENCERRAR_MOVER_BARRIL: nop
	
	ENCERRAR_ANIM_BARRIL: nop
	lw ra, 0(sp)
	addi sp, sp, 12
	
	ret
MOVIMENTAR_BARRIL: nop
	lw t0, 4(sp)
	lw t1, 12(t0)	# velocidade
	beq a3, zero, MOVER_BARRIL_ESQUERDA
	
	## Tratando Animacao Direita Barril ##
	la t2, barril1
	beq a0, t2, BARRIL2
	la t2, barril2
	beq a0, t2, BARRIL4
	la t2, barril4
	beq a0, t2, BARRIL3
	la a0, barril1
	jal zero, ENCERRAR_ANIM_DIREITA_BARRIL
	BARRIL2: nop
	la a0, barril2
	jal zero, ENCERRAR_ANIM_DIREITA_BARRIL
	BARRIL3: nop
	la a0, barril3
	jal zero, ENCERRAR_ANIM_DIREITA_BARRIL
	BARRIL4: nop
	la a0, barril4
	ENCERRAR_ANIM_DIREITA_BARRIL: nop
	
	add a1, a1, t1
	
	## Verifica fim de mapa direita ##
	li t1, 300
	slt t1, t1, a1
	xor a3, a3, t1
	
	jal zero, ENCERRAR_MOVER_BARRIL	
	MOVER_BARRIL_ESQUERDA: nop
	## Tratando Animacao Esquerda Barril ##
	la t2, barril1
	beq a0, t2, BARRIL_LEFT_3
	la t2, barril3
	beq a0, t2, BARRIL_LEFT_4
	la t2, barril4
	beq a0, t2, BARRIL_LEFT_2
	la a0, barril1
	jal zero, ENCERRAR_ANIM_ESQUERDA_BARRIL
	BARRIL_LEFT_2: nop
	la a0, barril2
	jal zero, ENCERRAR_ANIM_ESQUERDA_BARRIL
	BARRIL_LEFT_3: nop
	la a0, barril3
	jal zero, ENCERRAR_ANIM_ESQUERDA_BARRIL
	BARRIL_LEFT_4: nop
	la a0, barril4
	ENCERRAR_ANIM_ESQUERDA_BARRIL: nop
	
	sub a1, a1, t1
	
	jal zero, ENCERRAR_MOVER_BARRIL
MOVER_BARRIL_ESCADA: nop
	li t3, 3
	blt a4, t3, MOVIMENTAR_ESCADA

	lw t1, 8(sp)	# on_ground ?
	beq t1, zero, MOVIMENTAR_ESCADA
	
	## Alterna direcao apos escada ##
	li a4, 0
	xori a3, a3, 1
	jal zero, MOVIMENTAR_BARRIL
	
	MOVIMENTAR_ESCADA: nop
	addi a4, a4, 1
	addi a2, a2, 2
	
	## Tratando Animacao Esquerda Barril ##
	la t2, barril_escada1
	beq a0, t2, BARRIL_ESCADA2
	la a0, barril_escada1
	jal zero, ENCERRAR_ANIM_ESCADA_BARRIL
	BARRIL_ESCADA2: nop
	la a0, barril_escada2
	jal zero, ENCERRAR_ANIM_ESCADA_BARRIL
	ENCERRAR_ANIM_ESCADA_BARRIL: nop
	
	jal zero, ENCERRAR_MOVER_BARRIL
TOMAR_DECISAO_BARRIL: nop
	mv t3, a0
	li a7, 41
	ecall
	
	li t1, 2
	remu a4, a0, t1
	mv a0, t3
	
	beq a4, zero, MOVIMENTAR_BARRIL
	
	addi a2, a2, 12
	la a0, barril_escada1
	
	jal zero, ENCERRAR_MOVER_BARRIL
#################################

######## tratar_colisao(struct objetos[], int x, int y, int tipo)
## trata colisao entre objetos e personagens no frame
# a0 -> objetos[]
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> tipo objeto
## retorna se deve destruir ou nao objeto
# a0 -> imagem[]
# a1 -> novo X
# a2 -> novo Y
# a3 -> flag destruir ( 1 - nao, 0 - sim )
TRATAR_COLISAO: nop	
	## Verifica se objeto esta fora do mapa em X ##
	bge a1, zero, NAO_ESTA_FORA_X
	jal zero, FORA_MAPA
	
	NAO_ESTA_FORA_X: nop
		
	## Verifica se objeto fora do mapa em Y ##
	li t3, 236
	bge t3, a2, NAO_ESTA_FORA_Y
	FORA_MAPA: nop
	lw a0, 0(a0)
	li a3, 0	# flag nao-existencia
	ret
	
	NAO_ESTA_FORA_Y: nop
	
	## VERIFICAR TORTA ##
	li t3, 2
	bne a3, t3, NAO_EH_TORTA
	li t3, 15
	bgt a1, t3, VERIFICAR_TORTA_DIREITA
	jal zero, DESTRUIR_TORTA
	VERIFICAR_TORTA_DIREITA: nop
	li t3, 287
	blt a1, t3, NAO_EH_TORTA
	DESTRUIR_TORTA: nop
	lw a0, 0(a0)
	li a3, 0
	ret
	
	NAO_EH_TORTA: nop
	
	## VERIFICAR ELEVADOR ##
	li t3, 7
	bne a3, t3, NAO_EH_ELEVADOR
	li t3, 70
	bgt a2, t3, NAO_EH_ELEVADOR
	DESTRUIR_ELEVADOR: nop
	lw a0, 0(a0)
	li a3, 0
	ret
	NAO_EH_ELEVADOR: nop
	
	## VERIFICAR TARTAGURA ##
	li t3, 4
	bne a3, t3, NAO_EH_TARTAGURA
	la t3, tartagura_morta
	lw t1, 0(a0)
	bne t1, t3, NAO_EH_TARTAGURA
	DESTRUIR_TARTAGURA: nop
	
	la t3, TempoMorteTartagura
	lw t3, 0(t3)
	
	mv t1, a0
	li a7, 130
	ecall
	
	mv t4, a0
	mv a0, t1
	
	blt t4, t3, NAO_EH_TARTAGURA
	
	lw a0, 0(a0)
	li a3, 0
	ret
	NAO_EH_TARTAGURA: nop
	
	## VERIFICAR FOGO BOWSER ##
	li t3, 12
	bne a3, t3, NAO_EH_FOGO_BOWSER
	li t3, 50
	bgt a1, t3, NAO_EH_FOGO_BOWSER
	DESTRUIR_FOGO_BOWSERVADOR: nop
	la t1, Kong_Chamas
	li t2, 1
	sb t2, 0(t1)
	
	lw a0, 0(a0)
	li a3, 0
	ret
	NAO_EH_FOGO_BOWSER: nop
	
	## meu x inicial é menor igual que x inicial dele && x final meu é maior igual que x inicial dele
	## ou 
	## meu x inicial é maior igual que x inicial dele && x inicial meu é menor igual que x final dele
	la t0, Personagens
	li t1, 3
	
	lw t4, 0(a0)
	lw t2, 0(t4)	# largura imagem[]
	add t2, t2, a1	# x final meu
	
	lw t3, 4(t4)	# altura imagem[]
	add t3, t3, a2	# y final meu
	
	FOR1_TRATAR_COLISAO: nop
		beq t1, zero, EXIT_FOR1_TRATAR_COLISAO
		
		## colisao em X
		lw t4, 4(t0)	# x inicial dele
		blt t4, a1, FALHA_1
		bge t2, t4, SUCESSO_X
		FALHA_1: nop
		bgt t4, a1, NAO_ACHOU_COLISAO
		lw t5, 0(t0)	# imagem[]
		lw t6, 0(t5)	# largura dele
		add t6, t6, t4	# x final dele
		bge t6, a1, SUCESSO_X
		jal zero, NAO_ACHOU_COLISAO
		
		SUCESSO_X: nop
		## colisao em Y
		lw t4, 8(t0)	# y inicial dele
		blt t4, a2, FALHA_2
		bge t3, t4, COLIDIU_OBJETO
		FALHA_2: nop
		bgt t4, a2, NAO_ACHOU_COLISAO
		lw t5, 0(t0)	# imagem[]
		lw t6, 4(t5)	# altura dele
		add t6, t6, t4	# y final dele
		bge t6, a2, COLIDIU_OBJETO
		jal zero, NAO_ACHOU_COLISAO
		
		NAO_ACHOU_COLISAO: nop
		addi t0, t0, 20
		addi t1, t1, -1
		
		jal zero, FOR1_TRATAR_COLISAO
	EXIT_FOR1_TRATAR_COLISAO: nop
	li a3, 1
	
	lw a0, 0(a0)
	ret
COLIDIU_OBJETO: nop
	### COLISAO COM MARIO ###
	li t2, 3
	beq t1, t2, CAUSAR_MORTE

	### COLISAO COM OIL ###
	li t2, 2
	bne t1, t2, EXIT_FOR1_TRATAR_COLISAO
	
	## Colisao Barril com Oil ##
	beq a3, zero, TRANSFORMAR_FOGO
	li t2, 2
	beq a3, t2, TRANSFORMAR_FOGO
	jal zero, EXIT_FOR1_TRATAR_COLISAO
	
	TRANSFORMAR_FOGO: nop
	
	mv t2, a0
	li a7, 41
	ecall
	mv t3, a0
	mv a0, t2
	
	li t2, 2
	remu t2, t3, t2
	beq t2, zero, CRIA_FOGO_OIL
	
	li a3, 0
	
	lw a0, 0(a0)
	ret
	
	CRIA_FOGO_OIL: nop
	addi a2, a2, -18	# desloca para cima
	sw a2, 8(a0)
	
	li t2, 6
	sw t2, 12(a0)	# velocidade = 6
	
	li t2, 1
	sw t2, 16(a0)	# direcao = direita
	
	sw t2, 20(a0)	# tipo = fogo
	
	li t2, 10
	sw t2, 24(a0)	# passos = 10
	
	la t0, foguinho1_left
	sw t0, 0(a0)
	
	jal zero, EXIT_FOR1_TRATAR_COLISAO
CAUSAR_MORTE: nop
	li t4, 4
	beq a3, t4, COLISAO_TARTAGURA
	li t4, 5
	beq a3, t4, COLISAO_MOEDA
	li t4, 7
	beq a3, t4, COLISAO_ELEVADOR
	li t4, 8
	beq a3, t4, COLISAO_AK47
	li t4, 9
	beq a3, t4, COLISAO_MOEDA
	li t4, 10
	beq a3, t4, COLISAO_MOEDA
	li t4, 11
	beq a3, t4, COLISAO_MOEDA
	#### VERIFICAR PULO MARIO ####
	lw t4, 12(t0)	# is_jumpping
	#beq t4, zero, NAO_PULANDO_MORTE
	################################
	
	###### SE METADE DO MARIO ESTIVE DENTRO DO OBJETO #####
	lw t5, 8(t0)	# posicao Y
	blt t5, a2, OBJETO_NAO_ESTA_EMCIMA
	
	lw t4, 0(a0)
	lw t4, 4(t4)
	addi t4, t4, -8
	add t4, t4, a2
	bgt t4, t5, NAO_PULANDO_MORTE
	jal zero, NAO_ACHOU_COLISAO
	
	#######################################################
	OBJETO_NAO_ESTA_EMCIMA: nop
	###### SE METADE DO MARIO ESTIVE DENTRO DO OBJETO #####
	lw t5, 8(t0)	# posicao Y	
	lw t4, 0(t0)	# imagem[]
	lw t4, 4(t4)	# altura
	addi t4, t4, -6
	add t4, t4, t5	# Y + altura/2
	bgt t4, a2, NAO_PULANDO_MORTE
	#######################################################
	
	mv t6, a0
	li a7, 130
	ecall
	mv t4, a0
	mv a0, t6
	
	la t5, Tempo_Score
	lw t6, 0(t5)
	
	bgt t4, t6, CONTINUA_PONTUACAO
	jal zero, NAO_ACHOU_COLISAO
	
	CONTINUA_PONTUACAO: nop
	addi t6, t6, 100
	sw t6, 0(t5)
	
	la t4, Pontuacao
	lhu t5, 0(t4)
	addi t5, t5, 100
	sh t5, 0(t4)
	
	jal zero, NAO_ACHOU_COLISAO
	
	NAO_PULANDO_MORTE: nop
	la t4, Morreu
	li t5, 1
	sb t5, 0(t4)
	
	jal zero, EXIT_FOR1_TRATAR_COLISAO
COLISAO_MOEDA: nop
	mv s11, ra
	
	la t4, SOUND_MOEDA
	jalr ra, t4, 0
	
	mv ra, s11

	la t4, Pontuacao
	lhu t5, 0(t4)
	addi t5, t5, 500
	sh t5, 0(t4)
	
	lw a0, 0(a0)
	li a3, 0
	
	ret
COLISAO_ELEVADOR: nop
	lw t1, 8(t0)
	lw t5, 0(t0)
	lw t5, 4(t5)
	srai t5, t5, 1
	addi t5, t5, 4
	add t1, t1, t5
	
	blt t1, a2, ELEVAR_ELEVADOR
	jal zero, ENCERRAR_COLISAO_ELEVADOR
	
	ELEVAR_ELEVADOR: nop
	addi t1, a2, -21
	sw t1, 8(t0)
	li t1, 0
	sw t1, 12(t0)
	
	ENCERRAR_COLISAO_ELEVADOR: nop
	lw a0, 0(a0)
	li a3, 1
	ret
	
COLISAO_AK47: nop
	mv s11, ra
	
	la t4, SOUND_MOEDA
	jalr ra, t4, 0
	
	

	la t4, Pontuacao
	lhu t5, 0(t4)
	addi t5, t5, 100
	sh t5, 0(t4)
	
	la t4, Armada
	li t5, 1
	sb t5, 0(t4)
	
	la t4, Municao
	li t5, 120
	sb t5, 0(t4)
	
	la t5, RESETAR_PARTICULAS
	jalr ra, t5, 0
	
	mv ra, s11
	
	lw a0, 0(a0)
	li a3, 0
	
	ret
COLISAO_TARTAGURA: nop
	######## CONTINUAR AQUI ###########
	lw t4, 8(t0)	# y mario
	lw t5, 8(a0)	# y tartagura
	blt t4, t5, MATOU_TARTAGURA
	
	lw t4, 0(a0)
	la t5, tartagura_morta
	beq t4, t5, NAO_ACHOU_COLISAO
	jal zero, NAO_PULANDO_MORTE
	
	MATOU_TARTAGURA: nop
	
	mv t5, a0
	li a7, 130
	ecall
	
	addi t4, a0, 100
	mv a0, t5
	
	la t5, TempoMorteTartagura
	sw t4, 0(t5)
	
	la t4, tartagura_morta
	sw t4, 0(a0)
	la a0, tartagura_morta
	li a3, 1
	
	ret
####### mover_foguinho(struct objeto, int in_ground)
## move o foguinho
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_FOGUINHO: nop
	addi sp, sp, -12
	sw ra, 0(sp)
	sw a0, 4(sp)
	sw a2, 8(sp)
	
	## Lendo Informacoes sobre o fogo ##
	lw a1, 4(a0)	# posicao X
	lw a2, 8(a0)	# posicao Y
	lw a3, 16(a0)	# direcao
	lw a4, 24(a0)	# is_something ( passos )
	mv t0, a0	# salva struct
	lw a0, 0(a0)	# imagem[]
	
	## Se terminou de andar ##
	blt a4, zero, TOMAR_DECISAO_FOGUINHO
	MOVIMENTAR_FOGO: nop
	lw t0, 4(sp)
	## Movimento em Escada ##	
	li t2, 2
	beq a3, t2, MOVER_FOGO_CIMA
	li t2, 3
	beq a3, t2, MOVER_FOGO_BAIXO
	
	addi a4, a4, -1
	## Se nao terminou de andar, continue andando ##
	lw t1, 12(t0)	# velocidade
	beq a3, zero, MOVER_FOGO_ESQUERDA
	li t2, 1
	beq a3, t2, MOVER_FOGO_DIREITA
	
	MOVER_FOGO_CIMA: nop
	addi a2, a2, -4
	
	li t1, 4
	bgt a2, t1, MOVE_FOGO_CIMA_NORMAL
	
	li a2, 5
	MOVE_FOGO_CIMA_NORMAL: nop
	
	li a3, 79
	jal ra, VERIFICAR_CHAO
	## Pegando valores perdidos pela funcao ##
	mv t1, a0
	lw t0, 4(sp)
	lw a0, 0(t0)
	lw a3, 16(t0)
	
	beq t1, zero, CONTINUA_MOVER_CIMA_FOGO
	li a3, 0
	addi a2, a2, -18
	li t1, 3
	bgt a2, t1, CONTINUA_MOVER_CIMA_FOGO
	addi a2, a2, 18
	CONTINUA_MOVER_CIMA_FOGO: nop
	jal zero, ENCERRAR_MOVIMENTO_FOGO
	MOVER_FOGO_BAIXO: nop
	addi a2, a2, 4
	
	li a3, 79
	jal ra, VERIFICAR_CHAO
	## Pegando valores perdidos pela funcao ##
	mv t1, a0
	lw t0, 4(sp)
	lw a0, 0(t0)
	lw a3, 16(t0)
	
	beq t1, zero, CONTINUA_MOVER_BAIXO_FOGO
	li a3, 0
	CONTINUA_MOVER_BAIXO_FOGO: nop
	jal zero, ENCERRAR_MOVIMENTO_FOGO
	
	MOVER_FOGO_ESQUERDA: nop
	sub a1, a1, t1
	
	jal ra, VERIFICA_CHAO_FOGO
	
	li t1, 6
	bgt a1, t1, CONTINUAR_MOV_ESQ_FOGO
	li a1, 7
	CONTINUAR_MOV_ESQ_FOGO:  nop
	
	lw t0, 4(sp)
	lw a0, 0(t0)
	
	## Animacao Esquerda Fogo ##
	la t1, foguinho1_left
	beq a0, t1, FOGUINHO2_LEFT
	la a0, foguinho1_left
	jal zero, ENCERRAR_MOVIMENTO_FOGO
	FOGUINHO2_LEFT: nop
	la a0, foguinho1_jump_left
	jal zero, ENCERRAR_MOVIMENTO_FOGO
	
	MOVER_FOGO_DIREITA: nop
	add a1, a1, t1
	
	jal ra, VERIFICA_CHAO_FOGO
	
	li t1, 300
	blt a1, t1, CONTINUAR_MOV_DIR_FOGO
	li a1, 300
	
	CONTINUAR_MOV_DIR_FOGO:  nop

	lw t0, 4(sp)
	lw a0, 0(t0)
	
	## Animacao Direita Fogo ##
	la t1, foguinho1_left
	beq a0, t1, FOGUINHO2_RIGHT
	la a0, foguinho1_left
	jal zero, ENCERRAR_MOVIMENTO_FOGO
	FOGUINHO2_RIGHT: nop
	la a0, foguinho1_jump_left
	jal zero, ENCERRAR_MOVIMENTO_FOGO
	
	TOMAR_DECISAO_FOGUINHO: nop	
	## Verifica se esta tocando na escada ##
	li a3, 105	# cor verde
	jal ra, VERIFICAR_ESCADA
	
	mv t1, a0	# salva qtd pixel tocados em escada
	lw t0, 4(sp)# struct fogo
	lw a0, 0(t0)# imagem[]
	li t3, 0	# flag cima/baixo
	
	li t2, 40
	blt t1, t2, NAO_ENCONTROU_ESCADA_CIMA_FOGO
	li t2, 3	# ( 0 - esquerda, 1 - direita )
	jal zero, SORTEAR_FOGO
	
	NAO_ENCONTROU_ESCADA_CIMA_FOGO: nop
	## Verifica se esta tocando por baixo ##
	addi a2, a2, 24
	li a3, 105
	jal ra, VERIFICAR_ESCADA	
	mv t3, a0	# salva qtd pixel tocados em escada
	lw t0, 4(sp)# struct fogo
	lw a0, 0(t0)# imagem[]
	lw a2, 8(t0)# posicao Y
	
	li t2, 40
	blt t3, t2, NAO_ENCONTROU_ESCADA_BAIXO_FOGO
	li t2, 3	# ( 0 - esquerda, 1 - direita, 2 - cima/baixo )
	jal zero, SORTEAR_FOGO
	
	NAO_ENCONTROU_ESCADA_BAIXO_FOGO: nop
	li t2, 2	# ( 0 - esquerda, 1 - direita )
	SORTEAR_FOGO: nop
	
	## sorteia nova direcao ##
	mv t1, a0	# salva a0
	li a7, 41	# rand()
	ecall
	
	remu a3, a0, t2
	
	li t2, 2
	bne a3, t2, CONTINUA_SORTEIO	# if ( direcao != cima/baixo )
	beq t3, zero, CONTINUA_SORTEIO	# if ( flag_baixo == false )
	
	addi a3, a3, 1	# direcao = 3 ( mover baixo )	
	addi a2, a2, 18
	CONTINUA_SORTEIO: nop
	## sorteia qtd de passos ## 
	li a7, 41
	ecall

	li t2, 3
	remu a4, a0, t2
	mv a0, t1	# retorna original a0
	
	#jal zero, MOVIMENTAR_FOGO
	
	ENCERRAR_MOVIMENTO_FOGO: nop
	
	lw ra, 0(sp)
	addi sp, sp, 12
	
	ret
#################################

####### mover_torta(struct objeto, int in_ground)
## desenha a torta
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_TORTA: nop	
	lw a1, 4(a0)
	lw a2, 8(a0)
	lw a3, 16(a0)
	lw a4, 24(a0)
	lw a0, 0(a0)
	ret

####### mover_mola(struct objeto, int in_ground)
## desenha a torta
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_MOLA: nop
	addi sp, sp, -8
	sw ra, 0(sp)
	sw a1, 4(sp)
	
	lw a1, 4(a0)
	lw a2, 8(a0)
	lw a3, 16(a0)
	lw a4, 24(a0)
	lw a0, 0(a0)
	
	### ANIMACAO MOLA ###
	la t1, mola
	beq a0, t1, MOLA1
	la a0, mola
	jal zero, ENCERRA_ANIM_MOLA
	MOLA1: nop
	la a0, mola1
	####################
	
	ENCERRA_ANIM_MOLA: nop
	
	###### MOVIMENTO DIREITA ####
	li t1, 260
	bge a1, t1, MOLA_END
	addi a1, a1, 4
	jal zero, MOLA_ANDA
	MOLA_END: nop
	addi a2, a2, 10
	li a3, -5
	jal zero, ENCERRAR_MOLA_MOV
	#############################
	
	MOLA_ANDA: nop
	##### MOVIMENTO PULO #####
	blt a4, zero, IS_FALLING_MOLA
	## Subindo ##
	addi a4, a4, -1
	li a3, 2
	addi a2, a2, -2
	jal zero, ENCERRAR_MOLA_MOV
	
	## Queda ##
	IS_FALLING_MOLA: nop 
	li a3, 1
	lw t1, 4(sp)
	beq t1, zero, ENCERRAR_MOLA_MOV
	li a4, 9
	##########################
	
	ENCERRAR_MOLA_MOV: nop
	lw ra, 0(sp)
	addi sp, sp, 8
	ret

####### mover_tartaruga(struct objeto, int in_ground)
## desenha a tartaruga
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_TARTARUGA: nop	
	lw a1, 4(a0)
	lw a2, 8(a0)
	lw t1, 12(a0)
	lw a3, 16(a0)
	lw a4, 24(a0)
	lw a0, 0(a0)
	
	la t0, tartagura_morta
	beq a0, t0, FIM_TARTAGURA
	
	bne a3, zero, DIRECAO_TARTAGURA_RIGHT
	### ANIM. ESQUERDA ###
	la t0, tartagura1_left
	beq a0, t0, TARTAGURA2_LEFT
	la a0, tartagura1_left
	jal zero, MOVIMENTAR_TARTAGURA_LEFT
	TARTAGURA2_LEFT: nop
	la a0, tartagura2_left
	
	MOVIMENTAR_TARTAGURA_LEFT:nop
	sub a1, a1, t1
	jal zero, ENCERRAR_MOV_TARTAGURA
	
	DIRECAO_TARTAGURA_RIGHT: nop
	### ANIM. DIREITA ###
	la t0, tartagura1_left
	beq a0, t0, TARTAGURA2_RIGHT
	la a0, tartagura1_left
	jal zero, MOVIMENTAR_TARTAGURA_RIGHT
	TARTAGURA2_RIGHT: nop
	la a0, tartagura2_left
	
	MOVIMENTAR_TARTAGURA_RIGHT:nop
	add a1, a1, t1
	
	ENCERRAR_MOV_TARTAGURA: nop
	
	addi a4, a4, -1
	bge a4, zero, FIM_TARTAGURA
	xori a3, a3, 1
	li a4, 10
	
	FIM_TARTAGURA: nop
	ret
	
####### mover_moeda(struct objeto, int in_ground)
## desenha a moeda
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_MOEDA: nop	
	lw a1, 4(a0)
	lw a2, 8(a0)
	lw a3, 16(a0)
	lw a4, 24(a0)
	lw a0, 0(a0)
	
	la t1, moeda2_costa
	beq a0, t1, MOEDA_LADO1
	la t1, moeda2_lado
	beq a0, t1, MOEDA_LADO2
	la t1, moeda2_lado2
	beq a0, t1, MOEDA_FRENTE
	la a0, moeda2_costa
	jal zero, ENCERRA_ANIM_MOEDA
	
	MOEDA_LADO1: nop
	la a0, moeda2_lado
	jal zero, ENCERRA_ANIM_MOEDA
	
	MOEDA_LADO2: nop
	la a0, moeda2_lado2
	jal zero, ENCERRA_ANIM_MOEDA
	
	MOEDA_FRENTE: nop
	la a0, moeda2_frente
	
	ENCERRA_ANIM_MOEDA: nop
	ret
	
####### mover_saida_elevador(struct objeto, int in_ground)
## desenha a saida elevador
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_SAIDA_ELEVADOR: nop	
	addi sp ,sp -8
	sw ra, 0(sp)
	sw a0, 4(sp)
	
	lw a1, 4(a0)
	lw a2, 8(a0)
	
	addi a2, a2, 166
	la a0, saida_elevador_baixo
	li a3, 1
	la t0, CRIAR_QUADRADO
	jalr ra, t0, 0
	
	lw a0, 4(sp)
	lw a2, 8(a0)
	lw a3, 16(a0)
	lw a4, 24(a0)
	lw a0, 0(a0)
	
	addi a4, a4, -1
	
	bgt a4, zero, NAO_CRIA_ELEVADOR
	
	li a0, 7
	addi a2, a2, 136
	li a3, -5
	jal ra, CRIAR_OBJETO
	
	lw a0, 4(sp)
	lw a2, 8(a0)
	lw a3, 16(a0)
	li a4, 80
	lw a0, 0(a0)
	
	NAO_CRIA_ELEVADOR: nop
	lw ra, 0(sp)
	addi sp, sp, 8
	
	ret
	
####### mover_elevador(struct objeto, int in_ground)
## move o elevador
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_ELEVADOR: nop	
	lw a1, 4(a0)
	lw a2, 8(a0)
	lw a3, 16(a0)
	lw a4, 24(a0)
	lw a0, 0(a0)
	
	addi a2, a2, -1
	
	ret
####### mover_ak47(struct objeto, int in_ground)
## desenha a ak47
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_AK47: nop	
	lw a1, 4(a0)
	lw a2, 8(a0)
	lw a3, 16(a0)
	lw a4, 24(a0)
	lw a0, 0(a0)
	
	ret
## desenha o FOGO BOWSER
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_FOGO_BOWSER: nop	
	lw a1, 4(a0)
	lw a2, 8(a0)
	lw a3, 16(a0)
	lw a4, 24(a0)
	lw a0, 0(a0)
	
	addi a1, a1, -4
	
	la t0, chama1
	beq a0, t0, CHAMA2
	la a0, chama1
	ret
	CHAMA2: nop
	la a0, chama2
	ret
	
## desenha o BOWSER
# a0 -> struct objeto
# a1 -> on_ground ( 0 - nao esta no chao, 1 - esta no chao )
# a2 -> in_ground ( 0 - nao esta no chao, 1 - esta no chao )
MOVER_BOWSER: nop	
	lw a1, 4(a0)
	lw a2, 8(a0)
	lw a3, 16(a0)
	lw a4, 24(a0)
	lw a0, 0(a0)
	
	ret
##### VERIFICA SE POSSUI CHAO PRO FOGUINHO #####
VERIFICA_CHAO_FOGO: nop
	addi sp, sp, -20
	sw t1, 0(sp)
	sw a3, 4(sp)
	sw a0, 8(sp)
	sw t0, 12(sp)
	sw ra, 16(sp)
	#mv s3, t1
	#mv s4, a3
	#mv s5, a0
	#mv s6, t0
	#mv s7, ra
	
	la t0, VERIFICAR_CHAO
	jalr ra, t0, 0
	
	lw t0, 12(sp)
	lw a3, 4(sp)
	
	beq a0, zero, INVERTE_DIRECAO_FOGO_CHAO
	jal zero, CHAO_FOGO_ENCONTRADO
	INVERTE_DIRECAO_FOGO_CHAO: nop
	
	lw t1, 16(t0)
	xori a3, t1, 1
	sw a3, 16(t0)
	
	beq t1, zero, ESQ_CHAO_FOGO
	lw t1, 0(sp)#
	sub a1, a1, t1#
	#sub a1, a1, s3
	jal zero, CHAO_FOGO_ENCONTRADO
	ESQ_CHAO_FOGO: nop
	lw t1, 0(sp)#
	add a1, a1, t1#
	#add a1, a1, s3
	
	CHAO_FOGO_ENCONTRADO: nop
	lw a0, 8(sp)
	lw ra, 16(sp)
	addi sp, sp, 20
	
	ret
#################################################

####### bool verificar_chao(imagem[], int x, int y, int cor, int corpo, int direcao)
## verifica se a imagem toca o chao
# a0 -> vetor imagem
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> cor do chao ( argumento retirado )
VERIFICAR_CHAO: nop
	addi sp, sp, -8
	sw a2, 4(sp)
	
	## VETOR MAPA ##
	la t0, mapa
	addi t0, t0 8
	
	## imagem [] ##
	
	lw t2, 0(a0)	# largura
	lw t3, 4(a0)	# altura
	sw t2, 0(sp)	# backup largura
	
	li t4, 9
	blt t3, t4, NAO_MEIO
	
	addi a2, a2, 8
	addi t3, t3, -8
	
	NAO_MEIO: nop
	# 320 * y + x + End.I
	li t4, 320	# 320
	mul t4, t4, a2	# 320 * y
	add t4, t4, a1	# 320 * y + x
	add t0, t0, t4	# 320 * y + x + End.I
	
	li a0, 0
	FOR1_VERIFICAR_CHAO: nop
		beq t3, zero, EXIT_FOR1_VERIFICAR_CHAO
		
		lb t4, 0(t0)
		la t5, Chao
		lb t6, 0(t5)
		beq t4, t6, ACHOU_UM_CHAO
		lb t6, 1(t5)
		beq t4, t6, ACHOU_UM_CHAO
		lb t6, 2(t5)
		beq t4, t6, ACHOU_UM_CHAO
		lb t6, 3(t5)
		beq t4, t6, ACHOU_UM_CHAO
		lb t6, 4(t5)
		beq t4, t6, ACHOU_UM_CHAO
		lb t6, 5(t5)
		beq t4, t6, ACHOU_UM_CHAO
		VOLTAR_ACHOU_UM_CHAO:nop
		
		
		addi t0, t0, 1
		addi t2, t2, -1
		
		beq t2, zero, QUEBRAR_LINHA_CHAO
		
		jal zero, FOR1_VERIFICAR_CHAO
	EXIT_FOR1_VERIFICAR_CHAO: nop
	
	lw a2, 4(sp)
	addi sp, sp, 8
	ret
	
ACHOU_UM_CHAO: nop
	addi a0, a0, 1
	jal zero, VOLTAR_ACHOU_UM_CHAO
QUEBRAR_LINHA_CHAO: nop
	
	lw t2, 0(sp)
	
	sub t0, t0, t2
	addi t0, t0, 320
	
	addi t3, t3, -1
	
	jal zero, FOR1_VERIFICAR_CHAO
#######################

####### bool verificar_escada(imagem[], int x, int y, int cor)
## verifica se a imagem toca a escada
# a0 -> vetor imagem
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> cor da escada
## retorna quantidade de pixels escada encontrado
# a0 -> quantidade de pixels encontrado
VERIFICAR_ESCADA: nop
	#li t6, 0xFF000000 # uso para debug

	### achando a posicao no display para desenhar ##
	li t0, 320
	mul t0, t0, a2		# 320 * y
	add t0, t0, a1		# 320 * y + x
	la t1, mapa		# endereço inicial do mapa
	addi t1, t1, 8		# pula struct do mapa
	#add t6, t6, t0	# debug
	add t0, t0, t1		# 320*y + x + end.Inicial
	
	lw t1, 0(a0)			# largura da imagem
	lw t2, 4(a0)			# altura da imagem
	#srai t2, t2, 1			# divide altura por 2, utilizado caso queira apenas metdade do corpo
	#li t4, 248		#debug
	li t5, 0
FOR1_VERIFICAR_ESCADA: nop
		beq t2, zero, EXIT_FOR1_VERIFICAR_ESCADA
		
		## verificar se pixel eh igual a cor ##
		lb t3, 0(t0)
		#sb t4, 0(t6)	# debug
		beq t3, a3, ENCONTROU_ESCADA
		VOLTA_ENCONTROU_ESCADA: nop
		## verifica quebra de linha ##
		addi t1, t1, -1
		addi t0, t0, 1
		#addi t6, t6, 1	# debug
		bne t1, zero, NAO_QUEBRA_LINHA
		## se ja alcancou largura da imagem, quebra linha ##
		addi t0, t0, 320
		lw t1, 0(a0)
		sub t0, t0, t1
		#addi t6, t6, 320	# debug
		#sub t6, t6, t1		# debug
		addi t2, t2, -1	# contador de linhas --
NAO_QUEBRA_LINHA: nop
		jal zero, FOR1_VERIFICAR_ESCADA

EXIT_FOR1_VERIFICAR_ESCADA: nop
		mv a0, t5
		ret
ENCONTROU_ESCADA: nop
		addi t5, t5, 1
		jal zero, VOLTA_ENCONTROU_ESCADA
#######################
