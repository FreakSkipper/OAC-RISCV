.data
.include "..\..\images\chao.s"
.include "..\..\images\barril_mapa.s"
.include "..\..\images\escada_quebrada1.s"
.include "..\..\images\escada1.s"
.include "..\..\images\ferro_laranja.s"

Frame_Desenhar: .word 0xFF000000
mapa:.space 76800
.text

CRIAR_MAPA: nop

la s5, CRIAR_QUADRADO

## COPIAR VARIOS DESSES PARA CRIAR MAPA ##

####### Plataforma ############

######### CHAO PRINCESA ############
la a0, chao	# imagem do chao
li a1, 117	# posicao X
li a2, 25	# posicao Y
li a3, 1	# flag ( 0 - apaga, 1 - desenha )
jalr ra, s5, 0

li a1, 140	# posicao X
jalr ra, s5, 0

li a1, 163	# posicao X
jalr ra, s5, 0
####################################
li a2, 63	# posicao Y
li a1, 0
jalr ra, s5, 0

######### CHAO DO KONG ##############
li s6, 9
	FOR1_CRIAR_MAPA2: nop
		beq s6, zero, EXIT_FOR1_CRIAR_MAPA2
		addi a1, a1, 23
		jalr ra, s5, 0
		
		addi s6, s6, -1
		jal zero, FOR1_CRIAR_MAPA2
	EXIT_FOR1_CRIAR_MAPA2: nop
####################################

##### PISOS ACIMA DO MARIO ####
li a2, 212	# posicao Y
li a1, 0
jalr ra, s5, 0
li a1, 7
jalr ra, s5, 0

li a1, 0
li a2, 172	# posicao Y
jalr ra, s5, 0
li a1, 7
jalr ra, s5, 0

li a1, 0
li a2, 112	# posicao Y
jalr ra, s5, 0
li a1, 7
jalr ra, s5, 0
################################

li a1, 0
li a2, 232	# posicao Y
jalr ra, s5, 0

######### CHAO DO MARIO ##############
li s6, 13
	FOR2_CRIAR_MAPA2: nop
		beq s6, zero, EXIT_FOR2_CRIAR_MAPA2
		addi a1, a1, 23
		jalr ra, s5, 0
		
		addi s6, s6, -1
		jal zero, FOR2_CRIAR_MAPA2
	EXIT_FOR2_CRIAR_MAPA2: nop
####################################

###### MEIO #########
li a1, 74
li a2, 112	# posicao Y
jalr ra, s5, 0
li a1, 97
jalr ra, s5, 0

li a1, 97
li a2, 190	# posicao Y
jalr ra, s5, 0
li a1, 90
jalr ra, s5, 0
####################

#### CANTO #####
li a2, 212	# posicao Y
li a1, 160
jalr ra, s5, 0
li a1, 167
jalr ra, s5, 0
li a2, 204	# posicao Y
li a1, 200
jalr ra, s5, 0
li a2, 196	# posicao Y
li a1, 232
jalr ra, s5, 0
li a2, 188	# posicao Y
li a1, 270
jalr ra, s5, 0
li a1, 293
jalr ra, s5, 0

li a1, 167
li a2, 104	# posicao Y
jalr ra, s5, 0
li a1, 183
li a2, 144	# posicao Y
jalr ra, s5, 0
li a1, 220
li a2, 152	# posicao Y
jalr ra, s5, 0
li a1, 263
li a2, 160	# posicao Y
jalr ra, s5, 0
li a1, 297
li a2, 168	# posicao Y
jalr ra, s5, 0

li a1, 202
li a2, 100	# posicao Y
jalr ra, s5, 0
li a1, 210
li a2, 100	# posicao Y
jalr ra, s5, 0
li a1, 243
li a2, 92	# posicao Y
jalr ra, s5, 0
li a1, 283
li a2, 84	# posicao Y
jalr ra, s5, 0
li a1, 297
jalr ra, s5, 0

li a1, 263
li a2, 125	# posicao Y
jalr ra, s5, 0
li a1, 286
jalr ra, s5, 0
li a1, 297
jalr ra, s5, 0
#########################################

########## ESCADAS NIVEL 1 ################
la a0, escada1
li a1, 110
li a2, 0
jalr ra, s5, 0

li s6, 4
FOR3_CRIAR_MAPA2: nop
	beq s6, zero, EXIT_FOR3_CRIAR_MAPA2
	addi a2, a2, 12
	jalr ra, s5, 0
	addi s6, s6, -1
	jal zero, FOR3_CRIAR_MAPA2
	EXIT_FOR3_CRIAR_MAPA2: nop

li a1, 90
li a2, 0
jalr ra, s5, 0

li s6, 4
FOR4_CRIAR_MAPA2: nop
	beq s6, zero, EXIT_FOR4_CRIAR_MAPA2
	addi a2, a2, 12
	jalr ra, s5, 0
	addi s6, s6, -1
	jal zero, FOR4_CRIAR_MAPA2
	EXIT_FOR4_CRIAR_MAPA2: nop
	
li a1, 175
li a2, 33
jalr ra, s5, 0
li a2, 45
jalr ra, s5, 0
li a2, 49
jalr ra, s5, 0

li a1, 219
li a2, 71
jalr ra, s5, 0
li a2, 75
jalr ra, s5, 0
li a2, 87
jalr ra, s5, 0

li a1, 285
li a2, 92
jalr ra, s5, 0
li a2, 104
jalr ra, s5, 0
li a2, 108
jalr ra, s5, 0
li a2, 111
jalr ra, s5, 0

li a1, 263
li a2, 133
jalr ra, s5, 0
li a2, 145
jalr ra, s5, 0

li a1, 298
li a2, 176
jalr ra, s5, 0

li a1, 5
li a2, 199
jalr ra, s5, 0
li a2, 187
jalr ra, s5, 0
li a2, 181
jalr ra, s5, 0

li a1, 18
li a2, 159
jalr ra, s5, 0
li a2, 147
jalr ra, s5, 0
li a2, 135
jalr ra, s5, 0
li a2, 123
jalr ra, s5, 0
li a2, 120
jalr ra, s5, 0

li a1, 90
li a2, 120
jalr ra, s5, 0
li a2, 132
jalr ra, s5, 0
li a2, 144
jalr ra, s5, 0
li a2, 156
jalr ra, s5, 0
li a2, 168
jalr ra, s5, 0
li a2, 176
jalr ra, s5, 0

li a1, 109
li a2, 120
jalr ra, s5, 0
li a2, 132
jalr ra, s5, 0
li a2, 144
jalr ra, s5, 0
li a2, 156
jalr ra, s5, 0
li a2, 168
jalr ra, s5, 0
li a2, 176
jalr ra, s5, 0

li a1, 180
li a2, 112
jalr ra, s5, 0
li a2, 124
jalr ra, s5, 0
li a2, 130
jalr ra, s5, 0
############################################

li a7, 10
ecall


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
	ebreak
	jal zero, PULO_CONDICIONAL2