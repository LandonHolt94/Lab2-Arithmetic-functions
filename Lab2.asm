.ORIG x3000         ; Starting address of the program

        LDI R0, X           ; Load the first input into R0
        LDI R1, Y           ; Load the second input into R1

        ; Calculate X - Y
        NOT R3, R1          ; Negate Y and store the result in R3
        ADD R3, R3, #1      ; Add 1 to R3 to get -Y
        ADD R3, R0, R3      ; Add X to -Y to get X - Y
        STI R3, X_Y         ; Store the result in memory at X_Y

        ; Calculate the absolute value of X
        ADD R2, R0, #0      ; Load X into R2
        BRzp abs1           ; If X is positive or zero, skip the next instruction
        NOT R2, R2          ; Negate X to get |X|
        ADD R2, R2, #1      ; Add 1 to |X| to get the absolute value of X
abs1    STI R2, absx        ; Store the result in memory at absx

        ; Calculate the absolute value of Y
        ADD R4, R1, #0      ; Load Y into R4
        BRzp abs2           ; If Y is positive or zero, skip the next instruction
        NOT R4, R4          ; Negate Y to get |Y|
        ADD R4, R4, #1      ; Add 1 to |Y| to get the absolute value of Y
abs2    STI R4, absy        ; Store the result in memory at absy

        ; Calculate |X| - |Y|
        NOT R4, R4          ; Negate |Y| to get -|Y|
        ADD R4, R4, #1      ; Add 1 to -|Y| to get |-Y|
        ADD R4, R3, R4      ; Add X - Y to |-Y| to get |X| - |Y|
        BRn neg             ; If the result is negative, jump to neg
        BRz zero            ; If the result is zero, jump to zero
neg     AND R5, R5, #0      ; If the result is negative, set the result to 2
        ADD R5, R5, #2
        STI R5, z           ; Store the result in memory at z
        BR done             ; Jump to the end of the program
zero    AND R5, R5, #0      ; If the result is zero, set the result to 0
        ADD R5, R5, #0
        STI R5, z           ; Store the result in memory at z

done    HALT                ; Halt the program

X       .FILL x3120        ; Memory location of the first input
Y       .FILL x3121        ; Memory location of the second input
X_Y     .FILL x3122        ; Memory location to store X - Y
absx    .FILL x3123        ; Memory location to store |X|
absy    .FILL x3124        ; Memory location to store |Y|
z       .FILL x3125        ; Memory location to store |X| - |
        .END
        
        .ORIG x3120
        .FILL #36
        .FILL #-36
        .END
