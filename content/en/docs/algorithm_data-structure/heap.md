---
weight: 3201
title: "Heap"
description: |
  Documenation about the Heap data structure.
icon: "article"
date: "2025-07-01T08:42:58+02:00"
lastmod: "2025-07-01T08:42:58+02:00"
draft: false
toc: true
---

## Introduction

A heap is a data structure that stores a collection of elements in a partially ordered
binary tree. For this each element in the heap must have a key, which is used to
determine it's order in the heap based on the heap's comparison function.  
Such a heap can be used to implement a priority queue, which allows to remove the
element with the highest or lowest priority from a collection of elements.

## Concept

A heap describes a binary tree that satisfies the heap property. There are two
different types of heaps, the max-heap, where for each node in the tree the key
must be larger or equal to the keys of its children, and the min-heap, where the
key must be smaller or equal to the keys of its children.

A heap should support at least the following operations:

**Heapify**:  
The heapify operation rearranges the elements of the heap to restore the heap property.
It is performed when a specific element was changed by one of the other operations.
Which may result in the heap property being violated. The heapify operation can
occur in two different forms.

*Up-Heapify*: Restores the heap property from the bottom up, ensuring that the heap
property holds from a specific node up to the root of the tree.

*Down-Heapify*: Restores the heap property from the top down, ensuring that the
heap property holds from a specific node down to its leaves.

**Insert**:  
Adds a new element to the end of the heap and then uses the up-heapify operation
to restore the heap property.

**Remove**:  
Removes an element from the heap and replaces it with the last element. Afterwards
the last element can be deleted and the down-heapify operation is used to restore
the heap property.

**Peek**:  
Returns the element at the root of the heap, which has the highest or lowest
priority (max-heap or min-heap), without removing it.

**Pop**:  
Removes and returns the element at the root of the heap, which has the highest
or lowest priority (max-heap or min-heap) before restoring the heap property akin
to the remove operation.

**Build heap**:  
Creates a heap from a simple list of elements. This operation can be used to restore
the heap property more efficiently than inserting each element one by one.

### Implementation

For implementing a heap, there are different approaches, the easiest of which is
the binary heap. For the binary heap, the elements are stored in a static or dynamic
array, and the parent-child relationships of the binary tree are implicitly defined
by the indices of the elements in the array.

For an array with a starting index of 0, the relationships are defined as follows:
Index of the left child: `2 * i + 1`
Index of the right child: `2 * i + 2`
Index of the parent: `(i - 1) / 2`

When storing a complex data structure in the heap, the heap can simply store
a reference to the actual elements instead of the elements themselves.

## Usage

Heaps are primarily used for implementing priority queues. However, the heap property
may also be used to sort a collection of elements in-place. The algorithm used for
this is called [Heap-Sort][heapsort-wiki].

## Resources

[Heap - Wikipedia][heap-wiki]  

[heap-wiki]: https://en.wikipedia.org/wiki/Heap_(data_structure)
[heapsort-wiki]: https://en.wikipedia.org/wiki/Heapsort
