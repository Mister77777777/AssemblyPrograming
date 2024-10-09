MY SEGMENT
   A DW 1 
   SUM DW 0 ;结果放到数据段中的做法
MY ENDS
ASSUME CS:MY
MY SEGMENT
start:
    MOV AX, MY
    MOV DS, AX
    MOV CX,100
    MOV BL,0
L:
    MOV AX,A
    ADD SUM,AX
    INC A
    LOOP L  
    ; 先进行求和计算
    MOV CX,5
    
    MOV AX,SUM
    ; 使用栈存来输出NN
    

CLEAR_STACK:
    POP DX           ; 弹出栈顶元素
    LOOP CLEAR_STACK ; 循环直到CX为0
L2: 
    XOR DX,DX 
    MOV BX,10
    DIV BX
    PUSH DX
    INC CX
    CMP AX, 0
    JNZ L2

L3:
    POP DX
    ADD DL,'0'
    MOV AH,2
    INT 21H
    LOOP L3


    MOV AX, 4C00H  
    INT 21H      
MY ENDS
   END start

