---
weight: 4320
title: "RabbitMQ"
description: "Informationen und Dokumentation zu RabbitMQ"
icon: "cruelty_free"
date: "2024-10-23T16:24:01+02:00"
lastmod: "2024-10-23T16:24:01+02:00"
draft: false
toc: true
---

RabbitMQ ist ein Open-Source-Message-Broker, der von VMWare entwickelt wurde. Er
ist in Erlang geschrieben und implementiert das Advanced Message Queuing
Protocol (AMQP). RabbitMQ ist eine der beliebtesten Implementierungen von AMQP
und hat eine Client-Bibliothek für viele Programmiersprachen.

## RabbitMQ installieren

Es ist möglich RabbitMQ auf verschiedenen Betriebssystemen zu installieren,
jedoch ist es die einfachste Methode das Docker-Image von RabbitMQ zu verwenden.
Dabei gibt es zwei Varianten des Docker-Images. Einerseits gibt es die basis
Variante `rabbitmq:x.x.x` und die Management-Variante
`rabbitmq:x.x.x-management`. Die Management-Variante enthält ein Webinterface
für die Verwaltung des Brokers.

Der folgende Befehl startet einen RabbitMQ-Container mit dem Management-Plugin:

```bash
docker run -d --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:4.0-management
```

Nachdem der Container gestartet wurde sollte der Broker auf Port `5672` laufen.
Und das Webinterface sollte unter [`http://localhost:15672`](http://localhost:15672) erreichbar sein.
Die Standard-Credentials sind `guest`:`guest`.

## Ressourcen

[Offizielle Website](https://www.rabbitmq.com/)
