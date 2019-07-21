.data
.include "..\..\images\piramide.s"
.include "..\..\images\chao_duplo_final.s"
.include "..\..\images\bandeira.s"
.include "..\..\images\cano_bandeira.s"
.include "..\..\images\pino_bandeira.s"
.include "..\..\images\castelinho.s"
.include "..\..\images\nuvem.s"

.text

CRIAR_MAPA5: nop

la s3, DESENHAR_QUADRADO
mv s4, ra
la s5, CRIAR_QUADRADO

## COPIAR VARIOS DESSES PARA CRIAR MAPA ##

####### Plataforma ############

######### CHAO PRINCESA ############
la a0, chao_duplo_final	# imagem do chao
li a1, 0	# posicao X
li a2, 210	# posicao Y
li a3, 1	# flag ( 0 - apaga, 1 - desenha )
li a4, 0
jalr ra, s5, 0

li a5, 20
jalr ra, s3, 0

la a0, cano	# imagem do chao
li a1, 5	# posicao X
li a2, 193	# posicao Y
jalr ra, s5, 0

la a0, piramide	# imagem do chao
li a1, 37	# posicao X
li a2, 197	# posicao Y
#jalr ra, s5, 0

li a5, 7
jalr ra, s3, 0
	
li a1, 50	# posicao X
li a2, 184	# posicao Y

li a5, 6
jalr ra, s3, 0
	
li a1, 63	# posicao X
li a2, 171	# posicao Y

li a5, 5
jalr ra, s3, 0
	
li a1, 76	# posicao X
li a2, 158	# posicao Y

li a5, 4
jalr ra, s3, 0
	
li a1, 89	# posicao X
li a2, 145	# posicao Y

li a5, 3
jalr ra, s3, 0

li a1, 102	# posicao X
li a2, 132	# posicao Y
li a5, 2
jalr ra, s3, 0

li a1, 128	# posicao X
li a2, 119	# posicao Y
jalr ra, s5, 0

li a1, 180	# posicao X
li a2, 197	# posicao Y
jalr ra, s5, 0

la a0, cano_bandeira	# imagem do chao
li a1, 185	# posicao X
li a2, 152	# posicao Y
jalr ra, s5, 0

li a1, 185	# posicao X
li a2, 107	# posicao Y
jalr ra, s5, 0

li a1, 185	# posicao X
li a2, 87	# posicao Y
jalr ra, s5, 0

la a0, bandeira	# imagem do chao
li a1, 165	# posicao X
li a2, 87	# posicao Y
jalr ra, s5, 0

la a0, pino_bandeira	# imagem do chao
li a1, 181	# posicao X
li a2, 77	# posicao Y
jalr ra, s5, 0

la a0, castelinho	# imagem do chao
li a1, 225	# posicao X
li a2, 120	# posicao Y
jalr ra, s5, 0

la a0, nuvem	# imagem do chao
li a1, 225	# posicao X
li a2, 50	# posicao Y
jalr ra, s5, 0

li a1, 150	# posicao X
li a2, 30	# posicao Y
jalr ra, s5, 0

li a1, 90	# posicao X
li a2, 60	# posicao Y
jalr ra, s5, 0

li a1, 20	# posicao X
li a2, 15	# posicao Y
jalr ra, s5, 0

mv ra, s4
ret
