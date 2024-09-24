; DATA SEGMENT
;     MYWORD DB "HELLO WORLD!$"
; DATA ENDS

; CODE SEGMENT
;     ASSUME CS:CODE,DS:DATA
; start:
;     MOV AX,DATA
;     MOV DS,AX
;     LEA DX,MYWORD
;     MOV AH,09h
;     INT 21h
;     MOV AX,4c00h
;     INT 21h
; CODE ENDS

; ; END start
; STKSEG SEGMENT STACK
;   DW 32 DUP(0)
; STKSEG ENDS

; DATASEG SEGMENT
;     MSG DB"HELLO WORLD!$"
; DATASEG ENDS

; CODESEG SEGMENT
;     ASSUME CS:CODESEG, DS:DATASEG,SS:STKSEG
; MAIN PROC FAR
;   MOV AX,DATASEG
;   MOV DS,AX
;   ; MOV DS,DATASEG DS寄存器会直接将段地址当立即数处理，而不是段寄存器的值。
;   MOV AH,9
;   MOV DX,OFFSET MSG
;   INT 21H
;   MOV AX,4C00H
;   INT 21H
; MAIN ENDP
; CODESEG ENDS
;   END MAIN
.model small
.data
Hello DB 'Hello world!',0dh,0ah,'$'
.code
START: 
MOV AX,@DATA
MOV DS,AX
; LEA DX,Hello  用LEA指令，计算字符串的地址然后将地址打到DX寄存器
; MOV DX,offset Hello  用offset伪指令来得到字符串地址，offset也是计算得到字符串地址的方式。
MOV DX,offset Hello 
MOV AH,9
INT 21H 
MOV AX,4C00H
INT 21h
END START