;   New Task Subroutine
;   By Brighton Cox
;   The main subroutine to allow creation of tasks
;   Only reason it is a subroutine is to clear out main.asm

.orig x4000

; Takes input to create a new task and save it into the list
new_task
    ; Save R7 for later return jump
    LD R0 return_save_address
    STR R7 R0 #0

    ; Clear the screen
    LD R0 cls
    JSRR R0

    ; Load the max number of tasks that exist into R6
    LD R6 max_tasks

    AND R3 R3 #0

    ; Find the closest available task location
    find_idx_loop
    
        ADD R1 R3 #0
        LD R0 get_task
        JSRR R0
        
        LD R0 has_task
        JSRR R0 ; Check if task actually exists
        BRz end_find_idx_loop

        ADD R6 R6 #-1
        BRnz no_task
        
        ADD R3 R3 #1
        BR find_idx_loop
    
    end_find_idx_loop
    
    LEA R0 name_text
    PUTs
    
    LD R2 task_name_limit
    
    LD R0 strin
    JSRR R0

    LD R0 newline
    JSRR R0
    
    LD R2 task_name_limit
    
    ADD R1 R1 R2
    ADD R1 R1 #1
    
    LEA R0 description_text
    PUTs
    
    LD R2 task_description_limit
    
    LD R0 strin
    JSRR R0

    LD R0 newline
    JSRR R0
    
    LD R2 task_description_limit
    
    ADD R1 R1 R2
    ADD R1 R1 #1
    
    LEA R0 due_text
    PUTs
    
    LD R2 task_due_limit
    
    LD R0 strin
    JSRR R0

    LD R0 newline
    JSRR R0

    BR return
    no_task ; If there aren't any task slots left
    LEA R0 slots_out
    PUTs
    
    return

    ; Load Return Jump
    LD R0 return_save_address
    LDR R7 R0 #0

    RET

return_save_address .fill x4100

; Util Subroutines
newline .fill x3530
cls .fill x3540

; Task Subroutines
get_task .fill x3400
has_task .fill x3450

; Input Subroutines
intin .fill x3200
strin .fill x3300

task_name_limit .fill x30 ; Max characters for name
task_description_limit .fill x100 ; Max characters for description
task_due_limit .fill x10 ; Max Characters for due date

name_text .stringz "Input the name of the task:\n"
description_text .stringz "Input the details of the task:\n"
due_text .stringz "Input the due date of the task:\n"

slots_out .stringz "You are out of task slots, either remove one, or don't add a task.\n"

max_tasks .fill #15

.end