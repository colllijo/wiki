---
weight: 3110
title: "Algorithmus"
description: "Beschreibung und Funktinosweise des Dijkstr's Algorithmus"
icon: "route"
date: "2025-01-06T15:38:31+01:00"
lastmod: "2025-01-06T15:38:31+01:00"
draft: false
toc: true
---

## Einführung

Dijkstra's Algorithmus ermöglicht es den billigsten Weg zwischen Knoten in einem
gewichteten Graphen zu finden. Der Algorithmus ist nach dem niederländischen
Informatiker und Wissenschaftler [Edsger W. Dijkstra][wiki-edsger_w_dijkstra]
benannt, der ihn 1956 entwickelte.  
Er findet den kürzesten Weg von einem Startknoten zu allen anderen Knoten im
Graphen. Dies kann einerseits nützlich sein um den kürzesten Weg von einer
Ausgangsstadt zu einer anderen Stadt zu finden oder in der Netzwerktechnik um
die schnellste Verbindung zu einem anderen Computer zu finden, zum Beispiel als
Teil von OPFS ([Open Shortest Path First][wiki-ospf]).

## Beispiel

Um den Algorithmus einmal graphisch darzustellen und das Verständnis zu
vereinfachen hier ein Beispiel:

Gegeben ist folgender Graph:

```mermaid
%%{
  init: {
    'theme':'dark'
  }
}%%
graph LR
  Bern((Bern)) <-->|6| Basel((Basel))
  Bern <-->|5| Luzern((Luzern))
  Bern <-->|19| Lugano((Lugano))
  Basel <-->|5| Zürich((Zürich))
  Basel <-->|4| Luzern
  Zürich <-->|7| Chur((Chur))
  Luzern <-->|4| Zürich
  Luzern <-->|9| Chur
  Luzern <-->|12| Lugano
  Lugano <-->|11| Chur
```

Wenn nun das Ziel ist den kürzesten Weg von Bern nach Chur zu finden muss der
Algorithmus herausfinden, wie teuer es ist von Bern zu den anderen Knoten zu
gelangen. Dazu beginnt man mit Bern, welches keine Kosten hat, da man dort
beginnt, von hier aus können alle direkt Verbunden Knoten erreicht werden.
Diese erhalten, dann die bisherigen Kosten plus die Kosten der Kante über welche
sie erreicht werden sowie die Information von welchem Knoten aus sie erreicht
wurden. Alle so neu gefunden Knoten, werden in eine Liste aufgenommen, damit all
deren Verbindungen geprüft werden können. Wird ein Knoten von zwei verschiedenen
Pfaden erreicht, so erhält dieser die Kosten welche tiefer sind. Nachdem alle
Knoten überprüft wurden können die Kosten für den Knoten Chur sowie alle
vorherigen Knoten ausgelesen werden.

In diesem Fall wäre der schnellste Weg von Bern nach Chur über Luzern, dies
führt zu Kosten von 14:

```mermaid
%%{
  init: {
    'theme':'dark'
  }
}%%
graph LR
  Bern((Bern: 0)) <-->|5| Luzern((Luzern: 5))
  Luzern <-->|9| Chur((Chur: 14))
```

## Funktionsweise

{{% alert context="info" %}}
Dieser Abschnitt orientiert sich stark an der Beschreibung von Wikipedia:  
[Dijkstr's Algorithm > Algorithm][wiki-dijkstras_algorithm-algorithm]
{{% /alert %}}

Dijkstra's Algorithmus benötigt einen Startknoten sowie einen Zielkonten `N`,
welcher eine Distanz zum Startknoten hat. Der Algorithmus geht dann davon aus
das alle Knoten eine Unendliche Distanz haben und versucht diese zu verbessern.

1. Erstelle ein Set aller Knoten, welche noch nicht geprüft wurden.
2. Weise jedem Knoten eine Distanz von Startknoten hinzu für den Startknoten ist
   diese 0 für alle anderen Unendlich, da noch kein Pfad zu diesen gefunden
   wurde. Während der Ausführung werden diese durch die kürzest gefunden Pfade
   ersetzt.
3. Wähle den Knoten mit der kleinsten endlichen Distanz aus dem Set der
   noch nicht besuchten Knoten, anfänglich wird dies der Startknoten sein.
   Falls das Set leer ist oder kein Knoten mit einer endlichen Distanz gefunden
   wird ist der Algorithmus fertig und es kann mit Schritt 6 fortgefahren
   werden. Falls nur der Pfad zum Zielknoten relevant ist, kann der Algorithmus
   auch zu Schritt 6 springen, wenn der jetzige Knoten der Zielknoten ist.
4. Für den jetzigen Knoten überprüfe alle Nachbarn, welche noch nicht besucht
   wurden und aktualisieren deren Distanz. Dazu muss die neu berechnete Distanz
   durch den jetzigen Knoten mit der momentanen Distanz des Nachbarns verglichen
   werden, dieser soll die kleiner Distanz erhalten. Das heisst wenn der jetzige
   Knoten `A` eine Distanz von 7 hat und die Kante zum Nachbarn `B` eine Länge
   von 2 hat, so ist die Distanz zu `B` über `A` 9 (7 + 2). Ist die momentane
   Distanz von `B` grösser als 9 soll diese auf 9 gesetzt werden (Der Weg über
   `A` ist kürzer), andernfalls soll die Distanz beibehalten werden (Der Weg
   über `A` ist nicht kürzer).
5. Nachdem alle Nachbarn des jetzigen Knoten überprüft wurden, markiere den
   jetzigen Knoten als besucht und entferne ihn aus dem Set der noch nicht
   besuchten Knoten. Dadurch wird dieser nicht mehr überprüft, dies ist korrekt,
   da die gespeicherte Distanz auf dem Knoten bereits minimal ist (durch Schritt
   3 sichergestellt) und deshalb final.  
   Gehe zurück zu Schritt 3.
6. Nachdem die Schleife fertig ist (Schritte 3-5) enthalten alle Knoten die
   kürzeste Distanz vom Startknoten aus.

## Pseudocode

Folgend ist ein Pseudocode Beispiel des Algorithmus dieses Benutzt eine
priorisierte Warteschlange um die Knoten mit der kleinsten Distanz zu erhalten.
Dazu nutzt er eine einfach Optimierung des Algorithmus bei der nicht alle Knoten
mit einer Unendlichen Distanz initialisiert werden, sondern neue Knoten nach und
nach entdeckt werden.

```javascript
function dijkstra(start, graph) {
  PriorityQueue<Tuple<Number, Node>> queue;

  Map<Node, Number> distances;
  Map<Node, Number> previous;

  distances[start] = 0;
  previous[start] = null;

  queue.push(Tuple(0, start));

  while(!queue.empty()) {
    Number distance, Node current = queue.pop();

    for(Node neighbor in graph.neighbors(current)) {
      Number newDistance = distances + graph.distance(current, neighbor);

      if(!distances.contains(neighbor) || newDistance < distances[neighbor]) {
        distances[neighbor] = newDistance;
        previous[neighbor] = current;
        queue.push(Tuple(newDistance, neighbor));
      }
    }
  }

  return dist, prev;
}
```

## Ressourcen

[Wikipedia - Dijkstr's Algorithm][wiki-dijkstras_algorithm]  

[wiki-edsger_w_dijkstra]: https://en.wikipedia.org/wiki/Edsger_W._Dijkstra
[wiki-ospf]: https://en.wikipedia.org/wiki/Open_Shortest_Path_First
[wiki-dijkstras_algorithm]: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#:~:text=%5B17%5D-,Algorithm,-%5Bedit%5D
[wiki-dijkstras_algorithm-algorithm]: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm#:~:text=%5B17%5D-,Algorithm,-%5Bedit%5D
