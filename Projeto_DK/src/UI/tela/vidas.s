.data 
.include "..\..\..\images\Coracao_10_8.s"
.include "..\..\..\images\Coracao_branco.s"

.text

DESENHAR_VIDAS: nop
	mv s10, ra
	
	li a1, 300
	li a2, 0
	li a3, 1
	li a4, 1
	
	li a5, 5
	la t0, DESENHAR_QUADRADO
	la a0, Coracao_branco
	
	la s5, CRIAR_QUADRADO
	jalr ra, t0, 0
	
	li a2, 0
	la t0, Vidas
	lb a5, 0(t0)

	la t0, DESENHAR_QUADRADO
	la a0, Coracao_10_8
	
	la s5, CRIAR_QUADRADO
	jalr ra, t0, 0
	
	mv ra, s10	
	ret