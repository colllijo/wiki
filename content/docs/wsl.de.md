---
weight: 500
title: "Wsl"
description: "Dokumentation für WSL"
icon: "article"
date: "2024-06-27T08:18:41+02:00"
lastmod: "2024-06-27T08:18:41+02:00"
draft: true
toc: true
---

## Einführung

Das Windows Subsystem for Linux (WSL) ist eine Kompatibilitätsschicht von Windows, welche es ermöglicht
Linux Distributionen als Subsystem auf Windows auszuführen.

WSL kann für verschiedene Zwecke genutzt werden, wie zum Beispiel:

- Docker
- Entwicklungsumgebung
- UNIX Tools

## Konfiguration

Neben den normalen Einstellungen der Distribution, welche für WSL genutzt wird,
gibt es auch noch einige Einstellungen für die WSL Instanz selbst.
[Dokumentation von Microsoft](https://learn.microsoft.com/en-us/windows/wsl/wsl-config)

### Ressourcen

Falls im WSL nicht genügend oder zu viele Ressourcen genutzt werden.
Ist es Möglich die für WSL verfügbaren Ressourcen zu verändern.

Dazu kann im Windows die Datei `.wslconfig` erstellt werden.
Diese soll im Home Verzeichnis des Benutzers liegen.

%UserProfile%\.wslconfig

```plaintext
[wsl2]
memory=8GB # Verfügbarer RAM für WSL
processors=4 # Anzahl der Prozessoren für WSL
```

### WSL Konfiguration

Neben dieser Datei im Windows System gibt es noch eine weiter Konfigurationsdatei im WSL.
Diese findet sich unter `/etc/wsl.conf`.

/etc/wsl.conf

```plaintext
[network]
generateResolvConf = false # resolv.conf Datei nicht generieren
generateHosts = false # Hosts Datei nicht generieren

[interop]
appendWindowsPath = false # Windows Pfade nicht in WSL anhängen
```
