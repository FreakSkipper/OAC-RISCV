.text
MAIN: #csrrwi zero, 65, 1
	#li t1, 21
	#csrrw	t0, 65, t1
	#csrrc 	t0, 65, zero
	la t2, TESTEECALL
	csrrw t0, 5, t2
	ecall
	
FIM: j FIM
	
TESTEECALL: addi t0, t0, 2
	j TESTEECALL
	#uret
