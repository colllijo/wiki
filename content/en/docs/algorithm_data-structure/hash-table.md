---
weight: 3200
title: "Hash table"
description: |
  Documentation about hash tables.
icon: "article"
date: "2025-06-18T10:07:09+02:00"
lastmod: "2025-06-18T10:07:09+02:00"
draft: false
toc: true
---

## Introduction

A hash table is a data structure that stores key-value pairs. The key-value pairs
are stored in a special kind of array that allows efficient searching, inserting
and deletion based on the key.

## Concept

A hash table uses a hash function to calculate the index into the array of buckets
based on the key as input. This index is then used to store the key-value pair.
And as the index can be calculated using the key, it is possible to edit the element
in constant time.

As the indexing must be fast, most hash tables use imperfect hash functions, which
can lead to collisions. These collisions must then be handled to ensure that every
element is stored and correctly retrieved. It would be detrimental if the hash table
simply overwrites entries due to a collision. For this reason, hash tables in reality
don't always have constant time complexity, as in the worst case, where all hashes
collied, all elements must be searched manually to find the desired element.

This is why the hashing of the table always is a space-time tradeoff. If unlimited
memory is available, the complete key can directly be used to index any element.
Leading to every element having it's own designated location and no collisions.
And if unlimited time is available, the values can also be stored without a hash
as all elements can simply be searched manually.  
Therefore in reality, one tries to scale the hash table so that as few collisions
happen as possible with minimal memory usage, for this many implementations also
use an approach called rehashing, where the hash map is dynamically enlarged or
shrunk to properly fit the number of elements.

## Usage

Hash tables are one of the most commonly used data structures in computer science.
They form the basis of most associative arrays (maps, dictionaries), but also sets.

Additionally, due to their fast access and update times, hash tables are often
used for memoization, caching or other lookup tasks and are also used in databases
to index data.

## Collision resolution

For the resolution of collisions of two indices, there are mainly two approaches.
Hashing with chaining or hashing with open addressing.

When using hashing with chaining, it is accepted that not every element has its
own space in the array. Instead, each index is treated as a bucket that contains
all elements that hash to the same index. This most often is done using a linked
list, but can also be done using other data structures like a tree or a list.
Then when receiving a key, the hash identifies the bucket which is then searched
for the key.

With hashing with open addressing, it is ensured that every element has its
own space in the array. This is done by using the hash as a starting point and then
using a deterministic probing algorithm to find the *next* free space in the array.
On lookup, this can then be done in the exact same way, starting at the hash and
then probing until the key is found or an empty space is reached, indicating that
the value is not in the hash table. This approach has an important disadvantage
the more elements are in the has table, the longer it will take to find any given
element or an empty space. This results in an infinite loop once all spaces are
filled in and an element is searched that is not in the hash table, as no empty
space will be found.

## Dynamic resizing

The repeated insertion of elements into a hash table leads to an increased of the
load factor. The ration of elements stored to available buckets, is getting larger.
A higher load factor means a higher chance of a collision, resulting in worse
performance. For this reason, many implementations dynamically scale the number
of buckets to keep the load factor in a range that allows efficient access without
requiring too much memory.

For doing this, the number of buckets cannot simply be doubled, as the indices
of the already stored elements depend on the number of buckets. Instead, the
the entire table must be rehashed. This extra effort is justified, as otherwise
the efficiency of the hash table would degrade from O(1) towards O(n). Moreover,
if the number of buckets is always at least doubled or halved, the effort of rehashing
is amortized over the calls.

## Resources

[Hash table - Wikipedia][hashtable-wiki]

[hashtable-wiki]: https://en.wikipedia.org/wiki/Hash_table
