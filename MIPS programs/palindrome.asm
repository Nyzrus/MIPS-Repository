.data 

Inputstring: .space 200
stringPrompt: .asciiz "Enter input:"
isPalindrome: .asciiz "The string is a palindrome"
isntPalindrome: .asciiz "The string isn't a palindrome"
.text

 main:
 	li $v0, 4
 	la, $a0, stringPrompt
 	li $a1, 64
 	syscall
 	la $a1, Inputstring
 	li $a1, 200
 	li $v0, 8
 	syscall
 	jal stringLength
 	jal checkPalindrome
 	j Exit
	
 	
stringLength:
	addi $s1, $0, -1
looper:
	lb $t1, ($a0)			#load contents of $a0 into $t1
	beqz $t1, Done			#if contents are null, go back to the $ra
	addi $a0, $a0, 1		#increment pointer
	addi $s1, $s1, 1		#increment string length counter
	j looper
	
checkPalindrome:
	la $t0, stringPrompt
	la $t1, stringPrompt		
	li $t2, -1			# $t1 = -1
	li $t3, 1			# $t1 = 1		
	addi $t0, $t0, -1
	add $t0, $t0, $s1
	addi $t1, $t1, 0
looped:
	
	lb $s0, 0($t1)
	lb $s2, 0($t0)
	bne $s0,$s2, False	
	sub $t4, $t0, $t1				
	blt $t4, 2 True		
	
	add $t0, $t0, $t2
	add $t1, $t1, $t3				
	j looped
	
Done:
	jr $ra
	
True:
	li $v0, 4
 	la, $a0, isPalindrome
 	li $a1, 64
 	syscall
 	j Exit
False:
	li $v0, 4
 	la, $a0, isntPalindrome
 	li $a1, 64
 	syscall
 	j Exit

Exit:
