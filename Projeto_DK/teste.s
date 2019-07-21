.data

.include "images\kong_left.s"
.include "images\mapa.s"

	Frame_Desenhar: .word 0xFF000000

.text

la a0, kong_left
li a1, 0
li a2, 0
li a3, 1
li a4, 0
jal ra, CRIAR_QUADRADO

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
		
		PULO_CONDICIONAL: nop
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