---
weight: 999
title: "Nock"
description: ""
icon: "article"
date: "2025-03-20T08:11:23+01:00"
lastmod: "2025-03-20T08:11:23+01:00"
draft: true
toc: true
---

[Nock][nock] is a library for mocking an HTTP server and verifying
expectations using Node.js. Nock can be used to test modules in isolation that
need to send HTTP requests.

## Getting Started

Nock is available as an NPM package that can be installed as a dev dependency:

`npm install --save-dev nock`

Once Nock is installed, it can be imported and used in a test file. Here's a
short example using Jest:

{{< prism lang="typescript" line-numbers="true" >}}

import * as nock from 'nock';

describe('Service', () => {
  it('should intercept the request', async () => {
    nock('https://example.com')
      .get('/api')
      .reply(200, { data: 'mocked data' });

    const response = await fetch('https://example.com/api');

    expect(response.status).toBe(200);
    expect(await response.json()).toEqual({ data: 'mocked data' });
  });
});

{{< /prism >}}

## Scope

Nock offers various ways to restrict which requests are intercepted and
handled by Nock. Restrictions can be based on hostname, path, and query.

It is important to note that by default, Nock removes an interceptor after it
is used for the first time. This allows multiple requests to the same endpoint
to be handled differently. If this behavior is not desired, you can specify
how many times the interceptor should be invoked using `times` in the method
chain, or use `persist` to ensure it is always invoked.

### Hostname

The hostname can either be specified as a URL or a regular expression:

**URL:**

{{< prism lang="typescript" line-numbers="true" >}}

import * as nock from 'nock';

nock('https://example.com')
  .get('/resource')
  .reply(200, 'Hello, world!');

{{< /prism >}}

**Regular Expression:**
{{< prism lang="typescript" line-numbers="true" >}}

import * as nock from 'nock';

nock(/example/)
  .get('/resource')
  .reply(200, 'Hello, world!');

{{< /prism >}}

### Path

The path can be specified as a string, regular expression, or function:

**String:**
{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get('/resource')
  .reply(200, 'String match');

{{< /prism >}}

**Regular Expression:**
{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get(/source$/)
  .reply(200, 'Regex match');

{{< /prism >}}

**Function:**
{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get((uri) => uri.includes('cats'))
  .reply(200, 'Function match');

{{< /prism >}}

## Response Specification

Responses to a request can be specified using the `reply` method, which takes the status code and response body as parameters, along with optional headers:

{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get('/v1/resource')
  .reply(200, 'String response');

nock('https://example.com')
  .get('/v2/resource')
  .reply(200, {
    name: 'Mickey Mouse',
    age: 96
  });

{{< /prism >}}

If a larger response needs to be specified, the content of an external file can be used as a response. For this, the `replyWithFile` method can be used:

{{< prism lang="typescript" line-numbers="true" >}}

nock('https://example.com')
  .get('/v1/resource')
  .replyWithFile(200, __dirname + '/response.json');

{{< /prism >}}

[nock]: https://github.com/nock/nock
