@ BSS section
.bss
z: .word
@ DATA SECTION
.data

PRESENT: .word 0 
STRING: .asciz "CS6620" 
SUBSTRING: .asciz "6" 
 
	   
@ TEXT section
    .text

.global _main


_main:
	LDR R1,=STRING 		; @get the address of String
	LDR R7,=STRING		; @get the address of String
	LDR R2,=SUBSTRING	; @get the address of subString
	EOR R4,R4,R4		; @Clear R4 to store the value of PRESENT
	
	
StringLOOP: 				; @FOR EACH CAHARACTER IN THE STRING
		LDRB R5,[R1],#1 	; @Load each character of the string
		CMP R5, #0		; @compare whether it is End of String
		BEQ DONE		; @Branch to Done , if the String ends
		MOV R3,R1		; @Reset R3 to the index of current character in the String
		LDR R2,=SUBSTRING	; @Reset R2 to the start of the SubString


SUBSTRINGLOOP:				; @FOR EACH CAHARACTER IN THE SUBSTRING
		LDRB R6,[R2],#1 	; @Load each character of the string
		CMP R6, #0		; @compare whether it is End of SUBSTRING
		BEQ SETPRESENT2		; @Branch to SETPRESENT2, if the SUBSTRING ends
		CMP R5, R6 		; @Compare the character from STRING and SUBSTRING
		BNE StringLOOP		; @Branch to StringLOOP	;if both the characters are not equal
		LDRB R5,[R3],#1		; @ If not Load the next character of the string
		CMP R5, #0		; @compare whether it is End of SUBSTRING
		BEQ SETPRESENT1		; @Branch to SETPRESENT2, if the STRING ends
		B SUBSTRINGLOOP		; @Repeat the SUBSTRINGLOOP

SETPRESENT1:
		LDRB R6,[R2],#1		; @Load the next character of the SUBSTRING
		CMP R6, #0		; @compare whether it is End of SUBSTRING
		BNE DONE		; @Branch to DONE,if the SUBSTRING not ends
SETPRESENT2:	SUB R4,R1,R7		; @Calculate the starting index of matching substring

DONE:   
 	LDR R8, =PRESENT		; @Load the address of Present
	STR R4, [R8]			; @Store the result in Present
 	SWI 0x11
	.end