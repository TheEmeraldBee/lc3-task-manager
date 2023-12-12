; Save Tasks Subroutine
; By Brighton Cox
; Since you can't actually save or handle disk with lc-3

.orig x4900
save_task

    ST R7 SaveR7

    LD R0 cls
    JSRR R0

    AND R6 R6 #0

    task_loop

        ADD R1 R6 #0

        LD R0 get_task ; Get the task at that index
        JSRR R0

        LD R0 has_task
        JSRR R0
        
        ADD R0 R0 #0
        BRz no_task

        LEA R0 start_text
        PUTs

        ADD R0 R1 #0
        LD R2 printn
        JSRR R2
        ST R1 TempLoc
        
        AND R3 R3 #0

        print_loop
            LEA R0 value
            PUTs

            ADD R5 R1 R3 ; Get the deletion location and store it in R5

            LDR R0 R5 #0
            BRz print_zero
            BR print_number

            print_zero

            LEA R0 zero_text
            PUTs

            BR end_print

            print_number
            LD R2 printn
            JSRR R2

            end_print

            ADD R3 R3 #1

            LD R0 task_size

            ADD R4 R3 R0

            BRp end_print_loop

            BR print_loop

        end_print_loop

        LEA R0 end_text
        PUTs

        ADD R6 R6 #1

        LD R0 max_tasks
        ADD R0 R0 R6
        BRp end_task_loop

        LEA R0 copy_text
        PUTs

        GETC ; Wait for user input so they can copy the task
        BR task_loop

        no_task

        ADD R6 R6 #1

        LD R0 max_tasks
        ADD R0 R0 R6
        BRp end_task_loop
        BR task_loop

    end_task_loop

    LD R7 SaveR7

    RET

SaveR7 .fill #0
TempLoc .fill #0
TaskAddress .fill #0

; Task Subroutines
get_task .fill x3400
has_task .fill x3450
task_size .fill x-300

start_text .stringz "\n.orig #"
end_text .stringz "\n.end"
value .stringz "\n   .fill #"

copy_text .stringz "\n\n\nPlease copy the given code into a file, then press any key for the next line."

start_loc .fill x5000
max_tasks .fill #-14

; Util Subroutines
newline .fill x3530
cls .fill x3540
printn .fill x4600

zero_text .stringz "0"

.end