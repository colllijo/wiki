---
weight: 3101
title: "Linked List"
description: |
  Documentation of a linked list.
icon: "link"
date: "2025-02-26T13:18:04+01:00"
lastmod: "2025-02-26T13:18:04+01:00"
draft: false
toc: true
---

## Introduction

A linked list is a data structure that allows data to be stored in a sequential
order by linking individual elements together. This means that for each
element in the list, a reference to the next element is also stored. This
makes it easy to iterate through the list and it is not necessary to store
the entire list in a contiguous memory area.

## Concept

In a linked list, all values are bound to an element that holds not only
the value but also one or more references to other elements in the list. The
first element of a list is called the `head`, as it represents the beginning
of the list and it is possible to access the rest of the list from this
element. This element is passed to methods or functions that need to work
with the list. The so-called `tail` of the list refers either to the part
of the list that is not the `head` or to the last element of the list.

### Singly linked list

In a singly linked list, each element is stored with a reference to the next
element. The last element of the list holds a special value indicating that
this is the end of the list, usually `null` or `nullptr`.

A simple example of a singly linked list with the elements (12 ➡ 42 ➡ 9):

![Example of a singly linked list][ssl-img]

### Doubly linked list

In a doubly linked list, each element is stored with a reference to the
next and the **previous** element. This allows the list to be traversed in
both directions.

Here again is the example with the elements (12 ↔ 42 ↔ 9) in a doubly
linked list:

![Example of a doubly linked list][dsl-img]

## Advantages and Disadvantages

Linked lists are a way to store data sequentially, offering certain advantages
and disadvantages compared to other methods. The biggest advantages and
disadvantages are listed below.

### Advantages

- **Easy iteration of the list**: Each element points to the next, making it
  easy to traverse the list.
- **Easy insertion and deletion of elements**: Elements can be inserted or
  deleted in constant time (O(1)) by adjusting the references.

### Disadvantages

- **Access to elements by index**: Access requires traversing the list, which
  takes O(n) time on average.
- **Less cache-friendly (data is scattered in memory)**: Elements are not stored
  contiguously, leading to more frequent cache misses.

## Resources

[Linked Lists - Wikipedia][linked-lists-wiki]

## Implementations

{{< expand "Singly linked list in C++" >}}
{{< /expand >}}

[ssl-img]: /docs/images/algorithm_data-structure/list/singly-linked-list.png
[dsl-img]: /docs/images/algorithm_data-structure/list/doubly-linked-list.png

[linked-lists-wiki]: https://en.wikipedia.org/wiki/Linked_list
