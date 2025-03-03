---
weight: 4501
title: "Konzept"
description: |
  Informationen zu REST und dessen Konzept
icon: "article"
date: "2025-02-28T09:00:29+01:00"
lastmod: "2025-02-28T09:00:29+01:00"
draft: false
toc: true
---

## Was ist Representational State Transfer (REST)?

Representational State Transfer (REST) ist ein Paradigma für die
Softwarearchitektur, welche zum Ziel hat die Kommunikation zwischen Maschinen
durch eine einheitliche Schnittstelle zu vereinfachen. REST wird über das HTTP
Protokol Anwendung und ist vor allem auf Web-Services ausgerichtet. Entwickelt
wurde es um die Jahrtausendwende von [Roy Fielding][roy-fielding-wiki].
Der Name Representational State Transfer enstammt dem Ziel, das REST konforme
Dienste die Repräsentation ihres des Zustandes (State) an den abfragenden
übertragen sollen.

## Die RESTful Philosophie

REST ist mehr eine Philosophie als eine konkrete Technologie. Es gibt kein
festes Regelwerk, sondern nur eine Reihe von Prinzipien, für die die Entwickler
verantwortlich sind das sie eingehalten werden.

### Client-Server

Damit REST verwendet werden kann muss eine Client-Server-Architektur existieren,
welche es dem Server ermöglicht eine Dienst darzubieten, indem er dem Client
seinen Zustand übertragt.

### Zustandslosigkeit

Jede REST-Nachricht sollen den vollen Zustand enthalten, welcher vom Client
benötigt wird. Dazu ist es Notwendig, dass der Server selber keinen zusätzlichen
Zustand speichert, welcher nicht an den Client übertragen wird.  
Diese Zustandslosigkeit kann ein grösser Vorteil sein, da es dadurch sehr
einfach ist einen Server horizontal zu skalieren und die Nutzlast darüber zu
verteilen. So ist es nämlich egal mit welchem Server der Client kommuniziert,
da kein Server einen Zustand speichert.

### Einheitliche Schnittstelle

Für eine REST Schnittstelle ist, es wichtig, dass diese Schnittstelle
einheitlich Umgesetzt wird, damit diese einfacher zu nutzen ist.

Zusätzlich stellen Endpunkte bei REST keine Methoden dar sondern, die
Ressourcen auf die der Client zugreifen möchte, was mit einer Ressource getan
werden soll wird durch die HTTP Methoden definiert.

REST gibt nicht vor wie Ressourcen repräsentiert werden sollen, sondern wird
gefordert, dass ein Server eine Ressource möglichst in unterschiedlichen
Sprachen oder Formaten (HTML, JSON oder XML) angeboten wird, welche dann von
Client, per HTTP-Header angefordert werden können.

### HATEOAS

[**H**ypermedia **a**s **t**he **E**ngine **o**f **A**pplication **S**tate][hateoas-wiki]
(HATEOAS) ist nach Fielding der wichtigste Teil von REST, welcher in der Praxis
jedoch am wenigsten umgesetzt wird. HATEOAS sieht vor, dass der Zustand, welcher
vom Server and den Client übertragen wird, auch Links zu allen möglichen
Aktionen, welche mit der angefragten Ressource verbunden sind beinhaltet. So
wird es für den Client möglich die gesamte Schnittstelle zu erkunden und
benutzen, obwohl er nur eine einzige URL gekannt hat.

## Richardson Maturity Model

Das von Leonard Richardson entwickelte Richardson Maturity Model ist ein
Massstab, um die Reife einer RESTful API zu bewerten. Es besteht aus vier
Stufen, welche die Reife der API beschreiben.

{{% table "table-responsive table-bordered table-striped" %}}

| **Stufe** | **Beschreibung**                                                                                                                            |
| --------: | ------------------------------------------------------------------------------------------------------------------------------------------- |
|         0 | **The Swamp of POX**: Die API verwendet nur HTTP als Transportprotokoll, ohne die Vorteile von HTTP zu nutzen.                              |
|         1 | **Resources**: Die API verwendet Ressourcen und eindeutige URIs, um diese zu identifizieren.                                                |
|         2 | **HTTP Verbs**: Die API nutzt HTTP-Methoden (GET, POST, PUT, DELETE) zur Interaktion mit Ressourcen.                                        |
|         3 | **Hypermedia Controls (HATEOAS)**: Die API verwendet Hypermedia als Motor des Anwendungszustands, um Clients durch die Anwendung zu führen. |

{{% /table %}}

## Ressourcen

[REST - Wikipedia][rest-wiki]

[rest-wiki]: https://de.wikipedia.org/wiki/Representational_State_Transfer
[roy-fielding-wiki]: https://de.wikipedia.org/wiki/Roy_Fielding
[hateoas-wiki]: https://de.wikipedia.org/wiki/HATEOAS
