.data

	.globl W
	.globl H
	.globl startX
	.globl TotalElements
	.globl temp
	.globl map
	.globl indextmp
	.globl rastore
	.globl returns
	.globl labyrinthmessage
	.globl newline
	
	W:					.word 21
	H:					.word 11
	startX:				.word 1
	TotalElements:		.word 231
	map:				.asciiz	"I.IIIIIIIIIIIIIIIIIIII....I....I.......I.IIII.IIIII.I.I.III.I.II.I.....I..I..I.....II.I.III.II...II.I.IIII...I...III.I...I...IIIIII.IIIII.III.III.II.............I.I...IIIIIIIIIIIIIIII.I.III@...............I..IIIIIIIIIIIIIIIIIIIIIII"
	temp:				.align 0
						.space 100;
	indextmp:			.align 4
						.space 232
	rastore:			.align 4
						.space 232
	returns:			.align 4
						.space 232
	labyrinthmessage:	.asciiz "Labyrinth:\n"
	newline:			.asciiz "\n";
	
.text
.globl main
main:
	lw $s0, W
	lw $s1, H
	lw $s3, startX
	lw $s4, TotalElements
	li $s7, 1
	jal printLabyrinth
	lw $a0, startX
	jal makeMove
	jal printLabyrinth
	
	li $v0, 10
	syscall
	
printLabyrinth:
	
	#usleep start
	add $t6, $zero, $zero
	li $t4, 200000
	before_usleep:
	bge $t6, $t4, after_usleep
		addi $t6, $t6, 1
		j before_usleep
	after_usleep:
	#usleep end
	
	li $t8, 0
	la $t4, map																			#clang antistoixia sto t5
	la $t6, temp																		#clang antistoixia sto t8
	
	li	$v0,	4
	la	$a0,	labyrinthmessage
	syscall
	li $t9, 0																			#bhma 1hs loop 
	before_first_loop:
		bge $t9, $s1, print_end
		li $t5, 0																		#bhma 2hs loop
		la $t6, temp
		before_s_loop:
			bge $t5, $s0, after_s_loop
			lb $t7, 0($t4)
			sb $t7, 0($t6)
			addi $t4, $t4, 1
			addi $t6, $t6, 1
			addi $t8, $t8, 1
			addi $t5, $t5, 1
		j before_s_loop
		after_s_loop:
			addi $t6, $t6, 1
			li $t7, 4
			sb $t7, 0($t6)
			
			li	$v0, 4
			la	$a0, temp
			syscall
			
			li	$v0, 4
			la	$a0, newline
			syscall
			
			addi $t9, $t9, 1
		j before_first_loop
	print_end:
		jr $ra
		
makeMove:
	addi $sp, $sp, -12																	#occupy 3 places in stack and store index, fouded item, and return address
	sw $t1, 0($sp)
	sw $s5, 4($sp)
	sw $ra, 8($sp)
	
	move $t1, $a0
	
	bge $t1, $zero, case_dot
		li $v0, 0
		lw $ra, 8($sp)
		jr $ra
		bge $s4, $t1, case_dot
			li $v0, 0
			lw $ra, 8($sp)
			jr $ra
			
	case_dot:
		add $t2, $zero, $zero
		la $s5, map
		finding_index_beforeif:
		bge $t2, $t1, finding_index_afterif
			addi $s5, $s5, 1
			addi $t2, $t2, 1
		j finding_index_beforeif
		finding_index_afterif:
		li $t2, 46																		#ascii 46 = .(dot)
		lb $t3, 0($s5)
		bne $t2, $t3, case_else_if
			li $t2, 42																	#ascii 42 = *(asterisk)
			sb $t2, 0($s5)
			sw $ra, 8($sp)
			jal printLabyrinth
			lw $ra, 8($sp)
			
			#### CASE 1 if makeMove(index + 1) == 1 ####
			addi $a0, $t1, 1
			sw $ra, 8($sp)
			jal makeMove
			lw $ra, 8($sp)
			move $t5, $v0
			if_ifception1:																#if_ifception1 exists only for tiding up code
				bne $t5, $s7, if_ifception2
					li $t2, 35															#ascii 35 = #(hashtag)
					sb $t2, 0($s5)
					li $v0, 1
					lw $s5, 4($sp)
					lw $t1, 0($sp)
					addi $sp, $sp, 12
					jr $ra
				
			if_ifception2:
				#### CASE 2 if makeMove(index + W) == 1 ####
				add $a0, $t1, $s0
				sw $ra, 8($sp)
				jal makeMove
				lw $ra, 8($sp)
				move $t5, $v0
				bne $t5, $s7, if_ifception3
					li $t2, 35															#ascii 35 = #(hashtag)
					sb $t2, 0($s5)
					li $v0, 1
					lw $s5, 4($sp)
					lw $t1, 0($sp)
					addi $sp, $sp, 12
					jr $ra
			
			if_ifception3:
				#### CASE 3 if makeMove(index - 1) == 1 ####
				addi $a0, $t1, -1
				sw $ra, 8($sp)
				jal makeMove
				lw $ra, 8($sp)
				move $t5, $v0
				bne $t5, $s7, if_ifception4
					li $t2, 35															#ascii 35 = #(hashtag)
					sb $t2, 0($s5)
					li $v0, 1
					lw $s5, 4($sp)
					lw $t1, 0($sp)
					addi $sp, $sp, 12
					jr $ra
			
			if_ifception4:
				#### CASE 4 if makeMove(index - W) == 1 ####
				sub $a0, $t1, $s0
				sw $ra, 8($sp)
				jal makeMove
				lw $ra, 8($sp)
				move $t5, $v0
				bne $t5, $s7, case_end
					li $t2, 35															#ascii 35 = #(hashtag)
					sb $t2, 0($s5)
					li $v0, 1
					lw $s5, 4($sp)
					lw $t1, 0($sp)
					addi $sp, $sp, 12
					jr $ra
			
		case_else_if:
		li $t2, 64
		lb $t3, 0($s5)
		bne $t2, $t3, case_end
			li $t2, 37																	#ascii 37 = %
			sb $t2, 0($s5)
			sw $ra, 8($sp)
			jal printLabyrinth
			lw $ra, 8($sp)
			li $v0, 1
			lw $s5, 4($sp)
			lw $t1, 0($sp)
			addi $sp, $sp, 12
			jr $ra
			
		case_end:
		li $v0, 0
	lw $ra, 8($sp)
	lw $s5, 4($sp)
	lw $t1, 0($sp)
	addi $sp, $sp, 12
	jr $ra