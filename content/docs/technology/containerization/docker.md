---
weight: 4701
title: "Docker"
description: |
  Informationen zu Docker
icon: "article"
date: "2025-03-06T12:50:17+01:00"
lastmod: "2025-03-06T12:50:17+01:00"
draft: false
toc: true
---

## Was ist Docker?

[Docker][docker] ist eine freie Software, welche zur
[Containervirtualisierung][containervirtualisation-wiki] verwendet wird. Dadurch
können Anwendungen in Containern isoliert und unabhängig von der Host-Umgebung
ausgeführt werden. Dies vereinfacht die Bereitstellung von Applikationen, da
alle notwendigen Komponenten wie Code, Laufzeit, Systemwerkzeuge und
Bibliotheken im Container enthalten sind und nicht auf dem anderen System
installiert werden müssen.

{{% alert context="info" %}}

Docker selber setzt die Containervirtualisierung nicht um, sondern ist nur ein
Tool, welches die Erstellung und Verwaltung von Container vereinfacht.  
Docker selber benutzt [containerd][containerd], welches wiederum [runc][runc]
verwendet, welches die tatsächliche Virtualisierung durchführt.

{{% /alert %}}

## Docker Terminologie

Beim Arbeiten mit Docker ist es wichtig, einige grundlegende Begriffe zu kennen:

- **Image**: Ein Docker-Image ist eine unveränderliche Vorlage, die alle
  notwendigen Anweisungen enthält, um eine Anwendung auszuführen. Es basiert
  auf einer Reihe von Schichten, die jeweils Änderungen gegenüber der vorherigen
  Schicht darstellen. Images werden aus Dockerfiles erstellt und können in
  Registries gespeichert und von dort abgerufen werden.

- **Container**: Ein Container ist eine laufende Instanz eines Docker-Images.
  Er enthält alles, was die Anwendung benötigt, um in einer isolierten Umgebung
  zu laufen, einschliesslich des Codes, der Laufzeit, der Systemwerkzeuge und
  der Bibliotheken. Container sind leichtgewichtig und portabel, was sie ideal
  für die Entwicklung und Bereitstellung von Anwendungen macht.

- **Dockerfile**: Eine Dockerfile ist eine Textdatei, die eine Reihe von
  Anweisungen enthält, wie ein Docker-Image erstellt werden soll. Jede
  Anweisung in einer Dockerfile erzeugt eine neue Schicht im Image. Typische
  Anweisungen sind `FROM`, um das Basis-Image festzulegen, `RUN`, um Befehle
  auszuführen, und `COPY`, um Dateien in das Image zu kopieren.

- **Registry**: Eine Registry ist ein Speicherort für Docker-Images. Die
  bekannteste Registry ist Docker Hub, aber es gibt auch private Registries,
  die in Unternehmen verwendet werden können. Registries ermöglichen es,
  Images zu teilen und zu versionieren. Entwickler können Images in eine
  Registry pushen und von dort pullen, um sie auf verschiedenen Systemen zu
  verwenden.

- **Volume**: Ein Volume ist ein Mechanismus, um Daten ausserhalb des
  Containers zu speichern, sodass sie auch nach dem Stoppen oder Löschen des
  Containers erhalten bleiben. Volumes sind besonders nützlich für die
  Speicherung von Daten, die von mehreren Containern gemeinsam genutzt werden
  sollen, oder für die Speicherung von Daten, die über Container-Neustarts
  hinweg bestehen bleiben müssen.

- **Network**: Docker-Netzwerke ermöglichen die Kommunikation zwischen
  Containern und anderen Diensten. Es gibt verschiedene Netzwerkmodi, wie
  Bridge, Host und Overlay. Der Bridge-Modus ist der Standardmodus und
  erstellt ein privates internes Netzwerk für Container auf demselben Host.
  Der Host-Modus ermöglicht Containern den direkten Zugriff auf das Netzwerk des
  Hosts. Der Overlay-Modus wird verwendet, um Container über mehrere Hosts
  hinweg zu verbinden.

## Beispiel mit Docker

Um den ganzen Prozess besser zu verstehen, hier ein sehr einfaches beispiel
bei dem eine Website, welche einen nginx-Webserver verwendet, in einem Docker
Container ausgeführt wird.

Dazu kann ein Verzeichnis für diese Anwendung erstellt werden, in welchem eine
HTML-Datei, welche die Website darstellt, sowie eine Dockerfile für die
Erstellung des Images benötigt werden.

Hier ein beispiel für eine einfache HTML Website in der Datei `index.html`:

```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Docker Website</title>
  </head>
  <body>
    <h1>Welcome to my Docker website!</h1>
    <p>This is a simple static website, deployed using docker.</p>
  </body>
</html>
```

Nun muss ein Dockerfile erstellt werden, welches unsere HTML-Datei mit einem
Webserver in einem Container bereitstellt:

```Dockerfile
# Using the nginx webserver as base image
FROM nginx:alpine

# Copy the index.html file to the html directory served by nginx
COPY index.html /usr/share/nginx/html/index.html

# Expose the Port so that it can be accessed
EXPOSE 80
```

Mit diesen beiden Dateien kann nun das Docker-Image erstellt werden dazu kann
der `build` Befehl verwendet werden:

```bash
docker build -t my-docker-website .
```

Die `-t` Option wird verwendet, um dem Image einen Namen zu geben und der Punkt
am ende setzt das aktuelle Verzeichnis als Build-Context.

Nachdem der Build fertig ist kann ein Container aus dem Image erstellt werden
dazu wird der `run` Befehl verwendet:

```bash
docker run -d -p 8080:80 --name docker-website my-docker-website
```

Die `-d` Option startet den Container im Hintergrund, die `-p` Option verbindet
den Port `8080` auf der Host-Machine mit dem Port `80` im Container, wodurch die
Website von der Host-Machine aus erreichbar ist. Mit der `--name` Option wird
eine Name für den Container gesetzt und das letzte Argument spezifiziert das
Image, welches verwendet werden soll.

Nachdem der Container gestartet wurde kann die Website verwendet werden, indem
auf einem Browser die URL `http://localhost:8080` aufgerufen wird. Das der
Container läuft kann mit dem `docker ps` Befehl überprüft werden. Dieser gibt
eine Liste der laufenden Container zurück.

```bash
docker ps
```

Der Container kann dann mit dem `stop` Befehl gestoppt und dem `rm` Befehl
gelöscht werden:

```bash
docker stop docker-website
docker rm docker-website
```

Falls das Image nicht mehr benötigt wird, kann es mit dem `rmi` Befehl gelöscht

```bash
docker rmi my-docker-website
```

## Docker Alternativen

Neben Docker gibt es mehrere Alternativen zur Containerisierung von
Anwendungen. Eine der bekanntesten Alternativen ist Podman. Podman ist ein
Open-Source-Container-Engine, die es ermöglicht, Container ohne einen Daemon
im Hintergrund zu verwalten. Es bietet eine ähnliche Benutzererfahrung wie
Docker und ist kompatibel mit Docker-Images und -Kommandos. Diese Tools bieten
unterschiedliche Ansätze und Vorteile, je nach den
spezifischen Anforderungen und Einsatzszenarien.

## Ressourcen

[Docker][docker]  
[Docker - Wikipedia][docker-wiki]  
[Containervirtualisierung - Wikipedia][containervirtualisation-wiki]

[docker]: https://www.docker.com/
[containerd]: https://containerd.io/
[runc]: https://github.com/opencontainers/runc
[docker-wiki]: https://de.wikipedia.org/wiki/Docker_(Software)
[containervirtualisation-wiki]: https://de.wikipedia.org/wiki/Containervirtualisierung

