---
weight: 3224
title: "Trie"
description: |
  Dokumentation zu Trie's auch Präfixbaum genannt.
icon: "article"
date: "2025-07-02T11:13:34+02:00"
lastmod: "2025-07-02T11:13:34+02:00"
draft: false
toc: true
---

## Einführung

Ein Trie, auch Präfixbaum genannt, ist eine spezielle Art einer Baum-Datenstruktur,
welche für das Suchen einer Zeichenkette, zum Beispiel die automatische Vervollständigung
von Suchbegriffen, verwendet wird. Dabei werden die Zeichenketten so im Baum gespeichert,
dass die Zeichenketten, welche einen gemeinsamen Präfix haben, diesen auch im Baum
teilen. Dieser Präfix wird also für alle Zeichenketten nur einmal gespeichert.

## Konzept

Präfixbäume bestehen aus Knoten, welche einen beliebigen Wert enthalten können,
zum Beispiel einen Index in ein Wörterbuch. Diese Knoten werden dann über Kanten,
welche mit den Zeichen des Alphabets beschriftet sind miteinander verbunden.  
Die Präfixe sind also in den Kanten und nicht den Knoten gespeichert. Somit repräsentiert
der Wurzelknoten des Baums eine leere Zeichenkette.

Ein Knoten eines Präfixbaums hat somit einen Wert eines beliebigen Typs und eine
Liste von x Kindern, wobei x die Anzahl an Zeichen des Alphabets ist, zum Beispiel
52 für das lateinische Alphabet (Gross- und Kleinbuchstaben). Jeder Knoten des
Baums (mit Ausnahme des Wurzelknotens) muss genau ein Elterknoten haben.  
*Das lateinische Alphabet ist einfach nur ein Beispiel, es kann ein Alphabet aus
beliebigen Zeichen verwendet werden.*

Um ein Element zu finden kann nun einfach für jedes Zeichen der Zeichenkette, die
entsprechende Kante im Baum befolgt werden. Sollte dabei ein `null` Knoten erreicht
werden ist die Zeichenkette nicht im Baum enthalten. Andernfalls wird der mit dem
befolgen der Kante, des letzten Zeichens, der Zielknoten erreicht.

Das Einfügen eines neuen Elements funktioniert ähnlich, nur das jetzt einfach ein
neuer Knoten erstellt wird, falls ein `null` Knoten gefunden wird. Der gewünschte
Wert kann, dann einfach im Zielknoten gespeichert werden.

Das Entfernen eines Elements ist etwas komplizierter, so muss nicht nur der Zielknoten
gelöscht werden, sondern auch alle Knoten, welche danach keine Kinder mehr haben.

Für Tries gibt es auch noch weitere spezifischere Bäume, welche unter andrem den
Baum etwas komprimieren, da nicht in jedem Knoten eine Referenz für jedes Zeichen
des Alphabets gespeichert werden muss. Dazu gehört zum Beispiel der [Radixbaum][radix-tree-wiki].

## Verwendung

Tries werden vor allem für die suche von Texten (Zeichenketten) verwendet. Dies
zum Beispiel in From der automatischen Vervollständigung, Textvorschlägen oder
auch der Rechtschreibprüfung.  
Zusätzlich ermöglichen Ties auch die lexicographische Sortierung von Zeichenketten,
diese Sortierung ist eine Form des Radix-Sortierens.

## Ressourcen

[Trie - Wikipedia][trie-wiki]  

[trie-wiki]: https://de.wikipedia.org/wiki/Trie
[radix-tree-wiki]: https://en.wikipedia.org/wiki/Radix_tree
