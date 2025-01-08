---
weight: 4410
title: "Generate Document"
description: "Generate a (PDF) document from an OpenApi specification."
icon: "picture_as_pdf"
date: "2024-06-21T10:53:41+02:00"
lastmod: "2024-06-21T10:53:41+02:00"
draft: false
toc: true
---

OpenApi specifications are very helpful to document APIs. However, it is not really easy to read and understand the YAML or JSON file. It would be nice if you could read the specification as a PDF document.

There are different tools that can generate documents based on the OpenApi specification.

[**RapiPDF**](https://mrin9.github.io/RapiPdf/) is one of these tools that transforms the
OpenApi specification into a PDF document. If the specification is in a public GitHub
repository, the PDF can be created directly through the RapiPDF website by providing
the GitHub raw link to the specification. However, it is also possible to host
RapiPDF locally and use it in this way.

[**OpenAPI Generator**](https://openapi-generator.tech/) is another tool. It cannot generate PDFs, but it offers the
possibility to generate the documentation in many other formats such as asciidoc,
html, and markdown. With the OpenAPI Generator, it is possible to generate clients
and servers in many programming languages and frameworks.
