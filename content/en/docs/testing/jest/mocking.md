---
weight: 7120
title: "Mocking"
description: "Using Jest to mock classes and functions."
icon: "article"
date: "2024-06-25T10:23:56+02:00"
lastmod: "2024-06-25T10:23:56+02:00"
draft: false
toc: true
---

## Mocking objects

Jest allows for mocking classes or objects for testing. It isn't as easy as
passing a class to Jest a receiving a mock, but it is possible to create a new
object where the methods have been replaced with `jest.fn()` calls that
implement the mock behavior.

Here it is important to use `jest.fn()`, as this is the only way Jest can
observe the method calls and arguments, allowing for assertions to be made on
these function calls.

### Example

In a project which communicates with an external API, it might make sense to
mock the component, which is responsible for the communication with the API, to
remove the dependency on the API.

A simple example of how this could look is shown in the following test suite:

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

## Mocking functions

Jest also allows for mocking of individual functions on real objects. For this
you can create a spy on the function which can catch calls to the function and
let the mock behavior run instead.

### Example

As example I will use the example from the previous section, but instead of
mocking the complete ApiClient, I will only mock the `post` functionality using
a Jest spy.

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

The Jest spys can also be used to mock a function only in specific case, for
example one can use the `mockImplementationOnce` method instead of
`mockResolvedValue` to mock a function only for the first call.

## Mocking global classes and functions

Using Jest it is possible to mock not only individual components. But also global classes and functions.
This is especially useful when a certain functionality is only available in a specific Javascript runtime
and therefore the functionality works on the website but throws an error in the test.

To do this, the global object can simply be overridden with a Jest mock implementation.
{{% alert context="info" %}}
To prevent Typescript from showing errors, the mock can simply be converted to the type `unknown`:  
`... as unknown as typeof Object;`
{{% /alert %}}

### Examples

#### File

The File implementation in JSDOM does not have the method [File#text()](https://w3c.github.io/FileAPI/#text-method-algo), which can be used in the browser.
If a component is now to be tested, which creates a file and reads it, the File class must be mocked.

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
