.model tiny
.code
org 100h  
start: mov ah,9h     
       mov dx,offset n1en
       int 21h 
       mov ah,0ah 
       lea dx, stringeq ;Enter a string  
       int 21h    
       mov ah,9h         
       mov dx,offset newline
       int 21h    
       
       call atoi   
       mov num1, bx       
       
       mov ah,9h     
       mov dx,offset n2en
       int 21h        
       mov ah,0ah        
       lea dx, stringeq ;Enter a string  
       int 21h           
       mov ah,9h
       mov dx,offset newline   
       int 21h    
    
       call atoi  
       mov num2, bx 
       
       sgnent:
       mov ah,9h     
       mov dx,offset sen
       int 21h
       mov ah, 1
       int 21h
       mov opr, al
       mov sgnr, 0 
       
       cmp opr, '+'
       je plus
       cmp opr, '-'
       je minus
       cmp opr, '*'
       je mult
       cmp opr, '/'
       je divd
       mov ah,9h     
       mov dx,offset sgnerr
       int 21h  
       jmp sgnent 
       
negt:
neg bx 
mov min2, 1 
cmp min1, 1
je setz
mov min1, 1
jmp fin
setz:
mov min1, 0
jmp fin        

proc atoi        
  mov  si, offset stringeq + 1
  mov  cl, [ si ]                                         
  mov  ch, 0                 
  add  si, cx  
  mov  bx, 0
  mov  bp, 1   
repeat:                            
  mov  al, [ si ]  
  cmp al, '-'
  je negt
  sub  al, 48
  mov  ah, 0
  mul  bp
  add  bx,ax 
  mov  ax, bp
  mov  bp, 10
  mul  bp
  mov  bp, ax
  dec  si    
  fin:
  loop repeat 
  ret   
  endp   
  
plus:
mov ax, num1
add ax, num2
jns exit    
neg ax
mov sgnr, 1
jmp exit

minus:
mov ax, num1
sub ax, num2 
jns exit    
neg ax
mov sgnr, 1
jmp exit

mult:
mov ax, num1
imul num2 
jo exitzro
cmp min1, 0 
je exit    
neg ax
mov sgnr, 1
jmp exit

divd:
mov ax, num1  
cmp num2, 0
je exitzro
mov cx, num2 
mov ch, 0
idiv cl
cmp min1, 0 
je exit      
neg ax
mov sgnr, 1
jmp exit

exitzro:
 mov ah,9h          
 mov dx,offset zromsg
 int 21h 
 jmp mb 
exit:  
 mov bx, ax
 mov ah,9h          
 mov dx,offset newline
 int 21h         
 mov dx,offset msg
 int 21h
 cmp sgnr, 1
 jne cea
 mov dx,offset negres
 int 21h
 cea:  
 mov ax, bx
 call print
 mb:
 ret
 
proc print ;print number in ax
cmp al, 0
jne printy
    mov ah,9h     
    mov dx,offset nully
    int 21h  
    ret
printy:    
    pusha
    mov ah, 0
    cmp ax, 0
    je pdone
    mov dl, 10
    div dl    
    call printy
    mov al, ah
    add al, 30h
    mov ah, 0eh
    int 10h    
    jmp pdone
pdone:
    popa
    ret  
endp
  
zromsg db 0Dh,0Ah, "Division by zero error! ",0Dh,0Ah, '$' 
sgnerr db 0Dh,0Ah, "Wrong input! ",0Dh,0Ah, '$'                   
msg db 0Dh,0Ah, "Result: ",0Dh,0Ah, '$'
n1en db 0Dh,0Ah, "Enter 1st number: ",0Dh,0Ah, '$' 
n2en db 0Dh,0Ah, "Enter 2nd number: ",0Dh,0Ah, '$' 
sen db 0Dh,0Ah, "Enter sign (+, -, *, /): ",0Dh,0Ah, '$' 
nully db 0Dh,0Ah, "0",0Dh,0Ah, '$' 
negres db "-", '$'                   
newline db 0Dh, 0Ah, '$'  
stringeq db 12, 12 dup('$')
num1 dw ?
num2 dw ? 
numf dw ? '$'
opr db '?'
min1 dw ?
min2 dw ? 
sgnr dw ?  
buffer db 10, '$'

end start
