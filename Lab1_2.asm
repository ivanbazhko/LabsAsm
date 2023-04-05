 .model tiny  
 .code
 org 100h ;start
start:      

 mov ah,9h ;output function   

 mov dx,offset message1 ;message1 to dx
 int 21h ;print string 1           
   
 mov dx,offset message2 ;message2 to dx
 int 21h ;print string 2
 
 mov dx,offset message3 ;message3 to dx
 int 21h ;print string 3    
 
  mov dx,offset message4 ;message3 to dx
 int 21h ;print string 4
 
 ret ;end
       
message1 db "Hello World!",0Dh,0Ah,'$'    
message2 db "Bonjour",0Dh,0Ah,'$'
message3 db "How are you doing today?",0Dh,0Ah,'$' 
message4 db "12345",0Dh,0Ah,'$'

 end start