TITLE Program 2     (prog2.asm)

; Author:					Nils Streedain
; Last Modified:			1/29/2022
; OSU email address:		streedan@oregonstate.edu
; Course number/section:	271-001
; Assignment Number:		3
; Due Date:					1/30/2022
; Description:				Write a MASM program to perform the following tasks:
;							Display the program title and programmer’s name.
;							Get the user's name, and greet the user.
;							Display instructions for the user
;							Repeatedly prompt the user to enter the number. Validate the user input to be in [-100, -1] (inclusive). Count and accumulate the valid user numbers until a non-negative number is entered (The non-negative number is discarded)
;							Calculate the (rounded integer) average of the negative numbers
;							Display:
;								the number of negative numbers entered (Note: if no negative numbers were entered, display a special message and display the goodbye message with the user's name at the end)
;								the sum of negative numbers entered
;								the average, rounded to the nearest integer (e.g., -20.5 rounds to -21)
;								a goodbye message that includes the user’s name, and terminate the program.

INCLUDE Irvine32.inc

; constants
RANGE_MIN = -100
RANGE_MAX = -1

.data
	; interface strings
	prog_title	BYTE		"Welcome to the Integer Accumulator by Nils Streedain", 13, 10, 0
	;extra		BYTE		"**EC: Calculate and display the average as a floating-point number, rounded to the nearest .001.", 13, 10, 0
	prompt_1	BYTE		"What is your name? ", 0
	greeting	BYTE		"Hello, ", 0
	prompt_2a	BYTE		"Please enter numbers in [-100, -1].", 13, 10, "Enter a non-negative number when you are finished to see results.", 13, 10, 0
	prompt_2b	BYTE		"Enter number: ", 0
	error		BYTE		"Invalid number, please enter numbers in [-100, -1].", 13, 10, 0
	zeroAdded	BYTE		"No valid negative numbers were input by the user.", 0
	
	bye_1		BYTE		"You entered ", 0
	bye_2		BYTE		" valid numbers.", 13, 10, "The sum of your valid numbers is ", 0
	bye_3		BYTE		13, 10, "The rounded average is ", 0
	bye_4		BYTE		13, 10, "Thank you for playing Integer Accumulator!", 13, 10, "Goodbye, ", 0

	; program variables
	username	BYTE		33 DUP(0)
	curr		DWORD		?
	quantity	DWORD		0
	sum			DWORD		0

.code
main PROC

; Prints the program title, author's name, & extra credit tag.
introduction:
	mov		edx, OFFSET prog_title
	call	WriteString
	;mov		edx, OFFSET extra
	;call	WriteString

; Asks for and stores user's name. Also greets user using the name.
getUserInfo:
	; prompt for username
	mov		edx, OFFSET prompt_1
	call	WriteString

	; store username
	mov		edx, OFFSET username
	mov		ecx, 32
	call	ReadString

	; greet user
	mov		edx, OFFSET greeting
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString
	call	Crlf

; Tells the user to enter numbers between -100 & -1.
displayinstructions:
	mov		edx, OFFSET prompt_2a
	call	WriteString
	
; Prompts for number in the range -100 & -1. If the input is below, the program jumps to outOfRange, if above, jumps to endProgram.
numPrompt:
	; prompts for number to add to sum
	mov		edx, OFFSET prompt_2b
	call	WriteString
	call	ReadInt
	mov		curr, eax

	; check if input is out of range (ReadInt already stores input in eax)
	cmp		eax, RANGE_MIN
	jl		outOfRange
	cmp		eax, RANGE_MAX
	jg		endProgram
	
	; if not outOfRange, add input to sum, increase quantity, & loop numPrompt
	mov		eax, curr
	add		eax, sum
	mov		sum, eax
	inc		quantity
	jmp		numPrompt
	
; Gives the user an out of range error & then jumps to numPrompt to get another user input.
outOfRange:
	mov		edx, OFFSET error
	call	WriteString
	jmp		numPrompt

; Prints final quantity, sum, average & gives the user a salutation before exiting the program.
endProgram:
	; if zero numbers were added, give message & end program.
	mov		eax, quantity
	cmp		eax, 0
	je		noneAdded

	; find and print quantity of numbers input
	mov		edx, OFFSET bye_1
	call	WriteString
	mov		eax, quantity
	call	WriteDec
	
	; find and print sum of numbers input
	mov		edx, OFFSET bye_2
	call	WriteString
	mov		eax, sum
	call	WriteInt
	
	; find and print average of numbers input
	mov		edx, OFFSET bye_3
	call	WriteString
	mov		eax, sum
	mov		ebx, quantity
	cdq
	idiv	ebx
	call	WriteInt
;	fild	sum
;	fidiv	quantity
;	call	WriteFloat
	jmp		goodbye

; if no valid negative numbers are input by the user, this is called to tell the user
noneAdded:
	mov		edx, OFFSET zeroAdded
	call	WriteString

; tells the user goodbye & prints their name
goodbye:
	; say goodbye to the user
	mov		edx, OFFSET bye_4
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString

	exit	; exit to operating system
main ENDP

END main
