.model small
.stack 100h

.data
    msg db 'The 9mul9 table:', 0
    newline db 0dh, 0ah, '$'  ; 换行符

.code
main proc
    ; 初始化数据段
    MOV AX, @data
    MOV DS, AX

    ; 输出标题
    MOV DX, offset msg
    MOV AH, 09H
    INT 21H

    ; 循环输出九九乘法表
    MOV CX, 9       ; 控制行，从1到9

row_loop:
    MOV BX, 1       ; 右侧数初始值为1
    call print_mul

    ; 换行
    MOV DX,offset newline
    MOV AH,09H
    INT 21H

    LOOP row_loop      

    ; 退出程序
    MOV AX,4C00H
    INT 21H
main endp

; 打印当前行
print_mul proc
    PUSH AX         
    PUSH BX         
    PUSH CX         

print_line:
    ;输出左侧数
    MOV AX,CX
    CALL print_number

    ; 输出乘号
    MOV DL, '*'
    MOV AH, 02H
    INT 21H

    ; 输出右侧数
    MOV AX, BX
    CALL print_number

    ; 输出等号
    MOV DL, '='
    MOV AH, 02H
    INT 21H

    ; 计算乘积
    MOV AX, CX
    MUL BX         
    

    CALL print_number
    
    MOV DL,' '
    MOV AH,02H
    INT 21H

    INC BX

    CMP BX,CX
    JLE print_line
    
    ; 恢复
    POP CX
    POP BX
    POP AX
    ret
print_mul endp

; 输出AX中数字的子程序
print_number proc
    PUSH CX
    PUSH BX

    XOR CX, CX          
    MOV BX, 10          

convert_loop:
    XOR DX, DX          
    DIV BX               
    PUSH DX              

    INC CX               
    TEST AX, AX
    JNZ convert_loop   

print_loop:
    POP DX               
    ADD DL, '0'          
    MOV AH, 02H
    INT 21H              
    LOOP print_loop      

    POP BX
    POP CX
    ret
print_number endp

end main
