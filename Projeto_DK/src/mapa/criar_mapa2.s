
.text

CRIAR_MAPA2: nop

la s3, DESENHAR_QUADRADO
mv s4, ra
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
li a4, 0
li a5, 9
jalr ra, s3, 0
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
li a5, 12
jalr ra, s3, 0
####################################
li a1, 297
li a2, 232	# posicao Y
jalr ra, s5, 0

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
li a4, 1
jalr ra, s5, 0
addi a2, a2, -3
li a5, 4
jalr ra, s3, 0

li a1, 90
li a2, 0
jalr ra, s5, 0
addi a2, a2, -3
li a5, 4
jalr ra, s3, 0
	
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

mv ra, s4
ret
