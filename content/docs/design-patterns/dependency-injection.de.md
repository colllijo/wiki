---
weight: 999
title: "Dependency Injection"
description: "Eine kurze Einführung in das Thema Depedency Injection mit einem kleinen Java Beispiel"
icon: "article"
date: "2024-06-14T16:56:19+02:00"
lastmod: "2024-06-14T16:56:19+02:00"
draft: true
toc: true
---

## Einführung

Mit dependency Injection wird bewirkt das eine Klasse selber keine
Abhängigkeiten mehr verwalten muss, da diese automatisch zur Verfügung gestellt
werden. Dadurch soll es einefacher sein Abhängigkeiten zu verändern, da diese
weniger Anpassungen in ihren Anhängigkeiten zur folge haben, im besten fall
sogar gar keine Veränderungen mehr.

Eine Abhängigkeit kann mittels Dependency Injection an drei verschiedenen
Stellen eingeführt werden. Es ist möglich die Abhängigkeit bei der
Konstruktion des Clients zu erstellen, hierbei wird die Abhängigkeit in den
Konstruktor eingeführt, eine zweite Möglichkeit ist es, die Abhängigkeit mittels
einer Setter Method einzuführen, welche nach dem Konstruktor aufgerufen wird.
Die letze Möglichkeit ist es die Abhängikeit direkt im Feld einzuführen, sodass
weder eine Konstruktor noch eine spezifische Setter Methode benötigt wird.

Die Dependency Injection ist eine Erweiterung der Dependency Inversion unter dem
SOLID Prinzip. welche die Abhängikeit von unten nach oben bringt.

## Rollen

### Service

Der Service ist der Teil der Applikation, welcher an einer anderen Stelle
genutzt werden soll, da dieser einen Teil der Benötigten Geschäftslogik
implementiert. Damit die Applikation möglichst Modulat bleibt und mit dem
Dependency Inversion Ptinziple übereinstimmt, wird ein Service nie direkt in
einem Client genutzt. Anstelle dessen implementiert ein Service ein Interface,
welches wiederum von Clients verwendet werden kann.


### Client

Der Client bezeichnet den Teil der Applikation, welcher einen Serivce
konsummieren und benutzen soll. Die Abhängigkeit soll hier "eingesrpitzt"
werden. Dadurch kann der Client die Funktionalitäten des Interfaces, welche vom
Service impelmentiert werden einfach Nutzen ohne sich darum kümmern zu müssen,
welche implementation er jetzt benutzt.

### Interface

Das Interface ist die Abstraktion zwischen Client und Service. Es definiert eine
Schnittstelle wodurch ein Client weiss, welche Methoden ihm auf einem Service
zur Verfügung stehen und macht es für einen Service klar, welche Methoden
implementiert werden müssen.

### Injector

Die Aufgabe des Injectors ist es die jeweiligen Services in die
unterschiedlichen Interfaces der Clients "einzuspritzen", damit diese sie benutzen
können. Der Injector ist im Vergleich zur Dependency Inversion die einzig neue
Rolle welche zu vor noch nicht benötigt wurde.

## CDI

Contexts and Dependency Injection (CDI) ist ein Java-Standard, welcher die
Konfiguration von Modulen abhängig von verschiedenen Zusammenhängen durch
Injetion von Abhängigkeiten erlaubt.

## Quellen

[Wikipedia - Prinzipien objektorientierten Designs](https://de.wikipedia.org/wiki/Prinzipien_objektorientierten_Designs)
[Wikipedia - Contexts and Dependency Injection](https://de.wikipedia.org/wiki/Contexts_and_Dependency_Injection)
[Stackify - Dependency Injection](https://stackify.com/dependency-injection/)

## Beispiel

