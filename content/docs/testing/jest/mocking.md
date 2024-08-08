---
weight: 411
title: "Mocking"
description: "Jest verwenden, um Klassen und Funktionen zu mocken."
icon: "article"
date: "2024-06-25T10:23:58+02:00"
lastmod: "2024-06-25T10:23:58+02:00"
draft: false
toc: true
---

## Globale Klassen und Funktionen mocken

Mit Jest ist es möglich, nicht nur einzelne Komponenten zu Mocken. Sondern auch globale Klassen und Funktionen.
Dies ist vor allem nützlich, wenn eine bestimmte Funktionalität nur in einer bestimmten Javascriptruntime verfügbar ist
und deshalb die Funktionalität auf der Website funktioniert, im Test jedoch einen Fehler wirft.

Dazu kann das globale Objekt einfach mit einer Jest Mockimplementation überschrieben werden.
{{% alert context="info" %}}
Damit Typescript keine Fehler anzeigt kann der Mock einfach über `unknown` zum Typ umgewandelt werden:  
`... as unknown as typeof Object;`
{{% /alert %}}

### Beispiele

#### File

Die `File`-Implementation in JSDOM verfügt nicht über die Methode [File#text()](https://w3c.github.io/FileAPI/#text-method-algo), welche im Browser genutzt werden kann.
Wenn nun eine Komponente getestet werden soll, welche eine Datei erstellt und diese ausliest, muss die `File` Klasse gemockt werden.

{{< prism lang="typescript" line-numbers="true" >}}
global.File = jest.fn().mockImplementation((content, name, options) => {
  const file = Object.create(File.prototype);

  return Object.assign(file, {
    name,
    lastModified: Date.now(),
    text: jest.fn().mockResolvedValue(content),
  });
}) as unknown as typeof File;
{{< /prism >}}
