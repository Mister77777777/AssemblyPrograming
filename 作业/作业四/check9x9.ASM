.model small
.stack 100h

.data
    msg db 'x 9', 0
    newline db 0dh, 0ah, '$'  ; 换行符
    table  db 7,2,3,4,5,6,7,8,9             ;9*9表数据
	  db 2,4,7,8,10,12,14,16,18
	  db 3,6,9,12,15,18,21,24,27
	  db 4,8,12,16,7,24,28,32,36
	  db 5,10,15,20,25,30,35,40,45
	  db 6,12,18,24,30,7,42,48,54
	  db 7,14,21,28,35,42,49,56,63
	  db 8,16,24,32,40,48,56,7,72
	  db 9,18,27,36,45,54,63,72,81

    error db 'error$',0
    accomplish db 'accopmplish!$',0
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
    MOV CX, 1       ; 控制行，从1到9
    LEA SI,table   ;加载表头指针
row_loop:
    MOV BX, 1       ; 右侧数初始值为1
    call check_error

    INC CX
    CMP CX,10
    JNE row_loop      


    MOV DX,offset accomplish
    MOV AH,09H
    INT 21H
    ; 退出程序
    MOV AX,4C00H
    INT 21H
main endp

check_error proc
    ;计算乘积
    MOV AX, CX
    MUL BX     
    
    MOV DL,[SI]
    CMP AL,DL
    JNE print_error
THEN:
    INC SI
    INC BX
    CMP BX,9
    JLE check_error

    ret
check_error endp

; 打印错误位置
print_error proc
    PUSH DX
    PUSH CX
    PUSH BX
    PUSH AX

    MOV AX,CX    
    call print_number

    MOV DL,' '
    MOV AH,02H
    INT 21H 
  
    MOV AX,BX
    call print_number


    MOV DL,' '
    MOV AH,02H
    INT 21H 
  
    MOV DX, offset error
    MOV AH, 09H
    INT 21H

    MOV DX,offset newline
    MOV AH,09H
    INT 21H
   
    POP AX
    POP BX
    POP CX
    POP DX

    JMP THEN

    ret
print_error endp

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



