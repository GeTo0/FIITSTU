newline macro
    ;Macro for printing new line
    mov dl, 13         ; Carriage return
    mov ah, 02h        ; Function code for character output
    int 21h            ; Call interrupt to output the character

    mov dl, 10         ; Line feed
    mov ah, 02h        ; Function code for character output
    int 21h            ; Call interrupt to output the character
    xor dx, dx
    xor ax, ax
endm

counterzero macro
    ;Macro for setting line counters to zero
    mov lineLowerCount, 0
    mov totalLowerCount, 0

    mov lineUpperCount, 0
    mov totalUpperCount, 0

    mov lineDigitCount, 0
    mov totalDigitCount, 0

    mov lineOtherCount, 0
    mov totalOtherCount, 0
endm

addtototal macro data_segment
    ;macro to add line counts to total line counts and reset them
    mov ax, data_segment
    mov ds, ax          ; Set data segment
    xor ax, ax
    mov al, lineLowerCount
    add totalLowerCount, al

    xor ax, ax
    mov al, lineUpperCount
    add totalUpperCount, al

    xor ax, ax
    mov al, lineDigitCount
    add totalDigitCount, al

    xor ax, ax
    mov al, lineOtherCount
    add totalOtherCount, al

    mov lineLowerCount, 0
    mov lineUpperCount, 0
    mov lineDigitCount, 0
    mov lineOtherCount, 0
    xor ax, ax
endm

xorall macro
    ;macro to xor more registers at once
    xor ax, ax
    xor cx, cx
    xor dx, dx
endm

datedot macro
    ;macro to put dot in date (12.3.2024)
    mov ah, 02h
    mov dl, "."
    int 21h
endm