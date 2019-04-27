###############  EX.S  ################ (15 #(2 espacos)<arquivo>(2 espacos)15 #)
# settings:
# - tab = 4
# comentarios adicionais...


.data
# nomes: <TIPO>_<nome>_<...>
I_vetor: .word 9,2,5,1,8,2,4,3,6,7 			# tam = 10
S_hello: .string "CiC eh foda xD"
S_vetor_i: .string "Vetor inicial: "
S_vetor_f: .string "Vetor final: "
S_vetor_n: .string "Vetor limpo: "
S_comando1: .string "Insira um numero:"
S_comando2: .string "Somar de 0 ateh "
S_resposta: .string "Resultado: "
I_number: .word 0xF0CAF0FA
C_return: .byte '\n'


.text
# funcoes: tudo maiusculo
# <NOME>_<DERIVACAO>*_<FUNCIONALIDADE>*_<subgrupos>*_<etc>*
# (*) -> se houver necessidade!

# (!) Para facilitar a leitura:
# 	-usar "nop"(add zero, zero, zero) na frente do label.
#	 -> uma instrucao a mais :/
#	 -> mais facil de debuggar
#	 -> melhor visualizacao
# 	-comentar sempre que possivel (C like ou explicando msm)
# 	-usar esse arquivo como moddelo :D
MAIN: nop
	la a0, S_hello
	addi a7, zero, 4
	ecall	
	jal ra, RET				# funcao para printar \n
	
	la a0, S_vetor_i		# print string
	addi a7, zero, 4		# "RET pode ter alterado o valor de a7, e alterou :)"
	ecall
	la a0, I_vetor			# end. vetor
	addi a1, zero, 10		# tam. vetor
	jal ra, PRINT			# printar vetor
	
	addi a0, zero, '\n'		# printar \n (char/byte)
	addi a7, zero, 11		#
	ecall					#
	
	la a0, S_vetor_f		# print string
	addi a7, zero, 4 
	ecall
	la a0, I_vetor			# end. vetor
	addi a1, zero, 10		# tam. vetor
	jal ra, SORT			# ordena crescente
	jal ra, PRINT
	jal ra, RET
	
	la a0, S_vetor_n
	addi a7, zero, 4		# "n sei o que SORT, PRINT, RET faz"
	ecall
	la a0, I_vetor
	jal ra, CLEAR_RECURSIVE
	jal ra, PRINT
	jal ra, RET				
	
	la a0, S_comando2		# print string
	addi a7, zero, 4
	ecall
	
	addi a7, zero, 5		# Ler int
	ecall
	jal ra, SOMA			# resposta em a0
	add s0, zero, a0		# Estou na main, entao (teoricamente) nao ha a necessidade de usar a pilha
							# para poder guardar o valor anterior de s0.
	
	la a0, S_resposta		# print string
	addi a7, zero, 4
	ecall
	
	add	a0, zero, s0		# resposta em a0 novamente.
	addi a7, zero, 1		# Print int
	ecall
	
	jal zero, EXIT

####################  PRINT (20 # + 2 espaacos + <nome>)
## Printa vetor int 		(## + <breve descricao>)
# a0 -> end. vetor int		(# + argumentos)
# a1 -> tam. vetor
PRINT: nop		
	addi a7, zero, 1
	add s0, zero a0
	add t0, zero, zero
			
PRINT_LOOP: nop
	beq t0, a1, PRINT_EXIT		# t0 = i
	slli t2, t0, 2				# t2 anda t0 words
	add t2, t2, s0
	lw a0, (t2)					# a0 = v[i] (t2)
	ecall
			
	addi a0, zero, ' '
	addi a7, zero, 11
	ecall
		
	addi t0, t0, 1
	addi a7, zero, 1
	jal zero, PRINT_LOOP

PRINT_EXIT: nop
	add a0, zero, s0	
	jalr zero, ra, 0
############################## (30 #)

####################  RET
# printar \n
RET: nop
	la a0, C_return
	lw a0, 0(a0)
	addi a7, zero, 11
	ecall
	jalr zero, ra, 0
##############################

#################### SWAP
# ao -> end. vetor (word)
# a1 -> pos. de troca
SWAP:	slli t0, a1, 2		# a1 * 4
		add t0, a0, t0		# end. t0 = v[k]
		lw t1, (t0)			# t1 = v[k]
		addi t0, t0, 4		# v[k+1]
		lw t2, (t0)			# t2 v[k+1]
		addi t0, t0, -4
		sw t2, (t0)
		addi t0, t0, 4
		sw t1, (t0)
		jalr zero, ra, 0	# ret
##############################

#################### SORT
# a0 -> end. vetor (word)
# a1 -> tam. vetor
SORT: nop
# (!) Eh importante lembrar que cada funcao tem acesso aos mesmos registradores e a mesma pilha
# Ou seja, quando eu chamar SWAP, ele poderah fazer uso livre dos regs. temporarios.
# Por isso, eh bom armazenar nos regs. salvos (conforme a convensao) DADOS IMPORTANTES.
# Dessa forma, se a funcao quizer utilizar os regs. salvos, ela vai ter de guardar na pilha o valor ant.
	add s0, zero, zero			# contador i 
	addi sp, sp, -16			# ra e a1 serao utilizados na chamada de SWAP
	sw ra, 12(sp)				# por tanto, salvar ra.
	sw a1, 8(sp)				# salvar tamanho vetor.
	sw s1, 4(sp)
	sw s0, 0(sp)
	
SORT_LOOP: nop
	slt s1, s0, a1				# loop: (i < a1) ? 1 : 0 (s1)
	beq s1, zero, SORT_EXIT		# se s1 == 0 (i >= a1) => SORT_EXIT
	addi s1, s0, -1				# j = i - 1
	
SORT_LOOP_2: nop
	blt s1, zero, SORT_LOOP_FIM		# se t1 (j) < 0 sai
	slli t2, s1, 2				# carregando vetor..
	add t2, a0, t2				# end. v[j] em t2
	lw t3, 0(t2)				# v[j]
	lw t4, 4(t2)				# v[j+1]
	blt t3, t4, SORT_LOOP_FIM	# v[j] < v[j+1] ? fim : swap
	add a1, zero, s1			# a1 = s1 (j)
	jal ra, SWAP				# swap(v[j], v[j+1])
	
	lw a1, 8(sp)				# recuperar tam. vetor
	addi s1, s1, -1				# j--
	jal zero, SORT_LOOP_2		# volta na checagem do loop 2
	
SORT_LOOP_FIM: nop
	addi s0, s0, 1				# i++
	jal zero, SORT_LOOP			# volta para o loop
	
SORT_EXIT: nop
	lw ra, 12(sp)				# recupera da pilha
	lw a1, 8(sp)				#
	lw s1, 4(sp)				#
	lw s0, 0(sp)				#
	
	addi sp, sp, 8				#
	jalr zero, ra, 0			# ret
##############################

####################  CLEAR
## Limpa vetor (word)
# a0 -> endereco I_vetor
# a1 -> tamanho I_vetor
CLEAR: 	nop
	add t0, zero, zero
		
CLEAR_LOOP:	nop	
	beq t0, a1, CLEAR_EXIT		# t0 = contador
	slli t1, t0, 2				# t1 = t0 (i) * 4
	add t1, a0, t1				# achar pos. no vetor
	lw t2, (t1)					# t2 = v[i]
	add t2, zero, zero			# t2 = 0 (clear)
	sw t2, (t1)					# salvando..
		
	addi t0, t0, 1
	jal zero, CLEAR_LOOP		# volta para o loop
		
CLEAR_EXIT: nop
	jalr, zero, ra, 0			# saida
##############################

####################  CLEAR_RECURSIVE
## Limpa vetor (word)
# a0 -> endereço I_vetor
# a1 -> tamanho I_vetor
CLEAR_RECURSIVE: nop
	add t0, zero, a0			# v[0]
	slli t1, a1, 2
	add	t1, t0, t1				# v[k]
	
CLEAR_RECURSIVE_LOOP: nop
	sw zero, 0(t0)				# como o valor que eu vou salvar eh const
	addi t0, t0, 4			    # nao preciso carregar da mem. o valor ant.
	bltu t0, t1, CLEAR_RECURSIVE_LOOP	# teste de parada: if(end. atual < end. final)
	jalr zero, ra, 0
##############################

####################  SOMA
## Faz a soma ateh o valor de a0
# a0 -> numero int
SOMA: nop
	beq a0, zero, SOMA_STOP 	# n = 0 -> para
	addi sp, sp, -8				# salvando a0 (n) na pilha..
	sw ra, 4(sp)				# empilhando ra	
	sw a0, 0(sp)				# empilhando n
	addi a0, a0, -1				# a0 (n) - 1
	jal ra, SOMA				# chamada recursiva
	lw ra, 4(sp)				# carrega ra
	lw t0, 0(sp)				# carrega n da pilha
	add a0, a0, t0				# faz n + (n-1)
	addi sp, sp, 8				# att a pilha
	jalr zero, ra, 0			# ret
	
SOMA_STOP: nop
	add a0, zero, zero
	jalr zero, ra, 0
##############################


EXIT:	nop
	addi a7, zero, 10
	ecall
	
# P.S.: Evitei o uso de pseudo-instrucoes soh para praticar msm.
