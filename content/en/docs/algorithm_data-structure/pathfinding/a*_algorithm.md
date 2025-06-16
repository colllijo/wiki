---
weight: 3302
title: "A* algorithm"
description: |
  Description of the A* algorithm and its functionality.
icon: "route"
date: "2025-05-26T08:46:38+02:00"
lastmod: "2025-05-26T08:46:38+02:00"
draft: true
toc: true
katex: true
---

## Introduction

The A\* algorithm, also known as A\* search, is an informed search algorithm used
to calculate the shortest path between two nodes in a graph with weighted edges.
A\* is an extension or generalization of
[Dijkstra's algorithm][dijkstra-algorithmus].  
In contrast to uninformed search algorithms, the A* algorithm uses a [heuristic][heuristic-wiki],
which is used to estimate the cost of the remaining path and thus optimize the search.

## Functionality

The A* algorithm starts like Dijkstra's algorithm at the start node and examines
the node that is *most likely* to lead to the target, until it is reached. To determine
this *most likely* node, each node is assigned a cost $f(x)$ that estimates how
long the path from the start node to this node and from here to the target node
is.

$f(x) = g(x) + h(x)$

For a node $x$, $f(x)$ denotes the sum of $g(x)$ and $h(x)$. Here, $g(x)$ notes
the cost from the start node to node $x$, and $h(x)$ is the estimate of the remaining
distance to the target node. The estimate $h(x)$ is also known as a heuristic.
This heuristic can vary depending on the application, but for pathfinding, it
may use the straight-line distance between node $x$ and the target node to get
a rough idea of the remaining costs.

Following, the functionality is divided into clear steps. It is recommended to
first look at the functionality of [Dijkstra's algorithm][dijkstra-functionality],
as the A* algorithm builds on it and the steps are very similar.

1. Create a set of all nodes that have not yet been checked.
2. Assign each node a distance from the start node; for the start node,
   this is 0, and for all others, it is infinity, as no path to these has been found
   yet. During execution, these will be replaced by the shortest found paths.
3. Choose the node with the smallest finite distance from the set of
   unvisited nodes; initially, this will be the start node. If the set is empty
   or no node with a finite distance is found, the algorithm is finished and can
   proceed to step 7. If only the path to the target node is relevant, the algorithm
   can also jump to step 7 if the current node is the target node.
4. For the current node, calculate the costs of all neighbors that have not yet
   been visited by adding the edge weight to the path cost of the current node
   and the heuristic of the neighbor, which together give its costs.
5. Compare the newly calculated costs with the current costs of the neighbor,
   and if they are smaller, update the neighbor's costs to the newly calculated
   costs. If the new costs are larger, they remain unchanged.
6. After all neighbors of the current node have been checked, mark the
   current node as visited and remove it from the set of unvisited nodes. This ensures
   that it will not be checked again, which is correct because the stored distance
   on the node is already minimal (ensured by step 3) and therefore final.  
   Go back to step 3.
7. After the loop is finished (steps 3-6), all nodes contain
   the shortest distance from the start node.

## Pseudocode

The following is a pseudocode example of the A* algorithm. It uses a priority
queue to obtain the nodes with the smallest distance and a heuristic that calculates
the straight-line distance between two nodes. Additionally a simple optimization
is used, where not all nodes are initialized with an infinite distance at the
beginning, but new nodes are discovered gradually.

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

[A* algorithm - Wikipedia][a*-wiki]  

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

[a*-wiki]: https://en.wikipedia.org/wiki/A*_search_algorithm
[heuristic-wiki]: https://en.wikipedia.org/wiki/Heuristic
[dijkstra-algorithmus]: dijkstra's_algorithm/
[dijkstra-functionality]: dijkstra's_algorithm/#funktionsweise
