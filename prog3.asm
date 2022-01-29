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
RANGE_MIN = 1
RANGE_MAX = 46

.data
	; interface strings
	prog_title	BYTE		"Fibonacci Numbers", 13, 10, "Programmed by Nils Streedain", 13, 10, 0
	extra		BYTE		"**EC: Displays the numbers in aligned columns.", 13, 10, 0
	prompt_1	BYTE		"What is your name? ", 0
	greeting	BYTE		"Hello, ", 0
	prompt_2a	BYTE		"Enter the number of Fibonacci terms to be displayed.", 13, 10, "Provide the number as an integer in the range [1 .. 46].", 13, 10, 0
	prompt_2b	BYTE		"How many Fibonacci terms do you want? ", 0
	error		BYTE		"Out of range. Enter a number in [1 .. 46]", 13, 10, 0
	tab_char	BYTE		9, 0
	bye			BYTE		13, 10, "Results certified by Nils Streedain.", 13, 10, "Goodbye, ", 0

	; user inputs
	username	BYTE		33 DUP(0)
	num_fibs	DWORD		?
	
	; program variables
	fib_1		DWORD		0
	fib_2		DWORD		0

.code
main PROC

; Prints the program title, author's name, & extra credit tag.
introduction:
	mov		edx, OFFSET prog_title
	call	WriteString
	mov		edx, OFFSET extra
	call	WriteString

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

; Tells the user to enter the number of fibs they'd like printed.
displayinstructions:
	mov		edx, OFFSET prompt_2a
	call	WriteString
	
; Prompts for number of fibs in the range 1-46. If the input is out of range, the program jumps to outOfRange.
fibPrompt:
	; prompts for number of fibs in range
	mov		edx, OFFSET prompt_2b
	call	WriteString
	call	ReadInt

	; check if input is out of range (ReadInt already stores input in eax)
	cmp		eax, RANGE_MIN
	jl		outOfRange
	cmp		eax, RANGE_MAX
	jg		outOfRange
	
	; if not outOfRange, store num_fibs & then displayFibs
	mov		num_fibs, eax
	jmp		displayFibs
	
; Gives the user an out of range error & then jumps to fibPrompt to get another user input.
outOfRange:
	mov		edx, OFFSET error
	call	WriteString
	jmp		fibPrompt

; Starts a counted loop to print out a certain number of Fibonacci numbers.
displayFibs:
	mov		eax, fib_1			; eax stores the current fib number
	mov		ecx, num_fibs		; ecx stores the number of fibs to find, decreased after each loop

; Calculates the next fibonacci number
calcNthFib:
	mov		eax, fib_1			; resets eax to the curr fib
	cmp		eax, 0				; if eax is 0, it is increased
	je		incEax				; (this is for the first two iterations where 1 is printed)

	add		eax, fib_2			; calcs the next fib by adding fib_2 to curr fib

; Moves fib_1 -> fib_2 & eax -> fib_1. Also prints curr fib.
swapAndPrint:
	; swap fib_1 & fib_2 & set fib_1 to new fib in eax
	mov		ebx, fib_1
	mov		fib_2, ebx
	mov		fib_1, eax

	call	WriteDec			; print curr fib number

	; insert tab to create columns
	mov		edx, OFFSET tab_char
	call	WriteString
	
	; Find the remainder of the curent num_fibs count over three. This is done so every four fibs, a new line is printed.
	mov		ebx, 3
	cdq
	div		ebx
	cmp		edx, 0
	jne		noNewLine
	call	Crlf

; Jump point for when no new line is needed to create a new column.
noNewLine:
	loop	calcNthFib			; restart the loop for the next number (decreases ecx by 1)
	jmp		goodbye				; once ecx = 0, jump to goodbye

; Increments ebx for the first 2 iterations of calcNthFib. Then jumps to swapAndPrint to skip the addition of fib 1&2.
incEax:
	inc		eax
	jmp		swapAndPrint

; Gives the user a salutation & exits the program.
goodbye:
	mov		edx, OFFSET bye
	call	WriteString
	mov		edx, OFFSET username
	call	WriteString

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
