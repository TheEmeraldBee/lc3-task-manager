.orig x3300

; Gets a string input from the user. Works with backspace
; Subroutine ends when the return key is pressed
; R1 is address for storage
; R2 is max length
strin
    ST R0 SaveR0
    ST R1 SaveR1
    ST R2 SaveR2
    ST R3 SaveR3
    ST R4 SaveR4
    ST R5 SaveR5
    ST R6 SaveR6
    ST R7 SaveR7

    ADD R3 R1 #0 ; Clone R1 to R3
    input_loop
    
        LD R5 exit_condition
        GETC

        ; Check if enter was pressed

        NOT R4 R5
        ADD R4 R4 #1
        ADD R4 R4 R0
        
        BRz output_loop

        ; Check if backspace or delete was pressed (Different depending)

        ADD R4 R0 x-8 

        BRz backspace

        LD R4 delete
        ADD R4 R0 R4

        BRz backspace
        
        BR not_backspace
        
        backspace
            ADD R2 R2 #1
            ADD R3 R3 #-1
            
            NOT R6 R1
            ADD R6 R6 #1
            
            ADD R6 R6 R3
            
            BRn backspace_fail
            BR end_backspace_fail
            backspace_fail
                ADD R2 R2 #-1
                ADD R3 R3 #1
                BR end_backspace
            end_backspace_fail
        
            AND R0 R0 #0
            STR R0 R3 #0

            AND R0 R0 #0
            ADD R0 R0 x8

            LD R0 backspace_char
            OUT
            LD R0 space
            OUT
            LD R0 backspace_char
            
            BR end_backspace
        
        not_backspace
            ADD R2 R2 #-1
            BRn no_out
        
            STR R0 R3 #0
            
            ADD R3 R3 #1 ; Increment Address Counter
            
            BR end_backspace
            
        end_backspace

        OUT
        BR finish_no_out
        
        no_out

        ADD R2 R2 #1
        
        finish_no_out
        
        BR input_loop
    
    output_loop
    
    ; Store a final Zero char in location
    LD R0 empty_char
    STR R0 R3 #0

    LD R0 SaveR0
    LD R1 SaveR1
    LD R2 SaveR2
    LD R3 SaveR3
    LD R4 SaveR4
    LD R5 SaveR5
    LD R6 SaveR6
    LD R7 SaveR7

    RET

exit_condition .fill #10
empty_char .fill x0

delete .fill x-7F

SaveR0 .fill #0
SaveR1 .fill #0
SaveR2 .fill #0
SaveR3 .fill #0
SaveR4 .fill #0
SaveR5 .fill #0
SaveR6 .fill #0
SaveR7 .fill #0

backspace_char .fill x8
space .fill x20

.end