.text

start:
    addi $t0, $zero, 0
    addi $t1, $zero, 0
    nop
    beq $t0, $t1, b

a:
    addi $t2, $zero, 0x10
    nop
    j end

b:
    addi $t2, $zero, 0x20

end:
    nop
    j end
    nop
