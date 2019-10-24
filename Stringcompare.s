@ BSS section
.bss
z: .word
@ DATA SECTION
.data
Length: .word 3
GREATER: .word 0 
START1: .asciz "CAT" 
START2: .asciz "CUT" 
 
	   
@ TEXT section
    .text

.global _main


_main:
	LDR R9,=Length 		; @get the address of Length
	LDR R0,[R9]		; @Load the value of Length
	LDR R1,=START1		; @get the address of START1
	LDR R2,=START2		; @get the address of START2
	EOR R4,R4,R4		
	
	
Loop: 	LDRB R5,[R1],#1 	; @Load each character of the START1
	LDRB R6,[R2],#1 	; @Load each character of the START2
	CMP R5, R6 		; @Compare the Character
	BGT SETZero 		; @Branch to SETZero ,if the START1 is greater than START2
	CMP R5, R6 		; @Compare the Character
	BLT SETFF		; @Branch to SETFF,if the START1 is Lesser than START2
	CMP R0,#0 		; @CHECK if Length is Zero
	BEQ SETZero 		; @Branch to SETZero , if Length is Zero
	SUB R0,R0,#1 		; @Branch to Decrement Length by 1	
	B Loop 

SETZero:
	MOV R4, #0x00000000	; @Set #0x00000000	
	B Done
SETFF:
	MOV R4, #0xFFFFFFFF	; @Set #0xFFFFFFFF	

Done:   
 	LDR R8, =GREATER	; @Load the address of GREATER
	STR R4, [R8]		; @Store the result in GREATER
 	SWI 0x11
	.end