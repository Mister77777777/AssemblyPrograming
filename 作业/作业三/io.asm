
MY SEGMENT
    A DW 1 
    SUM DW 0 ;结果放到数据段中的做法
MY ENDS
ASSUME CS:MY
MY SEGMENT
start:
    MOV AX, MY
    MOV DS, AX

    MOV BL,0 ;当前输入位之前的结果
    MOV CL,10 
INPUT:
    MOV AH,1
    INT 21H
    
    CMP AL, 0Dh          ; 判断是否为回车键
    JE OVER
    
    SUB AL,48
    MOV DL,AL
    MOV DH,0
    MOV AL,BL 
    MUL CL 
    ADD AX,DX
    MOV BX,AX 
    JMP INPUT


OVER:
    MOV CX,BX
    MOV BL,0
L:
    MOV AX,A
    ADD SUM,AX
    INC A
    LOOP L  
    ; 先进行求和计算
    MOV AX,SUM
    MOV CX,5
    
CLEAR_STACK:
    POP DX           ; 弹出栈顶元素
    LOOP CLEAR_STACK ; 循环直到CX为0
L1: 
    XOR DX,DX 
    MOV BX,10
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNZ L1

L2:
    POP DX
    ADD DL,'0'
    MOV AH,2
    INT 21H
    LOOP L2
    MOV AX, 4C00H  
    INT 21H      
MY ENDS
   END start

