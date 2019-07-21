.data	
	CredProgramador: .string "Programacao Geral Assembly"
	ProgramadorGeral: .string "Alexandre Souza"
	
	CredProgramador2: .string "Programacao Keyboard Teclado e ADC"
	ProgramadorKeyboard: .string "Eduardo Assis"
	
	CredDesign: .string "Design Visual / Sprites"
	Designer: .string "Eduardo Assis"
	
	CredProcessador: .string "Desenvolvedores de Excecao"
	Processador: .string "Eduardo Assis e Thiaggo Ferreira"
	
	CredMusic: .string "Musicas e Efeitos Sonoros"
	Musico: .string "Isabelle Alex"
	
	CredMap: .string "Criacao de Mapas"
	Mapper: .string "Emanoel Johannes"
	
	CredLogistica: .string "Apoio na Logistica do Jogo"
	Apoio: .string "Alexandre, Eduardo e Thiaggo"
	
	CredEspecial: .string "Testadores e Apoiadores de Ideias"
	Especiais: "Isabele, Oscar e Alexandre K."
	
	CredExtras: .string "Creditos Extras"
	Extras: "www.google.com"
	
	CredDesenvolvimento: .string "Desenvolvedor"
	Desenvolvedor: .string "Alexandre Souza"
	
	CredPlaying: .string "THANKS FOR PLAYING!"
	Playing: .string "That's all, folks!"
	CredGameOver: .string "GAME OVER"
	
	CredEtapas: .half 0

.text

SINC_CREDITOS: nop
	mv s10, ra

	la t0, APAGAR_MAPA
	jalr ra, t0,0

	la t0, MUSICA_MARIO
	jalr ra, t0, 0
	
	la t0, CredEtapas
	li t1, 120
	sh t1, 0(t0)
	
	li a7, 130
	ecall
	
	mv s1, a0
	li s2, 0
	mv s3, a0
	FOR1_SINC_CREDITOS: nop
		li t1, 83
		beq s2, t1, EXIT_FOR1_SINC_CREDITOS
		
		la t0, CREDITOS
		jalr ra, t0, 0
		
		li a7, 130
		ecall
		blt a0, s1, FOR1_SINC_CREDITOS
		
		mv a0, s2
		la t0, TOCAR_MUSICA
		jalr ra, t0, 0
		mv t1, a0
		
		li a7, 130
		ecall
		add s1, a0, t1
		
		addi s2, s2, 1
		jal zero, FOR1_SINC_CREDITOS
	EXIT_FOR1_SINC_CREDITOS: nop
	
	li s2, 0
	jal zero, FOR1_SINC_CREDITOS
	
	mv ra, s10
	
	ret

CREDITOS: nop
	mv s11, ra
	
	li a7, 130
	ecall
	
	blt a0, s3, PULA_TUDO_CRED
	
	addi s3, a0, 500
	
	la t0, APAGAR_MAPA_FRAME
	jalr ra, t0,0
	
	li t0, 0xFF200604
	lw a4, 0(t0)
	xori a4, a4, 1
	
	la t0, CredEtapas
	lh t1, 0(t0)
	addi t1, t1, -10
	sh t1, 0(t0)
	
	INICIAR_CREDITOS: nop
	
	li t2, 0
	blt t1, t2, PULA_CRED_PROGRAMADOR
	#CredProgramador: .string "Programacao Geral Assembly"
	#ProgramadorGeral: .string "Alexandre Souza"
	la a0, CredProgramador
	li a1, 50
	mv a2, t1
	li a3, 0x003F
	li a7, 104
	ecall
	
	la a0, ProgramadorGeral
	li a1, 90
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	PULA_CRED_PROGRAMADOR: nop
	
	li t2, -40
	blt t1, t2, PULA_CRED_PROGRAMADOR2
	#CredProgramador2: .string "Programacao Keyboard Teclado e ADC"
	#ProgramadorKeyboard: .string "Eduardo de Assis"
	mv a2, t1
	la a0, CredProgramador2
	li a1, 20
	addi a2, a2, 40
	li a3, 0x0038
	li a7, 104
	ecall
	
	la a0, ProgramadorKeyboard
	li a1, 90
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	PULA_CRED_PROGRAMADOR2: nop
	
	li t2, -80
	blt t1, t2, PULA_CRED_DESIGN
	#CredDesign: .string "Design Visual / Sprites"
	#Designer: .string "Eduardo de Assis"
	mv a2, t1
	la a0, CredDesign
	li a1, 60
	addi a2, a2, 80
	li a3, 0x0038
	li a7, 104
	ecall
	
	la a0, Designer
	li a1, 90
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	PULA_CRED_DESIGN: nop
	
	li t2, -110
	blt t1, t2, PULA_CRED_PROCESSADOR
	#CredProcessador: .string "Desenvolvedores Exception Processador RISC-V"
	#Processador: .string "Eduardo de Assis e Thiago Ferreira"
	mv a2, t1
	la a0, CredProcessador
	li a1, 50
	addi a2, a2, 110
	li a3, 0x0038
	li a7, 104
	ecall
	
	la a0, Processador
	li a1, 30
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	PULA_CRED_PROCESSADOR: nop
	
	li t2, -140
	blt t1, t2, PULA_CRED_MUSIC
	addi t3, t1, 140
	li t2, 210
	bgt t3, t2, PULA_CRED_MUSIC
	#CredMusic: .string "Creditos Especiais pelas Musicas e Efeitos Sonoros"
	#Musico: .string "Isabele Alex"
	mv a2, t1
	la a0, CredMusic
	li a1, 50
	addi a2, a2, 140
	li a3, 0x00C6
	li a7, 104
	ecall
	
	la a0, Musico
	li a1, 100
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	PULA_CRED_MUSIC: nop
	
	
	li t2, -170
	blt t1, t2, PULA_CRED_MAPPER
	addi t3, t1, 170
	li t2, 210
	bgt t3, t2, PULA_CRED_MAPPER
	
	#CredMap: .string "Criacao de Mapas"
	#Mapper: .string "Emanoel Johannes"
	mv a2, t1
	la a0, CredMap
	li a1, 90
	addi a2, a2, 170
	li a3, 0x0007
	li a7, 104
	ecall
	
	la a0, Mapper
	li a1, 90
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	PULA_CRED_MAPPER: nop
	
	li t2, -200
	blt t1, t2, PULA_CRED_LOGISTICA
	addi t3, t1, 200
	li t2, 210
	bgt t3, t2, PULA_CRED_LOGISTICA
	#CredLogistica: .string "Apoio na Logistica do Jogo"
	#Apoio: .string "Alexandre, Eduardo e Thiago"
	mv a2, t1
	la a0, CredLogistica
	li a1, 50
	addi a2, a2, 200
	li a3, 0x003F
	li a7, 104
	ecall
	
	la a0, Apoio
	li a1, 50
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	PULA_CRED_LOGISTICA: nop
	
	
	li t2, -230
	blt t1, t2, PULA_CRED_ESPECIAL
	addi t3, t1, 230
	li t2, 210
	bgt t3, t2, PULA_CRED_ESPECIAL
	#CredEspecial: .string "Creditos Especiais a Testadores e Apoiadores de Ideias"
	#Especiais: "Isabele, Oscar, Alexandre K. e Guilherme"
	mv a2, t1
	la a0, CredEspecial
	li a1, 20
	addi a2, a2, 230
	li a3, 0x00C6
	li a7, 104
	ecall
	
	la a0, Especiais
	li a1, 30
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	PULA_CRED_ESPECIAL: nop
	
	li t2, -260
	blt t1, t2, PULA_CRED_EXTRAS
	addi t3, t1, 260
	li t2, 210
	bgt t3, t2, PULA_CRED_EXTRAS
	
	#CredExtras: .string "Creditos Extras"
	#Extras: "www.google.com"
	mv a2, t1
	la a0, CredExtras
	li a1, 90
	addi a2, a2, 260
	li a3, 0x0007
	li a7, 104
	ecall
	
	la a0, Extras
	li a1, 90
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	PULA_CRED_EXTRAS: nop
	
	li t2, -290
	blt t1, t2, PULA_CRED_DESENVOLVIMENTO
	addi t3, t1, 290
	li t2, 210
	bgt t3, t2, PULA_CRED_DESENVOLVIMENTO
	
	#CredDesenvolvimento: .string "Desenvolvedor"
	#Desenvolvedor: .string "Alexandre Souza"
	mv a2, t1
	la a0, CredDesenvolvimento
	li a1, 100
	addi a2, a2, 290
	li a3, 0x003F
	li a7, 104
	ecall
	
	la a0, Desenvolvedor
	li a1, 90
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	PULA_CRED_DESENVOLVIMENTO: nop
	
	addi t3, t1, 520
	li t2, 210
	bgt t3, t2, PULA_CRED_PLAYING
	
	mv a2, t1
	la a0, CredPlaying
	li a1, 80
	li a2, 80
	li a3, 0x003F
	li a7, 104
	ecall
	
	la a0, Playing
	li a1, 90
	addi a2, a2, 10
	li a3, 0x00FF
	li a7, 104
	ecall
	
	la a0, CredGameOver
	li a1, 120
	addi a2,a2, 20
	li a3, 0x0007
	li a7, 104
	ecall
	
	PULA_CRED_PLAYING: nop
	
	li t0, 0xFF200604
	lw a4, 0(t0)
	xori a4, a4, 1
	sw a4, 0(t0)
	
	PULA_TUDO_CRED: nop
	
	mv ra, s11	
	ret