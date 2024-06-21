---
weight: 100
title: "SOLID"
description: "Information about the basic acronym of the object-oriented programming, SOLID."
icon: "article"
date: "2024-06-14T16:56:21+02:00"
lastmod: "2024-06-14T16:56:21+02:00"
draft: false
toc: true
---

Solid describes 5 principles of object-oriented programming. These can be used
individually, but together they lead to the creation of robust and maintainable
programs.  
Depending on the project, it may be useful to adhere to the principles to
different degrees.

## Single Responsibility Principle

A class has only one reason to exist. It only has this use and therefore it's
only responsibility is to fulfill this purpose.

## Open/Closed Principle

The entities which make up software must be open for extension (open), but
closed from modifications, it needs to be extensible without changing the
original (closed).

## Liskov Substitution Principle

A class using a method of a different class should not need to worry if it is
calling the method on the base class or any of the derived/sub classes.

## Interface Segregation Principle

Interfaces should be created in a way that they fit the clients needs.
A client should not be forced to use interfaces it doesn't need and
the interface shouldn't provide methods which aren't used.

## Dependency Inversion Principle

Moduls of higher levels should not depend on modules of lower levels but on
abstracts. These abstracts should not depend on details, but the details should
depend on them.
