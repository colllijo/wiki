---
weight: 4201
title: "Konzept"
description: |
  Informationen zu Server-sent Events, deren Funktion und Zweck.
icon: "article"
date: "2025-02-26T10:24:16+01:00"
lastmod: "2025-02-26T10:24:16+01:00"
draft: false
toc: true
---

## Was sind Server-sent Events?

Server-sent Events sind eine Technologie, welche auf HTTP aufbaut. Sie
ermöglicht es entgegen dem Request-Response Prinzip von HTTP, dass der Server
selbständig neue Daten an den Client sendet. So kann der Server, den Client auf
dem neusten Stand halten, ohne dass der Client ständig den Server anfragen muss.
Dazu sendet der Server bei Updates ein Event and den Server, welches allfällige
Daten enthält, wodurch der Client sich aktualisieren kann.

## Zweck

Wie bereits in der Einführung erwähnt dienen Server-sent Events, kurz SSE, dazu
es einem Server zu ermöglichen seine Clients über Neuerungen zu informieren.
Dies kann zum Beispiel relevant sein um dem Client Push-Nachrichten zu senden
oder eine Echtzeitgraphik zum Beispiel ein Börsenkurs zu aktualisieren.  
SSE bietet dafür eine schönere und einfachere alternative als das Long-Polling,
da der Client nicht mehr immer neue Requests senden muss, um auf dem neusten
zu bleiben.

## Funktionsweise

Server-sent Events verwenden kein Eigenes Protokoll, sondern sind Teil der HTTP
Spezifikation.

Eine SSE Kommunikation wird gestartet, indem der Client eine HTTP Anfrage an den
SSE Endpunkt unseres Servers sendet. Dabei fügt der Client `text/event-stream`
in den Accept Header ein. Dieser Schritt wird meist mit der
[`EventSource`][event-source-mdn] API des Browsers gemacht.

```javascript
var source = new EventSource('updates.cgi');
source.onmessage = function (event) {
  alert(event.data);
};
```

Der Server Antwortet auf diese Anfrage, mit einer Leeren 200 HTTP Antwort, für
welche die folgenden Header gesetzt sind:

```http
HTTP/1.1 200 OK
Content-Type: text/event-stream
Cache-Control: no-cache
Connection: keep-alive
```

Zusätzlich hält der Server die Verbindung offen und speichert Sie in der Liste
der Clients, welche sich für die Server-sent Events registriert haben, damit er
bei einem Event weiss, an welche Clients dieses versendet werden soll.

Die Events, welche der Server an den Client senden kann bestehen entweder nur
aus Daten oder aus einem Eventnamen und Daten. Das Ende eines Events wird dabei
durch zwei Zeilenumbrüche signalisiert.

```http
data: some text

data: another message
data: with two lines

event: named-event
data: {"the": "data", "may": "also", "be": "a", "json": "string"}
```

Diese Verbindung wird so lange offen gehalten, bis der Client die Verbindung
stoppt es ist für den Server nicht möglich die Verbindung zu schliessen.
Versucht der Server trotzdem die Verbindung zu schliessen so nimmt der Client
an es handelt sich um einen Netzwerkfehler und versucht die Verbindung
wiederherzustellen.

## Ressourcen

[Server-sent Events - Wikipedia][sse-wiki]  
[Server-sent Events - MDN][sse-mdn]  
[Verwenden von Server-sent Events - MDN][using-sse-mdn]  

[sse-wiki]: https://en.wikipedia.org/wiki/Server-sent_events
[sse-mdn]: https://developer.mozilla.org/de/docs/Web/API/Server-sent_events
[using-sse-mdn]: https://developer.mozilla.org/de/docs/Web/API/Server-sent_events/Using_server-sent_events
[event-source-mdn]: https://developer.mozilla.org/de/docs/Web/API/EventSource
