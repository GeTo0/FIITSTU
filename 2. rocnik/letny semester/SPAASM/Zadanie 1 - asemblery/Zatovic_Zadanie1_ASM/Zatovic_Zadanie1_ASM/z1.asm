.model small
.stack 100h
include macros.asm

;Made by Dominik Zaťovič
;This program counts each type of characters (lower case, upper case, digits, other characters)
;in each line separately and total in whole file.

;USAGE
;To run this program, you need to use terminal.
;This program also takes arguments, such as name of file to read from and if wanted, available switches
;Available switches are "-h" and "-p"

;The program is started by command: <*name_of_program> <switch> <*file_to_read_from>
;(*) means its neccessary to enter in order to run the program

;EXAMPLE of USAGE:
;z1 input.txt -> standard run of program
;z1 -h input.txt / z1 -h -> print help message
;z1 -p input.txt -> program with paginating enabled

;Any incorrect usage will result in terminating the program

;PAGINATING
;If you put switch "-p", the paginating will be enabled
;After starting the program, you will be asked to press RIGHT ARROW KEY in order to proceed
;After that, the console screen will be cleared and output will be printed out, with current date and time and absolute path
;The output is printing the counts for each individual line, and in the end, the total count for whole file
;To proceed to next line, you need to press N again.




.data
    filename db 10 dup('$'), 0            ; Buffer to store filename
    filename_absolute db 'C:\Users\domin\Desktop\SPAASM\input.txt$ ', 0   ; Absolute path of filename
    buffer db 101 dup('$')                 ; Buffer to read file contents
    file_error_msg db "Error opening file.", 0ah, 0dh, "$"    ; Error message for file opening
    read_error_msg db "Error reading file.", 0ah, 0dh, "$"    ; Error message for file reading

    no_args_msg db "No arguments given.", 0ah, 0dh, "$"       ; Message for no arguments given
    help_msg db "Help message: This program counts each type of characters in each line and total in whole file. Switch -p makes paging, you need to press RIGHT ARROW KEY to continue", 0ah, 0dh, "$"   ; Help message

    filename_msg db 'Opening file: $'       ; Message indicating opening file
    filegonext_msg db 'Press RIGHT ARROW KEY to continue.$'   ; Message prompting user to press right arrow key
    filehandle dw ?    ; File handle variable

    lineLower db "Lowercase: $",0           ; Message for lowercase character count per line
    totalLower db "Lowercase Total: $", 0   ; Message for total lowercase character count
    lineLowerCount db ?                     ; Variable to store current line's lowercase character count
    totalLowerCount db ?                    ; Variable to store total lowercase character count

    lineUpper db "Uppercase: $",0           ; Message for uppercase character count per line
    totalUpper db "Uppercase Total: $", 0   ; Message for total uppercase character count
    lineUpperCount db ?                     ; Variable to store current line's uppercase character count
    totalUpperCount db ?                    ; Variable to store total uppercase character count

    lineDigit db "Digits: $",0              ; Message for digit count per line
    totalDigit db "Digits Total: $", 0      ; Message for total digit count
    lineDigitCount db ?                     ; Variable to store current line's digit count
    totalDigitCount db ?                    ; Variable to store total digit count

    lineOther db "Other chars: $",0         ; Message for other character count per line
    totalOther db "Other chars Total: $", 0 ; Message for total other character count
    lineOtherCount db ?                     ; Variable to store current line's other character count
    totalOtherCount db ?                    ; Variable to store total other character count

    date_day db ?       ; Variable to store day
    date_month db ?     ; Variable to store month
    date_year dw ?      ; Variable to store year
    date_hour db ?      ; Variable to store hour
    date_min db ?       ; Variable to store minute

    start_of_program db 1       ; Indicator for the start of the program
    paginate_flag db 0          ; Flag to indicate whether pagination is enabled (0 = no, 2 = yes)

    psp_segment dw 0            ; PSP segment address

.code                    ; Code segment
main:                    ; Main program entry point
    mov bx, ds                   ; Store PSP segment address
    mov ax, seg @data            ; Load DS with data segment
    mov ds, ax
    mov psp_segment, bx          ; Store PSP segment address for later access
    mov ds, psp_segment

    mov bx, 80h                  ; Load command line length
    mov cl, [bx]                 ; Store length in CL
    test cl, cl                  ; Check if any arguments are present
    jz no_args                   ; Jump if no arguments present
    inc bx                       ; Skip space character
    jmp read_args                ; Jump to read arguments

no_args:                         ; Label for no arguments
    mov ax, seg no_args_msg      ; Load address of no_args_msg
    mov ds, ax
    xor ax, ax
    mov ah, 9                     ; Print string function
    mov dx, offset no_args_msg    ; Load address of no_args_msg
    int 21h                       ; Print message
    jmp read_file                 ; Jump to read file

find_arg:                        ; Label for finding argument
    inc bx                        ; Skip to next character after dash
    mov dl, [bx]                  ; Load character after dash
    cmp dl, 'h'                   ; Check if next char is 'h'
    je arg_h                      ; Jump if 'h'
    cmp dl, 'p'                   ; Check if next char is 'p'
    je arg_p                      ; Jump if 'p'
    jmp exit_program              ; Jump if neither 'h' nor 'p'

read_args:                       ; Label for reading arguments
    xor dx, dx                    ; Clear DX
    inc bx                        ; Skip to first character in input
    mov dl, [bx]                  ; Load character
    cmp dl, '-'                   ; Check if dash is present
    je find_arg                   ; Jump to find_arg if dash is present
    jmp arg_filename              ; Jump to arg_filename if no dash

arg_h:                           ; Label for argument 'h'
    mov ax, seg help_msg          ; Load address of help_msg
    mov ds, ax
    xor ax, ax
    mov ah, 9                     ; Print string function
    mov dx, offset help_msg       ; Load address of help_msg
    int 21h                       ; Print help message
    jmp exit_program              ; Jump to exit program

arg_p:                           ; Label for argument 'p'
    mov ax, seg paginate_flag     ; Load address of paginate_flag
    mov ds, ax
    xor ax, ax
    mov paginate_flag, 02h        ; Set paginate_flag to 2
    inc bx                        ; Increase bx to skip space character
    inc bx                        ; Go to next character (start of filename)
    jmp arg_filename              ; Jump to arg_filename

arg_filename:                    ; Label for filename argument
    mov si, bx                    ; Load SI with bx (pointer to filename)
    mov ax, seg filename          ; Load ES with filename
    mov es, ax
    mov ds, ax
    mov ax, psp_segment           ; Load base segment to access program arguments
    mov ds, ax
    mov di, offset filename       ; Load DI with offset of filename
copy_filename:                   ; Loop to copy filename
    mov dl, [si]                  ; Load character from SI to DL
    cmp dl, 0Dh                   ; Check for carriage return (end of filename)
    je read_file                  ; Jump if end of filename
    movsb                         ; Copy data from SI to DI, incrementing SI and DI
    jmp copy_filename             ; Repeat until end of filename

read_file:                       ; Label for reading file
    mov ax, seg filename          ; Load DS with filename
    mov ds, ax
    xor ax, ax                    ; Clear AX
    mov ah, 9                     ; Print message function
    mov dx, offset filename_msg   ; Load address of filename_msg
    int 21h                       ; Print "Opening file: "
    mov ah, 9                     ; Print message function
    mov dx, offset filename       ; Load address of filename
    int 21h                       ; Print filename
    newline                       ; Macro for newline
    mov ah, 9                     ; Print message function
    mov dx, offset filegonext_msg ; Load address of filegonext_msg
    int 21h                       ; Print "Press RIGHT ARROW KEY to continue."
    mov ah, 3dh                   ; Open file function
    mov dx, offset filename       ; Load address of filename
    xor cx, cx                    ; Open for reading
    int 21h                       ; Call DOS interrupt
    jc file_error                 ; Jump if error
    mov filehandle, ax            ; Store file handle
    xor ax, ax                    ; Clear AX
    counterzero                   ; Macro to initialize counters
    newline                       ; Macro for newline
    jmp decide                    ; Jump to decide

file_error:                      ; Label for file error
    newline                       ; Macro for newline
    mov ah, 9h                    ; Print string function
    mov dx, offset file_error_msg ; Load address of file_error_msg
    int 21h                       ; Print "Error opening file."
    jmp exit_program              ; Jump to exit program

end_of_file:                     ; Label for end of file
    mov di, 1                     ; Set DI to 1 (flag for end of line)
    jmp end_of_line               ; Jump to end_of_line

decide:                          ; Label for decision-making
    cmp start_of_program, 1       ; Compare start_of_program with 1
    jne read_loop                 ; Jump to read_loop if not equal
    cmp paginate_flag, 2          ; Compare paginate_flag with 2
    jne read_loop                 ; Jump to read_loop if not equal
    mov start_of_program, 0       ; Set start_of_program to 0
    jmp paginate                  ; Jump to paginate

read_loop:                       ; Label for main reading loop
    mov ah, 3fh                   ; Read from file function
    mov bx, filehandle            ; Load file handle
    mov dx, offset buffer         ; Load buffer
    mov cx, 1                     ; Number of bytes to read
    int 21h                       ; Call DOS interrupt
    cmp ax, 0                     ; Check if no bytes read
    je end_of_file                ; Jump to end_of_file if no bytes read
    mov dl, byte ptr [buffer]     ; Load byte from buffer to DL
    cmp dl, 10                    ; Check for newline character
    je end_of_line                ; Jump to end_of_line if newline character found
    cmp dl, 'a'                   ; Compare DL with 'a'
    jb notLower                   ; Jump if DL is less than 'a'
    cmp dl, 'z'                   ; Compare DL with 'z'
    ja notLower                   ; Jump if DL is greater than 'z'
    inc lineLowerCount            ; Increment count for lowercase characters for current line
    jmp read_loop                 ; Jump back to read_loop
notLower:                        ; Label for non-lowercase characters
    cmp dl, 'A'                   ; Compare DL with 'A'
    jb notUpper                   ; Jump if DL is less than 'A'
    cmp dl, 'Z'                   ; Compare DL with 'Z'
    ja notUpper                   ; Jump if DL is greater than 'Z'
    inc lineUpperCount            ; Increment count for uppercase characters for current line
    jmp read_loop                 ; Jump back to read_loop
notUpper:                        ; Label for non-uppercase characters
    cmp dl, '0'                   ; Compare DL with '0'
    jb notDigit                   ; Jump if DL is less than '0'
    cmp dl, '9'                   ; Compare DL with '9'
    ja notDigit                   ; Jump if DL is greater than '9'
    inc lineDigitCount            ; Increment count for digits for current line
    jmp read_loop                 ; Jump back to read_loop
notDigit:                        ; Label for non-digit characters
    cmp dl, 13                    ; Compare DL with carriage return
    je read_loop                  ; Jump back to read_loop if carriage return found
    cmp dl, ' '                   ; Compare DL with space character
    je read_loop                  ; Jump back to read_loop if space character found
    inc lineOtherCount            ; Increment count for other characters for current line
    jmp read_loop                 ; Jump back to read_loop

end_of_line:                     ; Label for end of line
    mov ah, 09h                   ; Print string function
    mov dx, offset lineLower      ; Load address of lineLower
    int 21h                       ; Print "Lowercase: "
    xor dx, dx                    ; Clear DX
    mov dl, lineLowerCount        ; Load lineLowerCount to DL
    call printDigit               ; Call printDigit to print count
    xor ax, ax                    ; Clear AX
    newline                       ; Macro for newline

    mov ah, 09h                   ; Print string function
    mov dx, offset lineUpper      ; Load address of lineUpper
    int 21h                       ; Print "Uppercase: "
    xor dx, dx                    ; Clear DX
    mov dl, lineUpperCount        ; Load lineUpperCount to DL
    call printDigit               ; Call printDigit to print count
    xor ax, ax                    ; Clear AX
    newline                       ; Macro for newline

    mov ah, 09h                   ; Print string function
    mov dx, offset lineDigit      ; Load address of lineDigit
    int 21h                       ; Print "Digits: "
    xor dx, dx                    ; Clear DX
    mov dl, lineDigitCount        ; Load lineDigitCount to DL
    call printDigit               ; Call printDigit to print count
    xor ax, ax                    ; Clear AX
    newline                       ; Macro for newline

    mov ah, 09h                   ; Print string function
    mov dx, offset lineOther      ; Load address of lineOther
    int 21h                       ; Print "Other chars: "
    xor dx, dx                    ; Clear DX
    mov dl, lineOtherCount        ; Load lineOtherCount to DL
    call printDigit               ; Call printDigit to print count
    xor ax, ax                    ; Clear AX
    newline                       ; Macro for newline
    newline                       ; Macro for newline

    addtototal @data              ; Add counts from current line to total
    cmp di, 1                     ; Check if end of file reached
    je testend                    ; Jump to testend if end of file
    mov bl, paginate_flag         ; Load paginate_flag to BL
    mov al, 02h                   ; Load AL with 2
    cmp al, bl                    ; Compare AL with BL
    je paginate                   ; Jump to paginate if pagination flag set
    jmp read_loop                 ; Jump back to read_loop

testend:                         ; Label for testing end of file
    cmp paginate_flag, 2         ; Compare paginate_flag with 2
    je paginate                  ; Jump to paginate if pagination flag set
    jmp file_end                 ; Jump to file_end

paginate:                        ; Label for pagination
    mov ah, 00h                  ; Read keyboard function
    int 16h                      ; Call BIOS interrupt
    cmp ah, 4Dh                  ; Compare AH with 4Dh (RIGHT ARROW KEY)
    jne paginate                 ; Jump back to paginate if not RIGHT ARROW KEY
    xor ax, ax                   ; Clear AX

    ; Clear screen and set default attributes
    mov ah, 09h                  ; Display string function
    mov al, 07h                  ; Text attribute: white text on black background
    mov bh, 00h                  ; Page number
    mov cx, 0000h                ; Character count
    mov dx, 184fh                ; Starting position of the top-left corner of the area to be scrolled
    mov dx, 0000h                ; Starting position of the top-left corner of the area to be scrolled
    int 10h                      ; Call BIOS interrupt

    mov ah, 06h                  ; Scroll window function
    mov al, 00h                  ; Clear entire screen
    mov bh, 07h                  ; Attribute (white on black)
    mov cx, 0000h                ; Upper-left corner of the screen (row/column)
    mov dx, 184fh                ; Lower-right corner of the screen (row/column)
    int 10h                      ; Call BIOS interrupt

    call print_time              ; Call procedure to print current date and time

    cmp di, 1                    ; Check if end of file reached
    je file_end                  ; Jump to file_end if end of file
    jmp read_loop                ; Jump back to read_loop

file_end:                        ; Label for end of file
    mov ah, 09h                  ; Print string function
    mov dx, offset totalLower    ; Load address of totalLower
    int 21h                      ; Print "Lowercase Total: "
    xor dx, dx                   ; Clear DX
    mov dl, totalLowerCount      ; Load totalLowerCount to DL
    call printDigit              ; Call printDigit to print count
    newline                      ; Macro for newline

    mov ah, 09h                  ; Print string function
    mov dx, offset totalUpper    ; Load address of totalUpper
    int 21h                      ; Print "Uppercase Total: "
    xor dx, dx                   ; Clear DX
    mov dl, totalUpperCount      ; Load totalUpperCount to DL
    call printDigit              ; Call printDigit to print count
    newline                      ; Macro for newline

    mov ah, 09h                  ; Print string function
    mov dx, offset totalDigit    ; Load address of totalDigit
    int 21h                      ; Print "Digits Total: "
    xor dx, dx                   ; Clear DX
    mov dl, totalDigitCount      ; Load totalDigitCount to DL
    call printDigit              ; Call printDigit to print count
    newline                      ; Macro for newline

    mov ah, 09h                  ; Print string function
    mov dx, offset totalOther    ; Load address of totalOther
    int 21h                      ; Print "Other chars Total: "
    xor dx, dx                   ; Clear DX
    mov dl, totalOtherCount      ; Load totalOtherCount to DL
    call printDigit              ; Call printDigit to print count
    newline                      ; Macro for newline
    newline                      ; Macro for newline

    jmp close_file               ; Jump to close_file

print_time proc
    ; Get current date and time
    mov ah, 2Ah                     ; Function code for getting date
    int 21h                         ; Call DOS interrupt

    mov date_day, dl                ; Store day in register dl
    mov date_month, dh              ; Store month in register dh
    mov date_year, cx               ; Store year in register cx

    xor dx, dx                      ; Clear DX
    mov dl, date_day                ; Load day into DL
    call printDigit                 ; Print the day
    datedot                         ; Macro to print "." between day, month, and year

    xor dx, dx                      ; Clear DX
    mov dl, date_month              ; Load month into DL
    call printDigit                 ; Print the month
    datedot                         ; Macro to print "." between day, month, and year

    xor dx, dx                      ; Clear DX
    mov dx, date_year               ; Load year into DX
    call printDigit                 ; Print the year

    newline                         ; Macro for newline
    newline                         ; Macro for newline
    xorall                          ; Clear all registers

    mov ah, 2Ch                     ; Function code for getting time
    int 21h                         ; Call DOS interrupt

    mov date_hour, ch               ; Store hour in CH
    mov date_min, cl                ; Store minute in CL

    xor dx, dx                      ; Clear DX
    mov dl, date_hour               ; Load hour into DL
    call printDigit                 ; Print the hour
    
    mov ah, 02h                     ; Function code for printing
    mov dl, ":"                     ; Character to divide hours and minutes
    int 21h                         ; Call DOS interrupt

    xor dx, dx                      ; Clear DX
    mov dl, date_min                ; Load minute into DL
    call printDigit                 ; Print the minute

    newline                         ; Macro for newline
    newline                         ; Macro for newline
    xorall                          ; Clear all registers

    mov ax, seg filename_absolute   ; Print absolute path message
    mov dx, offset filename_absolute; Load address of filename_absolute
    mov ah, 9                       ; Print string function
    int 21h                         ; Call DOS interrupt
    newline                         ; Macro for newline
    newline                         ; Macro for newline
   
    ret                             ; Return from procedure

print_time endp

printDigit proc 
    mov bx, 10d                     ; Load 10 into BX (to be used for division)
    mov ax, dx                      ; Load number to be divided into AX
    xor cx, cx                      ; Clear CX

printloop:
    xor dx, dx                      ; Clear DX
    div bx                          ; Divide AX by BX
    push dx                         ; Push remainder onto stack
    inc cx                          ; Increment CX for each division
    cmp ax, 0                       ; Check if AX is 0 (end of division)
    jz printend                     ; If AX is 0, jump to printend
    jmp printloop                   ; Otherwise, continue loop

printend:
    dec cx                          ; Decrement CX for each pop from stack
    pop dx                          ; Pop digit from stack into DX
    mov ah, 02h                     ; Function code for printing
    add dx, '0'                     ; Convert remainder to ASCII
    int 21h                         ; Print ASCII character
    cmp cx, 0                       ; Check if there are more digits to print
    jz printfinal                   ; If CX is 0, jump to printfinal
    jmp printend                    ; Otherwise, continue loop

printfinal:
    ret                             ; Return from procedure

printDigit endp

close_file:
    ;Function to close file
    mov ah, 3eh       
    int 21h
    jmp exit_program

exit_program:
    ;Function to terminate program
    xor ax, ax
    mov ah, 4ch
    int 21h

end main