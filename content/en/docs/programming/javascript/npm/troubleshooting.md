---
weight: 4212
title: "Troubleshooting"
description: "Documentation of the solutions for some common problems in NPM."
icon: "troubleshoot"
date: "2024-06-21T16:43:07+02:00"
lastmod: "2024-06-21T16:43:07+02:00"
draft: false
toc: true
---

## Certificate Problems

When executing `npm install` or `npm update`, it may happen that an untrusted certificate is found in the chain.
In this case, this leads to an NPM error. To still be able to execute the NPM command, the certificate verification can be disabled.
But it is important to know that NPM will trust every certificate by doing this, so this adjustment should be reverted as soon as the installation is completed.

```shell
export NODE_TLS_REJECT_UNAUTHORIZED=0
```
