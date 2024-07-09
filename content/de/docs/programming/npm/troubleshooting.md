---
weight: 321
title: "Troubleshooting"
description: "Dokumentation der Lösungen für einige gängige Probleme in NPM."
icon: "troubleshoot"
date: "2024-06-21T16:43:04+02:00"
lastmod: "2024-06-21T16:43:04+02:00"
draft: false
toc: true
---

## Zertifikatsprobleme

Bei einem ausführen von `npm install` oder `npm update` kann es vorkommen, dass ein unvertrautes Zertifikat in der Kette gefunden wird.
In diesem Fall führt das zu einem NPM Fehler. Damit der NPM Befehl jedoch trotzdem ausgeführt werden kann, kann
die Zertifikatsprüfung deaktiviert werden. Es ist jedoch wichtig zu wissen, das NPM dadurch jedem Zertifikat vertraut,
deshalb sollte diese Anpassung direkt wieder Rückgängig gemacht werden, sobald die installation durchgelaufen ist.

```shell
export NODE_TLS_REJECT_UNAUTHORIZED=0
```
