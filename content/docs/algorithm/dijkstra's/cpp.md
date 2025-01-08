---
weight: 3111
title: "C++ Implementation"
description: "C++ Implementation von Dijkstra's Algorithmus"
icon: "code"
date: "2025-01-08T16:19:35+01:00"
lastmod: "2025-01-08T16:19:35+01:00"
draft: false
toc: true
---

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

  Node(const std::string& name): name(name) {}
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

std::tuple<std::map<struct Node *, int>, std::map<struct Node *, struct Node *>> dijkstras(struct Node *start, Graph *graph)
{
  using QueueType = std::tuple<int, struct Node *>;

  std::priority_queue<QueueType, std::vector<QueueType>, std::greater<QueueType>> queue;

  std::map<struct Node *, int> distances;
  std::map<struct Node *, struct Node *> previous;

  distances[start] = 0;
  previous[start] = nullptr;

  queue.push(std::make_tuple(0, start));

  do
  {
    auto [distance, current] = queue.top();
    queue.pop();

    for (const auto& neighbor : graph->getNeighbors(current))
    {
      int newDistance = distance + graph->getDistance(current, neighbor);

      if (!distances.count(neighbor) || newDistance < distances[neighbor])
      {
        distances[neighbor] = newDistance;
        previous[neighbor] = current;
        queue.push(std::make_tuple(newDistance, neighbor));
      }
    }
  } while (!queue.empty());

  return std::make_tuple(distances, previous);
}

int main(int argc, char *argv[])
{
  Node *Bern = new Node("Bern");
  Node *Basel = new Node("Basel");
  Node *Luzern = new Node("Luzern");
  Node *Lugano = new Node("Lugano");
  Node *Zürich = new Node("Zürich");
  Node *Chur = new Node("Chur");

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

  auto [distances, previous] = dijkstras(Bern, graph);

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
