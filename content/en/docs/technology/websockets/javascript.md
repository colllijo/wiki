---
weight: 4120
title: "WebSockets with Javascript"
description: "Documentation for using WebSockets with JavaScript"
icon: "article"
date: "2024-11-27T13:31:37+01:00"
lastmod: "2024-11-27T13:31:37+01:00"
draft: false
toc: true
---

## Websockets in JavaScript

The main use case for WebSockets is that websites can inform their users about changes in real-time. This is the case, for example, with chat apps or multiplayer games. For this reason, many WebSocket applications use JavaScript. JavaScript already has a built-in [WebSocket client](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket), and many server-side runtimes for JavaScript, such as [Deno](https://docs.deno.com/examples/http-server-websocket/), have a WebSocket server implementation.

## WebSocket Client

In JavaScript, a WebSocket client can be used without additional libraries. However, to make it easier to start the WebSocket, I use `node` to run the code. As a server, I use the echo server from [websocket.org](https://www.websocket.org/echo.html).

Since I am creating my WebSocket client with Node, I first need to create a Node project with `npm init`. Since Node does not have a built-in WebSocket, I need to install the `ws` library.

```bash
mkdir websocket
cd websocket

npm init -y
npm install --save ws
```

Now I can create the WebSocket client:

`client.js`
```javascript
import { WebSocket } from 'ws'; 

const webSocket = new WebSocket('wss://echo.websocket.org');

function handleOpen() {
  console.log('Connection opened');

  const message = 'Hello, WebSocket!';

  console.log(`Client sends: ${message}`);
  webSocket.send(message);
  webSocket.close();
}

function handleMessage(event) {
  console.log(`Server sent:  ${event.data}`);
}

function handleError(event) {
  console.error(`Connection error: ${event.message}`);
}

function handleClose() {
  console.log('Connection closed');
}

webSocket.onopen    = handleOpen;
webSocket.onmessage = handleMessage;
webSocket.onerror   = handleError;
webSocket.onclose   = handleClose;
```

1. **`import { WebSocket } from 'ws';`** Imports the WebSocket client implementation from the `ws` library.

2. **`new WebSocket('wss://echo.websocket.org');`** Creates a new WebSocket connection to the echo server. The URL of the WebSocket server is specified, using the `ws` or `wss` schema, where `s` indicates that the connection is encrypted.

3. After creating the WebSocket, I create functions for the four callbacks provided by the WebSocket:  
   `onopen`: The WebSocket connection was opened,  
   `onmessage`: The WebSocket received a message,  
   `onerror`: An error occurred in the WebSocket, and  
   `onclose`: The WebSocket connection was closed.

4. Finally, I assign the callbacks to the corresponding WebSocket functions.

When I run the program with `node client.js`, the WebSocket opens a connection to the echo server. Once open, it sends the message `Hello, WebSocket!` to the server and outputs the server's response, the echo.

```bash
$ node client.js
Connection opened
Client sends: Hello, WebSocket!
Server sent:  Request served by 1781505b56ee58
Server sent:  Hello, WebSocket!
Connection closed
```

## WebSocket Server

For the example of a WebSocket server, I want to create a server that sends all received messages to all connected WebSockets, a kind of broadcast. JavaScript itself does not have a WebSocket server, but the `ws` library from the client example also has a WebSocketServer, which I will use for this example.

I use the same project as for the client and create the `server.js` file:

`server.js`
```javascript
import { WebSocket, WebSocketServer } from 'ws';

const webSocketServer = new WebSocketServer({ port: 8080 });

webSocketServer.on('connection', (webSocket) => {
  webSocket.onmessage = (message) => {
    console.log(`Received message: ${message.data}`);

    webSocketServer.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message.data);
      }
    });
  };
});
```

1. `import { WebSocket, WebSocketServer } from 'ws';` Imports the WebSocket client and server implementation from the `ws` library.

2. `new WebSocketServer({ port: 8080 });` Creates a new WebSocketServer that waits for connections on port 8080.

3. `webSocketServer.on('connection', (webSocket) => {` Registers a callback function for the connection event of the WebSocket server. This is triggered when a client connects to the server.

4. `webSocket.onmessage = (message) => {` For the newly connected client, I create a callback function that is called when a message is received. This should send the message to all connected clients.

5. `webSocketServer.clients` This class variable stores all clients of the WebSocket server.

6. `if (client.readyState === WebSocket.OPEN)` This `if` statement ensures that the client is open. If so, the message is sent to it.

To use the previously created client to test this example, I change the URL from `wss://echo.websocket.org` to `ws://localhost:8080`. I also remove `webSocket.close();` so that the WebSocket is not closed.

Now I can start the WebSocketServer in one terminal and the WebSocket client in several others:

```bash
# Server

$ node server.js
Received message: Hello, WebSocket!
Received message: Hello, WebSocket!
```

```bash
### Client 1

$ node client.js

Connection opened
Client sends: Hello, WebSocket!
Server sent:  Hello, WebSocket!
Server sent:  Hello, WebSocket!
```

```bash
### Client 2

$ node client.js

Connection opened
Client sends: Hello, WebSocket!
Server sent:  Hello, WebSocket!
```
