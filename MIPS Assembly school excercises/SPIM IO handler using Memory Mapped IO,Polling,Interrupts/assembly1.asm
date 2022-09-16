.data

	.globl enterstring
	
	enterstring:	.asciiz "Please enter string:"
	enteredstring:	.asciiz "\nYour string:"
	reversedstring:	.asciiz "Reversed string:"
	readedstring:	.align 0
					.space 100
	
.text
.globl main
main:
	li $s0, 0xffff0000
	li $s1, 0xffff0004
	li $s2, 0xffff0008
	li $s3, 0xffff000c
	
	li $v0, 4
	la $a0, enterstring
	syscall
	
	jal read_string
	
	li $v0, 4
	la $a0, enteredstring
	syscall
	
	jal write_string
	jal reverse
	
	li $v0, 4
	la $a0, reversedstring
	syscall
	
	jal write_string
	
	li $v0 10
	syscall
	
write_ch:
	waiting_for_readywrite:
		lw $t4, 0($s2)
		and $t4, $t4, 1
		beq $t4, $zero, waiting_for_readywrite
	
	sw $a0, 0($s3)
	jr $ra

read_ch:
	waiting_for_readyread:
		lw $t4, 0($s0)
		and $t4, $t4, 1
		beq $t4, $zero, waiting_for_readyread
		
	lw $v0, 0($s1)
	
jr $ra

read_string:
	addi $sp, $sp, -12
	la $t0, readedstring
	li $t2, 10
	
	reading_string:
		sw $ra, 0($sp)
		jal read_ch
		lw $ra, 0($sp)
		move $t1, $v0
		
		sb $t1, 0($t0)
		addi $t0, $t0, 1
		bne $t1, $t2, reading_string
	addi $sp, $sp, 12
jr $ra

write_string:
	addi $sp, $sp, -12
	la $t0, readedstring
	li $t2, 10
	
	writing_string:
		lb $t1, 0($t0)
		sw $ra, 0($sp)
		move $a0, $t1
		jal write_ch
		lw $ra, 0($sp)
		addi $t0, $t0, 1
		bne $t1, $t2, writing_string
	addi $sp, $sp, -12
jr $ra

reverse:
	la $t6, readedstring
	li $t7, 0
	while_loop:
		bge $t7, 100, end_while
			lb $t9, 0($t6)
			beq $t9, 10, end_while
				ble $t9, 64, if_outofborder
					bge $t9, 123, if_outofborder
						bge $t9, 97, peza
							bge $t9, 91, if_outofborder
								addi $t1, $t9, 32
								sb $t1,0($t6)
								addi $t6, $t6, 1
								addi $t7, $t7, 1
								j while_loop
						peza:
							bge $t9, 123, if_outofborder
								addi $t1, $t9, -32
								sb $t1,0($t6)
								addi $t6, $t6, 1
								addi $t7, $t7, 1
								j while_loop
							
		if_outofborder:
			sb $t9,0($t6)
			addi $t6, $t6, 1
			addi $t7, $t7, 1
			j while_loop
	end_while:
jr $ra