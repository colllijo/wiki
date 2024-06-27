---
weight: 999
title: "Mocking Globals"
description: "Using Jest to mock global classes and functions."
icon: "article"
date: "2024-06-25T10:23:56+02:00"
lastmod: "2024-06-25T10:23:56+02:00"
draft: false
toc: true
---

## Introduction

Using Jest it is possible to mock not only individual components. But also global classes and functions.
This is especially useful when a certain functionality is only available in a specific Javascript runtime
and therefore the functionality works on the website but throws an error in the test.

To do this, the global object can simply be overridden with a Jest mock implementation.
{{% alert context="info" %}}
To prevent Typescript from showing errors, the mock can simply be converted to the type `unknown`:  
`... as unknown as typeof Object;`
{{% /alert %}}

## Examples

### File

The File implementation in JSDOM does not have the method [File#text()](https://w3c.github.io/FileAPI/#text-method-algo), which can be used in the browser.
If a component is now to be tested, which creates a file and reads it, the File class must be mocked.

```typescript
global.File = jest.fn().mockImplementation((content, name, options) => {
  const file = Object.create(File.prototype);

  return Object.assign(file, {
    name,
    lastModified: Date.now(),
    text: jest.fn().mockResolvedValue(content),
  });
}) as unknown as typeof File;
```
