---
weight: 351
title: "Clang"
description: ""
icon: "article"
date: "2024-07-02T14:44:30+02:00"
lastmod: "2024-07-02T14:44:30+02:00"
draft: true
toc: true
---

## Projekt setup (CMake)

```shell
cmake -S . -B build -Wdev -DCMAKE_EXPORT_COMPILE_COMMANDS=1
```

{{% alert context="warning" %}}
`-DCMAKE_EXPORT_COMPILE_COMMANDS=1` wird benötigt, dammit `clang` die Dateien finden kann.
{{% /alert %}}
