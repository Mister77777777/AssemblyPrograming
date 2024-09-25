MY SEGMENT
   A DB 'a' 
MY ENDS
ASSUME CS:MY
MY SEGMENT
start:
    MOV AX, MY
    MOV DS, AX
    MOV CX,2
    MOV BX,13
    MOV AH,2 
 L_1: 
    MOV BX,13
    L_2:  
    MOV DL,[A]
    INC [A]
    INT 21H
    DEC BX
    CMP BX,0
    JNZ L_2
    MOV DL,10
    INT 21H
    DEC CX
    CMP CX,0
    JNZ L_1
    MOV AX, 4C00H  
    INT 21H        
MY ENDS
   END start

; 使用跳转实现