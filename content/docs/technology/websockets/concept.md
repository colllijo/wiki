---
weight: 3110
title: "Konzept"
description: "Informationen zu Websockets und deren Zweck"
icon: "article"
date: "2024-10-18T10:48:20+02:00"
lastmod: "2024-10-18T10:48:20+02:00"
draft: false
toc: true
---

## Was sind Websockets?

WebSockets basieren auf TCP sie ermöglichen eine bidirektionale Kommunikation
zwischen einem Client und Server. Im Gegensatz zu HTTP, welches ein
Request-Response-Protokoll ist, hält ein WebSocket die Verbindung offen und
ermöglicht es beiden Parteien Nachrichten zu senden. So ist für einen Server
möglich denn Client über Ereignisse zu informieren, ohne das dieser wie bei
HTTP eine Anfrage senden muss.

## Zweck

Wie bereits in der Einleitung angedeutet wurden WebSockets dazu entwickelt
bidirektionale Kommunikation im Web zu ermöglichen. WebSockets ermöglichen es
Websites zu erstellen, welche dem Nutzer Echtzeitinformationen liefern können.
Dies ist für viele Anwendungen von Vorteil, so wäre es ohne WebSockets sehr
schwierig eine Website für einen Chat ein Onlinespiel oder Börseninformationen
zu erstellen.

## Funktionsweise

Eine WebSocket-Verbindung wird über einen Handshake aufgebaut.
Dabei sendet der Client eine HTTP-Anfrage an den Server mit der Information,
dass er die Verbindung auf WebSockets umstellen möchte. Der Server antwortet
dann damit, dass das Protokoll umgestellt. Ab diesem Zeitpunkt können beide
die TCP-Verbindung, welche zuvor für die HTTP-Kommunikation genutzt wurde,
zur Kommunikation über verwenden.

Nachdem die Verbindung erfolgreich aufgebaut wurde, können Daten entweder
als Text oder in Binärform übertragen werden. Das WebSocket-Protokoll
kennt dazu drei Kontrollnachrichten, die zum Steuern der Verbindung genutzt
werden. Diese sind `Ping`, `Pong` und `Close`, dabei wird `Close` zum
schliessen der Verbindung genutzt, und `Ping` und `Pong` um das Fortbestehen
der Verbindung zu überprüfen.

Der Handshake könnte wie folgt aussehen:

`Client-Request:`
```http
GET /chat HTTP/1.1
Host: server.example.com
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==
Origin: http://example.com
Sec-WebSocket-Protocol: chat, superchat
Sec-WebSocket-Version: 13
```

`Server-Response:`
```http
HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=
```

## Ressourcen

[The WebSocket Protocol](https://datatracker.ietf.org/rfc6455)  
[WebSocket - Wikipedia](https://en.wikipedia.org/wiki/WebSocket)  
[The WebSocket API - Mozilla](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)  
[WebSocket - Mozila](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)  
