MY SEGMENT
   A DB 'a' 
MY ENDS
ASSUME CS:MY
MY SEGMENT
start:
    MOV AX, MY
    MOV DS, AX
    MOV CX,2
    MOV AH,2 
 L_1: 
    MOV BX,CX
    MOV CX,13
    L_2:  
    MOV DL,[A]
    INC [A]
    INT 21H
    LOOP L_2
    MOV DL,10
    INT 21H
    MOV CX,BX
    LOOP L_1
    MOV AX, 4C00H  
    INT 21H        
MY ENDS
   END start
; 使用两次循环的方式
; FIRST_LINE:
;     MOV AL,A
;     MOV DL,AL
;     INC AL
;     MOV A,AL

;     INT 21H
;     LOOP FIRST_LINE

;     MOV AL,n
;     MOV DL,AL
;     INT 21H
    
;     MOV CX,13
; SECOND_LINE:
;     MOV AL,A
;     MOV DL,AL
;     INC AL
;     MOV A,AL

;     INT 21H
;     LOOP SECOND_LINE

