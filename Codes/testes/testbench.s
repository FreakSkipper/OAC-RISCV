.data
	ECALLs: .string "INICIANDO TESTES..."
	CSRRC: .string "Valor a0 por CSRRC:"
	CSRRCI: .string "Valor a0 por CSRRCI:"
	CSRRS: .string "Valor a0 por CSRRS:"
	CSRRSI: .string "Valor a0 por CSRRSI:"
	CSRRW: .string "Valor a0 por CSRRW:"
	CSRRWI: .string "Valor a0 por CSRRWI:"
	EBREAK: .string "EBREAK FUNCIONANDO!"
	ECALLURET: .string "TODOS ECALL E URET COMPLETADOS. SUCESSO!"
.text

.include "macros3.s"

RotinaTratamento(exceptionHandling)

MAIN: nop
	
	### LIMPANDO TELA ###
	li t0, 0xFF000000	# inicio frame 0
	li t1, 76800
	add t1, t1, t0		# final frame 0
	li t2, 0			# preto
	FOR1_MAIN: nop
		beq t0, t1, EXIT_FOR1_MAIN
		
		sw t2, 0(t0)
		addi t0, t0, 4
		
		jal zero, FOR1_MAIN
	EXIT_FOR1_MAIN: nop
	####################
	
	## PARAMETROS GERAIS ##
	li a3, 0x0038
	li a4, 0
	#######################
	
	### INICIANDO TESTES ###
	la a0, ECALLs
	li a1, 0
	li a2, 0
	li a7, 104
	ecall	# testando ecall
	########################
	
	### TESTE CSRRC ###
	la a0, CSRRC
	li a1, 0
	addi a2, a2, 12
	li a7, 104
	ecall
	
	li t1, 0
	csrrc a0, 5, t1
	
	li a1, 160
	li a7, 134
	ecall
	##################
	
	### TESTE CSRRCI ###
	la a0, CSRRCI
	li a1, 0
	addi a2, a2, 12
	li a7, 104
	ecall
	
	csrrci a0, 5, 0
	
	li a1, 160
	li a7, 134
	ecall
	##################
	
	### TESTE CSRRS ###
	la a0, CSRRS
	li a1, 0
	addi a2, a2, 12
	li a7, 104
	ecall
	
	li t1, 0
	csrrs a0, 5, t1
	
	li a1, 160
	li a7, 134
	ecall
	##################
	
	### TESTE CSRRSI ###
	la a0, CSRRSI
	li a1, 0
	addi a2, a2, 12
	li a7, 104
	ecall
	
	csrrsi a0, 5, 0
	
	li a1, 160
	li a7, 134
	ecall
	##################
	
	### TESTE CSRRW ###
	la a0, CSRRW
	li a1, 0
	addi a2, a2, 12
	li a7, 104
	ecall
	
	la t1, exceptionHandling
	csrrw a0, 5, t1
	
	li a1, 160
	li a7, 134
	ecall
	##################
	
	
	### TESTE CSRRWI ###
	la a0, CSRRWI
	li a1, 0
	addi a2, a2, 12
	li a7, 104
	ecall
	
	csrrwi a0, 2, 0x005
	
	li a1, 160
	li a7, 134
	ecall
	##################
	
	### TESTE EBREAK ###	
	ebreak
	
	la a0, EBREAK
	li a1, 0
	addi a2, a2, 12
	li a7, 104
	ecall
	##################
	
	### ECALL COMPLETE ###
	la a0, ECALLURET
	li a1, 0
	addi a2, a2, 12
	li a7, 104
	ecall
	
	li a7, 10
	ecall

.include "SYSTEMv14.s"
	
	
