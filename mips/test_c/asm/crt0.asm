.extern mips_main
.global start

start:
    nop
main:
    addi $sp, $zero, 0xff
    nop
    jal mips_main
    add $v1, $zero, $v0
    nop
    j end
    
end:
    nop
    j end
    nop
