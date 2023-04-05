.model tiny
.code
org 100h

start: mov ah,0ah 
       mov dx, offset buff ;Enter a string  
       int 21h 
       mov ah,9h         
       mov dx,offset newline
       int 21h
       mov dx,offset buff    
       add dx, 2h
       int 21h 
       mov dx,offset newline
       int 21h  
       lea bx, buff
       add bx, 2h
       mov si, bx  
       jmp word 

lookstring: mov si, di ;Look for the end
            cmp [si], '$'
            je foundend  
            inc si 
            mov bx, si
            jmp word            
                        
word: cmp [si], ' ' ;Find the space
      je foundspace  
      cmp [si], '$'
      je foundspace  
      inc si
      jmp word     

wheresend: cmp cx, 10 ;Go to next word or to final result
           je finale
           jmp lookstring            

foundspace: mov di, si ;Space found
            dec si 
            mov cx, 1
            jmp reverse                             

reverse: cmp bx, si ;Reversing from bx to si
            jae wheresend            
            mov al, [bx]
            mov ah, [si]            
            mov [si], al
            mov [bx], ah            
            inc bx
            dec si
            jmp reverse           

foundend: lea bx, buff ;String end found
          add bx, 2h
          dec si  
          mov cx, 10
          jmp reverse                 

finale: lea dx, buff ;Print result 
        add dx, 2h
        mov ah, 09h
        int 21h        

ret 

string1 db '1234 56 789 A BCDEFG$'  
newline db 0Dh, 0Ah, '$'  
buff db 200

end start
