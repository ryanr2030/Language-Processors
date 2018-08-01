

INCLUDE Irvine32.inc 

.DATA     
	msg BYTE "CIS 335  is a  great    course  at  CSU",0
	count DWORD ?
	tmpInd DWORD ?
	msgSize= ($ - msg) - 1
	ecxbkp Dword ?
	shiftLeft Dword ?
	esibkp Dword ?
 
.CODE 
Main PROC 

	;display the 
	MOV edx, OFFSET msg  
	CALL WriteString 
	CALL Crlf  
mov esi, 0

;compare each element to null eos(0) if true end loop
LI1:	
	cmp byte ptr msg[esi],0
	jne LI2
	jmp ext

comment	@
compare each element to the space character 
if it is not a space continue to the next character
if it is a space store the number of concurrent spaces
@
LI2:
	cmp byte ptr msg[esi], 20h
	jne notSpc
	cmp byte ptr msg[esi+1], 20h
	jne notSpc
	inc esi
	mov esibkp, esi
	mov shiftLeft, 0
	jmp L1

notSpc:
	inc esi
	jmp LI1

L1:
	cmp byte ptr msg[esi], 20h
	je move
	mov esi, esibkp
	jmp L2

move:
	inc shiftLeft
	inc esi
	jmp L1


L2:cmp byte ptr msg[esi],0
	jne Lp3
	mov esi, esibkp
	jmp LI1

;shift the elements
Lp3:
	add esi, shiftLeft
	mov al, msg[esi]
	sub esi, shiftLeft
	mov msg[esi], al
	inc esi
	jmp L2

ext:

;display yhe string without concurrent spaces
	MOV edx, OFFSET msg  
	CALL WriteString 
	CALL Crlf



	comment @
	Following code uses two loops one to push each char in the array
	on to the stack then a second to pop each character back into the array
	in reverse order.
	@
mov eax,0
 mov ecx,32
	mov	 esi,0

L3:	movzx eax,msg[esi]	; get character
	push eax				; push on stack
	inc	 esi
	loop L3

; Pop the name from the stack in reverse
; and store it in the msg array.

mov	 ecx, 32
	mov	 esi,0

L4:	pop  eax				; get character
	mov	 msg[esi],al		; store in string
	inc	 esi
	loop L4     
	
	; Display the string reversed char by char
	CALL WriteString 
	CALL Crlf  


	
	comment @
		the following uses a nested loop to reverse the order of each
		word in the string 
	@

;initialize registers used
mov ecx, 32	
mov count, ecx
mov ebx, 0
mov edx, 0
mov esi, 0
mov tmpInd, esi

;loop to the end of each word
L5:
	mov count, ecx
	mov al, msg[esi]
	cmp msg[esi], ' '
	je revWord		;jump to the nested loop to reverse each char
	inc esi
	loop L5

revWord:
	mov tmpInd, esi
	dec esi
	mov ecx, esi
	L6:
		;uses one iteration of quick sort to swap the corresponding characters
		cmp ebx, esi
		ja loopCont
		mov al, msg[esi]
		mov dl, msg[ebx]
		mov msg[esi], dl
		mov msg[ebx], al
		inc ebx
		dec esi
		loop L6

loopCont:
	inc tmpInd			;store the index of the start of the next word to reverse
	mov ebx, tmpInd
	mov esi, tmpInd
	mov ecx, count
	Loop L5				;loop to the end of the next word
lastWord:

;display the array reversed word by word
mov edx, offset msg
CALL WriteString 
	CALL Crlf  

	EXIT
Main ENDP 
 
END main