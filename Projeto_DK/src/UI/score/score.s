.data
	StringScore: .string "SCORE"
	Pontuacao: .half 0
	StringHighScore: .string "HIGH"
	HighPontuacao: .half 0
	Bonus: .half 5000
	TempoBonus: .word 0
	StringBonus: .string "Bonus"
.text


SCORE: nop
	li t0, 0xFF200604
	lw a4, 0(t0)
	
	la a0, StringScore
	li a1, 200
	li a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	la a0, Pontuacao
	lhu a0, 0(a0)
	li a1, 200
	li a2, 20
	li a3, 0x0007
	li a7, 101
	ecall
	
	la t0, HighPontuacao
	lhu t1, 0(t0)
	
	la t2, Pontuacao
	lhu t2, 0(t2)
	
	blt t2, t1, ESCREVER_HIGHSCORE
	
	sh t2, 0(t0)
	
	ESCREVER_HIGHSCORE: nop
	
	la a0, StringHighScore
	li a1, 30
	li a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	la a0, HighPontuacao
	lhu a0, 0(a0)
	li a1, 30
	li a2, 20
	li a3, 0x003F
	li a7, 101
	ecall
	
	li a7, 130
	ecall
	
	la t1, TempoBonus
	lw t2, 0(t1)
	
	blt a0, t2, NAO_DIMINUI_BONUS
	
	li t2, 5000
	add a0, a0, t2
	sw a0, 0(t1)
	
	la t0, Bonus
	lhu t1, 0(t0)
	addi t1, t1, -100
	sh t1, 0(t0)
	
	bne t1, zero, NAO_DIMINUI_BONUS
	
	la t0, Morto
	li t1, 1
	sb t1, 0(t0)
	
	NAO_DIMINUI_BONUS: nop
	
	la a0, StringBonus
	li a1, 250
	li a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	la a0, Bonus
	lhu a0, 0(a0)
	li a1, 250
	li a2, 20
	li a3, 0x003F
	li a7, 101
	ecall
	
	ret
