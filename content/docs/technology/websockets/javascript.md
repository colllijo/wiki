---
weight: 4120
title: "WebSockets mit JavaScript"
description: "Dokumentation wie WebSockets mit JavaScript verwendet werden können."
icon: "code"
date: "2024-10-18T10:48:38+02:00"
lastmod: "2024-10-18T10:48:38+02:00"
draft: false
toc: true
---

## Websockets in JavaScript

Der grösste Anwendungsfall für WebSockets ist das Websites ihre Nutzer über
Änderungen in Echtzeit informieren können. Dies wird zum Beispiel bei Chat-Apps
oder Multiplayer-Spielen der Fall sein. Aus diesem Grund benutzen viele
WebSocket-Applikationen JavaScript. So hat JavaScript auch bereits einen
eingebauten [WebSocket-Client](https://developer.mozilla.org/en-US/docs/Web/API/WebSocket) und viele Server-Side Runtimes für JavaScript,
wie zum Beispiel [Deno](https://docs.deno.com/examples/http-server-websocket/) haben eine WebSocket-Server-Implementierung.

## WebSocket Client

In JavaScript kann ein WebSocket-Client ohne zusätzliche Bibliotheken verwendet
werden, damit ich den WebSocket jedoch einfacher starten kann benutze ich `node`
um den Code zu starten. Als Server benutze ich hier den Echo-Server von
[websocket.org](https://www.websocket.org/echo.html).

Da ich meinen WebSocket-Client mit Node erstelle muss ich zuerst ein
Node-Projekt mit `npm init` erstellen. Da Node keinen eingebauten WebSocket hat
muss ich die Bibliothek `ws` installieren.

```bash
mkdir websocket
cd websocket

npm init -y
npm install --save ws
```

Nun kann ich den WebSocket-Client erstellen:

`client.js`
{{< prism lang="javascript" line-numbers="true" >}}
import { WebSocket } from 'ws'; 

/** @type {WebSocket} */
const webSocket = new WebSocket('wss://echo.websocket.org');

function handleOpen() {
  console.log('Connection opened');

  const message = 'Hello, WebSocket!';

  console.log(`Client sends: ${message}`);
  webSocket.send(message);
  webSocket.close();
}

/** @param {MessageEvent} event */
function handleMessage(event) {
  console.log(`Server sent:  ${event.data}`);
}

/** @param {ErrorEvent} event */
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
{{< /prism >}}

1. **`import { WebSocket } from 'ws';`** Importiert die WebSocket-Client
   Implementation der `ws` Bibliotheke.

2. **`new WebSocket('wss://echo.websocket.org');`** Erstellen
   einer neuen WebSocket-Verbindung zum Echo-Server. Dabei wird die URL des
   WebSocket-Servers angegeben, diese nutzt das Schema `ws` oder `wss`, wie bei
   `http` und `https` steht das `s` dafür, dass die Verbindung verschlüsselt ist.

3. Nachdem ich den WebSocket erstellt habe erstelle ich Funktionen für die vier
   Callbacks, welche der WebSocket zur verfügung stellt. Diese sind:  
   `onopen`: Die WebSocket-Verbindung wurde geöffnet,  
   `onmessage`: Der WebSocket hat eine Nachricht erhalten,  
   `onerror`: Im WebSocket ist ein Fehler aufgetretten und  
   `onclose`: Die WebSocket-Verbindung wurde geschlossen.

4. Zuletzte weise ich die Callbacks den entsprechenden Funktionen des WebSockets
   zu.

Wenn ich das Programm nun mit `node index.js` starte, öffnet der WebSocket eine
Verbindung zum Echo-Server, sobald diese Offen ist sendet er die Nachricht
`Hello, WebSocket!` an den Server und gibt die Antwort des Servers, das Echo,
aus.

```bash
$ node client.js
Connection opened
Client sends: Hello, WebSocket!
Server sent:  Request served by 1781505b56ee58
Server sent:  Hello, WebSocket!
Connection closed
```

## WebSocket Server

Für das Beispiel eines WebSocket-Servers möchte ich einen Server erstellen,
welcher alle Nachrichten, die er empfängt an alle verbundenen WebSockets sendet,
also eine Art von Broadcast. JavaScript selber kennt keinen WebSocket-Server
jedoch hat die `ws`-Bibliothek vom Client Beispiel auch einen WebSocketServer,
welchen ich für dieses Beispiel benutzen werde.

Dazu nutze ich das gleiche Projekt wie für den Client und erstelle die
`server.js` Datei:

`server.js`
{{< prism lang="javascript" line-numbers="true" >}}
import { WebSocket, WebSocketServer } from 'ws';

/** @type {WebSocketServer} */
const webSocketServer = new WebSocketServer({ port: 8080 });

/** @param {WebSocket} webSocket */
webSocketServer.on('connection', (webSocket) => {
  /** @param {MessageEvent} message */
  webSocket.onmessage = (message) => {
    console.log(`Received message: ${message.data}`);

    /** @param {WebSocket} client */
    webSocketServer.clients.forEach((client) => {
      if (client.readyState === WebSocket.OPEN) {
        client.send(message.data);
      }
    })
  }
});
{{< /prism >}}

1. `import { WebSocket, WebSocketServer } from 'ws';` Importiert die
   WebSocket-Client und -Server Implementierung der `ws`-Bibliothek

2. `new WebSocketServer({ port: 8080 });` Erstellt einen neuen WebSocketServer,
   welcher auf Port 8080 auf Verbindungen wartet.

3. `webSocketServer.on('connection', (webSocket) => {` Hier registriere ich eine
   Callbackfunktion für das Verbindungs event des WebSocket-Servers. Dieses wird
   Ausgelöst, wenn sich ein Client mit dem Server verbindet.

4. `webSocket.onmessage = (message) => {` Für den neu Verbundenen Client
   erstelle ich eine Callbackfunktion, welche beim Erhalt einer Nachricht
   aufgerufen wird, diese soll die Nachricht an alle verbunden Clients senden.

5. `webSocketServer.clients` In dieser Klassenvariable speicher der
   WebSocket-Server alle Clients.

6. `if (client.readyState === WebSocket.OPEN)` Dieses `if`-Statement stellt
   sicher, dass der client offen ist, ist dies der Fall wird ihm die Nachricht
   gesendet.

Damit ich den zuvor erstellten Client zum testen dieses Beispiels nutzen kann,
ändere ich die URL von `wss://echo.websocket.org` zu `ws://localhost:8080`.
Dazu entferne ich, das `webSocket.close();`, damit der WebSocket nicht
geschlossen wird.

Nun kann ich in einem Terminal den WebSocketServer starten und in mehreren
andern den WebSocket-Client:

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
