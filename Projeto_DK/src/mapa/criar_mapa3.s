.data
.include "..\..\images\chao_3.s"
.include "..\..\images\esteira.s"
.include "..\..\images\shis.s"

.text

CRIAR_MAPA3: nop

la s3, DESENHAR_QUADRADO
mv s4, ra
la s5, CRIAR_QUADRADO

## COPIAR VARIOS DESSES PARA CRIAR MAPA ##

############# Primeira linha #############

####### Plataforma ############

la a0, chao_3	# imagem do chao
li a1, 130	# posicao X
li a2, 30	# posicao Y
li a3, 1	# flag ( 0 - apaga, 1 - desenha )
jalr ra, s5, 0

li a4, 0
li a5, 5 
jalr ra, s3, 0

###### Escadas ########


#Escada grande da direita
la a0, escada1	# imagem do chao
li a1, 120	# posicao X
li a2, 0	# posicao Y
jalr ra, s5, 0

li a4, 1
li a5, 4 
jalr ra, s3, 0


#Escada grande da esquerda
la a0, escada1	# imagem do chao
li a1, 100	# posicao X
li a2, 0	# posicao Y

jalr ra, s5, 0

li a5, 4
jalr ra, s3, 0
li a4, 0

#Escada da plataforma
la a0, escada1	# imagem do chao
li a1, 167	# posicao X
li a2, 38	# posicao Y
jalr ra, s5, 0

li a1, 167
li a2, 50
jalr ra, s5, 0


##### chao #####

la a0, esteira	# imagem do chao
li a1, 25	# posicao X
li a2, 63	# posicao Y
jalr ra, s5, 0

li a5, 32
jalr ra, s3, 0


##################### Segunda linha #####################


########## Chao ###########

la a0, esteira	# imagem do chao
li a1, 0	# posicao X
li a2, 105	# posicao Y
jalr ra, s5, 0

li a5, 17
jalr ra, s3, 0


la a0, esteira	# imagem do chao
li a1, 183	# posicao X
li a2, 105	# posicao Y
jalr ra, s5, 0

li a5, 16
jalr ra, s3, 0


##### Escadas #####

#Escada da esquerda
la a0, escada1	# imagem do chao
li a1, 30	# posicao X
li a2, 94	# posicao Y
jalr ra, s5, 0

li a2, 83
jalr ra, s5, 0

li a2, 71
jalr ra, s5, 0


#Escada da direta 

la a0, escada1	# imagem do chao
li a1, 275	# posicao X
li a2, 94	# posicao Y
jalr ra, s5, 0

li a2, 83
jalr ra, s5, 0

li a2, 71
jalr ra, s5, 0


################### Terceira linha ####################

###### Escadas #######

# Escada da esquerda
la a0, escada1	# imagem do chao
li a1, 45		# posicao X
li a2, 138	# posicao Y
jalr ra, s5, 0

li a2, 126	# posicao Y
jalr ra, s5, 0

li a2, 114	# posicao Y
jalr ra, s5, 0

# Escada do meio (esquerda)
li a1, 125	 # posicao X
li a2, 138	 # posicao Y
jalr ra, s5, 0

li a2, 126	 # posicao Y
jalr ra, s5, 0

li a2, 114	 # posicao Y
jalr ra, s5, 0

# Escada do meio (direita)
li a1, 190
li a2, 138 	# posicao Y
jalr ra, s5, 0

li a2, 126 	# posicao Y
jalr ra, s5, 0

li a2, 114 	# posicao Y
jalr ra, s5, 0

# Escada da direita
li a1, 265	# posicao X
li a2, 138	# posicao Y
jalr ra, s5, 0

li a2, 126	# posicao Y
jalr ra, s5, 0

li a2, 114	# posicao Y
jalr ra, s5, 0


###### Chao #######

la a0, chao_3	# imagem do chao
li a1, 15	# posicao X
li a2, 150	# posicao Y
jalr ra, s5, 0

li a5, 7
jalr ra, s3, 0



la a0, chao_3	# imagem do chao
li a1, 110	# posicao X
li a2, 150	# posicao Y
jalr ra, s5, 0

li a5, 12
jalr ra, s3, 0




la a0, chao_3	# imagem do chao
li a1, 242	# posicao X
li a2, 150	# posicao Y
jalr ra, s5, 0

li a5, 7

jalr ra, s3, 0


##### X's #####

la a0, shis	# imagem do chao
li a1, 147	# posicao X
li a2, 140	# posicao Y
jalr ra, s5, 0

li a2, 132	# posicao Y
jalr ra, s5, 0

li a2, 124	# posicao Y
jalr ra, s5, 0


li a1, 155	# posicao X
li a2, 140	# posicao Y
jalr ra, s5, 0

li a2, 132	# posicao Y
jalr ra, s5, 0

li a2, 124	# posicao Y
jalr ra, s5, 0



li a1, 163	# posicao X
li a2, 140	# posicao Y
jalr ra, s5, 0

li a2, 132	# posicao Y
jalr ra, s5, 0

li a2, 124	# posicao Y
jalr ra, s5, 0



li a1, 171	# posicao X
li a2, 140	# posicao Y
jalr ra, s5, 0

li a2, 132	# posicao Y
jalr ra, s5, 0

li a2, 124	# posicao Y
jalr ra, s5, 0


################ Quarta linha #################

#### Chao ####

la a0, esteira	# imagem do chao
li a1, 25		# posicao X
li a2, 190	# posicao Y
jalr ra, s5, 0

li a5, 32
jalr ra, s3, 0

##### Escadas #####

# Escada da direita
la a0, escada1
li a1, 200	# posicao X
li a2, 158	# posicao Y
jalr ra, s5, 0

li a2, 170	# posicao Y
jalr ra, s5, 0

li a2, 178	# posicao Y
jalr ra, s5, 0

#Escada da esquerda

la a0, escada1
li a1, 115	# posicao X
li a2, 158	# posicao Y
jalr ra, s5, 0

li a2, 170	# posicao Y
jalr ra, s5, 0

li a2, 178	# posicao Y
jalr ra, s5, 0



################# Quinta linha ##################

#### Chao ####

la a0, chao_3	# imagem do chao
li a1, 0	# posicao X
li a2, 231	# posicao Y
jalr ra, s5, 0

li a5, 39
jalr ra, s3, 0


#### Escadas (da esquerda pra direita) ####

# Escada 1
la a0, escada1
li a1, 65	# posicao X
li a2, 198	# posicao Y
jalr ra, s5, 0

li a2, 210	# posicao Y
jalr ra, s5, 0

li a2, 218	# posicao Y
jalr ra, s5, 0


# Escada 2
li a1, 130	# posicao X
li a2, 198	# posicao Y
jalr ra, s5, 0

li a2, 210	# posicao Y
jalr ra, s5, 0

li a2, 218	# posicao Y
jalr ra, s5, 0


# Escada 3
li a1, 185	# posicao X
li a2, 198	# posicao Y
jalr ra, s5, 0

li a2, 210	# posicao Y
jalr ra, s5, 0

li a2, 218	# posicao Y
jalr ra, s5, 0


# Escada 4
li a1, 245	# posicao X
li a2, 198	# posicao Y
jalr ra, s5, 0

li a2, 210	# posicao Y
jalr ra, s5, 0

li a2, 218	# posicao Y
jalr ra, s5, 0

#########################################

mv ra, s4

ret

######## DESENHAR_QUADRADO
## desenha uma quantidade de quadrados a partir de uma posicao
# a0 -> imagem[]
# a1 -> posicao X inicial
# a2 -> posicao Y inicial
# a3 -> flag desenhar ( 0 - apaga, 1 - desenha )
# a4 -> direcao ( 0 - direita, 1 - baixo )
# a5 -> quantidade
DESENHAR_QUADRADO: nop
	mv s8, ra
	mv s6, a5
	bne a4, zero, CIMA_DESENHAR_QUADRADO
	lw s7, 0(a0)
	jal zero, FOR1_DESENHAR_QUADRADO
	CIMA_DESENHAR_QUADRADO:nop
	lw s7, 4(a0)
	
	FOR1_DESENHAR_QUADRADO: nop
		beq s6, zero, EXIT_FOR1_DESENHAR_QUADRADO
		
		bne a4, zero, DESENHAR_QUADRADO_CIMA
		add a1, a1, s7
		jal zero, CONTINUAR_FOR1_DESENHAR_QUADRADO
		
		DESENHAR_QUADRADO_CIMA: nop
		add a2, a2, s7
		
		CONTINUAR_FOR1_DESENHAR_QUADRADO: nop
		jalr ra, s5, 0
		addi s6, s6, -1
		jal zero, FOR1_DESENHAR_QUADRADO
	EXIT_FOR1_DESENHAR_QUADRADO: nop
	
	mv ra, s8
	ret
