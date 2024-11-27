---
weight: 4190
title: "Troubleshooting"
description: "Documentation of the solutions for some common problems in Java."
icon: "troubleshoot"
date: "2024-06-21T14:05:10+02:00"
lastmod: "2024-06-21T14:05:10+02:00"
draft: false
toc: true
---

## Certificate Problems

When a certificate error occurs in Java, it may be due to the use of a self-signed certificate somewhere in the chain.
To handle this, the certificate must be imported into the Java keystore. It should be noted that each Java installation has its own keystore.
Java 17 and 21 have different keystores and the certificate would need to be imported twice.
A missing certificate can also generally lead to network and HTTP errors.
So if such an error occurs, it is a good idea to check if it is a certificate problem, especially in a corporate environment.

### Import Certificate

```shell
keytool -import -alias "Zertifkatsname" -keystore /lib/jvm/java-21-openjdk-amd64/lib/security/cacerts -file /path/to/cert.crt
```
