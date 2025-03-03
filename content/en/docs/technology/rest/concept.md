---
weight: 4501
title: "Concept"
description: |
  Information about REST and its concept
icon: "article"
date: "2025-02-28T09:00:38+01:00"
lastmod: "2025-02-28T09:00:38+01:00"
draft: false
toc: true
---

## What is Representational State Transfer (REST)?

Representational State Transfer (REST) is a paradigm for software architecture
with the aim of simplifying communication between machines through a uniform
API. REST is applied via the HTTP protocol and is primarily aimed at web
services. It was developed around the turn of the millennium by
[Roy Fielding][roy-fielding-wiki].  
The name Representational State Transfer comes from the goal that REST-compliant
services should transmit the representation of their state to the querying
party.

## The RESTful Philosophy

REST is more of a philosophy than a specific technology. There is no fixed set
of rules, only a series of principles that developers are responsible for
adhering to in their implementation.

### Client-Server

To use REST, a client-server architecture must exist that allows the server to
provide a service by transmitting its state to the client.

### Statelessness

Every REST message should contain the full state required by the client. For
this to work, it is necessary that the server itself does not store any
additional state that is not transmitted to the client.  
This Statelessnes can be a great advantage, as it makes it very easy to scale a
server horizontally and distribute the payload across it. It doesn't matter
which server the client communicates with, as no server stores a state.

### Uniform Interface

For a REST interface, it is important that this interface is implemented
uniformly so that it is easier to use.

Additionally, endpoints in REST do not represent methods, but the resources the
client wants to access. What should be done with a resource is defined by the
HTTP method the client uses in his request.

REST does not dictate how resources should be represented, but it is required
that a server offers a resource in different languages or formats (HTML, JSON,
XML) which the client can request via HTTP headers.

### HATEOAS

[**H**ypermedia **a**s **t**he **E**ngine **o**f **A**pplication **S**tate][hateoas-wiki]
(HATEOAS) is, according to Fielding, the most important constraint of REST.
But is also the least implemented. HATEOAS means that the server not only
provides the state of the resource requested, but also links to all possible
relations or actions possible with said resource. By doing so, the client can
explore and use the entire API even with only knowing a single URL.

## Richardson Maturity Model

The by Leonard Richardson developed Richardson Maturity Model is a scale to
measure the maturity of a RESTful API. It consists of four levels that describe
how mature an API is.

{{% table "table-responsive table-bordered table-striped" %}}

| **Stufe** | **Beschreibung**                                                                                                                           |
| --------: | ------------------------------------------------------------------------------------------------------------------------------------------ |
|         0 | **The Swamp of POX**: The API uses only HTTP as a transport protocol without utilizing the benefits of HTTP.                               |
|         1 | **Resources**: The API uses resources and unique URIs, to identify them.                                                                   |
|         2 | **HTTP Verbs**: The API uses HTTP-Methods (GET, POST, PUT, DELETE) for interaction with the resources.                                     |
|         3 | **Hypermedia Controls (HATEOAS)**: The API uses Hypermeddia as the Engine for Application State, to guide clients through the application. |

{{% /table %}}

## Resources

[REST - Wikipedia][rest-wiki]

[rest-wiki]: https://en.wikipedia.org/wiki/Representational_State_Transfer
[roy-fielding-wiki]: https://en.wikipedia.org/wiki/Roy_Fielding
[hateoas-wiki]: https://en.wikipedia.org/wiki/HATEOAS
