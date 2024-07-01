---
weight: 312
title: "Graalvm"
description: "Documentation on GraalVM."
icon: "article"
date: "2024-07-01T15:37:43+02:00"
lastmod: "2024-07-01T15:37:43+02:00"
draft: true
toc: true
---

## Introduction

[GraalVM](https://www.graalvm.org/) is a Java Development Kit (JDK) that provides tools in addition to the standard JDK functionalities
which make it possible to create a Native Image from a Java application. A Native Image is an executable file without dependencies
to Java. This means that once a Native Image has been created from a Java application, it can be run directly on all systems of the target platform without Java
having to be installed. This means that Java does not have to be installed on all systems
and it is easier to start the application because no startup scripts are needed
and you no longer have to use a Java command like `java -jar program.jar`. The biggest
disadvantage, however, is that the Native Image created in this way is for a target platform, for
example Windows **or** Unix.
