---
weight: 7130
title: "Nock"
description: |
  HTTP server mokcing and expectations library for Node.js
icon: "article"
date: "2025-03-20T08:11:20+01:00"
lastmod: "2025-03-20T08:11:20+01:00"
draft: false
toc: true
---

[Nock][nock] ist eine Bibliothek, für das Mocken eines HTTP-Servers und das
Prüfen von Erwartungen mithilfe von Node.js. Nock kann dazu verwendet werden,
um Module isoliert zu testen, welche HTTP-Abfragen versenden müssen.

## Erste Schritte

Nock steht als NPM-Paket zu Verfügung, welches als Dev-Dependency installiert
werden kann:

`npm install --save-dev nock`

Nachdem Nock installiert wurde kann es in einem Test-File importiert und
verwendet werden, hier ein kurzes beispiel mit Jest:

{{< prism lang="typescript" line-numbers="true" >}}

import * as nock from 'nock';

describe('Service', () => {
  it('should intercept the request', async () => {
    nock('https://example.com')
      .get('/api')
      .reply(200, { data: 'mocked data' });

    const response = await fetch('https://example.com/api');

    expect(response.status).toBe(200);
    expect(await response.json()).toEqual({ data: 'mocked data' });
  });
});

{{< /prism >}}

## Erfassungsbereich

Nock bietet unterschiedliche Möglichkeiten um einzuschränken, welche Abfragen
abgefangen und durch Nock bearbeitet werden sollen. Dabei können Einschränkungen
auf Grund von hostname, path und query angegeben werden.

Hier ist es wichtig zu beachten, das Nock standardmässig ein Interceptor wieder
entfernt, nachdem dieser das erste mal verwendet wurde. So können mehrere
Abfragen an den gleichen Endpunkt unterschiedlich behandelt werden, soll dies
nicht der fall sein, kann mit `times` in der Methodenkette angegeben werden
wie oft dieser Interceptor aufgerufen werden soll oder mit `persist` angegeben
das er immer aufgerufen werden soll.

### Hostname

Als hostname kann entweder die URL angegeben werden oder ein regulärer Ausdruck:

**URL:**
{{< prism lang="typescript" line-numbers="true" >}}

import * as nock from 'nock';

nock('https://example.com')
  .get('/resource')
  .reply(200, 'Hello, world!');

{{< /prism >}}

**Regulärer Ausdruck:**
{{< prism lang="typescript" line-numbers="true" >}}

import * as nock from 'nock';

nock(/example/)
  .get('/resource')
  .reply(200, 'Hello, world!');

{{< /prism >}}

### Path

Der Pfad kann als String, regulärer Ausdruck oder als Funktion angegeben werden:

**String:**
{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get('/resource')
  .reply(200, 'String match');

{{< /prism >}}

**String:**
{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get(/source$/)
  .reply(200, 'Regex match');

{{< /prism >}}

**Funktion:**
{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get((uri) => uri.includes('cats'))
  .reply(200, 'Function match');

{{< /prism >}}

## Antwortspezifikation

Antworten auf eine Abfrage können mit der `reply` Methode spezifiziert werden,
diese nimmt als Parameter den Statuscode und den Antwortkörper, sowie optional
die Header entgegen:

{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get('/v1/resource')
  .reply(200, 'String Antwort');

nock('https://example.com')
  .get('/v2/resource')
  .reply(200, {
    name: 'Micky Mouse',
    alter: 96
  });

{{< /prism >}}

Falls eine grössere Antwort spezifiziert werden soll, kann auch mit dem Inhalt
einer externen Datei geantwortet werden, dazu kann die `replyWithFile` Methode
verwendet werden:

{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get('/v1/resource')
  .replyWithFile(200, __dirname + '/response.json');

{{< /prism >}}

[nock]: https://github.com/nock/nock
