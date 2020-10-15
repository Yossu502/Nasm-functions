;Bloque de funciones a utilizar para manejo de entrada y salida
;int strLen(mensaje)
SECTION .data
	msgBorrar:	db	27,"[H", 27, 0h, "[2J", 0h
	BORRARSC	equ	$-msgBorrar
	Posicion:	db	1Bh, "[12;40H", 0h
srtLent:
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
strPrint:
	push	edx
	push	ecx
	push	ebx
	push 	eax
	call	srtLent
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

quit:
	mov	ebx, 0
	mov	eax, 1
	int 	80h
	ret

strPrintln:
	call	strPrint
	push	eax
	mov	eax, 0Ah
	push	eax
	mov	eax, esp
	call 	strPrint
	pop 	eax
	pop	eax
	ret

;--------------Funcion para borrar Pantalla-----------------------
BorraPantalla:
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, msgBorrar
	mov	edx, BORRARSC
	int 	80h
	mov 	eax, 1
	mov	ebx, 0
	int	80h

;-----------------Funcion para implementar para imprimir en cierto lugar de la pantalla-----------------
gotoxy:
	push	eax
	mov	eax, Posicion
	call	strPrintln
	pop	eax
	ret
