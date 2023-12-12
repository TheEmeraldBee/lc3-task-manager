; Integer Input Module
; By Brighton Cox
; Allows input for both single integers, and 2 digit integers

.orig x3200

; Gets a number input from the user
; Returns number to R0
; Handles errors automatically
intin
    GETC
    OUT
    
    ADD R5 R7 #0 ; Store jump location
    JSR char_int
    ADD R7 R5 #0 ; Restore jump location
    
    ADD R1 R1 #0 ; Make R1 last edited value
    
    BRp return
    
    LEA R0 invalid_option_text
    PUTs ; Anounce to user that input was incorrect
    
    BR intin
    return
    LD R1 ascii_offset
    ADD R0 R0 R1 ; Convert R0 into number value
    RET

; Converts an ascii character to a number, and ensures it is a number
; R0 is the input character
; R1 returns as the fail code (1 if fail, 0 if success)
char_int
    LD R1 ascii_offset  ; Load Ascii Offsets
    LD R2 ascii_max
    
    ADD R3 R0 R1 ; MIN
    BRn fail
    ADD R3 R0 R2 ; MAX
    BRp fail
    
    BR succeed
    
    fail
    AND R1 R1 #0
    BR finish
    
    succeed
    AND R1 R1 #0
    ADD R1 R1 #1
    BR finish
    
    finish
    RET

invalid_option_text .stringz "\nInvalid input, try again: "

ascii_offset .fill x-30
ascii_max .fill x-39

.end

.orig x4300
; Gets a 2 digit input from user
; Tens then Ones
; Returns value in R0
anyint
    ST R7 return_save_address

    ; Get 10s input
    LD R5 intinput
    JSRR R5

    LD R2 num_10
    ADD R1 R0 #0

    ; Load mult address
    LD R0 mult
    JSRR R0

    ADD R4 R1 #0

    ; Get 1s input
    LD R5 intinput
    JSRR R5

    ADD R4 R4 R0

    ADD R0 R4 #0

    LD R7 return_save_address
    RET

num_10 .fill #10

; Subroutines
intinput .fill x3200
mult .fill x3500

; Address where R7 (Return address) is saved
return_save_address .fill x4100
.end