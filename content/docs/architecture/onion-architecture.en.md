---
weight: 999
title: "Onion Architecture"
description: "Simple Information and notes about the Onion Architecture"
icon: "article"
date: "2024-06-14T16:10:13+02:00"
lastmod: "2024-06-14T16:10:13+02:00"
draft: true
toc: true
---

## Introduction

The Onion Architecture tries to create applications as *modular* as possible.
By doing so, the maintenance of the application can be kept simple. It is
meant to provide a basis to create an environment for *flexible*, *testable*,
and *extensible* developement.  
The big goal is to make components easily exchangeable and interchangeable
without needing to break open other parts of the application, a core part of
making this possible is to avoid creating fixed dependencies and only using
interfaces for communication between components.

![Model of an Onion Architecture](images/architecture/onion/onion-model.png)

## Concepts

### Dependencies

In an Onion Architecture, dependencies flow from the outside to the inside.
This results in the inner layers of the application not needing to know
about the outer components. This gets rid of fixed dependencies and makes
it possible to easily exchange conpomnents without editing other parts of
the application.

### Layers

**Domain:** The domain layer is used to represent the different domains of a
business. Here the actual business logic and entities are implemented.

**Application:** The application layer provides the different use cases of the
application. And it enabled the flow of data between the different elements
and layers of the application.

**Infrastructure:** The infrastructure layer provides the interfaces to the
outside world. It implements the communication of the application with other
services and systems. For example like a database, a REST-API or many other
services needed by the application.

**Presentation:** The presentation layer is part of the infrastructure. But
instead of communication with other systems, it communicates with the user.
This is done by providing a user interface like a website for example.
