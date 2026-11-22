; Aufgabe 4 - Sieb des Eratosthenes
; Autor: Khaled
;
; Hauptprogramm:
; 1. Das Siebfeld initialisieren.
; 2. Die Funktion Sieb aufrufen.
; 3. Die Funktion Abspeichern aufrufen.
; 4. Das Ergebnisfeld enthält alle Primzahlen von 2 bis 1000.
;
; Funktion Initialisierung:
; - Alle Einträge des Siebfeldes von Index 0 bis 1000 auf 0 setzen.
; - Die Einträge von Index 2 bis 1000 auf 1 setzen.
; - Index 0 und 1 bleiben auf 0, da diese Zahlen keine Primzahlen sind.
;
; Funktion Sieb:
; - Die Zahlen von 2 bis 1000 nacheinander überprüfen.
; - Nur Zahlen bearbeiten, deren Eintrag im Siebfeld = 1 ist.
; - Für jede noch nicht gestrichene Zahl p bei p * p beginnen.
; - Alle Vielfachen von p ab p * p im Siebfeld auf 0 setzen.
; - Die nächste Zahl jeweils durch Addition von p erreichen.
; - Das Sieben beenden, sobald p * p größer als 1000 ist.
; - Bereits gestrichene Zahlen werden übersprungen.
;
; Funktion Abspeichern:
; - Das Siebfeld von Index 2 bis 1000 durchlaufen.
; - Bei Siebfeld[index] = 1 den Index im Ergebnisfeld speichern.
; - Nach jedem gespeicherten Wert den Ergebniszähler erhöhen.
; - Am Ende enthält das Ergebnisfeld alle gefundenen Primzahlen.
;
; Speicheraufbau:
; - Siebfeld: 1001 Elemente vom Typ Byte.
; - Jeder Index entspricht einer Zahl zwischen 0 und 1000.
; - Wert 0 bedeutet, dass die Zahl keine Primzahl ist.
; - Wert 1 bedeutet, dass die Zahl als Primzahl gilt.
; - Ergebnisfeld: maximal 999 Elemente vom Typ 16-Bit-Wort.
; - Im Ergebnisfeld werden nur die gefundenen Primzahlen gespeichert.
; - Ein Zähler gibt an, wie viele Primzahlen gespeichert wurden.