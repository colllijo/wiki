---
weight: 4110
title: "Concept"
description: "Information about Websockets and their usage"
icon: "article"
date: "2024-11-27T13:31:32+01:00"
lastmod: "2024-11-27T13:31:32+01:00"
draft: false
toc: true
---

## What are Websockets?

WebSockets are based on TCP and enable bidirectional communication between a client and server. Unlike HTTP, which is a request-response protocol, a WebSocket keeps the connection open and allows both parties to send messages. This makes it possible for a server to inform the client about events without the client having to send a request as with HTTP.

## Purpose

As already indicated in the introduction, WebSockets were developed to enable bidirectional communication on the web. WebSockets make it possible to create websites that can provide users with real-time information. This is advantageous for many applications, as it would be very difficult to create a website for a chat, an online game, or stock information without WebSockets.

## Functionality

A WebSocket connection is established via a handshake. The client sends an HTTP request to the server with the information that it wants to switch the connection to WebSockets. The server then responds by switching the protocol. From this point on, both can use the TCP connection, which was previously used for HTTP communication, for communication.

Once the connection is successfully established, data can be transmitted either as text or in binary form. The WebSocket protocol includes three control messages used to manage the connection. These are `Ping`, `Pong`, and `Close`, with `Close` being used to close the connection, and `Ping` and `Pong` to check the connection's status.

The handshake might look like this:

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

## Resources

[The WebSocket Protocol](https://datatracker.ietf.org/rfc6455)  
[WebSocket - Wikipedia](https://en.wikipedia.org/wiki/WebSocket)  
[The WebSocket API - Mozilla](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)  
[WebSocket - Mozilla](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket)  
