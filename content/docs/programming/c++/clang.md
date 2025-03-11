---
weight: 5501
title: "Clang"
description: ""
icon: "article"
date: "2024-07-02T14:44:30+02:00"
lastmod: "2024-07-02T14:44:30+02:00"
draft: false
toc: true
---

## Projekt setup (CMake)

Es ist wichtig, dass die Flag `CMAKE_EXPORT_COMPILE_COMMANDS` gesetzt ist, da
dieses die benötigten Informationen für den `C++` Sprachserver
generiert. Ohne diese kann dieser die richtigen Dateien nicht finden und somit
nicht die korrekten Hinweise bereitstellen.
