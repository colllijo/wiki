---
weight: 3101
title: "Linked List"
description: |
  Dokumentation zu einer verketteten Liste.
icon: "link"
date: "2025-02-26T13:18:04+01:00"
lastmod: "2025-02-26T13:18:04+01:00"
draft: false
toc: true
---

## Einführung

Eine verkettete Liste ist eine Datenstruktur, welche es ermöglicht Daten in
einer sequentiellen Reihenfolge zu speicher, indem die einzelnen Elemente
miteinander Verknüpft werden. Das heisst für jedes Element der Liste wird
zusätzlich Eine Referenz auf das nächste Element gespeichert. Dies ermöglicht
es die Liste einfach zu iterieren und zusätzlich ist es nicht Notwendig die
gesamte Liste in einem zusammenhängenden Speicherbereich zu speichern.

## Konzept

In einer verketteten Liste werden alle Werte in ein Element gebunden, welches
neben dem Wert auch noch eine oder mehrere Referenzen auf andere Elemente
der Liste hält.
Das erste Element einer Liste wird als `head` bezeichnet, da dieses den Anfang
der Liste darstellt und es von diesem aus möglich ist die restliche Liste
aufzurufen wird dieses Element an Methoden oder Funktionen übergeben, welche mit
der Liste arbeiten müssen. Der sogenannte `tail` der Liste bezeichnet entweder
den Teil der Liste, welcher nicht der `head` ist oder das letzte Element der
List.

### Einfach verkettete Liste (Singly linked list)

In einer einfach verketteten Liste wird jedes Element mit einer Referenz auf das
nächste Element gespeichert. Das letzte Element der Liste hält dabei einen
speziellen Wert, welcher anzeigt, dass dies das Ende der Liste ist, meistens
`null` oder `nullptr`.

Ein einfaches Beispiel einer einfach verketteten Liste mit den Elementen (12 ➡ 42 ➡ 9):

![Beispiel einer einfach verketteten Liste][ssl-img]

### Doppelt verkettete Liste (Doubly linked list)

In einer doppelt verketteten Liste wird jedes Element mit einer Referenz auf das
nächste und auf das **vorherige** Element gespeichert. Dies ermöglicht es die
Liste in beide Richtungen zu durchlaufen.

Hier nochmals das Beispiel mit den Elementen (12 ↔ 42 ↔ 9) in einer doppelt
verketteten Liste:

![Beispiel einer doppelt verketteten Liste][dsl-img]

## Vor- und Nachteile

Verkettete Listen sind eine Möglichkeit Daten sequentiell zu speichern, dabei
bieten sie im Vergleich mit anderen Wegen gewisse Vor- und Nachteile. Die
grössten Vor- und Nachteil sind in der folgenden Liste benannt.

### Vorteile

- **Einfaches Iterieren der Liste**: Jedes Element verweist auf das nächste,
  was das Durchlaufen der Liste erleichtert.
- **Einfaches Einfügen und Löschen von Elementen**: Elemente können durch
  Anpassen der Referenzen in konstanter Zeit (O(1)) eingefügt oder gelöscht
  werden.

### Nachteile

- **Zugriff auf Elemente mittels Index**: Der Zugriff erfordert das Durchlaufen
  der Liste, was im Durchschnitt O(n) Zeit benötigt.
- **Weniger Cache-freundlich (Daten sind im Speicher verstreut)**: Elemente sind
  nicht zusammenhängend gespeichert, was zu häufigeren Cache-Misses führt.

## Ressourcen

[Verkettete Listen - Wikipedia][linked-lists-wiki]  

## Implementationen

{{< expand "Singly linked list in C++" >}}
{{< /expand >}}

[ssl-img]: /docs/images/algorithm_data-structure/list/singly-linked-list.png
[dsl-img]: /docs/images/algorithm_data-structure/list/doubly-linked-list.png

[linked-lists-wiki]: https://en.wikipedia.org/wiki/Linked_list
