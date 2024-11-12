.model small
.stack 100h

.code
    public divide_dd,print_number
    extern print_color:near
main proc
    MOV AX, 4C00H
    INT 21H
main endp


divide_dd proc
    ; 显示数字的过程，将寄存器中的数字转换为ASCII并输出
    PUSH BX                       ; 保存寄存器值
    PUSH AX


    MOV AX, DX                    ; 高字部分移入AX
    MOV DX, 0
    DIV CX                        ; 计算高字部分除以CX
    POP BX
    PUSH AX                       ; 保存高字商
    MOV AX, BX                    ; 低字部分移入AX
    DIV CX                        ; 计算低字部分除以CX
    MOV CX, DX                    ; 保存低字余数


    POP DX                        ; 恢复原DX
    POP BX
    RET                           ; 返回

divide_dd endp

print_number PROC
    PUSH CX                       ; 保存寄存器值
    PUSH BX
    PUSH SI
    PUSH DI
    MOV DI, 10                    ; 用于计算数字的除数
    MOV SI, 0                     ; 存储转换后数字的长度

convert_loop:
    MOV CX, 10                    
    CALL divide_dd        
    PUSH CX                       
    INC SI                        
    CMP AX, 0
    JNZ convert_loop   
    CMP DX, 0
    JNZ convert_loop    
    MOV BX, DI
    SUB BX, SI                    ; 计算数字前需要填充的空格数量

print_loop:
    POP DX                       
    ADD DL, '0'   
    call print_color
    DEC SI                        
    JNZ print_loop       ; 如果还有数字，继续显示

print_space:
    CMP BX, 0                     ; 判断是否需要显示空格
    JLE print_end
    MOV DL, ' '                   
    MOV AH, 02H                   
    INT 21H
    DEC BX                        
    JMP print_space       ; 循环显示空格

print_end:
    POP DI                        ; 恢复寄存器值
    POP SI
    POP BX
    POP CX
    RET                           

print_number ENDP



END main