---
weight: 3200
title: "Hashtabelle"
description: |
  Dokumentation zu Hashtabellen.
icon: "article"
date: "2025-06-18T10:07:09+02:00"
lastmod: "2025-06-18T10:07:09+02:00"
draft: false
toc: true
---

## Einführung

Eine Hashtabelle ist eine Datenstruktur, welche Schlüssel-Wert-Paare speichert.
Dabei ist eine Hashtabelle eine spezielle Art eines Arrays, welche es effizeint
ermöglicht, Werte anhand eines Schlüssels in einem Array zu suchen, einzufügen
und zu löschen.

## Konzept

Ein Hashtabelle verwendet eine Hash-Funktion, um aus dem Schlüssel den Index ins
Array aus Eimern zu berechnen, in welchem das Schlüssel-Wert-Paar gespeichert wird.
Diese Indexierung ermöglicht es Elemente in konstanter Zeit zu suchen, einzufügen
und zu löschen.

Da das Indexieren möglichst schnell sein muss, verwenden die meisten Hash Tabellen
imperfekte Hash-Funktionen, welche Kollisionen verursachen können. Diese Kollisionen
müssen dann behandelt werden, um sicherzustellen, dass die Hashtabelle nicht einfach
Einträge überschreibt. Aus diesem Grund hat eine Hashtabelle in der Realität nicht
immer eine konstante Zeitkomplexität, so müssen im Schlimmsten Fall alle Element
manuell durchsucht werden, um das gewünschte Element zu finden.

Dabei ist das Hashing einer Hashtabelle immer ein Space-Time Tradeoff. Sei unbegrenzt
viel Speicher vorhanden, so kann der komplette Schlüssel verwendet werden, um ein
Element zu Indexieren. So hat jeder Wert einen eigenen Speicherort und es existieren
keine Kollisionen. Is jedoch unendlich viel Zeit vorhanden, so können die Werte
auch ohne Hash-Funktion gespeichert werden, indem einfach alle Element durchsucht
werden.  
In der Realität versucht man deshalb die Hashtabelle so zu skalieren, dass eine
möglichst geringe Anzahl an Kollisionen mit minimalen Speicheraufwand entstehen,
dazu verwenden viele Implementierungen ein Rehashing bei dem die Hash Map, je nach
Anzahl der Elemente, vergrössert oder verkleinert wird.

## Verwendung

Hashtabellen sind ein der am häufigsten verwendeten Datenstrukturen in der Informatik.
So bilden Hashtabellen die Grundlage der meisten Assoziativen Arrays (Maps, Dictionaries),
aber auch von Sets.

Zusätzliche werden Hashtabellen aufgrund ihrer schnellen Zugriffs- und Updatezeiten
auch oft für Memoization, Caching oder andere Lookup-Aufgaben verwendet und finden
so auch in Datenbanken für die Indizierung von Daten Verwendung.

## Kollisionsauflösung

Für das Auflösen von Kollisionen zweier Indizes gibt es hauptsächlich zwei Ansätze.
Ein Hashing mit Verkettung oder ein Hashing mit offener Adressierung.

Beim Hashing mit Verkettung wird akzeptiert, dass nicht jedes Element einen eigenen
Platz im Array hat. Stattdessen werden die Elemente des Arrays als Eimer betrachtet,
welche alle Elemente mit dem gleichen Index enthalten. In der Praxis geschieht dies
meist in Form einer verketteten Liste, wobei der Eimer anhand des Hashes des Schlüssels
gewählt wird, und dieser dann nach dem Schlüssel durchsucht wird.

Beim Hashing mit offener Adressierung wird an jedem Platz im Array nur ein Element
gespeichert. Beim auftreten einer Kollision wird anhand einer klaren Vorgehensweise
ein anderer Freier Platz ausgehend vom Ursprünglichen Index gesucht. Wenn nun das
Element wieder ausgelesen werden soll, kann dieselbe Vorgehensweise verwendet werden,
bis entweder das Schlüssel-Wert-Paar gefunden wurde, oder ein leerer Platz gefunden
wird und damit klar ist, dass das Element nicht in der Hashtabelle enthalten ist.
Ein wichtiger Nachteil der offenen Adressierung ist, das die Suche nach einem Element
Länger geht, um so weniger freie Plätze im Array vorhanden sind und sobald alle
Plätze belegt sind und nach einem Element gesucht wird, welches nicht vorhanden
ist, ensteht eine Endlosschleife, da kein leerer Platz gefunden werden kann.

## Dynamische Grössenänderung

Das wiederholte Einfügen von Elementen in einer Hashtabelle führt zu einem erhöhten
Beladungsfaktor. Das Verhältnis von gespeicherten Elementen zu verfügbaren Eimern.
wird also grösser. Umso grösser der Beladungsfaktor, desto grösser die Chance auf
eine Kollision. Aus diesem Grund skalieren viele Implementierungen die Anzahl
der verfügbaren Eimer dynamische, um den Beladungsfaktor in einem Bereich zu halten
welcher effiziente Zugriffe ermöglicht ohne unnötig viel Speicher zu verbrauchen.

Dazu kann jedoch nicht einfach die Anzahl der Eimer verdoppelt werden, da die Indizes
der bereits gespeicherten Elemente von der Anzahl der Eimer anhängen. Stattdessen
muss die ganze Tabelle neu gehasht werden. Dieser Extraaufwand ist jedoch gerechtfertigt,
da sich sonst die Effizienz der Hashtabelle von O(1) in Richtung O(n) verschlechtert.
Wenn zudem die Anzahl der Eimer immer mindestens verdoppelt oder halbiert wird,
so Amortisiert sich der Aufwand für das Rehashing, über die Aufrufe hinweg.

## Ressourcen

[Hashtabelle - Wikipedia][hashtable-wiki]  

[hashtable-wiki]: https://de.wikipedia.org/wiki/Hashtabelle
