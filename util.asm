.orig x3500

SaveR0 .fill #0

; Multiplies the Data in R1 and R2, returning the result in R1
mult

    ADD R3 R1 #0
    AND R1 R1 #0
    
    ADD R3 R3 #0
    BRz mult_return
    
    ADD R2 R2 #0
    BRz mult_return
    
    mult_loop
    
        ADD R1 R1 R3 ; Increment result
        
        ADD R2 R2 #-1
        
        BRz mult_return
        BR mult_loop
    
    mult_return
    RET
.end

.orig x3530
newline

    LEA R0 newline_text
    PUTs

    RET
.end

.orig x3540
cls
    ST R0 SaveR0
    LEA R0 newline_text
    PUTs
    PUTs
    PUTs
    PUTs
    PUTs
    PUTs
    PUTs
    PUTs
    PUTs
    LD R0 SaveR0
    RET

newline_text .stringz "\n"
.end