---
weight: 3302
title: "Quick Sort"
description: "Functionality of the quicksort algorithm"
icon: "sort"
date: "2025-01-15T08:31:41+01:00"
lastmod: "2025-01-15T08:31:41+01:00"
draft: false
toc: true
katex: true
---

## Introduction

The [`Quicksort`][quicksort-wiki] algorithm is a fast non-stable sorting
algorithm, which applies the divide and conquer concept. Non-stable means that
the order of elements with the same sorting key is not necessarily maintained.
It was developed around 1960 by [Antony R. Hoare][antony-r-hoare] and has been
improved several times since then.

The `Quicksort` algorithm has an average runtime of $O(n \log n)$ and a
worst-case runtime of $O(n^2)$. In the worst case, the `Quicksort` algorithm has
space complexity of $O(n)$.

## Functionality

The `Quicksort` algorithm splits a list into two sublists ensuring that one
sublist contains only elements smaller than a chosen pivot and the other sublist
contains only elements larger than the pivot. This process is repeated on the
two sublists until the entire list is sorted.

This follows these instructions:

1. If the list contains less than two elements, return directly as there is
   nothing to do, a list with only one or less element is always sorted.
2. If this isn't the case choose an element from the list as the `pivot`. The
   method by which the `pivot` is chosen can vary depending on the
   implementation.
3. Now the list needs to be partitioned, for this a point of partition is chosen
   and all elements smaller than the pivot are placed in one sublist and all
   elements larger in the other. It can make sense to choose the pivot as the
   center point between the two sublists, as it will already be in the correct
   position and doesn't need to be sorted further.
4. Now this process can be repeated recursively on both sublists until the list
   is sorted.

## Example

To illustrate the `Quicksort` algorithm, consider the following example, given
is the following list:

$$
\boxed{3} \quad \boxed{1} \quad \boxed{4} \quad \boxed{1} \quad \boxed{5} \quad
\boxed{9} \quad \boxed{2} \quad \boxed{6} \quad \boxed{5} \quad \boxed{3}
$$

As this list contains more than one element we need to choose a `pivot`. In this
example I simply choose the last value of the list, so `3`.

$$
\boxed{3} \quad \boxed{1} \quad \boxed{4} \quad \boxed{1} \quad \boxed{5} \quad
\boxed{9} \quad \boxed{2} \quad \boxed{6} \quad \boxed{5} \quad
\color{red}{\boxed{3}}
$$

Now that we have a `pivot` we can ensure that all elements smaller than the
`pivot` are on the left side of the list and all elements larger than the
`pivot` are on the right side  
For this we start on the left side of the list and search for an element which
isn't smaller than the `pivot`. This will be the first element `3`.

$$
{\color{blue}{\boxed{3}}} \quad \boxed{1} \quad \boxed{4} \quad \boxed{1} \quad
\boxed{5} \quad \boxed{9} \quad \boxed{2} \quad \boxed{6} \quad \boxed{5} \quad
{\color{red}{\boxed{3}}}
$$

Now we do the same thing starting from the right side and search for the first
element that isn't larger than the `pivot`. On the first search this will always
be the `pivot`.

$$
{\color{blue}{\boxed{3}}} \quad \boxed{1} \quad \boxed{4} \quad \boxed{1} \quad
\boxed{5} \quad \boxed{9} \quad \boxed{2} \quad \boxed{6} \quad \boxed{5} \quad
{\color{green}{\boxed{3}}}
$$

Now both elements get swapped, this process of searching from the left and right
and the swapping the two elements continues until the two searches meet. For
our list this looks like this.

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

Now that the two searches have met each other we can partition out list into two
parts. The left part contains all elements up to the `1` which was found by the
right search and the right half contains the rest.

$$
\boxed{3} \quad \boxed{1} \quad \boxed{2} \quad \boxed{1} \quad \mid \quad
\boxed{5} \quad \boxed{9} \quad \boxed{4} \quad \boxed{6} \quad
\boxed{5} \quad \boxed{3}
$$

Now we can repeat the process on both parts of the list until it is sorted.
For simplicity I will only show the left part of the list.

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

Now that we only have one element left this part of the list is sorted.

$$
\boxed{1}
$$

After the remaining parts of the list are sorted the complete list looks like
this:

$$
\boxed{1} \quad \boxed{1} \quad \boxed{2} \quad \boxed{3} \quad \boxed{3} \quad
\boxed{4} \quad \boxed{5} \quad \boxed{5} \quad \boxed{6} \quad \boxed{9}
$$

## Pseudocode

To define the algorithm, we can use the following pseudocode:

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

## Resources

[Quicksort - Wikipedia][quicksort-wiki]
[Quicksort - Geeks for Geeks][quicksort-geeks]

## Impllementations

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
