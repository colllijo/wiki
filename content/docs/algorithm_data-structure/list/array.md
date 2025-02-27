---
weight: 3102
title: "Array"
description: |
  Dokumentation zu Arrays
icon: "data_array"
date: "2025-02-26T14:45:21+01:00"
lastmod: "2025-02-26T14:45:21+01:00"
draft: false
toc: true
---

## Einführung

Ein Array ist eine Datenstruktur, welche eine Gruppe von Elementen sequentiell
im Speicher ablegt. So kann ein Element aus der Liste anhand des Indexes aus
dem Speicher gelesen werden, indem der Index als Offset auf das erste Element
angewandt wird.

## Konzept

Arrays sind im Speicher zusammenhängender Block, welcher eine Sammlung von
Elementen des gleichen Datentyps darstellt. Jedes Element im Array hat einen
Index, welche die Position des Elements im Array repräsentiert und als Offset
auf den Speicherblock angewandt wird um dieses zu erhalten. So ist es sehr
einfach ein beliebiges Element im Array zu finden.  
Da der Index als Offset auf den Speicherblock verwendet wird, sind Arrays in
vielen Programmiersprachen Null-basiert, da der Offset des ersten Elements 0
ist.

### Statische Arrays

Statische Arrays sind Arrays mit einer festen Grösse, welche zur Kompilierzeit
bereits bekannt sein muss. Die Grösse dieser Arrays kann später nicht mehr
verändert werden, dass heisst das Array muss bereits bei der Deklaration genug
gross sein um alle Elemente aufnehmen zu können.

### Dynamische Arrays

Dynamische Arrays basieren auf statischen Arrays bieten jedoch zusätzlich die
Möglichkeit die Grösse des Arrays zu verändern. Dazu muss jedoch ein neuer
Speicherblock reserviert werden, welcher die neue Grösse enthält und die
Elemente des alten Arrays müssen in das neue Array kopiert werden.

Da es sehr ineffizient ist bei jedem Einfügen eines Elements das gesamte Array
zu kopieren, verwenden die meisten dynamischen Arrays Implementierungen einen
besseren Ansatz verwenden.  
Neben der Referenz auf den Speicherblock, welcher die Elemente enthält, wird
eine Kapazität sowie die Grösse des Arrays gespeichert. So können neue Elemente
einfach eingesetzt werden solange die Grösse kleiner als die Kapazität ist und
erst sobald die Kapazität erreicht ist, wird ein neuer Speicherblock reserviert.
Die Grösse des neuen Speicherblocks ist dabei meistens doppelt so gross wie
zuvor, dadurch wird sichergestellt, dass die Zusätzlich für diesen Vorgang
verwendete Rechenzeit amortisiert wird.

## Vor- und Nachteile

Arrays bieten die Möglichkeit eine Gruppe an Daten sequentiell zu speichern,
dabei haben sie gewisse Vor- aber auch Nachteile gegenüber anderen
Datenstrukturen.

### Vorteile

- **Schneller Indexzugriff**: Da der Index als Offset auf den Speicherblock
  verwendet wird, kann ein Element im Array in konstanter Zeit gefunden werden.
- **Cache-Freundlich**: Da die Elemente im Speicher zusammenhängend abgelegt
  sind, können mehrere Elemente auf einmal in den Cache geladen werden.
- **Effizient bei kleinen Datenmengen**: Bei einer kleinen Anzahl an Elementen
  ist ein Array meist effizienter als andere Datenstrukturen.

### Nachteile

- **Statische Grösse**: Statische Arrays haben eine feste Grösse, welche zur
  Kompilierzeit bekannt sein muss.
- **Grössenänderung**: Dynamische Arrays müssen bei einer Grössenänderung die
  Elemente in einen neuen Speicherblock kopieren, was sehr ineffizient sein
  kann.

## Ressourcen

[Arrays - Wikipedia][array-wiki]  
[Dynamsiche Arrays - Wikipedia][dynamic-array-wiki]  

## Implementationen

[array-wiki]: https://en.wikipedia.org/wiki/Array_(data_structure)
[dynamic-array-wiki]: https://en.wikipedia.org/wiki/Dynamic_array
