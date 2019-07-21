.data
.include "chao_3.s"
.include "esteira.s"
.include "shis.s"
.include "escada_quebrada1.s"
.include "escada1.s"
.include "ferro_laranja.s"
Frame_Desenhar: .word 0xFF000000
.text

CRIAR_MAPA: nop

## COPIAR VARIOS DESSES PARA CRIAR MAPA ##

############# Primeira linha #############

####### Plataforma ############

la a0, chao_3	# imagem do chao
li a1, 130	# posicao X
li a2, 30	# posicao Y
li a3, 1	# flag ( 0 - apaga, 1 - desenha )
jal ra, CRIAR_QUADRADO

li s6, 5 
FOR1_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR1_CRIAR_MAPA
	addi a1, a1, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR1_CRIAR_MAPA

EXIT_FOR1_CRIAR_MAPA: nop 

###### Escadas ########


#Escada grande da direita
la a0, escada1	# imagem do chao
li a1, 120	# posicao X
li a2, 0	# posicao Y
li a3, 1	# flag ( 0 - apaga, 1 - desenha )
jal ra, CRIAR_QUADRADO

li s6, 7 
FOR2_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR2_CRIAR_MAPA
	addi a2, a2, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR2_CRIAR_MAPA

EXIT_FOR2_CRIAR_MAPA: nop 


#Escada grande da esquerda
la a0, escada1	# imagem do chao
li a1, 100	# posicao X
li a2, 0	# posicao Y
jal ra, CRIAR_QUADRADO

li s6, 7
FOR3_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR3_CRIAR_MAPA
	addi a2, a2, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR3_CRIAR_MAPA

EXIT_FOR3_CRIAR_MAPA: nop


#Escada da plataforma
la a0, escada1	# imagem do chao
li a1, 167	# posicao X
li a2, 38	# posicao Y
jal ra, CRIAR_QUADRADO

li a1, 167
li a2, 50
jal ra, CRIAR_QUADRADO


##### chao #####

la a0, esteira	# imagem do chao
li a1, 25	# posicao X
li a2, 63	# posicao Y
jal ra, CRIAR_QUADRADO

li s6, 32
FOR5_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR5_CRIAR_MAPA
	addi a1, a1, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR5_CRIAR_MAPA

EXIT_FOR5_CRIAR_MAPA: nop


##################### Segunda linha #####################


########## Chao ###########

la a0, esteira	# imagem do chao
li a1, 0	# posicao X
li a2, 105	# posicao Y
jal ra, CRIAR_QUADRADO

li s6, 17
FOR6_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR6_CRIAR_MAPA
	addi a1, a1, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR6_CRIAR_MAPA

EXIT_FOR6_CRIAR_MAPA: nop


la a0, esteira	# imagem do chao
li a1, 183	# posicao X
li a2, 105	# posicao Y
jal ra, CRIAR_QUADRADO

li s6, 16
FOR7_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR7_CRIAR_MAPA
	addi a1, a1, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR7_CRIAR_MAPA

EXIT_FOR7_CRIAR_MAPA: nop


##### Escadas #####

#Escada da esquerda
la a0, escada1	# imagem do chao
li a1, 30	# posicao X
li a2, 94	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 83
jal ra, CRIAR_QUADRADO

li a2, 71
jal ra, CRIAR_QUADRADO


#Escada da direta 

la a0, escada1	# imagem do chao
li a1, 275	# posicao X
li a2, 94	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 83
jal ra, CRIAR_QUADRADO

li a2, 71
jal ra, CRIAR_QUADRADO


################### Terceira linha ####################

###### Escadas #######

# Escada da esquerda
la a0, escada1	# imagem do chao
li a1, 45		# posicao X
li a2, 138	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 126	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 114	# posicao Y
jal ra, CRIAR_QUADRADO

# Escada do meio (esquerda)
li a1, 125	 # posicao X
li a2, 138	 # posicao Y
jal ra, CRIAR_QUADRADO

li a2, 126	 # posicao Y
jal ra, CRIAR_QUADRADO

li a2, 114	 # posicao Y
jal ra, CRIAR_QUADRADO

# Escada do meio (direita)
li a1, 190
li a2, 138 	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 126 	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 114 	# posicao Y
jal ra, CRIAR_QUADRADO

# Escada da direita
li a1, 265	# posicao X
li a2, 138	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 126	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 114	# posicao Y
jal ra, CRIAR_QUADRADO


###### Chao #######

la a0, chao_3	# imagem do chao
li a1, 15	# posicao X
li a2, 150	# posicao Y
jal ra, CRIAR_QUADRADO

li s6, 7
FOR8_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR8_CRIAR_MAPA
	addi a1, a1, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR8_CRIAR_MAPA

EXIT_FOR8_CRIAR_MAPA: nop



la a0, chao_3	# imagem do chao
li a1, 110	# posicao X
li a2, 150	# posicao Y
jal ra, CRIAR_QUADRADO

li s6, 12
FOR9_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR9_CRIAR_MAPA
	addi a1, a1, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR9_CRIAR_MAPA

EXIT_FOR9_CRIAR_MAPA: nop




la a0, chao_3	# imagem do chao
li a1, 242	# posicao X
li a2, 150	# posicao Y
jal ra, CRIAR_QUADRADO

li s6, 7

FOR10_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR10_CRIAR_MAPA
	addi a1, a1, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR10_CRIAR_MAPA

EXIT_FOR10_CRIAR_MAPA: nop


##### X's #####

la a0, shis	# imagem do chao
li a1, 147	# posicao X
li a2, 140	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 132	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 124	# posicao Y
jal ra, CRIAR_QUADRADO


li a1, 155	# posicao X
li a2, 140	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 132	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 124	# posicao Y
jal ra, CRIAR_QUADRADO



li a1, 163	# posicao X
li a2, 140	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 132	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 124	# posicao Y
jal ra, CRIAR_QUADRADO



li a1, 171	# posicao X
li a2, 140	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 132	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 124	# posicao Y
jal ra, CRIAR_QUADRADO


################ Quarta linha #################

#### Chao ####

la a0, esteira	# imagem do chao
li a1, 25		# posicao X
li a2, 190	# posicao Y
jal ra, CRIAR_QUADRADO

li s6, 32
FOR11_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR11_CRIAR_MAPA
	addi a1, a1, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR11_CRIAR_MAPA

EXIT_FOR11_CRIAR_MAPA: nop

##### Escadas #####

# Escada da direita
la a0, escada1
li a1, 200	# posicao X
li a2, 158	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 170	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 178	# posicao Y
jal ra, CRIAR_QUADRADO

#Escada da esquerda

la a0, escada1
li a1, 115	# posicao X
li a2, 158	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 170	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 178	# posicao Y
jal ra, CRIAR_QUADRADO



################# Quinta linha ##################

#### Chao ####

la a0, chao_3	# imagem do chao
li a1, 0	# posicao X
li a2, 231	# posicao Y
jal ra, CRIAR_QUADRADO

li s6, 39
FOR12_CRIAR_MAPA: nop
	beq s6, zero, EXIT_FOR12_CRIAR_MAPA
	addi a1, a1, 8
	jal ra, CRIAR_QUADRADO
	addi s6, s6, -1
	jal zero, FOR12_CRIAR_MAPA

EXIT_FOR12_CRIAR_MAPA: nop


#### Escadas (da esquerda pra direita) ####

# Escada 1
la a0, escada1
li a1, 65	# posicao X
li a2, 198	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 210	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 218	# posicao Y
jal ra, CRIAR_QUADRADO


# Escada 2
li a1, 130	# posicao X
li a2, 198	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 210	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 218	# posicao Y
jal ra, CRIAR_QUADRADO


# Escada 3
li a1, 185	# posicao X
li a2, 198	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 210	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 218	# posicao Y
jal ra, CRIAR_QUADRADO


# Escada 4
li a1, 245	# posicao X
li a2, 198	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 210	# posicao Y
jal ra, CRIAR_QUADRADO

li a2, 218	# posicao Y
jal ra, CRIAR_QUADRADO

#########################################

li a7, 10
ecall


#################### void criar_quadrado(int imagem[], int x, int y, int flag)
## Cria o quadrado no display
# a0 -> vetor da imagem
# a1 -> posicao X
# a2 -> posicao Y
# a3 -> flag ( 0 - apaga, 1 - crie )
CRIAR_QUADRADO: nop
	### achando a posicao no display para desenhar ##
	li t0, 320
	mul t0, t0, a2		# 320 * y
	add t0, t0, a1		# 320 * y + x
	la t1, Frame_Desenhar	# endereço inicial
	
	#la t6, mapa
	#addi t6, t6, 8
	#add t6, t6, t0
	
	lw t1, 0(t1)
	add t0, t0, t1		# 320*y + x + end.Inicial
	

	## atribuicoes da imagem ##
	addi t1, a0, 8			# endereco inicial do quadrado
	lw t2, 4(a0)			# altura da imagem
	lw t3, 0(a0)			# contador largura

FOR1_CRIAR_QUADRADO: nop
	lb t4, 0(t1) 		# le byte da imagem do quadrado
	beq a3, zero, USAR_MAPA
	li t5, 0xffffffc7
	bne t4, t5, PINTA_NORMAL
	USAR_MAPA: nop
	li t4, 0
	PINTA_NORMAL: nop
	sb t4, 0(t0) 		# poe no display pedaco de 4 bytes da imagem
	addi t1, t1, 1 		# proximo byte da imagem
	addi t0, t0, 1 		# proximo byte do display
	#addi t6,t6, 1
	addi t3, t3, -1 	# contador largura --
	beq t3, zero, PULAR_LINHA_CRIAR_QUADRADO # if (contador == 0)

VOLTA_IF: nop
	bne t2,zero, FOR1_CRIAR_QUADRADO
	ret

PULAR_LINHA_CRIAR_QUADRADO: nop
	lw t3, 0(a0)		# reseta contador largura
	addi t4, zero, 320	# colunas em 1 linha

	sub t4, t4, t3 		# 320 - 60, correcao de posicao
	add t0, t0, t4 		# avanca para proxima linha
	#add t6, t6, t4
	addi t2, t2, -1		# contador altura --
	jal zero, VOLTA_IF
##############################
