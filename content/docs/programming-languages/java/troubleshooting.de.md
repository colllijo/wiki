---
weight: 1000
title: "Fehlerbehebung"
description: "Dokumentation der Lösungen für einige gängige Probleme in Java."
icon: "troubleshoot"
date: "2024-06-21T14:05:12+02:00"
lastmod: "2024-06-21T14:05:12+02:00"
draft: false
toc: true
---

## Zertifikatsfehler

Wenn in Java ein Zertifikatsfehler auftritt, kann dies daran liegen, dass ein Self-Signed Zertifikat irgendwo in der Kette verwendet wird.
Damit java damit umgehen kann, muss das Zertifikat in den Java Keystore importiert werden. Hierbei gilt es zu beachten, dass jede
Java installation einen eigenen Keystore hat. Java 17 und 21 haben als unterschiedliche Keystores und das Zertifikat müsste zweimal importiert werden.
Ein fehlendes Zertifikat kann auch allgemein zu Netzwerk und HTTP Fehlern führen.
Falls also ein solcher Fehler auftritt ist es eine gute Idee zu prüfen ob es sich um ein Zertifikatsproblem handelt, vor allem in einem Firmen Umfeld.

### Zertifikat importieren

```shell
keytool -import -alias "Zertifkatsname" -keystore /lib/jvm/java-21-openjdk-amd64/lib/security/cacerts -file /path/to/cert.crt
```
