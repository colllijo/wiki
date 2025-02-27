---
weight: 3102
title: "Array"
description: |
  Documentation about arrays
icon: "data_array"
date: "2025-02-26T14:45:25+01:00"
lastmod: "2025-02-26T14:45:25+01:00"
draft: false
toc: true
---

## Introduction

An array is a data structure that stores a group of elements sequentially in
memory. An element from the list can be read from memory using the index, which
is applied as an offset to the first element.

## Concept

Arrays are a contiguous block in memory that represents a collection of elements
of the same data type. Each element in the array has an index that represents
the position of the element in the array and is applied as an offset to the
start of the memory block to access it. This makes it very easy to find any
element in the array.  
As the index is used as an offset to the memory block, arrays in many
programming languages are zero-based, as the offset of the first element is 0.

### Static Arrays

Static arrays are arrays with a fixed size that must be known at compile time.
The size of these arrays cannot be changed later, meaning that the array must
be large enough to hold all elements it ever needs to hold when declared.

### Dynamic Arrays

Dynamic arrays are based on static arrays but also offer the possibility to
expand the size of the array. To do this, a new memory block must be reserved
and the elements of the old array must be copied into the new array.

As it is very inefficient to copy the entire array every time an element is
added, most dynamic array implementations use a better approach.  
Next to the reference to the memory block containing the elements, the capacity
and size of the array are stored. This allows new elements to be easily added
to the array as long as the size is smaller than the capacity. Only when the
capacity is reached is a new memory block reserved. The size of the new memory
will usually be twice as large as before, ensuring that the additional
computational time used for this operation is amortized.

## Advantages and Disadvantages

Arrays offer the ability to store a group of data sequentially, but they have
their own advantages and disadvantages compared to other data structures.

### Advantages

- **Fast Index Access**: Since the index is used as an offset to the memory
  block, an element in the array can be found in constant time.
- **Cache-Friendly**: Since the elements are stored contiguously in memory,
  multiple elements can be loaded into the cache at once.
- **Efficient for Small Data Sets**: For a small number of elements, an array is
  usually more efficient than other data structures.

### Disadvantages

- **Static Size**: Static arrays have a fixed size, which must be known at
  compile time.
- **Resizing**: Dynamic arrays must copy the elements to a new memory block when
  resizing, which can be very inefficient.

## Resources

[Arrays - Wikipedia][array-wiki]  
[Dynamic Arrays - Wikipedia][dynamic-array-wiki]  

## Implementationen

[array-wiki]: https://en.wikipedia.org/wiki/Array_(data_structure)
[dynamic-array-wiki]: https://en.wikipedia.org/wiki/Dynamic_array
