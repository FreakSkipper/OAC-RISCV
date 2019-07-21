.data
D_DADO1: 	.word 	16
D_DADO2: 	.float	2.0
SPACE:		.space  4
.text	
MAIN: la t0, D_DADO1
	la t2, SPACE
	lw t1, 0(t0)
	sw t1, 0(t2)
	
	la t0, D_DADO2
	flw ft0, 0(t0)
	fsw ft0, 0(t2)
	fmv.s ft1, ft0
	
FIM: j FIM