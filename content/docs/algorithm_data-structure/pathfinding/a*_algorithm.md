---
weight: 3302
title: "A*-Algorithmus"
description: |
  Beschreibung des A*-Algorithmus, seiner Funktionsweise und Anwendungsfälle.
icon: "route"
date: "2025-05-26T08:46:33+02:00"
lastmod: "2025-05-26T08:46:33+02:00"
draft: false
toc: true
katex: true
---

## Einführung

Der A*-Algorithmus, auch A*-Suche, ist ein informierter Suchalgorithmus, er dient
zur Berechnung des kürzesten Pfades von zwei Knoten in einem Graphen mit gewichteten
Kanten. Dabei ist der A*-Algorithmus eine Erweiterung, oder auch Verallgemeinerung
von [Dijkstra's Algorithmus][dijkstra-algorithmus].  
Im Gegensatz zu den uninformierten Suchalgorithmen verwendet der A*-Algorithmus
eine Schätzfunktion ([Heuristik][heuristik-wiki]), welche genutzt wird um die
Kosten für den verbleibenden Pfad zu schätzen und so die Suche zu optimieren.

## Funktionsweise

Der A*-Algorithmus beginnt wie der Dijkstra's Algorithmus am Startknoten und untersucht
von dort ausgehend jeweils den Knoten der am *wahrscheinlichsten* zum Ziel führt,
bis dieses erreicht ist. Um diesen *wahrscheinlichsten* Knoten zu bestimmen, wird
jedem Knoten eine Kost $f(x)$ zugeordnet, die Abschätzt, wie lange der Weg vom Startknoten
hierher und von hier bis zum Zielknoten ist.

$f(x) = g(x) + h(x)$

Für einen Knoten $x$ bezeichnet $f(x)$ die Summe von $g(x)$ und $h(x)$. Dabei bezeichnet
$g(x)$ die Kosten vom Startknoten bis zum Knoten $x$ und $h(x)$ die Schätzung der
Kosten bis zum Zielknoten. Die Schätzung $h(x)$ wird auch als Heuristik bezeichnet.
Diese Heuristik kann je nach Anwendungsfall unterschiedlich sein, als Beispiel für
die Wegfindung kann jedoch zum Beispiel die Luftlinie zwischen dem Knoten $x$ und
dem Zielknoten verwendet werden um eine grobe Idee der verbleibenden Kosten zu erhalten.

Folgend wird die Funktionsweise in klare Schritte unterteilt, dabei ist es empfehlenswert
zuerst die Funktionsweise des [Dijkstra's Algorithmus][dijkstra-functionality] anzuschauen,
da der A*-Algorithmus auf diesem aufbaut und die Schritte sehr ähnlich sind.

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
   wird ist der Algorithmus fertig und es kann mit Schritt 7 fortgefahren
   werden. Falls nur der Pfad zum Zielknoten relevant ist, kann der Algorithmus
   auch zu Schritt 7 springen, wenn der jetzige Knoten der Zielknoten ist.
4. Für den jetzigen Knoten berechne die Kosten aller Nachbarn, welche noch nicht
   besucht wurden, durch den jetzigen Knoten. Dazu werden die Wegkosten durch das
   addieren des Kantengewichts zu den Wegkosten des jetzigen Knotens und die Heuristik
   des Nachbarns berechnet, welche zusammen dessen Kosten ergeben.
5. Vergleiche die neu berechneten Kosten mit den momentanen Kosten des Nachbarns
   und falls diese kleiner sind, aktualisiere die Kosten des Nachbarns auf die
   neu berechneten Kosten. Falls die neuen Kosten grösser sind, bleiben sie bestehend.
6. Nachdem alle Nachbarn des jetzigen Knoten überprüft wurden, markiere den
   jetzigen Knoten als besucht und entferne ihn aus dem Set der noch nicht
   besuchten Knoten. Dadurch wird dieser nicht mehr überprüft, dies ist korrekt,
   da die gespeicherte Distanz auf dem Knoten bereits minimal ist (durch Schritt
   3 sichergestellt) und deshalb final.  
   Gehe zurück zu Schritt 3.
7. Nachdem die Schleife fertig ist (Schritte 3-6) enthalten alle Knoten die
   kürzeste Distanz vom Startknoten aus.

## Pseudocode

Folgend ist ein Pseudocode Beispiel des Algorithmus dieses Benutzt eine
priorisierte Warteschlange um die Knoten mit der kleinsten Distanz zu erhalten und
eine Heuristik, welche die Luftlinie zweier Knoten berechnet.
Dazu nutzt er eine einfach Optimierung des Algorithmus bei der nicht alle Knoten
mit einer Unendlichen Distanz initialisiert werden, sondern neue Knoten nach und
nach entdeckt werden.

```javascript
function linearDistance(Node a, Node b) {
  return Math.sqrt(Math.pow(a.x - b.x, 2) + Math.pow(a.y - b.y, 2));
}

function dijkstra(start, target, graph) {
  PriorityQueue<Tuple<Number, Node>> queue;

  Map<Node, Number> costs;
  Map<Node, Number> previous;

  costs[start] = 0;
  previous[start] = null;

  queue.push(Tuple(0, start));

  while(!queue.empty()) {
    Number distance, Node current = queue.pop();

    if (current == target) {
      break;
    }

    for(Node neighbor in graph.neighbors(current)) {
      Number newDistance = distances + graph.distance(current, neighbor);
      Number newHeuristic = linearDistance(neighbor, target);

      Number newCost = newDistance + newHeuristic;

      if(!costs.contains(neighbor) || newCost < costs[neighbor]) {
        distances[neighbor] = newCost;
        previous[neighbor] = current;
        queue.push(Tuple(newCost, neighbor));
      }
    }
  }

  return dist, prev;
}
```

## Ressourcen

[A*-Algorithmus - Wikipedia][a*-wiki]  

## Implementierung

{{< expand title="Implementation in C++" >}}

{{< prism lang="cpp" line-numbers="true" >}}

#include <iostream>
#include <map>
#include <queue>
#include <string>
#include <tuple>
#include <vector>

struct Node
{
  std::string name;
  int latitude, longitude;

  Node(const std::string& name, int latitude, int longitude): name(name), latitude(latitude), longitude(longitude) {}
};

struct Edge
{
  struct Node *first;
  struct Node *second;
  int distance;

  Edge(struct Node *first, struct Node *second, int distance): first(first), second(second), distance(distance) {}
};

struct Graph
{
  std::vector<struct Node *> nodes;
  std::vector<struct Edge *> edges;

  ~Graph()
  {
    for (auto edge : edges)
      delete edge;
  }

  void addNode(struct Node *node)
  {
    nodes.push_back(node);
  };

  void addEdge(struct Node *first, struct Node *second, int distance)
  {
    struct Edge *edge = new Edge(first, second, distance);
    edges.push_back(edge);
  };

  std::vector<struct Node *> getNeighbors(struct Node *node)
  {
    std::vector<struct Node *> neighbors;

    for (const auto& edge : edges)
    {
      if (edge->first == node)
      {
        neighbors.push_back(edge->second);
      }
      else if (edge->second == node)
      {
        neighbors.push_back(edge->first);
      }
    }

    return neighbors;
  };

  int getDistance(struct Node *first, struct Node *second)
  {
    for (const auto& edge : edges)
    {
      if ((edge->first == first && edge->second == second) || (edge->first == second && edge->second == first))
      {
        return edge->distance;
      }
    }

    throw std::runtime_error("No edge found between nodes");
  };
};

int linearDistance(struct Node *a, struct Node *b)
{
	int latDiff = a->latitude - b->latitude;
	int lonDiff = a->longitude - b->longitude;

	return latDiff * latDiff + lonDiff * lonDiff;
}

std::tuple<std::map<struct Node *, int>, std::map<struct Node *, struct Node *>> dijkstras(struct Node *start, struct Node *target, Graph *graph)
{
  using QueueType = std::tuple<int, struct Node *>;

  std::priority_queue<QueueType, std::vector<QueueType>, std::greater<QueueType>> queue;

  std::map<struct Node *, int> costs;
  std::map<struct Node *, struct Node *> previous;

  costs[start] = 0;
  previous[start] = nullptr;

  queue.push(std::make_tuple(0, start));

  do
  {
    auto [distance, current] = queue.top();
    queue.pop();

    for (const auto& neighbor : graph->getNeighbors(current))
    {
      int edgeWeight = graph->getDistance(current, neighbor);
      int newDistance = distance + edgeWeight * edgeWeight;
      int newHeuristic = linearDistance(neighbor, target);

      int newCost = newDistance + newHeuristic;

      if (!costs.count(neighbor) || newCost < costs[neighbor])
      {
        costs[neighbor] = newCost;
        previous[neighbor] = current;
        queue.push(std::make_tuple(newCost, neighbor));
      }
    }
  } while (!queue.empty());

  return std::make_tuple(costs, previous);
}

int main(int argc, char *argv[])
{
  Node *Bern = new Node("Bern", 46, 7);
  Node *Basel = new Node("Basel", 47, 7);
  Node *Luzern = new Node("Luzern", 47, 8);
  Node *Lugano = new Node("Lugano", 46, 9);
  Node *Zürich = new Node("Zürich", 47, 8);
  Node *Chur = new Node("Chur", 46, 9);

  Graph *graph = new Graph;

  graph->addNode(Bern);
  graph->addNode(Basel);
  graph->addNode(Luzern);
  graph->addNode(Lugano);
  graph->addNode(Zürich);
  graph->addNode(Chur);

  graph->addEdge(Bern, Basel, 6);
  graph->addEdge(Bern, Luzern, 5);
  graph->addEdge(Bern, Lugano, 19);
  graph->addEdge(Basel, Zürich, 5);
  graph->addEdge(Basel, Luzern, 4);
  graph->addEdge(Luzern, Zürich, 4);
  graph->addEdge(Luzern, Chur, 9);
  graph->addEdge(Luzern, Lugano, 12);
  graph->addEdge(Zürich, Chur, 7);
  graph->addEdge(Lugano, Chur, 11);

  auto [distances, previous] = dijkstras(Bern, Chur, graph);

  std::cout << "Distance from Bern to Chur: " << distances[Chur] << std::endl;

  delete graph;

  delete Bern;
  delete Basel;
  delete Luzern;
  delete Lugano;
  delete Zürich;
  delete Chur;

  return 0;
}

{{< /prism >}}

{{< /expand >}}

[a*-wiki]: https://de.wikipedia.org/wiki/A*-Algorithmus
[heuristik-wiki]: https://de.wikipedia.org/wiki/Heuristik
[dijkstra-algorithmus]: dijkstra's_algorithm/
[dijkstra-functionality]: dijkstra's_algorithm/#funktionsweise
