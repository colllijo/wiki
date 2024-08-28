---
weight: 431
title: "Grundlagen"
description: "Grundlagen zum Testen mit K6."
icon: "analytics"
date: "2024-08-23T16:21:32+02:00"
lastmod: "2024-08-23T16:21:32+02:00"
draft: true
toc: true
---

## Einführung

[K6](https://k6.io/) ist ein Open-Source-Tool, das für die Leistungs- und Lasttests entwickelt wurde. Es ist in Go geschrieben und bietet eine einfache Möglichkeit, Tests mit JavaScript zu schreiben. K6 kann sowohl für die API-Tests als auch für die Lasttests verwendet werden.

## Installation

Um K6 zu nutzen muss die CLI installiert werden Grafana hat eine [Anleitung](https://k6.io/docs/getting-started/installation) dazu erstellt, welche den Vorgang auf unterschiedlichen Betriebssystemen beschreibt.
Eine einfache Möglichkeit ist den letzten [GitHub-Release](https://github.com/grafana/k6/releases) von K6 herunterzuladen und das Executable an den richtigen Ort zu verschieben.

```bash
wget https://github.com/grafana/k6/releases/download/v0.53.0/k6-v0.53.0-linux-amd64.tar.gz
tar -xvf k6-v0.53.0-linux-amd64.tar.gz
sudo mv k6-v0.53.0-linux-amd64/k6 /usr/local/bin/
```

## Entwickeln

Die Last- und Performance-Tests für K6 werden mit JavaScript geschrieben und benutzen die [k6 API](https://k6.io/docs/javascript-api/k6-http). Hier ein einfaches Beispiel:

```javascript
import { check, sleep } form 'k6';
import http from 'k6/http';

export const options = {
  // Etappen mit Anzahl der Virtuellen Benutzer und Dauer
  stages: [
    { duration: '30s', target: 20 },
    { duration: '1m', target: 10 },
    { duration: '30s', target: 0 }
  ],

  thresholds: {
    http_req_failed: ['rate<0.01'], // weniger als 1% der Requests dürfen fehlschlagen
    http_req_duration: ['p(95)<500'], // 95% der Requests müssen unter 500ms sein
  },
}

// Testfunktion
export default function() {
  // Request ausführen
  const res = http.get('https://example.com');

  // Resultat prüfen
  check(res, {
    'status is 200': (r) => r.status === 200,
  });
  sleep(0.1);
}
```

## Testen

Ein Test kann dann mit dem `run` Befehl von k6 ausgeführt werden, dabei muss als Parameter die JavaScript-Datei angegeben werden.
Zum Beispiel `k6 run test.js`. Dadurch wird der Test gestartet was einige Zeit dauern kann. Sobald der Test beendet ist zeigt
K6 eine Zusammenfassung des Tests mit allen Metriken an. Dies könnte zum Beispiel so aussehen:

<img src="/docs/images/testing/k6/k6-test.png" alt="K6 Test Ergebnis"/>
