---
weight: 3201
title: "Heap"
description: |
  Dokumentation zu Heaps.
icon: "article"
date: "2025-07-01T08:42:54+02:00"
lastmod: "2025-07-01T08:42:54+02:00"
draft: false
toc: true
---

## Einführung

Ein Heap ist eine Datenstruktur, welche eine Menge von Elementen in einem partiell
geordneten Binärbaum speichert. Dazu muss für jedes Element im Heap ein Schlüssel
festgelegt sein, welche anhand der Vergleichsmethode des Heaps, die Ordnung des Elements
im Heap bestimmt.  
Ein solcher Heap kann vor allem für die Implementierung von Prioritätswarteschlangen,
welche es ermöglichen das Element mit der höchsten oder niedrigsten Priorität aus
einer Menge von Elementen zu entfernen, verwendet werden.

## Konzept

Ein Heap beschreibt einen Binärbaum, welcher die Heap-Eigenschaft erfüllt. Dabei
gibt es zwei Arten von Heaps, den Max-Heap, bei dem für jeden Knoten um Baum gilt,
das der Schlüssel des Knotens grösser oder gleich dem Schlüssel seiner Kinder sein
muss und den Min-Heap, bei dem der Schlüssel des Knotens kleiner oder gleich dem
Schlüssel seiner Kinder sein muss.

Dabei unterstützt ein Heap grundsätzlich mindestens die folgenden Operationen:

**Heapify**:  
Die Heapify Operation ordnet die Elemente des Heaps neu an, sodass die Heap-Eigenschaft
wiederhergestellt wird. Sie erfolgt, wenn ein bestimmtes Element durch eine der
anderen Operationen verändert wurde. Dabei kann die Heapify-Operation in zwei unterschiedlichen
Ausprägungen auftreten.

*Up-Heapify*: Stellt die Heap-Eingenschaft nach dem Bottum-Up-Ansatz sicher, indem
sichergestellt wird, dass die Bedingung von einem bestimmten Knoten bis zur Wurzel
des Baums gegeben ist.

*Down-Heapify*: Stellt die Heap-Eingenschaft nach dem Top-Down-Ansatz sicher, indem
sichergestellt wird, dass die Bedingung von einem bestimmten Knoten bis zu dessen
Blättern gegeben ist.

**Insert**:  
Fügt ein neues Element am ende des Heaps hinzu und stellt anschliessend mithilfe
der Up-Heapify-Operation sicher, dass die Heap-Eigenschaft erhalten bleibt.

**Remove**:  
Entfernt ein Element aus dem Heap und ersetzt dieses mit dem letzten Element. Anschliessend
das letzte Element gelöscht und mithilfe der Down-Heapify-Operation sichergestellt,
dass die Heap-Eigenschaft erhalten bleibt.

**Peek**:  
Gibt das Element an der Wurzel des Heaps, also mit der höchsten oder niedrigsten
Priorität (Max-Heap oder Min-Heap) zurück, ohne es zu entfernen.

**Pop**:  
Gibt das Element an der Wurzel des Heaps zurück und entfernt es anschliessend
ähnlich der Remove-Operation.

**Build Heap**:  
Erstellt aus einer einfachen Liste vom Elementen einen Heap. Dabei wird die Heap-Eigenschaft
effizienter hergestellt, als indem jedes Element einzeln eingefügt wird.

### Implementierung

Für die Implementierungen eines Heaps gibt es unterschiedliche Ansätze, der einfachste
ist jedoch der binäre Heap. Beim binären Heap, werden die Elemente in einem statischen
oder dynamischen Array gespeichert. Wobei die Elter-Kind-Beziehung implizit durch
den Index in diesem Array gegeben ist.

Für ein Array mit Startindex 0 gilt dabei:  
Index des linken Kindes: `2 * i + 1`  
Index des rechten Kindes: `2 * i + 2`  
Index des Elternteils: `(i - 1) / 2`  

Falls der Heap komplexere Datenstrukturen beinhalten soll, so kann der eigentliche
Heap auch einfach die Referenzen auf die tatsächlichen Elemente speichern.

## Verwendung

Heaps werden primär für die Implementierung von Prioritätswarteschlangen verwendet.
Die Heap-Eigenschaft kann jedoch auch verwendet werden, um eine Menge von Elementen
an Ort und Stelle zu sortieren. Der dafür verwendete Algorithmus wird
[Heap-Sort][heapsort-wiki] genannt.

## Ressourcen

[Heap - Wikipedia][heap-wiki]  

[heap-wiki]: https://de.wikipedia.org/wiki/Heap_(Datenstruktur)
[heapsort-wiki]: https://de.wikipedia.org/wiki/Heapsort
