    EXTERN initITSboard
    EXPORT main

ConstByteA  EQU 0xAFFE

    AREA DATA, DATA, align=2
VariableA   DCW 0xBEEF
VariableB   DCW 0x1234
VariableC   DCW 0x0000

    AREA |.text|, CODE, READONLY, ALIGN=3
    ALIGN

main
    BL initITSboard

;* Anw01 bis Anw06: Bytes von VariableA vertauschen
    LDR     R0, =VariableA      ; Anw01
    LDRB    R2, [R0]            ; Anw02
    LDRB    R3, [R0, #1]        ; Anw03
    LSL     R2, #8              ; Anw04
    ORR     R2, R3              ; Anw05
    STRH    R2, [R0]            ; Anw06

;* Anw07 und Anw08: AFFE in VariableC als AF FE speichern
    MOV     R5, #ConstByteA     ; Anw07

    AND     R6, R5, #0xFF       ; FE isolieren
    LSR     R7, R5, #8          ; AF isolieren
    LSL     R6, #8              ; FE nach links verschieben
    ORR     R5, R6, R7          ; R5 = 0xFEAF

    LDR     R0, =VariableC
    STRH    R5, [R0]            ; Anw08

;* Anw09 ff.: VariableB so ändern, dass Memory 12 34 zeigt
    LDR     R1, =VariableB      ; Anw09
    LDRH    R6, [R1]            ; Anw0D
    MOV     R7, #0x21DE         ; Anw0B
    ADD     R6, R6, R7          ; Anw0C
    STRH    R6, [R1]            ; Anw0E

stop
    B       stop

    ALIGN
    END