.include "macros3.s"

.data
string:	.string "Ecall funcionando!\n"

.text
	#RotinaTratamento(exceptionHandling)
MAIN: li t0, 16
	li t1, 17
	csrrw  	zero, 1, t1
	csrrc	t0, 1, zero
	la t2, TESTEECALL
	csrrw zero, 5, t2
	
	la t2, SOMA
	jalr ra, t2, 0
	bne zero, zero, FIM
	ebreak
	ecall
	ebreak
	jal ra, SOMA
	j FIM
	
TESTEECALL: addi t0, t0, 2
	uret

FIM: addi t0, t0, 1
	j FIM

SOMA: addi t0, t0, 21
	ret




.include "SYSTEMv14.s"
