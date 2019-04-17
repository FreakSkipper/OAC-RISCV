.eqv BTMPi 0xFF000000
.eqv BTMPf 0xFF012C00

.data
.include "..\..\images\telateste.s"

.text
MAIN: nop
    li a7, 101
    la a0, teste
    jal ra, PRINTA_SPRITE_WORD

    j EXIT
####################  PRINTA_SPRITE
## Precisa do BTMPi e do BTMPf;
# a0 -> end.
PRINTA_SPRITE_WORD: nop
    addi sp, sp, -12
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)

    mv s0, a0
    lb s1, 0(s0)        # Carregar ncol (X)
    lb s2, 4(s0)        # Carregar nlin (Y)
    addi s0, s0, 8      # Pular nlin e ncol
        
    li t0, BTMPi
    li t1, BTMPf
    mul t2, t0, t1      # Quantos pixels o bitmap tem
    mul t3, s1, s2      # Quantos pixels o sprite tem
    slt t4, t3, t2      # t3 < t2 ? 1 : 0
    beq t4, zero, PRINTA_SPRITE_WORD_EXIT

PRINTA_SPRITE_WORD_LOOP: nop
    bge t0, t1, PRINTA_SPRITE_WORD_EXIT
    lw t2, 0(s0)            # Ler uma word do vetor do arquivo
    sw t2, 0(t0)            # Grava uma word na mem VGA
    addi s0, s0, 4
    addi t0, t0, 4
    j PRINTA_SPRITE_WORD_LOOP

PRINTA_SPRITE_WORD_EXIT: nop
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    addi sp, sp, 12
    ret
##############################
EXIT: nop  
    li a7, 10
    ecall
    
