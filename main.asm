;   Assembly Task Manager
;   By Brighton Cox
;   Enables user to create, edit, and delete tasks

.orig x3000

main_loop

    ; Clear the screen
    LD R0 cls
    JSRR R0

    ; Print out the menu text
    LEA R0 main_menu
    PUTs
    
    ; Print out the options for typing
    LEA R0 option_text
    PUTs

    ; Get Integer input from users
    LD R4 intin
    JSRR R4
    
    ADD R0 R0 #-1 ; List tasks
    BRz list_tasks
    
    ADD R0 R0 #-1   ; Loop Exit Condition
    BRz new_task
    
    ADD R0 R0 #-1   ; Loop Exit Condition
    BRz delete_task
    
    ADD R0 R0 #-1   ; Loop Exit Condition
    BRz main_break

    ADD R0 R0 #-1   ; Loop Exit Condition
    BRz save_break_loop

    BR main_loop

    list_tasks
    
    ; Clear the screen
    LD R0 cls
    JSRR R0
    
    AND R3 R3 #0
    
    ; Loop through all tasks
    list_tasks_loop

        ; Convert index to task location
        ADD R1 R3 #0
        LD R0 get_task
        JSRR R0
        
        ADD R3 R3 #1

        ; Check if we have hit max task location
        LD R5 max_tasks
        ADD R5 R3 R5
        BRzp main_loop
        
        LD R0 has_task
        JSRR R0 ; Check if task actually exists

        BRz list_tasks_loop

        ADD R0 R3 #0 ; Clone R3 to R0
        LD R5 printn
        JSRR R5 ; Print the task index

        LD R5 newline
        JSRR R5 ; Newline
        
        ADD R0 R1 #0 ; Clone R1 to R0
        PUTs ; Print task name

        ADD R6 R0 #0
        
        LD R5 newline
        JSRR R5 ; Newline

        ADD R0 R6 #0
        
        LD R2 task_name_limit
        
        ADD R0 R0 R2
        ADD R0 R0 #1
        
        PUTs ; Print task details

        ADD R6 R0 #0
        
        LD R5 newline
        JSRR R5 ; Newline

        ADD R0 R6 #0
        
        LD R2 task_description_limit
        
        ADD R0 R0 R2
        ADD R0 R0 #1
        
        PUTs ; Print task due date
        
        ADD R6 R0 #0
        
        LD R5 newline
        JSRR R5 ; Newline
        JSRR R5 ; Newline

        ADD R0 R6 #0
        
        BR list_tasks_loop

    new_task
        ; Run new task subroutine to prompt user for new task input.
        LD R0 new_task_func
        JSRR R0

        BR main_loop

    delete_task
        LD R0 delete_task_func
        JSRR R0
        BR main_loop

save_break_loop
LD R0 save_task
JSRR R0

main_break

HALT

; Input Subroutines
intin .fill x3200
strin .fill x3300

; Task Subroutines
get_task .fill x3400
has_task .fill x3450

new_task_func .fill x4000
delete_task_func .fill x4700

save_task .fill x4900

; Util Subroutines
newline .fill x3530
cls .fill x3540
printn .fill x4600

main_menu .stringz "Action List:\n  1) List Tasks\n  2) New Task\n  3) Delete Task\n  4) Quit\n  5) Save and Quit\n"
option_text .stringz "\nInput Number Of Option: "
task_name_limit .fill x30 ; Max characters for name
task_description_limit .fill x100 ; Max characters for description
task_due_limit .fill x10 ; Max Characters for due date

max_tasks .fill #-15
task_size .fill x300 ; Offset between each task

.end