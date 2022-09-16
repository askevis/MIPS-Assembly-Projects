.data

.globl	message
.globl	cflag
.globl	cdata

message: 		.asciiz	"\nEnter character: \n"
cflag: 			.byte 0
cdata:			.byte 0

.text

main:
	mfc0 $t0, $12
	li $t1, 0x801
	and $t0, $t0, $t1
	addi $t0, $t0, 1
	mtc0 $t0, $12

	li $t0, 0xffff0000
	lw $t1, 0($t0)
	ori $t2, $t1, 0x2
	sw $t2, 0($t0)
	
	la $s0, cflag
	la $s1, cdata
	
	main_loop:
	
	sb $zero, 0($s0)
	
	li $v0, 4
	la $a0, message
	syscall
	
	loop_waiting:
		lb $t1, 0($s0)
	beq $t1, $zero, loop_waiting
	
	li $v0, 4
	la $a0, cdata
	syscall
	
	sb $zero, 0($s0)
	
	j main_loop
	
	li $v0, 10
	syscall
