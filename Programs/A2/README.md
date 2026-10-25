# Aufgabe 2 – Erklärung der Assembler-Befehle

## Anw01 – Adresse laden
```asm
LDR R0, =VariableA
```
Mit diesem Befehl laden wir die Adresse von `VariableA` in das Register R0. Wir laden nicht den Wert der Variable, sondern ihre Adresse.

## Anw02 – Erstes Byte lesen
```asm
LDRB R2, [R0]
```
Wir lesen ein Byte von der Speicheradresse, die in R0 steht, und speichern es in R2. Wegen Little Endian ist das erste Byte `0xEF`.

Ergebnis: `R2 = 0x000000EF`

## Anw03 – Zweites Byte lesen
```asm
LDRB R3, [R0, #1]
```
Wir lesen ein Byte von der Adresse in R0 plus 1 Byte und speichern es in R3.

Ergebnis: `R3 = 0x000000BE`

## Anw04 – Bits nach links verschieben
```asm
LSL R2, #8
```
Wir verschieben den Wert in R2 um 8 Bits nach links. Das entspricht einem Byte.

Ergebnis: `R2 = 0x0000EF00`

## Anw05 – Bitweise ODER-Verknüpfung
```asm
ORR R2, R3
```
Wir verknüpfen die Bits von R2 und R3 mit einer bitweisen ODER-Operation. Das Ergebnis wird in R2 gespeichert.

Ergebnis: `R2 = 0x0000EFBE`

## Anw06 – Halfword in den Speicher schreiben
```asm
STRH R2, [R0]
```
Wir schreiben die unteren 16 Bit von R2 als Halfword (2 Byte) in den Speicher an der Adresse in R0. Wegen Little Endian steht das Byte `0xBE` zuerst und danach `0xEF`.

Speicher nach Anw06: `BE EF`

## Anw07 – Konstante laden
```asm
MOV R5, #ConstByteA
```
Wir laden den Wert der Konstante `ConstByteA` in das Register R5.

