---
weight: 210
title: "Onion Architektur"
description: "Informationen und Notizen zur Onion Architektur"
icon: "article"
date: "2024-06-14T14:23:13+02:00"
lastmod: "2024-06-14T14:23:13+02:00"
draft: false
toc: true
---

{{< rawhtml >}}
<style>
  .split-container {
    display: grid;
    grid-template-columns: 2fr 1fr;
  }
</style>
{{< /rawhtml >}}

## Einführung

Eine Onion Architektur zielt darauf ab, eine Applikation möglichs *modular* zu
erstellen. Dadurch soll die Unterhaltung der Applikation vereinfacht werden.
Dazu soll es eine Grundlage dafür sein, in der Entwicklung *flexiblen*,
*testbaren* und *erweiterbaren* Code zu schreiben.  
Das grosse Ziel der Architektur ist es, dass Komponenten einfach ausgetauscht
werden können, ohne dass andere Teile der Applikation davon betroffen sind,
indem keine festen Abhängigkeiten erstellt werden und nur Interfaces verwendet
werden.

{{< rawhtml >}}
<div class="split-container">
  <div>
{{< /rawhtml >}}
## Konzepte

### Abhängigkeiten

In einer Onion Architektur fliessen die Abhängigkeiten von aussen nach inne. So
haben die inneren Module keine Kentnisse der äusseren Module. Dadurch gibt es
keine festen Abhängigkeiten wodurch alle Komponenten einfacher ausgetauscht
werden können. Dies ohne dass andere Teile der Applikation bearbeitet werden
müssen.

### Schichten

**Domain:** Auf der Domainebene werden die einzelnen Domänen des Geschäfts
abgebildet. Hier sind die eigentlichen Geschäftsfalle und Entitäten
implementiert.

**Applikation:** Die Applikationsebene ermöglicht die Stellt die verschiedenen
Anwendungsfälle der Applikation zur Verfügung. Hier wird der Datenfluss
zwischen den einzelnen Elementen und Ebenen ermöglicht.

**Infrastruktur:** Die Infrastruktur ebene stellt die Schnittstellen zur
Aussenwelt dar. Sie implementiert jegliche Kommunikation der Applikation mit
andern Diensten und Systemen. Dazu gehört zum Beispiel die Datenbank, eine
REST-Schnittstelle und viele weitere Services welche in der Applikation benötigt
/ genutzt werden.

**Präsentation:** Die Präsentationsebene ist ein Teil der Infrastruktur. Jedoch
übernimmt sie keine Kommunikation mit anderen System sondern mit dem Benutzer.
Indem sie ihm eine Benutzeroberfläche zum Beispiel in Form einer Website zur
Verfügung stellt.
{{< rawhtml >}}
  </div>
  <div>
    <img src="/docs/images/architecture/onion/onion-model.png" alt="Onion Architektur Model" />
  </div>
</div>
{{< /rawhtml >}}
