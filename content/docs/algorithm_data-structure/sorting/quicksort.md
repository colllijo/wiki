---
weight: 3302
title: "Quicksort"
description: "Funktionsweise des Quicksort Algorithmus"
icon: "sort"
date: "2025-01-15T08:31:35+01:00"
lastmod: "2025-01-15T08:31:35+01:00"
draft: false
toc: true
katex: true
---

## Einführung

Der [`Quicksort`][quicksort-wiki] Algorithmus ist ein schneller nicht-stabiler
Sortieralgorithmus, welcher nach dem Teile und herrsche Konzept arbeitet. Dabei
bedeutet nicht-stabil, dass die Reihenfolge von Elementen mit dem gleichen
Sortierschlüssel nicht unbedingt beibehalten wird. Er wurde ca. 1960 von
[Antony R. Hoare][antony-r-hoare] entwickelt und seither mehrmals verbessert.

Der `Quicksort` Algorithmus hat im Durchschnitt eine Laufzeit von $O(n \log n)$
und im schlimmsten Fall eine Laufzeit von $O(n^2)$. Dabei hat der `Quicksort`
Algorithmus im schlimmsten Fall eine Platzkomplexität von $O(n)$.

## Funktionsweise

Der `Quicksort` Algorithmus teilt eine Liste in zwei Teillisten auf, wobei
sichergestellt wird, dass kein Element der ersten Teilliste grösser als ein
Element der zweiten Teilliste ist. Dieser Prozess wird solange auf den beiden
Teillisten wiederholt, bis die ganze Liste sortiert ist.

Dazu werden folgende Instruktionen befolgt:

1. Enthält die liste weniger als zwei Element kehre direkt zurück, da nichts zu
   tun ist.
2. Falls dies nicht der Fall ist wähle ein Element `Drehpunnkt` oder `pivot`
   genannt, aus der Liste. Die Art wie dieser Punkt gewählt wird kann je nach
   Implementation anders definiert sein.
3. Teile die Liste in zwei Teile, so dass alle Element kleiner dem `Drehpunkt`
   in einem und alle grösser im anderen Teil sind. Hier kann es Sinn machen
   den `Drehpunkt` an den Mittelpunkt zwischen den beiden Teillisten zu setzen,
   da dieser so bereits am korrekten Punkt in der Liste ist und nicht weiter
   sortiert werden muss.
4. Nun kann dieser Prozess rekrusive auf beide Teillisten bis die Liste sortiert
   ist.

## Beispiel

Um den `Quicksort` Algorithmus zu verdeutlichen, betrachten wir folgendes
Beispiel, gegeben ist folgende Liste:

$$
\boxed{3} \quad \boxed{1} \quad \boxed{4} \quad \boxed{1} \quad \boxed{5} \quad
\boxed{9} \quad \boxed{2} \quad \boxed{6} \quad \boxed{5} \quad \boxed{3}
$$

Da diese List mehr als ein Element enthält müssen wir einen `Drehpunkt` wählen.
In diesem Beispiel nehme ich einfach den letzten Wert der Liste, also `3`.

$$
\boxed{3} \quad \boxed{1} \quad \boxed{4} \quad \boxed{1} \quad \boxed{5} \quad
\boxed{9} \quad \boxed{2} \quad \boxed{6} \quad \boxed{5} \quad
\color{red}{\boxed{3}}
$$

Da wir nun einen `Drehpunkt` haben können wir sicherstellen, dass alle Element
kleiner als der `Drehpunkt` auf der linken Seite der Liste und alle Elemente
grösser als der Drehpunkt auf der rechten Seite sind.  
Dazu fangen wir von der linken Seite an ein Element zu suchen, welches nicht
kleiner ist als der `Drehpunkt`. Dadurch finden wir das erste Element `3`.

$$
{\color{blue}{\boxed{3}}} \quad \boxed{1} \quad \boxed{4} \quad \boxed{1} \quad
\boxed{5} \quad \boxed{9} \quad \boxed{2} \quad \boxed{6} \quad \boxed{5} \quad
{\color{red}{\boxed{3}}}
$$

Diesen machen wir jetzt auch von der rechten Seite her und Suchen ein Element,
welches nicht grösser als der `Drehpunkt` ist. Dies wird beim ersten Durchlauf
immer unser `Drehpunkt` sein.

$$
{\color{blue}{\boxed{3}}} \quad \boxed{1} \quad \boxed{4} \quad \boxed{1} \quad
\boxed{5} \quad \boxed{9} \quad \boxed{2} \quad \boxed{6} \quad \boxed{5} \quad
{\color{green}{\boxed{3}}}
$$

Nun werden diese beiden Element getauscht, dieser Prozess wiederholt sich so
lange, bis sich unsere linke und rechte Suche treffen. Für unsere Liste sieht
dieser Prozess so aus.

$$
\boxed{3} \quad \boxed{1} \quad {\color{blue}{\boxed{4}}} \quad \boxed{1} \quad
\boxed{5} \quad \boxed{9} \quad {\color{green}{\boxed{2}}} \quad \boxed{6} \quad
\boxed{5} \quad \boxed{3}
$$

$$
\boxed{3} \quad \boxed{1} \quad {\color{green}{\boxed{2}}} \quad \boxed{1} \quad
\boxed{5} \quad \boxed{9} \quad {\color{blue}{\boxed{4}}} \quad \boxed{6} \quad
\boxed{5} \quad \boxed{3}
$$

$$
\boxed{3} \quad \boxed{1} \quad \boxed{2} \quad {\color{green}{\boxed{1}}} \quad
{\color{blue}{\boxed{5}}} \quad \boxed{9} \quad \boxed{4} \quad \boxed{6} \quad
\boxed{5} \quad \boxed{3}
$$

Da sich nun unsere beiden Suchen getroffen haben, können wir unsere List in
zwei Teillisten Teilen. Dabei geht der linke Teil der Liste bis zur `1`, welche
durch die rechte Suche gefunden wurde und der rest geht in die rechte Hälfte

$$
\boxed{3} \quad \boxed{1} \quad \boxed{2} \quad \boxed{1} \quad \mid \quad
\boxed{5} \quad \boxed{9} \quad \boxed{4} \quad \boxed{6} \quad
\boxed{5} \quad \boxed{3}
$$

Nun können wir diese beiden Listen rekrusiv weiter sortieren, der Einfachheit
halber zeige ich jeweils nur den Sortiervorgang der linken hälfte auf.

$$
{\color{blue}{\boxed{3}}} \quad \boxed{1} \quad \boxed{2} \quad
{\color{green}{\boxed{1}}}
$$

$$
{\color{green}{\boxed{1}}} \quad \boxed{1} \quad \boxed{2} \quad
{\color{blue}{\boxed{3}}}
$$

$$
{\color{green}{\boxed{1}}} \quad {\color{blue}{\boxed{1}}} \quad \boxed{2} \quad
\boxed{3}
$$

$$
\boxed{1} \quad \mid \quad \boxed{1} \quad \boxed{2} \quad
\boxed{3}
$$

Da wir nun nur noch ein Element haben ist dieser Teil der Liste fertig sortiert.

$$
\boxed{1}
$$

Nachdem die restlichen Teillisten auch sortiert wurden sieht die vollständige
List wie folgt aus:

$$
\boxed{1} \quad \boxed{1} \quad \boxed{2} \quad \boxed{3} \quad \boxed{3} \quad
\boxed{4} \quad \boxed{5} \quad \boxed{5} \quad \boxed{6} \quad \boxed{9}
$$

## Pseudocode

Um diesen Algorithmus etwas klarer zu definieren wird er hier in Form von
Pseudocode dargestellt.

```javascript
function quicksort(arr, low, high) {
  // Stop out of bounds access
  if (low < 0 || low >= list.size() || high < 0 || high >= list.size()) {
    return;
  }

  if (low < high) {
    pivot = partition(arr, low, high);

    quicksort(arr, low, pivot);
    quicksort(arr, pivot + 1, high)
  }
}

function partition(arr, low, high) {
  pivot = arr[high];

  i = low - 1;
  j = high + 1;

  for(;;) {
    do { i++; } while (arr[i] < pivot);
    do { j--; } while (arr[j] > pivot);

    if (i >= j) {
      return j;
    }

    swap(arr[i], arr[j]);
  }
}

quicksort(list, 0, list.size() - 1);
```

## Ressourcen

[Quicksort - Wikipedia][quicksort-wiki]
[Quicksort - Geeks for Geeks][quicksort-geeks]

## Implementationen

{{< expand title="Implementation in C++" >}}

{{< prism lang="cpp" line-numbers="true" >}}

#include <bits/stdc++.h>
#include <iostream>
#include <utility>
#include <vector>

int partition(std::vector<int> &arr, int low, int high) {
  int pivot = arr[high];

  int i = low - 1;

  for (int j = low; j < high; j++) {
    if (arr[j] < pivot) {
      i++;
      std::swap(arr[i], arr[j]);
    }
  }

  // Move the pivot to the position between both list parts.
  // This puts the pivot in the correct position, allowing it
  // to be excluded from the next recursive calls.
  std::swap(arr[i + 1], arr[high]);

  return i + 1;
}

void quicksort(std::vector<int> &arr, int low, int high) {
  if (low < 0 || low >= arr.size() || high < 0 || high >= arr.size()) {
    return;
  }

  if (low < high) {
    int pivot = partition(arr, low, high);

    quicksort(arr, low, pivot - 1);
    quicksort(arr, pivot + 1, high);
  }
}

int main() {
  std::vector<int> list = {3, 1, 4, 1, 5, 9, 2, 6, 5, 3};

  quicksort(list, 0, list.size() - 1);

  for (const auto &i : list) {
    std::cout << i << " ";
  }
  std::cout << std::endl;

  return 0;
}

{{< /prism >}}

{{< /expand >}}

[quicksort-wiki]: https://en.wikipedia.org/wiki/Quicksort
[antony-r-hoare]: https://de.wikipedia.org/wiki/C._A._R._Hoare
[quicksort-geeks]: https://www.geeksforgeeks.org/quick-sort-algorithm/
