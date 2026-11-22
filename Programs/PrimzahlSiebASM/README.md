# Aufgabe 4 – Sieb des Eratosthenes

**Modul:** Grundlagen der Technischen Programmierung (GTP)  
**Hochschule:** HAW Hamburg  
**Autor:** Khaled

---

## 1. Analyse der Aufgabenstellung

Ziel dieser Aufgabe ist die Entwicklung eines Assemblerprogramms, das alle Primzahlen im Zahlenbereich von 2 bis 1000 ermittelt. Dafür wird das Sieb des Eratosthenes verwendet.

Das Verfahren basiert darauf, zunächst alle Zahlen des betrachteten Bereichs als mögliche Primzahlen zu behandeln. Anschließend werden die Vielfachen der bereits ermittelten Primzahlen gestrichen. Diese Zahlen können keine Primzahlen sein, da sie durch eine andere Zahl als 1 und sich selbst teilbar sind.

Das Verfahren beginnt mit der Zahl 2. Ihre Vielfachen werden aus dem Zahlenbereich entfernt. Danach wird mit der nächsten noch nicht gestrichenen Zahl fortgefahren. Auf diese Weise werden beispielsweise zuerst die Vielfachen von 2, danach die von 3, 5, 7 und weiteren Primzahlen markiert.

Das Markieren der Vielfachen beginnt jeweils beim Quadrat der betrachteten Zahl. Kleinere Vielfache wurden bereits bei der Bearbeitung ihrer kleineren Primfaktoren berücksichtigt. Dadurch werden unnötige Wiederholungen vermieden.

Das Verfahren endet, sobald das Quadrat der aktuell betrachteten Zahl größer als 1000 ist. Die nicht gestrichenen Zahlen im Siebfeld sind anschließend die gesuchten Primzahlen.

Das Programm wird in folgende Teilfunktionen aufgeteilt:

- Initialisierung des Siebfeldes
- Ermittlung der Primzahlen durch das Sieb
- Abspeichern der gefundenen Primzahlen in einem separaten Ergebnisfeld

---

## 2. Programmaufbau und Algorithmus

Das Programm wird in mehrere Funktionen unterteilt. Dadurch können die einzelnen Arbeitsschritte getrennt bearbeitet werden.

### 2.1 Hauptprogramm

Das Hauptprogramm steuert den Ablauf und ruft die benötigten Funktionen in der richtigen Reihenfolge auf.

```text
HAUPTPROGRAMM

    Initialisierung des Siebfeldes

    Funktion Sieb aufrufen

    Funktion Abspeichern aufrufen

ENDE
```

### 2.2 Initialisierung des Siebfeldes

Zu Beginn werden alle 1001 Elemente des Siebfeldes (Index 0 bis 1000) auf 0 gesetzt.

Anschließend werden die Elemente von Index 2 bis 1000 auf 1 gesetzt. Dadurch gelten alle Zahlen ab 2 zunächst als mögliche Primzahlen.

Die Indizes 0 und 1 bleiben auf 0, da diese keine Primzahlen sind.

```text
FUNKTION INITIALISIERUNG

    FÜR i = 0 BIS 1000:

        Siebfeld[i] = 0

    ENDE FÜR

    FÜR i = 2 BIS 1000:

        Siebfeld[i] = 1

    ENDE FÜR

ENDE FUNKTION
```

### 2.3 Funktion Sieb

Die Funktion überprüft das Siebfeld und markiert die Vielfachen der noch nicht gestrichenen Zahlen.

Es werden nur Zahlen bearbeitet, deren Eintrag im Siebfeld noch den Wert 1 besitzt.

Das Streichen beginnt jeweils beim Quadrat der betrachteten Zahl. Die weiteren Vielfachen werden durch Addition von p erreicht.

Der Vorgang endet, sobald p * p größer als 1000 ist. Dadurch müssen nur Zahlen bis zur Quadratwurzel der Obergrenze als mögliche Primfaktoren überprüft werden.

```text
FUNKTION SIEB

    p = 2

    SOLANGE p * p <= 1000:

        WENN Siebfeld[p] = 1:

            i = p * p

            SOLANGE i <= 1000:

                Siebfeld[i] = 0

                i = i + p

            ENDE SOLANGE

        ENDE WENN

        p = p + 1

    ENDE SOLANGE

ENDE FUNKTION
```

### 2.4 Funktion Abspeichern

Nach dem Siebvorgang werden alle nicht gestrichenen Zahlen in das Ergebnisfeld übertragen.

Dazu wird das Siebfeld von Index 2 bis 1000 durchlaufen. Wenn ein Eintrag den Wert 1 besitzt, wird der entsprechende Index im Ergebnisfeld gespeichert.

Nach jedem gespeicherten Wert wird der Ergebniszähler erhöht.

```text
FUNKTION ABSPEICHERN

    Ergebniszähler = 0

    FÜR i = 2 BIS 1000:

        WENN Siebfeld[i] = 1:

            Ergebnisfeld[Ergebniszähler] = i

            Ergebniszähler = Ergebniszähler + 1

        ENDE WENN

    ENDE FÜR

ENDE FUNKTION
```

Der Ergebniszähler gibt an, wie viele Primzahlen gefunden und gespeichert wurden.

---

## 3. Verwendete Speicherfelder

Für die Umsetzung des Algorithmus werden zwei Speicherfelder verwendet.

### 3.1 Siebfeld

Das Siebfeld enthält 1001 Elemente und bildet den Zahlenbereich von 0 bis 1000 ab. Der Index eines Elements entspricht dabei direkt der zugehörigen Zahl.

Jedes Element wird als Byte (8 Bit) gespeichert.

- Wert 0: Die Zahl ist keine Primzahl.
- Wert 1: Die Zahl ist eine mögliche Primzahl beziehungsweise nach Abschluss des Siebvorgangs eine Primzahl.

Die Indizes 0 und 1 werden von Anfang an auf 0 gesetzt.

### 3.2 Ergebnisfeld

Das Ergebnisfeld speichert die tatsächlich gefundenen Primzahlen. Dafür werden 16-Bit-Wörter verwendet, da alle Zahlen im betrachteten Bereich problemlos in 16 Bit dargestellt werden können.

Zwischen 2 und 1000 gibt es insgesamt 168 Primzahlen. Daher werden 168 Elemente benötigt.

Ein Ergebniszähler speichert die Anzahl der eingetragenen Primzahlen.

### 3.3 Grafische Darstellung des Siebfeldes

Jeder Index des Siebfeldes entspricht direkt einer Zahl.

**Beispiel nach der Initialisierung:**

| Index | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Wert | 0 | 0 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 | 1 |

**Beispiel nach dem Siebvorgang:**

| Index | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 |
|---|---|---|---|---|---|---|---|---|---|---|---|
| Wert | 0 | 0 | 1 | 1 | 0 | 1 | 0 | 1 | 0 | 0 | 0 |

Dabei bedeutet:

- 1: Die Zahl ist eine Primzahl.
- 0: Die Zahl ist keine Primzahl.

### 3.4 Grafische Darstellung des Ergebnisfeldes

Im Ergebnisfeld werden nur die Zahlen gespeichert, deren entsprechender Eintrag im Siebfeld nach dem Siebvorgang noch den Wert 1 besitzt.

```text
Ergebnisfeld (16-Bit-Wörter)

Index 0   ->  2
Index 1   ->  3
Index 2   ->  5
Index 3   ->  7
Index 4   ->  11
Index 5   ->  13
Index 6   ->  17
Index 7   ->  19
   ...
Index 167 ->  997
```

Der Ergebniszähler hat am Ende den Wert 168.

### 3.5 Speicherbedarf

| Speicherfeld | Elemente | Elementgröße | Gesamtgröße |
|---|---:|---:|---:|
| Siebfeld | 1001 | 1 Byte | 1001 Byte |
| Ergebnisfeld | 168 | 2 Byte | 336 Byte |
| **Gesamt** | | | **1337 Byte** |

Der angegebene Speicherbedarf bezieht sich auf die Nutzdaten der beiden Felder ohne zusätzliche Ausrichtungs- oder Verwaltungsbytes.

---

## 4. Erwartetes Ergebnis

Nach der vollständigen Ausführung des Algorithmus enthält das Ergebnisfeld alle Primzahlen zwischen 2 und 1000.

Die Gesamtanzahl der gefundenen Primzahlen beträgt 168.

Die letzte Primzahl in diesem Zahlenbereich ist 997.

---

## 5. Offene Aufgaben und Schwierigkeiten

Die grundlegende Funktionsweise des Siebs des Eratosthenes wurde erarbeitet und in einzelne Teilfunktionen unterteilt.

Die Aufgabenstellung wurde analysiert und der geplante Programmablauf durch Pseudocode beschrieben. Auch der Aufbau der benötigten Speicherfelder und deren Datentypen wurden festgelegt.

In dieser Vorbereitungsphase wurde noch kein ausführbarer Assembler-Code erstellt, da zunächst die Funktionalität und der Speicheraufbau geplant werden sollten.

Die Umsetzung der beschriebenen Funktionen in Assembler sowie deren Überprüfung auf dem ITS-Board stehen noch aus.

Bisher konnten alle Anforderungen des konzeptionellen Entwurfs bearbeitet werden. Weitere Schwierigkeiten werden während der Implementierung dokumentiert.