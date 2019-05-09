.eqv DISP_BEGIN 0xff000000
.eqv DISP_END 0xff012C00

.data
.include "../../Imagens/brasil.s"
.include "../../Imagens/botafogo.s"
.text
MAIN: 	la a0, brasil
		jal PRINTA
		jal CLR

		la a0, botafogo
		jal PRINTA
	 	
		j EXIT
		
#################### void PRINTA_INICIO(a0)
# a0 -> end. imagem	
# (!) usa DISP_BEGIN
PRINTA_INICIO: la a0, brasil
		lw a2, 0(a0)
		lw a3, 4(a0)
		addi a0, a0, 8
		
		li t0, 321
		bge a2, t0, PRINTA_INICIO_EXIT
		li t0, 241
		bge a3, t0, PRINTA_INICIO_EXIT
		
		li a1, DISP_BEGIN
		li t0, 0
		li t1, 0
		
PRINTA_INICIO_LOOP: bge t1, a3, PRINTA_INICIO_EXIT
		bge t0, a2, PRINTA_INICIO_CASE1
		lb t2, 0(a0)
		sb t2, 0(a1)
		
		addi t0, t0, 1
		
		addi a0, a0, 1
		addi a1, a1, 1
		j PRINTA_INICIO_LOOP

PRINTA_INICIO_CASE1: addi a1, a1, 320
		sub a1, a1, a2
		li t0, 0
		
		addi t1, t1, 1
		j PRINTA_INICIO_LOOP
		
PRINTA_INICIO_EXIT: ret
##############################

#################### void PRINTA(a0)
# a0 -> end. imagem
# (!) usa DISP_BEGIN
PRINTA: lw t1, 0(a0)			# carrega num colunas (X)
		lw t2, 4(a0) 			# carrrega num linhas (Y)
		mv a2, t1
		mv a3, t2
		
		slti t0, t1, 321		# t1 < 321 ? 1 : 0 -- 1 imagem menor q o display
		slti t0, t2, 241		# t2 < 241 ? 1 : 0
		beq t0, zero, PRINTA_EXIT		# caso falhe na checagem
		
		mul s1, t1, t2			# quanto pixels para printar (contador)
		
		li a1, DISP_BEGIN
		addi a0, a0, 8			# avan�a no vetor da imagem
		
		li t3, 320				# t4 margem vertical
		sub t3, t3, a2
		li t4, 2
		div t3, t3, t4
		add a1, a1, t3
		
		li t4, 240	
		sub t4, t4, a3			# t4 margem horizontal
		srai t4, t4, 1
		li t0, 320
		mul t4, t4, t0
		add a1, a1, t4
		
		li t0, 0
		mv t3, a2
		li t4, 0
		
PRINTA_LOOP: bge t0, s1, PRINTA_EXIT			# a0 end imagem / a1 pos inicial / t0 cont pixels / t3 cont col (X)/ t4 cont linha (Y) 
		beq t3, zero, PRINTA_CASE1				# t3 cont (ncol) >= a2 (ncol) ? PRINTA_CASE1
		lb t1, 0(a0)							# lendo do end. da imagem
		sb t1, 0(a1)							# gravando no BMP Display
		addi a0, a0, 1							# att end. imagem
		addi a1, a1, 1							# att end. bmp display
		
		addi t0, t0, 1							# contador pixels
		addi t3, t3, -1							# contador colunas
		j PRINTA_LOOP

PRINTA_CASE1: addi a1, a1, 320						# descendo uma linha
		sub a1, a1, a2	
		
		mv t3, a2
		j PRINTA_LOOP
		
PRINTA_EXIT: ret
##############################

#################### void CLR()
# Preenche de branco o display
# (!) utiliza DISP_BEGIN, DISP_END
CLR: li t0, DISP_BEGIN
		li t1, DISP_END
		li t2, 0
CLR_LOOP: blt t1, t0, CLR_EXIT
		sw t2, 0(t0)

		addi t0, t0, 4
		j CLR_LOOP
CLR_EXIT: ret
##############################


EXIT: 	li a7, 10	
		ecall
