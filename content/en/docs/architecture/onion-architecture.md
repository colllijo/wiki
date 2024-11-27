---
weight: 1100
title: "Onion Architecture"
description: "Information and notes about Onion Architecture"
icon: "article"
date: "2024-06-14T16:10:13+02:00"
lastmod: "2024-06-14T16:10:13+02:00"
draft: false
toc: true
---

## Introduction

An Onion Architecture tries to create applications as *modular* as
possible. This should make the maintenance of the application easier.
It also aims to provide a basis for developing *flexible*, *testable*, and
*extensible* code.  
The large goal of the architecture is to make components easily exchangeable,
without affecting other parts of the application, by avoiding fixed
dependencies and instead only using Interfaces as contracts between components.

{{< split type="start" size="3fr 1fr" >}}

## Concepts

### Dependencies

In an Onion Architecture, the dependencies flow from the outer layers to the
inner layers. This allows the inner modules to work without knowing about the
outer layers. This avoids fixed dependencies, making it possible to easily swap
components. This without the need to touch other parts of the application.

### Layers

**Domain:** In the domain layer, the different business domains required by the
application are depicted. This is where the actual business cases with their
logic and entities are implemented.

**Application:** The application layer allows the different use cases to work.
For this the application layer enables the flow of data between the different
components and layers of the application.

**Infrastructure:** The infrastructure layer provides the interfaces to the
outside world. It implements the communication of the application with other
services and systems. For example like a database, a REST-API or many other
services needed / used by the application.

**Presentation:** The presentation layer is part of the infrastructure. But
instead of communication with other systems, it communicates with the user.
This is done by providing a user interface like a website for example.

{{< split >}}

![Model of an Onion Architecture](/docs/images/architecture/onion/onion-model.png "Model of the Onion Architektur")

{{< split type="end" >}}
