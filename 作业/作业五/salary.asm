.model small
.stack 100h

TABLE SEGMENT
    ; 定义一个用于存储结果的表，每行21个字节
    DB 21 DUP('year summ ne ??')
TABLE ENDS
.data
    years DB '1975','1976','1977','1978','1979','1980','1981','1982','1983','1984','1985','1986','1987','1988','1989','1990','1991','1992','1993','1994','1995'
    ; 定义收入数组，每个收入占4字节
    incomes DD 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514,345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000
    ; 定义员工数量数组，每个数量占2字节
    employees DW 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226,11542,14430,15257,17800

.code
extern print_color:near,print_gap:near,newline:near,clear_screen:near,divide_dd:near,print_number:near
main proc 
    MOV AX,@data
    MOV DS,AX

    ; 初始化表段
    MOV AX, table
    MOV ES, AX
    MOV CX, 21                  
    MOV SI, offset years      
    MOV DI, 0                  

COPY_YEARS_LOOP:
    ; 将年份拷贝到表中
    MOVSB
    MOVSB
    MOVSB
    MOVSB
    ADD DI, 12                  ; 每次跳过12个字节（年后插入的空格）
    LOOP COPY_YEARS_LOOP

    ; 处理收入数据
    MOV CX, 21
    MOV SI, offset incomes      ; 指向收入数组
    MOV DI, 5                   ; 表中收入的起始偏移量

INPUT_INCOMES:
    ; 将收入数据拷贝到表中
    MOV AX, [SI]
    MOV DX, [SI + 2]            ; 处理双字数据
    MOV ES:[DI], AX
    MOV ES:[DI + 2], DX
    ADD DI, 16                  ; 每次跳过16个字节
    ADD SI, 4                   ; 移动到下一个收入
    LOOP INPUT_INCOMES

    ; 处理员工数据
    MOV CX, 21
    MOV SI, OFFSET employees    ; 指向员工数量数组
    MOV DI, 10                  ; 表中员工数量的起始偏移量

INPUT_EMPLOYEES:
    ; 将员工数量拷贝到表中
    MOV AX, [SI]
    MOV ES:[DI], AX
    ADD DI, 16                  ; 每次跳过16个字节
    ADD SI, 2                   ; 移动到下一个员工数量
    LOOP INPUT_EMPLOYEES

    ; 计算平均收入
    MOV CX, 21
    MOV BX, 13                  ; 偏移量
    MOV SI, offset incomes
    MOV DI, offset employees

CAL_AVERAGES:
    ;计算平均收入
    PUSH BX

    ; 取出收入数据
    MOV AX, [SI]
    MOV DX, [SI + 2]
    ADD SI, 4

    ; 取出员工数据
    MOV BX, [DI]
    ADD DI, 2

    ; 平均收入 = 收入 / 员工
    DIV BX
    POP BX
    PUSH DI

    ; 将平均收入存储到表中
    MOV DI, BX
    MOV ES:[DI], AX
    ADD DI, 16
    MOV BX, DI
    POP DI
    LOOP CAL_AVERAGES


    ; 打印表格
    MOV BX, 21
    MOV SI, 0
    MOV AX, TABLE
    MOV DS, AX

    call clear_screen
    call newline


	mov ax,0B800H
	mov es,ax			;es控制打印的屏幕
    mov si,0			;si控制字符串数据的起始位置
    mov di,0004h		;di控制颜色属性的起始位置


PRINT_TABLE:
   
    CALL print_gap            ; 打印制表符
    MOV CX, 4                   ; 打印年份的长度
PRINT_YEAR:
    MOV DL, [SI]                ; 逐个字符显示年份
    call print_color
    INC SI
    LOOP PRINT_YEAR

    ; 打印制表符
    call print_gap

    ; 打印收入
    INC SI
    MOV AX, [SI]
    ADD SI, 2
    MOV DX, [SI]
    ADD SI, 2
    call print_number
    call print_gap

    ; 打印员工数量
    INC SI
    MOV AX, [SI]
    MOV DX, 0
    ADD SI, 2
    call print_number
    call print_gap

    ; 打印平均收入
    INC SI
    MOV AX, [SI]
    MOV DX, 0
    ADD SI, 2
    call print_number
    INC SI

    ; 换行
    CALL newline
    DEC BX
    JNZ PRINT_TABLE

    ; 正常退出程序
    MOV AX, 4C00H
    INT 21H

main endp


end main



