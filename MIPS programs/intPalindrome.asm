   .data
array:  .space 400
prompt: .asciiz "How many integers would you like to input?"
inputPrompt: .asciiz "Enter an integer:"
isPal: .asciiz " is a numerical palindrome"
isNot: .asciiz " is not a numerical palindrome"
intArray: .word 20
int: .word 1
   .text

main:
	jal numPrompt		#prompt for number of inputs
	li $t0, 0
	la $a2, intArray	
	jal question		#for entering inputs
	jal countertoBase	#bring pointer down to first entry
	jal checkPalindrome	#check if palindrome
	j Exit


numPrompt:
	la $a0, prompt
	li $v0, 4
	syscall
	li $v0, 5
    	syscall
   	sw $v0, 0($a0)
   	addi $t1, $v0, 0
   	la $a0, ($t1)
   	li $v0, 1
   	j Done
question:
	beq $t0, $t1, Done
	addi $t0, $t0, 1
	la $a0, inputPrompt
	li $v0, 4
	syscall
	la $a0, ($a2)
	li $a1, 4
	li $v0, 8
	syscall
	la $s1, ($a2)
	add $a2, $a2, 4
	j question

countertoBase:
	beq $t0, 0, Done		#increments down to first array entry
	add $a2, $a2, -4
	add $t0, $t0, -1
	lb $a0, ($a2)
	li $v0, 11
	syscall
	j countertoBase
	
checkPalindrome:
	la $a3, intArray		#pointer for last entry
	mul $t8, $t1, 4
	add $a3, $a3, $t8
loop:
	beq $t0, $t1, True
	la $s3, ($a3)
	la $s2, ($a2)
	bne $s3, $s2, False		#compare pointers at each end of the array, moving inwards
	addi $a2, $a2, 4		#increment bottom up
	addi $a3, $a3, -4		#increment top down
	addi $t0, $t0, 1
	j loop

True:
	la $a0, isPal			#print is palindrome
	li $v0, 4
	syscall
	j Done
	
False:
	la $a0, isNot			#print is not palindrome
	li $v0, 4
	syscall
	j Done

Done:
	jr $ra
   	
Exit: