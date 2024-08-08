---
weight: 600
title: "Wsl"
description: "Documentation for WSL"
icon: "article"
date: "2024-06-27T08:18:39+02:00"
lastmod: "2024-06-27T08:18:39+02:00"
draft: false
toc: true
---

## Introduction

The Windows Subsystem for Linux (WSL) is a compatibility layer of Windows that allows
linux distributions to run as a subsystem on Windows.

WSL can be used for various purposes, such as:

- Docker
- Development environment
- UNIX tools

## Configuration

Next to the normal settings of the distribution used for WSL,
there are also some settings for the WSL instance itself.
[Documentation from Microsoft](https://learn.microsoft.com/en-us/windows/wsl/wsl-config)

### Resources

If not enough or too many resources are used in WSL.
It is possible to change the resources available for WSL.

For this, the file `.wslconfig` can be created in Windows.
This file should be located in the user's home directory.

%UserProfile%\\.wslconfig

```plaintext
[wsl2]
memory=8GB # Available RAM for WSL
processors=4 # Number of processors for WSL
```

### WSL Configuration

Next to this file in the Windows system there is another configuration file in WSL.
This file can be found under `/etc/wsl.conf`.

/etc/wsl.conf

```plaintext
[network]
generateResolvConf = false # Don't generate the resolv.conf file
generateHosts = false # Don't generate the hosts file

[interop]
appendWindowsPath = false # Don't append Windows paths to WSL
```
