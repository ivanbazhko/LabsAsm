.model  small 
.stack  100h
.code          
start:
mov ax, @data                   
mov ds, ax 
call get_name     
mov ah, 3Dh  ;open file
mov al, 00h     
lea dx, [FileName]
int 21h
jc leave 
mov bx, ax
mov di, 01
 
read: ;read file by bytes
mov cx, 1
lea dx, buff
mov ah, 3fh
int 21h
jc close
mov cx, ax
cmp buff, 0Dh
je founddh
mov si, 0
after:
jcxz close 
jmp read
 
founddh: ;0Dh found
mov cx, 1
lea dx, buff
mov ah, 3fh
int 21h
jc close
mov cx, ax
cmp buff, 0Ah ;check for 0Ah
jne after
cmp si, 1
je empty
mov si, 1 
jmp after
empty: ;found empty string
inc bp
jmp after

close: ;close file
mov ah, 3eh
int 21h
jmp final
leave: ;error happened
mov ah,9h     
mov dx,offset newline
int 21h      
mov dx,offset string1
int 21h
jmp kjb
final:
mov ah,9h     
mov dx,offset lines
int 21h 
mov ax, bp
mov num, bp
call print
kjb:
mov ax, 4C00h
int 21h

proc print ;print number in ax
cmp al, 0
jne printy
    mov ah,9h     
    mov dx,offset nolines
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

proc get_name
    push ax 
    push cx
    push di
    push si
    xor cx, cx
    mov cl, es:[80h]    ;amount of symbols in cmd line
    cmp cl, 1
    je leave
    mov di, 81h         ;offset of cmd line in PSP block
    lea si, FileName    ;load file name in si
cicle1:
    mov al, es:[di]     ;load in AL the value of of cmd line char by char
    cmp al, 0Dh         ;check for end
    je end_get_name
    mov [si], al        ;load symbol from cmd line in file name 
    inc di              ;for next symbol
    inc si            
    jmp cicle1 

end_get_name:        
    pop si          
    pop di
    pop cx
    pop ax   
ret
endp 

.data         
lines db 'Number of empty strings: $'
nolines db 'No empty strings!$' 
string1 db 'Something went really wrong!$'   
newline db 0Dh, 0Ah, '$'  
buff db 200
num dw 0
FileName db 80 dup(0)
f_name db 'c:\testlab5\filel5.txt',0 ; file name 

end start
