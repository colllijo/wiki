---
weight: 110
title: "SOLID"
description: "Informationen zu den grundlegenden Prinzipien der Objektorientierten Programmierung, welche hinter dem Akronym SOLID stehen."
icon: "article"
date: "2024-06-14T16:56:19+02:00"
lastmod: "2024-07-09T11:20:19+02:00"
draft: false
toc: true
---

Solid beschreibt 5 Prinzipien der objektorientierten Programmierung. Diese
können einzeln eingesetzt werden, doch zusammen führen sie zur Erstellung von
robusten und wartbaren Programmen.  
Je nach Projekt kann es sinnvoll sein, die Prinzipien unterschiedlich strikt
einzuhalten.

## Single Responsibility Principle (SRP)

Ziel des Single Responsibility Principle ist es, die verschiedenen Belange zu trennen ([Separation of Concerns](https://en.wikipedia.org/wiki/Separation_of_concerns)).
Das heisst, eine Klasse sollte alle Sachen sammeln, welche sich aus einem bestimmten Grund ändern und nicht mehr.
So hat jede Klasse nur die Verantwortung, sich um die Anforderungen einer spezifischen Sache zu kümmern.

## Open/Closed Principle (OCP)

Software-Einheiten müssen erweiterbar sein (open).  
Dies muss möglich sein, ohne dass die grundlegende Einheit in irgend einer Weise
verändert werden muss (closed).

## Liskov Substitution Principle (LSP)

Das Ausführen einer Operation der Klasse `T` auf der Klasse `S` muss zum
gleichen Ergebnis führen wie das ausführen der Operation auf der Klasse `T`,
wenn die Klasse `S` eine Unterklasse der Klasse `T` ist. Ist dies nicht der
Fall, so wird das Liskovsche Substitutionsprinzip verletzt.

Dies führt dazu, dass Unterklassen ein Ist-ein-Kriterium erfüllen müssen.
Hat man die Klassen `Kreis` und `Ellipse`, so ist es planimetrisch korrekt
anzunehmen, dass ein `Kreis` eine `Ellipse` ist und deshalb eine Unterklasse von
`Ellipse` sein kann. Hat die `Ellipse` jedoch Funktionalitäten unabhängig in der X
und Y Achse skaliert zu werden, so ist ein `Kreis` keine `Ellipse` mehr, da ein
`Kreis` immer in beide Achsen skaliert werden muss.

## Interface Segregation Principle (ISP)

Interfaces sollen so aufgeteilt werden, dass sie den Anforderungen des Clients
entsprechen, sodass diese nicht Interfaces benutzen müssen, welche Methoden
beinhalten, welche sie nicht benötigen.

## Dependency Inversion Principle (DIP)

Module hoher Ebenen sollen nicht von Modulen tieferer Ebenen abhängen, beide sollen von Abstraktionen abhängig sein.  
Diese Abstraktionen sollen nicht von Details, sondern die Details von ihnen abhängen.

**Ressourcen**:  
[Wikipedia - SOLID](https://en.wikipedia.org/wiki/SOLID)  
[Wikipedia - Prinzipien objektorientiertes Designs](https://de.wikipedia.org/wiki/Prinzipien_objektorientierten_Designs#SOLID-Prinzipien)  

[Wikipedia - Single Responsibility Principle](https://de.wikipedia.org/wiki/Single-Responsibility-Prinzip)  
[Wikipedia - Open-closed principle](https://en.wikipedia.org/wiki/Open%E2%80%93closed_principle)  
[Wikipedia - Liskovsches Substitutionsprinzip](https://de.wikipedia.org/wiki/Liskovsches_Substitutionsprinzip)  
[Wikipedia - Interface segregation principle]()  
[Wikipedia - Dependency inversion principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle)  
