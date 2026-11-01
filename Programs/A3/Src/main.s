;************************************************
;* Beginn der globalen Daten
;************************************************
        AREA MyData, DATA, align = 2

; Basisadresse des Datenbereichs
Base

; Offset 0:
; DCW reserviert 2 Byte und speichert den Wert 0x1234.
; Little Endian: Das niederwertige Byte 0x34 liegt zuerst im Speicher.
VariableA          DCW 0x1234

; Offset 2:
; DCW reserviert weitere 2 Byte für den Wert 0x4711.
; Little Endian: Im Speicher stehen die Bytes 0x11 0x47.
VariableB          DCW 0x4711

; Offset 4:
; DCD reserviert 4 Byte und initialisiert sie mit 0.
VariableC          DCD 0

; Offset 8:
; DCW speichert sechs Halbwortwerte (je 2 Byte).
; Negative Werte werden im Zweierkomplement dargestellt.
; Die Werte werden hintereinander im Speicher abgelegt.
MeinHalbwortFeld   DCW 0x22, 0x3e, -52, 78, 0x27, 0x45

; Offset 20:
; DCD speichert sechs 32-Bit-Werte (je 4 Byte).
; Jeder Wert belegt vier aufeinanderfolgende Speicherbytes.
MeinWortFeld       DCD 0x12345678, 0x9dca5986
                   DCD -872415232, 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

; Offset 44:
; DCB speichert jedes ASCII-Zeichen in einem Byte.
; Die abschließende 0 ist das Nullterminierungszeichen.
MeinTextFeld       DCB "ABab0123",0

; Die EXPORT-Anweisungen machen die Variablen und Felder
; für andere Programmteile bzw. Module sichtbar.
                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld


;***********************************************
;* Beginn des Programms
;***********************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3

; main wird als Einstiegspunkt des Hauptprogramms exportiert.
                EXPORT main
                EXTERN initITSboard

main            PROC

                ; Ruft die Hardware-Initialisierung auf.
                ; BL speichert die Rücksprungadresse im Link Register (LR).
                bl    initITSboard

;-----------------------------------------------
; Laden von Konstanten in Register
;-----------------------------------------------

                ; Anw-01:
                ; MOV kopiert den unmittelbaren Wert 0x12 in Register R0.
                mov   r0,#0x12

                ; Anw-02:
                ; MOV lädt den Wert -128 in R1.
                ; Bei 32-Bit-Darstellung entspricht dies 0xFFFFFF80.
                ; Die konkrete Maschinenbefehlsdarstellung kann im Disassembly
                ; beispielsweise als MVN erscheinen.
                mov   r1,#-128

                ; Anw-03:
                ; LDR mit = ist eine Pseudoinstruktion.
                ; Der Assembler entscheidet, wie die Konstante geladen wird.
                ; Möglich ist ein Zugriff auf einen Literal Pool.
                ; Die tatsächlichen Befehle sieht man im Disassembly View.
                ; Der Wert 0x12345678 wird in R2 geladen.
                ldr   r2,=0x12345678

;-----------------------------------------------
; Zugriff auf einzelne Variablen
;-----------------------------------------------

                ; Anw-04:
                ; Lädt die Speicheradresse von VariableA in R0.
                ; Es wird noch nicht der Inhalt der Variable geladen.
                ldr   r0,=VariableA

                ; Anw-05:
                ; Liest 2 Byte (ein Halbwort) ab der Adresse in R0.
                ; Der gelesene Wert wird in R1 gespeichert.
                ; LDRH erweitert den 16-Bit-Wert mit Nullen auf 32 Bit.
                ldrh  r1,[r0]

                ; Anw-06:
                ; Liest 4 Byte (ein Wort) ab der Adresse in R0.
                ; Dadurch werden VariableA und VariableB gemeinsam gelesen.
                ; Wegen Little Endian enthält R2 den Wert 0x47111234.
                ldr   r2,[r0]

                ; Anw-07:
                ; Speichert den 32-Bit-Inhalt von R2 an der Adresse R0 + 4.
                ; Dadurch wird VariableC mit 0x47111234 überschrieben.
                str   r2,[r0,#VariableC-VariableA]

;-----------------------------------------------
; Zugriff auf Halbwortfelder
;-----------------------------------------------

                ; Anw-08:
                ; Lädt die Anfangsadresse von MeinHalbwortFeld in R0.
                ldr   r0,=MeinHalbwortFeld

                ; Anw-09:
                ; Liest das erste Halbwort (Offset 0) aus dem Speicher.
                ; R1 erhält den Wert 0x00000022.
                ldrh  r1,[r0]

                ; Anw-10:
                ; Liest das zweite Halbwort bei Offset 2.
                ; R2 erhält den Wert 0x0000003E.
                ldrh  r2,[r0,#2]

                ; Anw-11:
                ; MOV lädt den unmittelbaren Wert 10 in R3.
                ; R3 wird anschließend als Byte-Offset verwendet.
                mov   r3,#10

                ; Anw-12:
                ; Liest ein Halbwort an der Adresse R0 + R3.
                ; Bei Offset 10 befindet sich das sechste Element.
                ; R4 erhält den Wert 0x00000045.
                ldrh  r4,[r0,r3]

                ; Anw-13:
                ; Pre-Indexed mit Writeback:
                ; Zuerst wird R0 um 2 erhöht.
                ; Anschließend wird das Halbwort an der neuen Adresse geladen.
                ; R5 erhält 0x0000003E.
                ldrh  r5,[r0,#2]!

                ; Anw-14:
                ; R0 wird erneut um 2 erhöht.
                ; Danach wird das Halbwort an der neuen Adresse geladen.
                ; R6 erhält 0x0000FFCC.
                ; LDRH führt eine Nullerweiterung durch.
                ldrh  r6,[r0,#2]!

                ; Anw-15:
                ; Pre-Indexed mit Writeback:
                ; R0 wird zunächst um 2 erhöht.
                ; Anschließend werden die unteren 16 Bit von R6
                ; an der neuen Speicheradresse abgelegt.
                ; Dadurch wird der bisherige Wert 78 (0x004E) überschrieben.
                strh  r6,[r0,#2]!

;-----------------------------------------------
; Addition und Subtraktion
;-----------------------------------------------

                ; Anw-16:
                ; Lädt die Anfangsadresse von MeinWortFeld in R0.
                ldr   r0,=MeinWortFeld

                ; Anw-17:
                ; Liest das erste 32-Bit-Wort bei Offset 0.
                ; R1 erhält 0x12345678.
                ldr   r1,[r0]

                ; Anw-18:
                ; Liest das zweite 32-Bit-Wort bei Offset 4.
                ; R2 erhält 0x9DCA5986.
                ldr   r2,[r0,#4]

                ; Anw-19:
                ; Addiert R1 und R2 und speichert das Ergebnis in R3.
                ; ADDS aktualisiert zusätzlich die Statusflags.
                ; Ergebnis: R3 = 0xAFFEAFFE.
                ; N=1: Ergebnis ist im 32-Bit-Sinne negativ.
                ; Z=0: Ergebnis ist nicht null.
                ; C=0: Kein Carry aus dem höchstwertigen Bit.
                ; V=0: Kein vorzeichenbehafteter Überlauf.
                adds  r3,r1,r2

                ; Anw-20:
                ; Liest das dritte 32-Bit-Wort bei Offset 8.
                ; R4 erhält 0xCC000000.
                ldr   r4,[r0,#8]

                ; Anw-21:
                ; Liest das vierte 32-Bit-Wort bei Offset 12.
                ; R5 erhält 0x4E000000.
                ldr   r5,[r0,#12]

                ; Anw-22:
                ; Subtrahiert R5 von R4 und speichert das Ergebnis in R6.
                ; SUBS aktualisiert zusätzlich die Statusflags.
                ; Ergebnis: R6 = 0x7E000000.
                ; N=0: Höchstwertiges Bit ist 0.
                ; Z=0: Ergebnis ist nicht null.
                ; C=1: Kein Borrow (Ausleihen).
                ; V=1: Vorzeichenbehafteter Überlauf.
                subs  r6,r4,r5

                ; Anw-23:
                ; Liest das fünfte 32-Bit-Wort bei Offset 16.
                ; R7 erhält 0x27000000.
                ldr   r7,[r0,#16]

                ; Anw-24:
                ; Liest das sechste 32-Bit-Wort bei Offset 20.
                ; R8 erhält 0x45000000.
                ldr   r8,[r0,#20]

                ; Anw-25:
                ; Subtrahiert R8 von R7 und speichert das Ergebnis in R9.
                ; SUBS aktualisiert zusätzlich die Statusflags.
                ; Ergebnis: R9 = 0xE2000000.
                ; N=1: Höchstwertiges Bit ist 1.
                ; Z=0: Ergebnis ist nicht null.
                ; C=0: Borrow (Ausleihen) ist aufgetreten.
                ; V=0: Kein vorzeichenbehafteter Überlauf.
                subs  r9,r7,r8

;-----------------------------------------------
; Programmende
;-----------------------------------------------

                ; Anw-26:
                ; Unbedingter Sprung zur eigenen Adresse.
                ; Dadurch entsteht eine Endlosschleife.
                ; Das Programm bleibt an dieser Stelle stehen.
forever         b     forever

                ENDP
                END