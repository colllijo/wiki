---
weight: 2100
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
code.  
Depending on the project, it may be useful to adhere to the principles with
different degrees of strictness.

## Single Responsibility Principle (SRP)

The goal of the single responsibility principle is the [separation of concerns](https://en.wikipedia.org/wiki/Separation_of_concerns) within a program.
This separation is achieved by ensuring a single class contains all things which have a specific reason to change and nothing more.
This way each class is only responsible for the requirements of a specific thing.

## Open/Closed Principle (OCP)

The entities which make up software must be open for extension (open), but
closed from modifications, it needs to be extensible without changing the
original (closed).

## Liskov Substitution Principle (LSP)

The execution of an operation of class `T` on class `S` must lead to the same
result as executing the operation on class `T` if class `S` is a subclass of
class `T`. If this is not the case, the Liskov substitution principle is violated.

This leads to the requirement that subclasses must fulfill an is-a criterion.
Given the classes `Circle` and `Ellipse`, it is planimetrically correct to
assume that a `Circle` is an `Ellipse` and therefore a subclass of `Ellipse`.
But if `Ellipse` has functionalities that allow it's axis to be scaled independently,
then a `Circle` is no longer an `Ellipse` because a `Circle` must always be scaled
equally in both axis.

## Interface Segregation Principle (ISP)

Interfaces should be created in a way that they fit the clients needs.
A client should not be forced to use interfaces it doesn't need and
the interface shouldn't provide methods which aren't used.

## Dependency Inversion Principle (DIP)

Moduls of higher levels should not depend on modules of lower levels but on
abstracts. These abstracts should not depend on details, but the details should
depend on them.

Resources:  
[Wikipedia - SOLID](https://en.wikipedia.org/wiki/SOLID)  
[Wikipedia - Prinzipien objektorientiertes Designs](https://de.wikipedia.org/wiki/Prinzipien_objektorientierten_Designs#SOLID-Prinzipien)  

[Wikipedia - Single Responsibility Principle](https://de.wikipedia.org/wiki/Single-Responsibility-Prinzip)  
[Wikipedia - Open-closed principle](https://en.wikipedia.org/wiki/Open%E2%80%93closed_principle)  
[Wikipedia - Liskovsches Substitutionsprinzip](https://de.wikipedia.org/wiki/Liskovsches_Substitutionsprinzip)  
[Wikipedia - Interface segregation principle]()  
[Wikipedia - Dependency inversion principle](https://en.wikipedia.org/wiki/Dependency_inversion_principle)  
