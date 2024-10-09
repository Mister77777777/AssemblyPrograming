MY SEGMENT
   A DW 1 
;结果放到栈中的做法
MY ENDS
ASSUME CS:MY
MY SEGMENT
start:
    MOV AX, MY
    MOV DS, AX
    MOV CX,100
    MOV BL,0
    MOV AX,0
    PUSH AX
L:
    POP AX
    ADD AX,A
    INC A
    PUSH AX
    LOOP L  
    ; 先进行求和计算
    MOV CX,5
    ; 使用栈存来输出
    

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

