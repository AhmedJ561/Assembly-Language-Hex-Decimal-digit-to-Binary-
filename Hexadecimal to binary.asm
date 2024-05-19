.model small
.stack 100h
.data
    
    msg db 10,13,'Enter Hexadecimal  0-9 & A-F : $' 
    nl db 10,13    
    msg1 db 10,13,'Binary output: $' 
    msg2 db 10,13,'Zero Count: $' 
    msg3 db 10,13,'One Count: $'   
    z_c db 48 
    o_c db 48

.code
main proc
    mov ax, @data
    mov ds, ax      

    lea dx, msg
    mov ah, 9h
    int 21h
               
      
    mov ah, 1
    int 21h

    mov bl, al
    
    cmp bl,48
    jge l1
    jl exit
l1:
    cmp bl,58
    jle l2
    jg l3    
l2:     
    sub bl,48
    jmp l4 
l3:        
    cmp bl,65
    jl exit
    
    cmp bl,71
    jg exit 
       
    sub bl,55
l4:
    lea dx, nl
    mov ah, 9h
    int 21h

    mov bh, 0
    mov cx, 8

l5:
    shl bx, 1
    rcr bh, 1
    jnc zero
    jc one

zero:  
    cmp cx,4
    jg  continue_loop
    mov dl, '0'
    mov ah, 2h
    int 21h 
    inc byte ptr z_c
    jmp continue_loop

one:     
     cmp cx,4
    jg  continue_loop
    mov dl, '1'
    mov ah, 2h
    int 21h
    inc byte ptr o_c
continue_loop:
    loop l5

exit: 
    
    mov ah,9h
    lea dx,msg2
    int 21h
    
    mov bl,z_c
     
    mov dl,bl
    mov ah,2h
    int 21h
         
    mov ah,9h
    lea dx,msg3
    int 21h
    
    mov bl,o_c
    mov dl,bl
    mov ah,2h
    int 21h     
    
    
    mov ah, 4ch
    int 21h

main endp
end main
