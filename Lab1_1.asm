 .model tiny  
 .code
 org 100h ;start  
 
start:      

 mov ah,0ah 
 mov dx, offset buff   
 int 21h 
 
 mov ah,9h         
 
 mov dx,offset newline
 int 21h
  
 mov dx,offset buff ;buff to dx    
 add dx, 2h
 int 21h ;print  
 
 mov dx,offset newline
 int 21h  
 
 mov cx, 10   
 mov si, 0
 
 L1:    
 
 mov dx,offset buff ;buff to dx    
 add dx, 2h
 int 21h ;print  
 
 mov dx,offset newline
 int 21h  
 
 LOOP L1
 
 ret
 
 newline db 0Dh, 0Ah, '$'  
 buff db 30

 end start