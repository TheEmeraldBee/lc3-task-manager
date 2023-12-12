;   Delete Task Subroutine
;   By Brighton Cox
;   The main subroutine to allow deletion of tasks
;   Only reason it is a subroutine is to clear out main.asm

.orig x4700
delete_task
    ST R7 SaveR7

    LD R0 cls ; Clear the screen
    JSRR R0

    LEA R0 deletion_input_text ; Print the input text
    PUTs

    LD R0 anyint
    JSRR R0

    ADD R1 R0 #-1 ; Clone Result of anyint into R1

    LD R0 get_task ; Get the task at that index
    JSRR R0
    
    LD R3 task_size
    ADD R3 R3 #-1

    deletion_loop
        ADD R5 R1 R3 ; Get the deletion location and store it in R5

        AND R0 R0 #0
        STR R0 R5 #0

        ADD R3 R3 #-1
        BRn end_deletion_loop

        BR deletion_loop

    end_deletion_loop

    LD R7 SaveR7
    RET

SaveR7 .fill #0

cls .fill x3540

deletion_input_text .stringz "Input the 2 digit value of the task you want to delete: "

get_task .fill x3400
anyint .fill x4300

max_tasks .fill #-50
task_size .fill x300 ; Offset between each task
.end