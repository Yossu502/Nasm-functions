SECTION .data
	msgBorrar	db	1Bh, "[2J", 1Bh, "[3J", 1Bh, "[H", 0h
	Posicion	db	1Bh, "[12;40H", 0h
	
    	msg1        	db      '-CALCULADORA-', 0h
    	msg2        	db      'Ingrese 1er Numero: ', 0h
    	msg3        	db      'Ingrse 2do Numero: ', 0h
    	msg4        	db      '1. SUMA', 0h
    	msg5        	db      '2. RESTA', 0h
    	msg6        	db      '3. MULTIPLICACION', 0h
    	msg7        	db      '4. DIVISION', 0h
    	msg8        	db      'OPERACION A EJECUTAR: ', 0h
    	msg9        	db      'RESULTADO: ', 0h
    	msg10       	db      'ERROR', 0h
		msg11			db		'Ingrese Divisor: ', 0h
		msg12			db		'Ingrese Dividendo: ',0h
		msg13			db		'Residuo: ', 0h 
	
    	nlinea      	db      10,10,0
    	lnlinea     	equ     $ - nlinea


SECTION .bss
	opc:        resb    40
    	num1:       resb    40
    	num2:       resb    40
    	result:     resb    40


SECTION .text

;-----This fuction start a calculator of two numbers----------------
start:
    mov 	eax, msg1
    call 	sprintLF	
    mov 	eax, msg4
	call	sprintLF
    mov 	eax, msg5
	call	sprintLF
    mov 	eax, msg6
	call	sprintLF
    mov 	eax, msg7
	call	sprintLF
    mov 	eax, msg8
	call	sprint
    mov 	ebx,0
    mov 	ecx,opc
    mov 	edx,2
    mov 	eax,3
    int 	80h
    mov 	ah, [opc]       
    sub 	ah, '0'     
    cmp 	ah, 1
    je 		suma
	cmp 	ah, 2
    je 		resta
	cmp 	ah, 3
    je 		multi
	cmp 	ah, 4
    je 		division	
    mov 	eax, msg10
	call	sprintLF
    call	quit
;------Function to add two numbers---
suma:
	mov		eax, msg2
	call	sprint

	mov		edx, 40
	mov		ecx, num1
	mov 	ebx, 0
	mov		eax, 3
	int		80h
	mov		eax, ecx
	call	atoi
	mov		ebx, eax
	push	ebx
	
	mov		eax, msg3
	call	sprint

	mov		edx, 40
	mov		ecx, num2
	mov 	ebx, 0
	mov		eax, 3
	int		80h
	mov		eax, msg9
	call	sprint	
	mov		eax, ecx
	call	atoi
		
	pop		ebx
	add		ebx, eax
	mov		eax, ebx
	call	iprintLF
	call	quit
;--------Function to sub two numbers
resta:
	mov		eax, msg2
	call	sprint
	mov		edx, 40
	mov		ecx, num1
	mov 	ebx, 0
	mov		eax, 3
	int		80h
	mov		eax, ecx
	call	atoi
	mov		ebx, eax
	push	ebx
	mov		eax, msg3
	call	sprint
	mov		edx, 40
	mov		ecx, num2
	mov 	ebx, 0
	mov		eax, 3
	int		80h
	mov		eax, msg9
	call	sprint	
	mov		eax, ecx
	call	atoi
		
	pop		ebx
	sub		ebx, eax
	mov		eax, ebx
	call	iprintLF
	call	quit

;-------------Function to multiply two numbers
multi:
	mov		eax, msg2
	call	sprint
	mov		edx, 40
	mov		ecx, num1
	mov 	ebx, 0
	mov		eax, 3
	int		80h
	mov		eax, ecx
	call	atoi
	mov		ebx, eax
	push	ebx
	
	mov		eax, msg3
	call	sprint

	mov		edx, 40
	mov		ecx, num2
	mov 	ebx, 0
	mov		eax, 3
	int		80h
	mov		eax, msg9
	call	sprint	
	mov		eax, ecx
	call	atoi
		
	pop		ebx
	mul		ebx
	call	iprintLF
	call	quit
;------------Function to div two numbers
division:
	mov		eax, msg11
	call	sprint


	mov		edx, 40
	mov		ecx, num1
	mov 	ebx, 0
	mov		eax, 3
	int		80h
	mov		eax, ecx
	call	atoi
	mov		ebx, eax
	push	ebx
	
	mov		eax, msg12
	call	sprint

	mov		edx, 40
	mov		ecx, num2
	mov 	ebx, 0
	mov		eax, 3
	int		80h
	mov		eax, msg9
	call	sprint	
	mov		eax, ecx
	call	atoi
	mov		edx, 0
	pop		ebx
	div		ebx
	call	iprintLF


	mov		eax, msg13
	call	sprint
	mov 	eax, edx
	call	iprintLF
	call	quit


iprint:
    push    eax             
    push    ecx             
    push    edx             
    push    esi             
    mov     ecx, 0          
 
divideLoop:
    inc     ecx             
    mov     edx, 0          
    mov     esi, 10        
    idiv    esi             
    add     edx, 48         
    push    edx             
    cmp     eax, 0          
    jnz     divideLoop      
 
printLoop:
    dec     ecx             
    mov     eax, esp        
    call    sprint          
    pop     eax             
    cmp     ecx, 0          
    jnz     printLoop       
 
    pop     esi             
    pop     edx             
    pop     ecx             
    pop     eax             
    ret
 
 
;-----------------Function to print on screen with spaces or blank line

iprintLF:
    call    iprint          
 
    push    eax             
    mov     eax, 0Ah        
    push    eax             
    mov     eax, esp        
    call    sprint          
    pop     eax             
    pop     eax             
    ret
 
 

slen:
    push    ebx
    mov     ebx, eax
 
nextchar:
    cmp     byte [eax], 0
    jz      finished
    inc     eax
    jmp     nextchar
 
finished:
    sub     eax, ebx
    pop     ebx
    ret
 
 
;-----------------Print any type of number (NO negative)--------------------
sprint:
    push    edx
    push    ecx
    push    ebx
    push    eax
    call    slen
 
    mov     edx, eax
    pop     eax
 
    mov     ecx, eax
    mov     ebx, 1
    mov     eax, 4
    int     80h
 
    pop     ebx
    pop     ecx
    pop     edx
    ret
 
 

sprintLF:
    call    sprint
 
    push    eax
    mov     eax, 0AH
    push    eax
    mov     eax, esp
    call    sprint
    pop     eax
    pop     eax
    ret
 
;------------function to convert string to Integer-------------------
atoi:
    push    ebx            
    push    ecx             
    push    edx             
    push    esi             
    mov     esi, eax        
    mov     eax, 0          
    mov     ecx, 0          
 
.multiplyLoop:
    xor     ebx, ebx        
    mov     bl, [esi+ecx]   
    cmp     bl, 48          
    jl      .finished       
    cmp     bl, 57          
    jg      .finished       
 
    sub     bl, 48          
    add     eax, ebx        
    mov     ebx, 10         
    mul     ebx             
    inc     ecx             
    jmp     .multiplyLoop   
 
.finished:
    mov     ebx, 10         
    div     ebx            
    pop     esi             
    pop     edx             
    pop     ecx             
    pop     ebx             
    ret

;------------------para salir
quit:
    mov     ebx, 0
    mov     eax, 1
    int     80h
    ret
