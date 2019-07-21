.data

teste: .word 0

.text

.include "macros2.s"

RotinaTratamento(exceptionHandling)

## Testa se os Antigos M_Ecall funcionam ##
li a0, 20
li a1, 0
li a2, 0
li a3, 0xFF07
li a7, 101
ecall

## Endereco de Instrucao Desalinhado ##
PC_ATUAL: la t0, PC_ATUAL
addi t0, t0, 5	# desalinhando PC
jalr zero, t0, 0

## Endereco de Instrucao Invalido ##
#jalr zero, zero, 0

## Ilegal Instruction ##
#csrr t1, 200

## Acesso de Memória Invalida Segment fault ##
li a0, 0
#sw t0,0(a0)	# store Access Fault
#lw t0, 0(a0)	# load Access Fault

## Desalinhamento de Memoria ##
la a0, teste
sw t0, 1(a0)	# store misaligned
#lw t0, 1(a0)	# load misaligned

li a7, 10
ecall

.include "SYSTEMv14.s"
	
	
