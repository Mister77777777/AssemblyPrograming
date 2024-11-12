.model small
.stack 100h

.code
PUBLIC print_color,print_gap,newline,clear_screen
main proc
    MOV AX, 4C00H
    INT 21H
main endp
print_color proc
    push cx
    push bx
    mov cx,1
    MOV AH, 09h           
    MOV BL, 04h        ; 设置颜色属性：BL 的低 4 位是前景色，4 为红色；高 4 位是背景色，0 为黑色
    INT 10h  
    MOV AH, 02H                  
    INT 21H
    pop bx               
    pop cx
    ret
print_color endp

print_gap proc
    ;打印数据间隔
    PUSH DX                       ; 保存寄存器值
    PUSH CX
    PUSH AX
    MOV DL, ' '                   ; 空格字符
    MOV AH, 02H                   ; 调用DOS中断显示字符
    MOV CX,8
gap:
    INT 21H
    LOOP gap  
    POP AX                        ; 恢复寄存器值
    POP CX
    POP DX
    RET                           ; 返回

print_gap endp

; 显示换行符的过程
newline proc 
    ; 打印新一行
    PUSH DX                       ; 保存寄存器值
    PUSH AX
    MOV DL, 13                    ; 回车符
    MOV AH, 02H                   ; 调用DOS中断显示回车
    INT 21H
    MOV DL, 10                    ; 换行符
    MOV AH, 02H                   ; 调用DOS中断显示换行
    INT 21H
    POP AX                        ; 恢复寄存器值
    POP DX
    RET                           ; 返回

newline endp

clear_screen proc
;   清屏
    mov ax,0600h                                  ;向上滚行清窗口
    mov bh,0                                        ;
    mov cx,0000                                       ;窗口左上角
    mov dx,184fh                                      ;窗口右下角
    int 10h
    mov ax,1301h
    ret
clear_screen endp


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
end main
