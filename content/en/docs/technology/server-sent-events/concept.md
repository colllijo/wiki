---
weight: 4201
title: "Concept"
description: |
  Information about server-sent events, their function and purpose.
icon: "article"
date: "2025-02-26T10:24:27+01:00"
lastmod: "2025-02-26T10:24:27+01:00"
draft: false
toc: true
---

## What are Server-sent Events?

Server-sent Events are a technology that builds on HTTP. It allows the server
to send new data to the client independently of the request-response principle
of HTTP. This way, the server can keep the client up to date without the client
having to constantly query the server. To do this, the server sends an event to
the client when updates are available, which may contain any data that the
client can use to update itself.

## Purpose

As already mentioned in the introduction, Server-sent Events, or SSE for short,
enable a server to inform its clients about new developments. This can be
useful, for example, to send push messages to the client or to update a
real-time graphic, such as a stock price. SSE offers a more elegant and simpler
way to do this than long polling, as the client no longer has to send new
requests all the time to stay up to date.

## Functionality

Server-sent Events do not use their own protocol but are part of the HTTP
specification.

A SSE communication is started when the client sends an HTTP request to the SSE
endpoint of our server. The client adds `text/event-stream` to the Accept header
to their request signaling that they want to receive server-sent events. This
step is usually done with the [`EventSource`][event-source-mdn] API of the
browser.

```javascript
var source = new EventSource('updates.cgi');
source.onmessage = function (event) {
  alert(event.data);
};
```

The server responds to this request with an empty 200 HTTP response, for which
the following headers are set:

```http
HTTP/1.1 200 OK
Content-Type: text/event-stream
Cache-Control: no-cache
Connection: keep-alive
```

Additionally, the server keeps the connection open and stores it in the list of
clients that have registered for server-sent events so that it can send updates
to them.

The event stream is a simple text-based protocol that consists of a series of
events separated by a double newline. Each event consists either of only a data
field or an event name as well as a data field.

```http
data: some text

data: another message
data: with two lines

event: named-event
data: {"the": "data", "may": "also", "be": "a", "json": "string"}
```

This connection is kept open until the client stops it. It is not possible for
server to close the connection. If the server tries to close the connection, the
client assumes it is a network error and tries to restore the connection.

## Resourcs

[Server-sent Events - Wikipedia][sse-wiki]  
[Server-sent Events - MDN][sse-mdn]  
[Using Server-sent Events - MDN][using-sse-mdn]  

[sse-wiki]: https://en.wikipedia.org/wiki/Server-sent_events
[sse-mdn]: https://developer.mozilla.org/en/docs/Web/API/Server-sent_events
[using-sse-mdn]: https://developer.mozilla.org/en/docs/Web/API/Server-sent_events/Using_server-sent_events
[event-source-mdn]: https://developer.mozilla.org/en/docs/Web/API/EventSource
