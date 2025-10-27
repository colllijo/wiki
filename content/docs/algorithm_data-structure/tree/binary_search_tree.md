---
weight: 3222
title: "Binärer Suchbaum"
description: |
  Dokumentation zu Binären Suchbäumen
icon: "article"
date: "2025-07-02T11:13:11+02:00"
lastmod: "2025-07-02T11:13:11+02:00"
draft: false
toc: true
---

## Einführung

Ein binärer Suchbaum (Binary Search Tree, BST) ist eine Datenstruktur, welche es
ermöglicht, Element effizient zu suchen, einzufügen und zu löschen. Dazu werden
die Elemente geordnet in einem Binärbaum gespeichert. Diese Eigenschaft führt dazu
dass die Operationen eine Logarithmische Zeitkomplexität haben, da sich die Anzahl
an Knoten pro Ebene des Baums exponentiell erhöht.

## Konzept

Ein binärer Suchbaum ist ein strikt geordneter Binärbaum, dass heisst das jeder
Knoten im Baum maximal zwei Kindknoten hat und eine Absolute Ordnung im Baum herrscht.
Wird also der Baum Sequentiell durchlaufen, dass heisst von links nach rechts, von
unten nach oben, so gilt für jeden Knoten, dass er in der Vergleichsoperation des
Baums kleiner ist als alle folgenden Knoten. Dabei kann die Vergleichsoperation
ein beliebiges Kriterium sein. Dabei ist kleiner nicht ganz richtig, da die Definition
von kleiner abhängig von der Vergleichsoperation ist, wird zum Beispiel ein nummerischer
kleiner Vergleich verwendet, so ist kleiner die mathematische kleiner Zahl, wird
jedoch ein nummerischer grösser Vergleich verwendet, so ist kleiner die mathematische
grössere Zahl.

Durch diese strikte Ordnung ist es möglich ein spezifisches Element schnell zu finden.
Da man an jedem Knoten des Baums weiss ob das gesuchte Element sich in der linken
Hälfte oder der rechten Hälfte des aktuellen Knotens befindet. So kann jeweils
der halbe Baum, aus der Suche ausgeschlossen werden. So ergibt sich die durchschnittliche
Zeitkomplexität von O(log n). Was jedoch bei dieser Annahme Auffällt ist, dass
nur die Hälfte des Baums entfernt werden kann, wenn der Baum komplett gefüllt ist.
Besitzt ein Knoten nur ein Kind, so macht es keinen Unterschied ob die andere
Hälfte des Baums entfernt wird, da sie gar nicht existiert. Dies führt dazu, dass
im schlechtesten Fall eine Zeitkomplexität von O(n) erreicht werden kann.

Aus diesem Grund gibt es verschiedene Strategien, um den Baum balanciert und somit
die Zeitkomplexität im Durchschnitt zu O(log n) zu halten. Solche Bäume sind zum
Beispiel AVL-Bäume, Rot-Schwarz-Bäume, diese sind balancierte binäre Suchbäume.

### Implementierung

Eine Implementierung eines binären Suchbaums sollte mindestens die folgenden Operationen
beinhalten:

**Suchen**:  
Ein Element des Baums anhand dessen Schlüsselwertes im Baum suchen.  
Dazu kann beginnen vom Wurzelknoten des Baums ausgehend, jeweils der linke oder
rechte Kindknoten untersucht werden, je nachdem ob der gesuchte Schlüsselwert
kleiner oder grösser als der aktuelle Knoten ist. Dies wird so lange wiederholt,
bis das Element gefunden wurde oder kein Knoten mehr vorhanden ist.

**Einfügen**:  
Ein Element an der richtigen Stelle im Baum einfügen.  
Dazu wird der Baum vom Wurzelknoten ausgehend ähnlich der Suche durchsucht, dieses
Mal jedoch in jedem Fall bis kein Knoten mehr vorhanden ist. An dieser Stelle wird
dann der neue Knoten eingefügt.

{{< alert context="info" >}}

Wenn die Schlüsselwerte der Elemente nicht eindeutig sind, so muss definiert werden,
wie Kollisionen behandelt werden. Ansätze dabei wären das bestehende Element zu
überschreiben, in einem Knoten eine Liste aller Elemente mit dem gleichen Schlüsselwert
zu speichern oder die BST-Bedingung umformulieren, sodass der linke Knoten immer
kleiner und der rechte Knoten immer grösser oder gleich dem aktuellen Knoten ist,
dadurch ist die Ordnung jedoch abhängig von der Einfüge-Reihenfolge der Elemente.

{{< /alert >}}

**Löschen**:  
Ein Element aus dem Baum entfernen ohne die Struktur des Baums zu zerstören.  
Beim Entfernen eines Elements aus dem Baum können drei Fälle auftreten:

- Das Element ist ein Blattknoten:  
  In diesem Fall kann das Element einfach aus dem Baum entfernt werden, also
  durch `null` ersetzt werden.
- Das Element hat ein Kind:  
  In diesem Fall wird der Knoten des Elements einfach durch sein Kind ersetzt.
  So übernimmt das Kind die Position des Knotens im Baum.
- Das Element hat zwei Kinder:
  In diesem Fall wird der Knoten des Elements durch sein folge Element
  ersetzt.  
  - Ist das nächste Element der rechte Kindknoten des Knotens, so kann dieser wie
    im zweiten Fall den Knoten ersetzen.
  - Ist das nächste Element im rechten Unterbaum des Knotens, aber nicht der direkte
    Kindknoten, so muss zuerst der Knoten des nächsten Elements durch seinen eigenen
    rechten Kindknoten ersetzt werden, bevor der Knoten des zu entfernenden Elements
    durch diesen ersetzt werden kann.

Der Prozess im dritten Fall kann auch mit dem direkten Vorgänger des Knotens durchgeführt
werden, wobei sich alle Operationen umkehren.

## Verwendung

Binäre Suchbäume werden unter anderem für das Sortieren von Elementen und die
Erstellung von Prioritätswarteschlangen verwendet.
Sie können auch verwendet werden um Daten anhand eines Schlüssels geordnet zu speichern,
und effiziente Verwendung zu ermöglichen. Zum Beispiel in Form einer Map.

## Ressourcen

[Binärer Suchbaum - Wikipedia][bst_wiki]

[bst_wiki]: https://de.wikipedia.org/wiki/Binärer_Suchbaum
