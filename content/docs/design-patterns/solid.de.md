---
weight: 999
title: "SOLID"
description: ""
icon: "article"
date: "2024-06-14T16:56:19+02:00"
lastmod: "2024-06-14T16:56:19+02:00"
draft: true
toc: true
---

## Single Responsibility Principle

Jede Klasse erfüllt nur einen Zweck und hat deshalb nur diese Verantwortung.

## Open/Closed Principle

Software-Einheiten müssen erweiterbar sein (open), jedoch ohne das die
eigentliche Einheit jedoch irgendwie verändert werden muss (closed).

## Liskov Substitution Principle

Für den ausführer einer Methode darf es keinen Unterschied machen, ob er nun
eine Instanz der Basisklasse oder einer Subklasse benutzt.

## Interface Segregation Principle

Interfaces sollen so aufgeteilt werden, dass sie den Anforderungen des Cleints
entsprechen, so dass diese nicht Interfaces benutzen müssen, welche Methoden
beinhalten welche sie nicht benötigen.
## Dependency Inversion Principle

Module hoher Ebenen sollen nicht von Modulen tieferer Ebenen abhängen sondern
von Abstraktionen. Diese Abstraktionen sollen nicht von Details, sondern die
Details von ihnen abhängen.

All diese Prinzipien können bereits alleine Eingesetzt werden, jedoch stehen sie
zusammen im Ziel die Robustheit und Wartbearkeit vom Objektorienterten
Programmen zu verbessern.
