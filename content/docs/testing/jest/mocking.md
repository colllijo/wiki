---
weight: 7120
title: "Mocking"
description: "Jest verwenden, um Klassen und Funktionen zu mocken."
icon: "article"
date: "2024-06-25T10:23:58+02:00"
lastmod: "2024-06-25T10:23:58+02:00"
draft: false
toc: true
---

## Objekte mocken

Jest ermöglicht es Klassen oder Objekte für Tests zu mocken. Dabei gibt es zwar
keine Möglichkeit eine Klasse an Jest zu übergeben und einen Mock zu erhalten,
jedoch kann einfach ein neues Objekt erstellt werden, bei welchem die Methoden
durch `jest.fn()` aufrufe ersetzt wurden, welche das mock Verhalten umsetzen.

Hierbei ist es wichtig, dass `jest.fn()` verwendet wird, denn nur so kann Jest
die Methodenaufrufe und Argumente überwachen und es ermöglichen, Assertions
zu diesen zu machen.

### Beispiel

In einem Projekt, welches mit einer externen API Kommuniziert kann es Sinn
machen die Komponente, welche für die Kommunikation zuständig ist zu mocken, um
die Abhöngigkeit zur API zu entfernen.

Ein Beispiel wie das aussehen könnte ist in der folgenden Test-Suite
ersichtlich:

{{< prism lang="typescript" line-numbers="true" >}}

describe('Service', () => {
  let service;
  let apiClientMock;

  beforeAll(() => {
    mockApiClient = {
      get: jest.fn().mockResolvedValue({ data: 'mocked data' }),
      post: jest.fn().mockImplementation((data) => Promise.resolve({ data: `mocked post: ${data}` }))
    };

    services = Service(mockApiClient);
  });

  it('should return the mocked data', async () => {
    const data = await service.getData();

    expect(data).toBe('mocked data');
    expect(mockApiClient.get).toHaveBeenCalledTimes(1);
  });

  it('should use the mocked post', async () => {
    const response = await service.postData('some data');

    expect(response).toBe('mocked post: some data');
    expect(mockApiClient.post).toHaveBeenCalledTimes(1);
    expect(mockApiClient.post).toHaveBeenCalledWith('some data');
  });
});

{{< /prism >}}

## Funktionen mocken

Jest ermöglicht es nicht nur ganze Objekte zu mocken, sondern auch einzelne
Funktionsaufrufe auf tatsächlichen Objekten abzufangen und durch Mocks zu
Ersetzen.

### Beispiel

Als Beispiel dafür verwende ich nochmals das Beispiel aus dem vorherigen
Abschnitt, mocke jedoch nicht den kompletten ApiClient, sondern nur die `post`
Funktionalität, mithilfe eines Jest spys.

{{< prism lang="typescript" line-numbers="true" >}}

describe('Service', () => {
  let service;
  let apiClient;


  beforeAll(() => {
    apiClient = ApiClient();
    services = Service(ApiClient);
  });

  it('should mock the post call', () => {
    const spy = jest.spyOn(apiClient, 'post').mockResolvedValue({ data: 'mocked post' });

    const response = await service.postData('some data');

    expect(response).toBe('mocked post');
    expect(spy).toHaveBeenCalledTimes(1);
  });
})

{{< /prism >}}

Dieses Verhalten mit den Jest Spionen kann auch dann nützlich sein, wenn die
Funktion nur in gewissen fällen gemockt sein soll, so kann zum Beispiel anstelle
von `mockResolvedValue` `mockResolvedValueOnce` verwendet werden, um die
Funktion nur beim ersten Aufruf zu mocken.

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
