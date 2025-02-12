---
weight: 10102
title: "COLL Advent of Code - Lösungsbibliothek"
description: "Informationen zu meinen Lösungen für Advent of Code."
icon: "emoji_objects"
date: "2025-01-10T13:09:20+01:00"
lastmod: "2025-01-10T13:09:20+01:00"
draft: false
toc: true
---

## Was ist COLL Advent of Code

[`COLL Advent of Code`][aoc-github] ist meine `C++` Bibliothek, welche dabei
helfen soll die [Advent of Code][aoc] Rätsel zu lösen. Da diese Bibliothek
momentan vor allem durch mich benutzt wird ist die Dokumentation jedoch noch
nicht allzu ausführlich und die Gesamte Bibliothek ist noch in Entwicklung und
kann sich noch stark ändern.  
Bis jetzt sind folgende Funktionen in der Bibliothek enthalten:

- Automatisches generieren aller Lösungsdateien für ein Jahr
- Ausführen der Lösung von einzelnen Tagen oder Teilen
- Automatisches Herunterladen der Rätsel-Eingabe
- Automatisches Einsenden der Lösung
- Eine (kleine) Bibliothek an Hilfsfunktionen
  - Datenstruktur für Raster
  - Implementation von oft benötigten Algorithmen
  - ThreadPool für parallelisierte Lösungsansätze

## Meine Teilnahmen am Advent of Code

Persönlich nehme ich seit 2022 an Advent of Code teil und versuche mich dabei
jedes Jahr zu verbessern. So ist es mir im ersten Jahr noch nicht gelungen alle
Rätsel im Dezember zu lösen. Mittlerweile ist es mir gelungen alle Rätsel zu
lösen und ich kann versuchen die globale Rangliste ein erstes mal zu erreichen.

Meine Lösungen zu den Rätseln veröffentliche ich ebenfalls in meinem GitHub
Repository unter dem [`colllijo/main`][aoc-github-solutions] Branch. Dabei
versuche ich natürlich eine möglichst schöne Lösung zu finden, dies ist jedoch
auf Grund der Wettbewerbsnatur von Advent of Code nicht immer der Fall, weshalb
ich nicht garantieren kann, dass der Code schön ist noch für jeglichen Input
funktioniert.

{{% alert context="info" %}}

Da ich in meinen ersten beiden Jahren noch nicht mit dieser Bibliothek
gearbeitet habe und diese erst für 2024 erstellt habe, sind meine Lösungen
für die 2022 und 2023 noch nicht um GitHub verfügbar.  
Ich versuche jedoch auch alle alten Events nachzulösen um mich vorzubereiten und
meine Bibliothek zu verbessern.

{{% /alert %}}

[aoc]: https://adventofcode.com/
[aoc-github]: https://github.com/colllijo/advent-of-code
[aoc-github-solutions]: https://github.com/colllijo/advent-of-code/tree/colllijo/main
