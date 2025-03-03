---
weight: 4610
title: "Dokument generieren"
description: "(PDF) Dokument aus einer OpenApi-Spezifikation generieren."
icon: "picture_as_pdf"
date: "2024-06-21T13:14:08+02:00"
lastmod: "2024-06-21T13:14:08+02:00"
draft: false
toc: true
---

OpenApi Spezifikationen sind sehr hilfreich, um Schnittstellen zu dokumentieren.
Jedoch ist es nicht wirklich einfach, die YAML oder JSON Datei zu lesen und verstehen.
Hier wäre es schon wenn man die Spezifikation als PDF lesen könnte.

Hier gibt es verschiedene Tools, welche die Dokumente anhand der OpenApi-Spezifikation generieren können.

[**`RapiPDF`**](https://mrin9.github.io/RapiPdf/) ist ein solches Tool, welches die OpenApi-Spezifikation in ein PDF Dokument umwandelt.
Falls die Spezifikation in einem öffentlichen GitHub-Repository liegt, kann das PDF direkt über die `RapiPDF` Website erstellt werden.
Indem der GitHub raw Link zur Spezifikation angegeben wird.  
Es ist jedoch auch möglich, `RapiPDF` lokal zu hosten und so zu benutzen.

[**`OpenAPI Generator`**](https://openapi-generator.tech/) ist ein weiteres Tool. Es kann zwar keine PDFs generieren.
Dafür bietet es jedoch die Möglichkeit, die Dokumentation in vielen anderen Formaten wie `asciidoc,` `html` und `markdown` zu generieren.
Dazu ist es mit dem `OpenAPI Generator` möglich, Clients und Server in vielen Programmiersprachen und Frameworks zu generieren.

