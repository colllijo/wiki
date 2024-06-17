---
weight: 999
title: "SOLID"
description: "Informationen zu den grundlegenden Prinzipien der Objektorientierten Programmierung, welche hinter dem Akronym SOLID stehen."
icon: "article"
date: "2024-06-14T16:56:19+02:00"
lastmod: "2024-06-14T16:56:19+02:00"
draft: true
toc: true
---

Solid beschreibt 5 Prinzipien der Objektorientierten Programmierung. Diese
können einzeln Eingesetzt werden, doch zusammen führen sie zur Erstellung von
robusten und wartbaren Programmen.  
Je nach Projekt kann es sinnvoll sein, die Prinzipien unterschiedlich strikt
einzuhalten.

## Single Responsibility Principle

Jede Klasse erfüllt nur einen Zweck und hat deshalb nur diese Verantwortung.

## Open/Closed Principle

Software-Einheiten müssen erweiterbar sein (open), jedoch ohne das die
eigentliche Einheit jedoch irgendwie verändert werden muss (closed).

## Liskov Substitution Principle

Für den Benutzer einer Methode darf es keinen Unterschied machen, ob er nun
eine Instanz der Basisklasse oder einer Subklasse benutzt.

## Interface Segregation Principle

Interfaces sollen so aufgeteilt werden, dass sie den Anforderungen des Clients
entsprechen, so dass diese nicht Interfaces benutzen müssen, welche Methoden
beinhalten welche sie nicht benötigen.

## Dependency Inversion Principle

Module hoher Ebenen sollen nicht von Modulen tieferer Ebenen abhängen sondern
von Abstraktionen. Diese Abstraktionen sollen nicht von Details, sondern die
Details von ihnen abhängen.
