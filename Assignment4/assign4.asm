INCLUDE Irvine32.inc

.model flat, stdcall
.code
Findlargest Proto, arrPTR:PTR SDWORD, arrSize:DWORD 

;__________________________________________________________________

Findlargest PROC USES ebx ecx esi,   ;preserves ecx, ebx, esi registers
	arrPTR:PTR SDWORD,   ;pointer to the first element in the array
	arrSize: DWORD		;Number of elements in the array 
;Takes in an array of positive and/or negative integers
;
;Returns EAX: Largest Value in the array
;__________________________________________________________________
	
	mov eax, -2147483648d  ;initiliaze eax register to the smallest integer a DWORD can Store
	mov esi, arrPTR			; Move the address of the first element of the array to the ESI reg
	mov ecx, arrSize		; Move array size to the counter 
	mov ebx, [esi]			; Move first value into ebx reg
	
	cmp ebx, eax		;check to see if the first element is less than the lowest possible storable integer
	JLE first		
	first:
		mov eax, ebx
	dec ecx					; first val in esi dec ecx by one 
	L1:
		add esi, 4			; Move to the next element
		mov ebx, [esi]		;put the next value in the 
		cmp ebx, eax		;if ebx is less than or equal to eax continue to the next element
		JLE check			
		mov eax, ebx		;else if ebx is greater than eax store ebx into eax
		check:
			loop L1
		ret
	Findlargest ENDP
END 