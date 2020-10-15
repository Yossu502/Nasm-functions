;Bloque de funciones a utilizar para manejo de entrada y salida
;int strLen(mensaje)
SECTION .data
	msgBorrar	db	1Bh, "[2J", 1Bh, "[3J", 1Bh, "[H", 0h
	Posicion	db	1Bh, "[12;40H", 0h
strLen:
	push	ebx
	mov	ebx, eax
nextChar:
	cmp 	byte [eax], 0
	jz	finishStrlen
	inc 	eax
	jmp	nextChar
finishStrlen:
	sub 	eax, ebx
	pop 	ebx
	ret
;-------------------------------------------------------------------
Print:
	push	edx
	push	ecx
	push	ebx
	push 	eax
	call	strLen
	mov	edx, eax
	pop	eax
	mov	ecx, eax
	mov	ebx, 1
	mov	eax, 4
	int 	80h
	pop	ebx
	pop	ecx
	pop	edx
	ret
Println:
	call	Print
	push	eax
	mov	eax, 0Ah
	push	eax
	mov	eax, esp
	call 	Print
	pop 	eax
	pop	eax
	ret
BorraPantalla:
	push	eax
	mov	eax, msgBorrar
	call 	Print
	pop	eax
	ret
gotoxy:
	push	eax
	mov	eax, Posicion
	call	Print
	pop	eax
	ret

UpperCase:
	push	edx
	mov	edx, eax
	push	eax
	push	ecx
	mov	ecx, 0
	call 	strLen
	jmp 	Upper
Upper:
	cmp	byte[edx + ecx], 65
	jb	NextUpper
	cmp	byte[edx + ecx], 90
	ja	NextUpper
	add	byte[edx + ecx], 32
	jmp	NextUpper
NextUpper:
	inc	ecx
	cmp	ecx, eax
	jne	Upper
	pop	ecx
	pop	eax
	pop	edx
	ret

LowerCase:
	push	edx
	mov	edx, eax
	push	eax
	push	ecx
	mov	ecx, 0
	call	strLen
	jmp	Lower
Lower:
	cmp	byte[edx+ecx], 97
	jb	NextLower
	cmp	byte[edx+ecx], 122
	ja	NextLower
	sub	byte[edx+ecx], 32
	jmp	NextLower
NextLower:
	inc	ecx
	cmp	ecx, eax
	jne	Lower
	pop	ecx
	pop	eax
	pop	edx
	ret
print_Numeros:
    push    eax             
    push    ecx             
    push    edx             
    push    esi             
    mov     ecx, 0          
 
DividirNumero:
    inc     ecx            
    mov     edx, 0          
    mov     esi, 10         
    idiv    esi             
    add     edx, 48         
    push    edx             
    cmp     eax, 0          
    jnz     DividirNumero     
 
print_Ciclo:
    dec     ecx             
    mov     eax, esp        
    call    Print          
    pop     eax             
    cmp     ecx, 0          
    jnz     print_Ciclo     
 
    pop     esi             
    pop     edx             
    pop     ecx             
    pop     eax             
    ret
 
Print_todoTipoDeNumero:
    call    print_Numeros         
 
    push    eax             
    mov     eax, 0Ah        
    push    eax             
    mov     eax, esp        
    call    Print          
    pop     eax             
    pop     eax             
    ret

quit:
	mov	ebx, 0
	mov	eax, 1
	int 	80h
	ret
