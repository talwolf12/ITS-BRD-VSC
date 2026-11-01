# GTP – Praktikumsaufgabe Woche 3 (A3)
## Erste Betrachtungen der ARM ISA

**HAW Hamburg – Informatik Technischer Systeme**

## 1. Bisherige Arbeiten

Im Rahmen der Praktikumsaufgabe A3 wurde ein neues VS-Code-Projekt mit dem Namen `A3` erstellt.

Das vorgegebene Assemblerprogramm `main_w3.s` wurde in die Datei `main.s` übernommen.

Anschließend wurde das Projekt erfolgreich kompiliert. Das Programm enthält verschiedene ARM-Assembler-Anweisungen, mit denen Register, Speicherzugriffe, Datenfelder sowie Addition und Subtraktion untersucht werden.

Folgende Bereiche wurden bisher bearbeitet:

- A3-Projekt erstellt und eingerichtet.
- Vorgegebenes Assemblerprogramm in `main.s` eingefügt.
- Programm erfolgreich kompiliert.
- Assembler-Anweisungen untersucht und kommentiert.
- Speicheraufbau und Little-Endian-Darstellung betrachtet.
- Zugriffe auf Variablen und Datenfelder untersucht.
- Registerbelegung und Speicherzugriffe vorbereitet.

## 2. Umgang mit dem Disassembly View

Der Disassembly View wird verwendet, um die tatsächlich erzeugten Maschinenbefehle des Assemblers anzuzeigen.

Dies ist besonders wichtig bei Pseudoinstruktionen, da diese nicht immer direkt einem einzelnen Maschinenbefehl entsprechen.

### Disassembly View öffnen

1. Debugger starten.
2. Mit `Shift + Strg + P` die Command Palette öffnen.
3. Nach `GDB: Open Disassembly View` suchen.
4. Den Disassembly View öffnen.
5. Falls eine Fehlermeldung bezüglich einer ungültigen Adresse erscheint, zunächst einen Schritt im Debugger ausführen.

Nach dem ersten Debug-Schritt kennt der Disassembly View die richtige Adresse und kann die Maschinenbefehle anzeigen.

### Warum wird der Disassembly View benötigt?

Bei der Anweisung:

```asm
LDR R2, =0x12345678
```

handelt es sich um eine Pseudoinstruktion.

Der Assembler entscheidet, wie die Konstante geladen wird. Deshalb kann man im Disassembly View sehen, welche tatsächlichen Maschinenbefehle daraus erzeugt wurden.

## 3. Literal Pool

Ein Literal Pool ist ein Speicherbereich, in dem der Assembler Konstanten ablegen kann, die nicht direkt als unmittelbarer Wert in einer Maschineninstruktion codiert werden können.

Beispiel:

```asm
LDR R2, =0x12345678
```

Das Gleichheitszeichen zeigt, dass es sich um eine Pseudoinstruktion handelt.

Der Assembler kann die Konstante `0x12345678` im Literal Pool ablegen und anschließend über einen PC-relativen Zugriff in R2 laden.

Wichtig ist der Unterschied:

```asm
LDR R0, =VariableA
```

Lädt die Adresse von `VariableA` in R0.

```asm
LDRH R1, [R0]
```

Lädt dagegen den 16-Bit-Inhalt aus dem Speicher an der Adresse, die in R0 steht.

Das bedeutet: Eine Adresse zu laden ist nicht dasselbe, wie den Inhalt dieser Adresse zu laden.

## 4. Zweierkomplement

Das Zweierkomplement wird verwendet, um negative Zahlen im Binärsystem darzustellen.

Bei einem 32-Bit-Register werden negative Zahlen mit 32 Bit dargestellt.

Beispiel: Darstellung von -128.

1. Positive Zahl 128 in Binärdarstellung:

```text
00000000 00000000 00000000 10000000
```

2. Alle Bits invertieren:

```text
11111111 11111111 11111111 01111111
```

3. Eins addieren:

```text
11111111 11111111 11111111 10000000
```

Das Ergebnis ist:

```text
0xFFFFFF80
```

Deshalb ergibt die Anweisung:

```asm
MOV R1, #-128
```

den 32-Bit-Wert `0xFFFFFF80` in R1.

### Negative Werte im Speicher

Auch bei den Datenfeldern wird das Zweierkomplement verwendet.

Beispiel:

```asm
DCW -52
```

Bei einer 16-Bit-Darstellung entspricht -52 dem Hexadezimalwert:

```text
0xFFCC
```

Da ARM Little Endian verwendet, stehen die Bytes im Speicher in folgender Reihenfolge:

```text
CC FF
```

## 5. Little Endian und Speicheraufbau

Bei Little Endian wird das niederwertigste Byte an der niedrigsten Speicheradresse gespeichert.

Beispiel:

```asm
VariableA DCW 0x1234
VariableB DCW 0x4711
```

Speicherinhalt:

| Variable | Adresse relativ zu Base | Byte |
|---|---:|---|
| VariableA | 0 | 34 |
| VariableA | 1 | 12 |
| VariableB | 2 | 11 |
| VariableB | 3 | 47 |

Werden beide Variablen mit einem einzigen 32-Bit-Lesezugriff gelesen, ergibt sich:

```text
0x47111234
```

## 6. Wichtige Erkenntnisse

Während der Bearbeitung wurden folgende Zusammenhänge gelernt:

- Ein Byte besteht aus 8 Bit.
- Ein Halbwort besteht aus 16 Bit = 2 Byte.
- Ein Wort besteht aus 32 Bit = 4 Byte.
- `LDR` lädt ein Wort.
- `LDRH` lädt ein Halbwort und erweitert es mit Nullen.
- `LDRB` lädt ein Byte und erweitert es mit Nullen.
- Das Gleichheitszeichen bei `LDR` kennzeichnet eine Pseudoinstruktion.
- Der Disassembly View zeigt die tatsächlich erzeugten Maschinenbefehle.
- Das Zweierkomplement ermöglicht die Darstellung negativer Zahlen.
- Little Endian bestimmt die Reihenfolge der Bytes im Speicher.

## 7. Noch durchzuführende Arbeiten

- Registerbelegung für die einzelnen Anweisungen mit dem Debugger ermitteln.
- Speicherinhalte untersuchen und in die Excel-Tabelle eintragen.
- Vorgegebenes Formular vollständig ausfüllen.
- Weitere Codeänderungen und Tests durchführen und dokumentieren.
- Abschließende Ergebnisse auf das Git-Repository pushen.
- Git-Tag `Aufgabe_3.i` erstellen.

