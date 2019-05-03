.data
MSG: .string "mdc= "

.text
MAIN: addi x10, zero, 289
	addi a1, zero, 102
	jal MDC
	
	add t0, zero, a0
	addi a7, zero, 4
	la a0, MSG
	ecall
	
	addi a7, zero, 1
	add a0, zero, t0
	ecall
	
	addi a7, zero, 11
	addi a0, zero, '\n'
	ecall
	
	addi a7, zero, 10
	ecall
	
MDC: beq a0, a1, MDC_EXIT
	slt t0, a1, a0
	beq t0, zero, MDC_CASE1
	
	sub a0, a0, a1
	jal zero, MDC
	 
MDC_CASE1: sub a1, a1, a0
	jal zero, MDC
	
MDC_EXIT: jalr zero, ra, 0 