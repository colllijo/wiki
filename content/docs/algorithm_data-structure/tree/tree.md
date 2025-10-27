---
weight: 3221
title: "Baum"
description: |
  Dokumentation zur Terminologie von Baum-Datenstrukturen und von gewöhnlichen
  Bäumen.
icon: "park"
date: "2025-07-02T11:12:59+02:00"
lastmod: "2025-07-02T11:12:59+02:00"
draft: false
toc: true
---

## Einführung

Ein Baum ist eine Datenstruktur, welche eine Hierarchie abbilden kann. Dabei besteht
ein Baum aus Knoten, welche durch Kanten miteinander verbunden sind. Jeder Baum
einen Wurzelknoten, dieser ist der oberste Knoten des Baums. Von dort aus kann jeder
Knoten keine bis viele Kinderknoten haben. Wobei für jeden Knoten, mit Ausnahme
des Wurzelknotens, genau ein Elternknoten existieren muss. Diese Bedingung führt
dazu, dass es in einem Baum keine Zyklen geben kann.  
Es gibt unterschiedliche Arten von Bäumen, welche sich in ihrer Struktur und ihrer
Anwendung unterscheiden, dazu gehören beispielsweise binäre Bäume, binäre Suchbäume
Tries, AVL-Bäume und B-Bäume.

## Terminologie

Bäume bestehen aus Knoten, welche beliebige Daten enthalten können. Diese Knoten
werden durch Kanten miteinander verbunden. Dabei bilden diese Kanten eine gerichtete,
hierarchische Verbindung, bei der der Elterknoten hierarchisch über dem Kindknoten
steht. Alle Knoten, haben exakt einen Elterknoten, mit Ausnahme des Wurzelknotens.
Ein Knoten kann keine oder mehrere Kinderknoten haben. Diese Kinderknoten haben,
normalerweise ein Ordnung, welche die Reihenfolge der Kinderknoten angibt. So ist
es Konvention, Bäume von Oben nach Unten von Links nach Rechts zu lesen.

Knoten können zusätzlich in innere Knoten und Blätter unterteilt werden. Ein Blatt
ist dabei ein Knoten, welcher keine Kinderknoten hat. Folglich ist ein innerer Knoten
einer, welcher mindestens einen Kinderknoten hat.

Zusätzlich ist es möglich einen Baum in Unterbäume zu unterteilen, indem ein nicht
Wurzelknoten als Wurzelknoten eines neuen Baums betrachtet wird.

Folgende Begriffe werden häufig im Zusammenhang mit Bäumen als Datenstruktur verwendet:

**Root (Wurzel)**:  
Der oberste Knoten eines Baums, von dem alle anderen Knoten abgeleitet sind.

**Parent (Elternknoten)**:  
Der Knoten, der direkt über einem anderen Knoten steht und somit dessen Vorgänger
ist.

**Child (Kindknoten)**:  
Ein Knoten, der direkt unter einem anderen Knoten steht und somit dessen Nachfolger
ist. Ein Knoten kann keine oder mehrere Kindknoten haben.

**Neighbor (Nachbarknoten)**:
Knoten, welche direkt mit einem Knoten verbunden sind, dass heisst der Elterknoten
sowie alle Kindknoten des Knotens.

**Ancestry (Ahnen)**:  
Ein Knoten, welcher durch das wiederholte Aufsteigen zum Elterknoten erreicht werden
kann.

**Descendant (Nachkomme)**:  
Ein Knoten, der durch das wiederholte Absteigen zu einem Kindknoten erreicht werden
kann.

**Height (Höhe)**:  
Die Anzahl an Knoten auf dem längsten Pfad von der Wurzel zu einem Blattknoten.
Ein Baum, der nur aus der Wurzel besteht, hat eine Höhe von 0. Ein leerer Baum,
es existiert auch keine Wurzel, hat eine Höhe von -1.

**Degree (Grad)**:  
Der Grad eines Knotens ist die Anzahl seiner direkten Kindknoten. So hat ein
Blattknoten immer den Grad 0, da er keine Kindknoten hat

**Degree of tree (Grad des Baums)**:  
Der Grad des gesamten Baums ist gleich dem maximalen Grad aller Knoten im Baum.

**Level (Ebene)**:  
Die Ebene eines Knotens beschreibt die Anzahl der Kanten, die von der Wurzel bis
zu diesem Knoten führen. Anstelle von Ebene wird auch häufig die Tiefe (Depth)
verwendet.

**Width (Weite)**:  
Die Weite beschreibt die gesamte Anzahl an Knoten auf einer bestimmten Ebene.

**Breadth (Breite)**:  
Die Breite beschreibt die Anzahl der Blattknoten eines Baums.

## Konzepte

Bäume sind eine fundamentale Datenstruktur, die in vielen Situationen Anwendung
finden, dabei werden für diese unterschiedlichen Situationen meist spezielle Arten
von Bäumen verwendet. Das heisst Bäume, welche zusätzliche Bedingungen erfüllen
müssen und so besondere Eigenschaften garantieren.

So sind möglich Anwendungsfälle vom Bäumen:

- Die Dateistruktur in Dateisystemen, mit Ordern und Dateien, welche in einer
  hierarchischen Struktur organisiert sind. (Dies gilt jedoch nur solange kein
  Verknüpfungen oder symbolische Links verwendet werden.)
- Abtract Syntax Trees (ASTs), welche verwendet um den Quellcode von Prorgammen
  zu parsen und kompilieren.
- Das Document Object Model (DOM), welches die Struktur von HTML- und XML-Dokumenten
  beschreibt.

Zusätzlich gibt es einige gängige Varianten einen Baum zu traversieren. Dazu gehört
beispielsweise eine konditionale Traversierung, bei der die Wahl des nächsten Knotens
Anhand einer bestimmten Bedingung getroffen wird. So wird bei einem binären Suchbaum
zum Beispiel der gesuchte Wert mit dem aktuellen Knoten verglichen um zu entscheiden,
ob als nächstes der linke oder rechte Kindknoten besucht wird. Die Tiefensuche (Depth-First
Search, DFS) bei der alle Knoten des Baums besucht werden, wobei zuerst alle Kindknoten
eines Knotens besucht werden, bevor die Knoten der selben Ebene besucht werden.
Und die Breitensuche (Breadth-First Search, BFS), bei der alle Knoten auf selben
Ebene besucht werden, bevor die Knoten der nächsten Ebene besucht werden.

### Binärer Baum

Ein Binärbaum ist an sich eine Spezialisierung des generellen Baums, da er jedoch
selber Grundlage für eine grosse Anzahl anderer Bäume ist, wird er hier trotzdem
kurz beschrieben.

Ein Binärbaum bedingt, das jeglicher Knoten höchstens zwei Kindknoten haben kann.
Aus dieser Bedingung und da die Kindknoten meist von links nach rechts gezeichnet
werden, ergibt sich die Konvention, die beiden Knoten als linken und rechten Kindknoten
zu bezeichnen.

Möglich Anwendungsfälle für Binärbäume sind:

- Huffmann Bäume, für die Kompression von Daten
- Implementation von unterschiedlichen Suchalgorithmen, wie dem binären Suchbaum
- Prioritätswarteschlangen, implementiert durch einen binären Heap

## Ressourcen

[Tree - Wikipedia][tree_wiki]  

[tree_wiki]: https://de.wikipedia.org/wiki/Baum_(Datenstruktur
