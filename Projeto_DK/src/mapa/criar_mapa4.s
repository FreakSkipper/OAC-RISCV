.data
.include "..\..\images\chao_azul.s"
.include "..\..\images\chao_azul_duplo.s"
.include "..\..\images\cano_corpo.s"
.include "..\..\images\cano.s"
.include "..\..\images\cano_grande.s"
.text

CRIAR_MAPA4: nop

la s3, DESENHAR_QUADRADO
mv s4, ra
la s5, CRIAR_QUADRADO

## COPIAR VARIOS DESSES PARA CRIAR MAPA ##

####### Plataforma ############

la a0, cano_grande
li a1, 257	# posicao X
li a2, 80	# posicao Y
li a3, 1	# flag ( 0 - apaga, 1 - desenha )
li a4, 0
jalr ra, s5, 0

la a0, cano_corpo
li a1, 293	# posicao X
li a2, 0	# posicao Y

jalr ra, s5, 0

######### CHAO ############
la a0, chao_azul# imagem do chao
li a1, 0	# posicao X
li a2, 0	# posicao Y
jalr ra, s5, 0
#### PAREDE ESQUERDA
li a4, 1
li a5, 14
jalr ra, s3, 0
li a4, 0
######### CHAO DUPLO ############
la a0, chao_azul_duplo# imagem do chao
li a1, 16	# posicao X
li a2, 50	# posicao Y

jalr ra, s5, 0
#### CHAO CIMA
li a5, 12
jalr ra, s3, 0
	
li a1, 64	# posicao X
li a2, 130	# posicao Y

jalr ra, s5, 0
#### CHAO MEIO
li a5, 13
jalr ra, s3, 0

li a1, 16	# posicao X
li a2, 209	# posicao Y

jalr ra, s5, 0
#### CHAO BAIXO
li a5, 18
jalr ra, s3, 0

la a0, cano
li a1, 80	# posicao X
li a2, 115	# posicao Y
jalr ra, s5, 0

li s6, 2
FOR5_CRIAR_MAPA4: nop
	beq s6, zero, EXIT_FOR5_CRIAR_MAPA4
	addi a1, a1, 80		# posicao Y
	jalr ra, s5, 0
	addi s6, s6, -1
	jal zero, FOR5_CRIAR_MAPA4
	EXIT_FOR5_CRIAR_MAPA4: nop
	
li a1, 80	# posicao X
li a2, 194	# posicao Y
jalr ra, s5, 0

addi a1, a1, 80		# posicao Y
jalr ra, s5, 0


mv ra, s4
ret
