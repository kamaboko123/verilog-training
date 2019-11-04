.extern mips_main
.global start

start:
    nop
main:
    addi $sp, $zero, 0xff
    nop
    j mips_main
    
