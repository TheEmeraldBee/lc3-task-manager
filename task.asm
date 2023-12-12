.orig x3400
; Load task at IDX R1, returning the address in R1
get_task
    ; Save Registers
    ST R0 SaveR0
    ST R2 SaveR2
    ST R3 SaveR3
    ST R4 SaveR4
    ST R5 SaveR5
    ST R6 SaveR6
    ST R7 SaveR7

    LD R4 task_addr ; Load task start addr into R4
    
    LD R2 task_size ; Load task size in memory into R2
    
    LD R6 mult
    JSRR R6 ; Mult R1 (The task idx) and R2 (The task size)
    
    ADD R1 R4 R1 ; Add The address and store in R1

    ; Reload Registers
    LD R0 SaveR0
    LD R2 SaveR2
    LD R3 SaveR3
    LD R4 SaveR4
    LD R5 SaveR5
    LD R6 SaveR6
    LD R7 SaveR7
    
    RET

SaveR0 .fill #0
SaveR2 .fill #0
SaveR3 .fill #0
SaveR4 .fill #0
SaveR5 .fill #0
SaveR6 .fill #0
SaveR7 .fill #0
    
.end

.orig x3450

; Checks if task exists at a given address
; R0 is 0 if task doesn't exist at that location
; R0 is 1 if task does exist at that location
has_task
    LDR R0 R1 #0
    BRz no_task
    BR task
    
    no_task
    AND R0 R0 #0
    RET
    
    task
    AND R0 R0 #0
    ADD R0 R0 #1
    
    RET

.end

.orig x3490
task_size .fill x300 ; Offset between each task
task_addr .fill x5000 ; The address where tasks are stored
mult .fill x3500
max_task .fill #15 ; The max number of tasks you can have.
.end