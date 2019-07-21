.data 
.include "..\..\images\chao.s"
.include "..\..\images\barril_mapa.s"
.include "..\..\images\escada_quebrada1.s"
.include "..\..\images\escada1.s"
.include "..\..\images\ferro_laranja.s"

.text
CRIAR_MAPA: nop

addi sp, sp, -4
sw ra, 0(sp)

la s5, CRIAR_QUADRADO

## COPIAR VARIOS DESSES PARA CRIAR MAPA ##

####### Plataforma ############

la a0, chao	# imagem do chao
li a1, 117	# posicao X
li a2, 25	# posicao Y
li a3, 1	# flag ( 0 - apaga, 1 - desenha )
jalr ra, s5, 0

li a1, 140	# posicao X
jalr ra, s5, 0

li a1, 163	# posicao X
jalr ra, s5, 0

####### Primeira linha ########


####### Barris ###############

la a0, barril_mapa	# imagem do chao
li a1, 2	# posicao X
li a2, 40	# posicao Y
li a3, 1	# flag ( 0 - apaga, 1 - desenha )
jalr ra, s5, 0

li a2, 22	# posicao Y
jalr ra, s5, 0

li a1, 15	# posicao X
li a2, 40	# posicao Y
jalr ra, s5, 0

li a2, 22	# posicao Y
jalr ra, s5, 0


####### Escadas ###############

# Escada da esquerda

la a0, ferro_laranja	# imagem do chao
li a1, 82	# posicao X
li a2, 1	# posicao Y
jalr ra, s5, 0

la a0, escada1	# imagem do chao
li a2, 10	# posicao Y
jalr ra, s5, 0

li a2, 22	# posicao Y
jalr ra, s5, 0

li a2, 34	# posicao Y
jalr ra, s5, 0

li a2, 46	# posicao Y
jalr ra, s5, 0

# Escada da direita

la a0, ferro_laranja	# imagem do chao
li a1, 105	# posicao X
li a2, 1	# posicao Y
jalr ra, s5, 0

la a0, escada1	# imagem do chao
li a2, 10	# posicao Y
jalr ra, s5, 0

li a2, 22	# posicao Y
jalr ra, s5, 0

li a2, 34	# posicao Y
jalr ra, s5, 0

li a2, 46	# posicao Y
jalr ra, s5, 0

# Escada da plataforma

li a1, 175	# posicao X
li a2, 46	# posicao Y
jalr ra, s5, 0

li a2, 34	# posicao Y
jalr ra, s5, 0


####### Chão ##################

la a0, chao	# imagem do chao
li a1, 0	# posicao X
li a2, 59	# posicao Y
jalr ra, s5, 0

li a1, 23	# posicao X
jalr ra, s5, 0

li a1, 46	# posicao X
jalr ra, s5, 0

li a1, 69	# posicao X
jalr ra, s5, 0

li a1, 92	# posicao X
jalr ra, s5, 0

li a1, 115	# posicao X
jalr ra, s5, 0

li a1, 138	# posicao X
jalr ra, s5, 0

li a1, 161	# posicao X
jalr ra, s5, 0

li a1, 184	# posicao X
li a2, 60	# posicao Y
jalr ra, s5, 0

li a1, 207	# posicao X
li a2, 61	# posicao Y
jalr ra, s5, 0

li a1, 230	# posicao X
li a2, 62	# posicao Y
jalr ra, s5, 0

li a1, 253	# posicao X
li a2, 63	# posicao Y
jalr ra, s5, 0


 ################ Segunda Linha ################
 
 
 ############ Escadas ############ 
 
la a0, escada1	# imagem do chao
li a1, 250	# posicao X
li a2, 71		# posicao Y
jalr ra, s5, 0

li a2, 75		# posicao Y
jalr ra, s5, 0

la a0, escada_quebrada1	# imagem do chao
li a1, 120	# posicao X
li a2, 68		# posicao Y
jalr ra, s5, 0

la a0, escada1	# imagem do chao
li a2, 80		# posicao Y
jalr ra, s5, 0

  
 ############ Chão ############ 
la a0, chao	# imagem do chao
li a1, 297	# posicao X
li a2, 85		# posicao Y
jalr ra, s5, 0

li a1, 274	# posicao X
li a2, 86		# posicao Y
jalr ra, s5, 0

li a1, 251	# posicao X
li a2, 87		# posicao Y
jalr ra, s5, 0

li a1, 228	# posicao X
li a2, 88		# posicao Y
jalr ra, s5, 0

li a1, 205	# posicao X
li a2, 89		# posicao Y
jalr ra, s5, 0

li a1, 182	# posicao X
li a2, 90		# posicao Y
jalr ra, s5, 0

li a1, 159	# posicao X
li a2, 91		# posicao Y
jalr ra, s5, 0

li a1, 136	# posicao X
li a2, 92		# posicao Y
jalr ra, s5, 0

li a1, 113	# posicao X
li a2, 93		# posicao Y
jalr ra, s5, 0

li a1, 90	# posicao X
li a2, 94		# posicao Y
jalr ra, s5, 0

li a1, 67	# posicao X
li a2, 95		# posicao Y
jalr ra, s5, 0

li a1, 44	# posicao X
li a2, 96		# posicao Y
jalr ra, s5, 0

li a1, 21	# posicao X
li a2, 97		# posicao Y
jalr ra, s5, 0

################ Terceira Linha ################

###### Escadas ########

la a0, escada1	# imagem do chao
li a1, 47	# posicao X
li a2, 112	# posicao Y
jalr ra, s5, 0

li a2, 104	# posicao Y
jalr ra, s5, 0

li a1, 95	# posicao X
li a2, 110	# posicao Y
jalr ra, s5, 0

li a1, 95	# posicao X
li a2, 102	# posicao Y
jalr ra, s5, 0

la a0, escada_quebrada1	# imagem do chao
li a1, 220	# posicao X
li a2, 98	# posicao Y
jalr ra, s5, 0

li a2, 102	# posicao Y
jalr ra, s5, 0

la a0, escada1	# imagem do chao
li a2, 120	# posicao Y
jalr ra, s5, 0


###### Chão #######
la a0, chao	# imagem do chao
li a1, 0	# posicao X
li a2, 120		# posicao Y
jalr ra, s5, 0

li a1, 23	# posicao X
li a2, 121		# posicao Y
jalr ra, s5, 0

li a1, 46	# posicao X
li a2, 122		# posicao Y
jalr ra, s5, 0

li a1, 69       # posicao X
li a2, 123              # posicao Y
jalr ra, s5, 0

li a1, 92       # posicao X
li a2, 124              # posicao Y
jalr ra, s5, 0

li a1, 115      # posicao X
li a2, 125              # posicao Y
jalr ra, s5, 0

li a1, 138      # posicao X
li a2, 126              # posicao Y
jalr ra, s5, 0

li a1, 161      # posicao X
li a2, 127              # posicao Y
jalr ra, s5, 0

li a1, 184      # posicao X
li a2, 128              # posicao Y
jalr ra, s5, 0

li a1, 207      # posicao X
li a2, 129              # posicao Y
jalr ra, s5, 0

li a1, 230      # posicao X
li a2, 130              # posicao Y
jalr ra, s5, 0

li a1, 253      # posicao X
li a2, 131              # posicao Y
jalr ra, s5, 0

################ Quarta Linha ################

####### Escadas #########

la a0, escada1	# imagem do chao
li a1, 250	# posicao X
li a2, 142	# posicao Y
jalr ra, s5, 0

la a0, escada_quebrada1	# imagem do chao
li a2, 140     # posicao Y
jalr ra, s5, 0

la a0, escada1	# imagem do chao
li a1, 150	# posicao X
li a2, 150	# posicao Y
jalr ra, s5, 0

li a2, 138	# posicao Y
jalr ra, s5, 0

la a0, escada_quebrada1	# imagem do chao
li a2, 134	# posicao Y
jalr ra, s5, 0

li a1, 80	# posicao X
li a2, 132	# posicao Y
jalr ra, s5, 0

li a2, 135	# posicao Y
jalr ra, s5, 0

li a2, 146	# posicao Y
jalr ra, s5, 0

la a0, escada1	# imagem do chao
li a2, 150	# posicao Y
jalr ra, s5, 0
 
 
####### Chão ########
la a0, chao	# imagem do chao
li a1, 297	# posicao X
li a2, 154		# posicao Y
jalr ra, s5, 0

li a1, 274	# posicao X
li a2, 155		# posicao Y
jalr ra, s5, 0

li a1, 251	# posicao X
li a2, 156		# posicao Y
jalr ra, s5, 0

li a1, 228	# posicao X
li a2, 157		# posicao Y
jalr ra, s5, 0

li a1, 205	# posicao X
li a2, 158		# posicao Y
jalr ra, s5, 0

li a1, 182	# posicao X
li a2, 159		# posicao Y
jalr ra, s5, 0

li a1, 159	# posicao X
li a2, 160		# posicao Y
jalr ra, s5, 0

li a1, 136	# posicao X
li a2, 161		# posicao Y
jalr ra, s5, 0

li a1, 113	# posicao X
li a2, 162		# posicao Y
jalr ra, s5, 0

li a1, 90	# posicao X
li a2, 163		# posicao Y
jalr ra, s5, 0

li a1, 67	# posicao X
li a2, 164		# posicao Y
jalr ra, s5, 0

li a1, 44	# posicao X
li a2, 165		# posicao Y
jalr ra, s5, 0

li a1, 21	# posicao X
li a2, 166		# posicao Y
jalr ra, s5, 0


################ Quinta Linha ################


###### Escadas #######

la a0, escada1	# imagem do chao
li a1, 40	# posicao X
li a2, 172	# posicao Y
jalr ra, s5, 0

li a2, 184	# posicao Y
jalr ra, s5, 0

li a1, 200	# posicao X
li a2, 185	# posicao Y
jalr ra, s5, 0

li a2, 173	# posicao Y
jalr ra, s5, 0

li a2, 165	# posicao Y
jalr ra, s5, 0

###### Chão #######

la a0, chao	# imagem do chao
li a1, 0	# posicao X
li a2, 190		# posicao Y
jalr ra, s5, 0

li a1, 23	# posicao X
li a2, 191		# posicao Y
jalr ra, s5, 0

li a1, 46	# posicao X
li a2, 192		# posicao Y
jalr ra, s5, 0

li a1, 69       # posicao X
li a2, 193              # posicao Y
jalr ra, s5, 0

li a1, 92       # posicao X
li a2, 194              # posicao Y
jalr ra, s5, 0

li a1, 115      # posicao X
li a2, 195              # posicao Y
jalr ra, s5, 0

li a1, 138      # posicao X
li a2, 196              # posicao Y
jalr ra, s5, 0

li a1, 161      # posicao X
li a2, 197              # posicao Y
jalr ra, s5, 0

li a1, 184      # posicao X
li a2, 198              # posicao Y
jalr ra, s5, 0

li a1, 207      # posicao X
li a2, 199              # posicao Y
jalr ra, s5, 0

li a1, 230      # posicao X
li a2, 200              # posicao Y
jalr ra, s5, 0

li a1, 253      # posicao X
li a2, 201              # posicao Y
jalr ra, s5, 0

############ Sexta Linha #############

##### Escadas ######

la a0, escada1	# imagem do chao
li a1, 180	# posicao X
li a2, 215	# posicao Y
jalr ra, s5, 0

li a2, 203	# posicao Y
jalr ra, s5, 0


li a1, 100	# posicao X
li a2, 216	# posicao Y
jalr ra, s5, 0

la a0, escada_quebrada1	# imagem do chao
li a2, 203	# posicao Y
jalr ra, s5, 0

##### Chão #####

la a0, chao     # imagem do chao
li a1, 0      # posicao X
li a2, 230              # posicao Y
jalr ra, s5, 0

li a1, 23      # posicao X
jalr ra, s5, 0

li a1, 46      # posicao X
jalr ra, s5, 0

li a1, 69      # posicao X
jalr ra, s5, 0

li a1, 92      # posicao X
jalr ra, s5, 0

li a1, 115      # posicao X
jalr ra, s5, 0

li a1, 138      # posicao X
jalr ra, s5, 0

li a1, 161      # posicao X
li a2, 229              # posicao Y
jalr ra, s5, 0

li a1, 184      # posicao X
li a2, 228              # posicao Y
jalr ra, s5, 0

li a1, 207      # posicao X
li a2, 227              # posicao Y
jalr ra, s5, 0

li a1, 230      # posicao X
li a2, 226              # posicao Y
jalr ra, s5, 0

li a1, 253      # posicao X
li a2, 225              # posicao Y
jalr ra, s5, 0

li a1, 276      # posicao X
li a2, 224              # posicao Y
jalr ra, s5, 0

li a1, 299      # posicao X
li a2, 223              # posicao Y
jalr ra, s5, 0

lw ra, 0(sp)
addi sp, sp, 4
ret
