---
weight: 8110
title: "Cross-Origin Resource Sharing"
description: "Documentation about Cross-Origin Resource Sharing (CORS)"
icon: "share"
date: "2024-11-27T08:46:05+01:00"
lastmod: "2024-11-27T08:46:05+01:00"
draft: false
toc: true
---

## Introduction

`Cross-Origin Resource Sharing` is a mechanism that allows websites to define
exceptions to the same-origin policy. By doing so, it allows web servers to
allow certain web applications to access it's resources using client side
scripting languages like JavaScript and CSS. This allows for other pages to be
able to use resources from different domains without harming the security of the
web.

### Example

The JavaScript code of the site `https://cat.com` would like to use the
JavaScript [`fetch() API`](https://developer.mozilla.org/en-US/docs/Web/API/Window/fetch) to retrieve a JSON file the site `https://dog.com`.
It then wants to display the data of this file in a table on the site
`https://cat.com`.  
For security reasons, this requests will normally be blocked by the browser due
to the same-origin policy, which restricts such communication.  
But if the site `https://dog.com` has set the appropriate CORS headers, the
request can still be made, and the application executes as intended.

{{< figure
  src="/docs/images/security/web/cors-example.svg"
  width="840px"
  class="text-center"
  alt="Graphic showing a CORS request"
>}}

## CORS Headers

CORS works using specific HTTP headers. These headers are added by the server to
it's responses. These are then evaluated by the user agent, aka the browser,
which then decides whether the request is allowed or not. Depending on the
request the user agent decides whether this is a simple request or not. If it
is a simple request, it can be sent directly, but if it is not, a preflight
request must be sent first. This allows the server to inform the user agent
if the actual request would be allowed or not. After which the user agent
knows whether to send the actual request or not.

### Response Headers

Most of the CORS Headers are response headers that are set by the server to
inform the user agent whether a request is allowed or not. The following headers
are defined:

{{% alert context="danger" %}}

Most of these headers allow the use of a wildcard (`*`). However, this only
works if **no credentials** are used in the request. If the wildcard is used
in a request with credentials, it will either result in an error or the wildcard
will be interpreted as `*` (A simple asterisk, not a wildcard).

{{% /alert %}}

#### Access-Control-Allow-Origin

The `Access-Control-Allow-Origin` header is used to specify which domains are
eligible to make a request to the server.  
It can either be a single domain or a wildcard (`*`) which allows all origins
to access a specific resource. It is important to note, that it isn't possible
to specify multiple domains in this header. If multiple domains should be able
to access the resource, the server must dynamically respond with the correct
domain based on the request. Next to the methods above it is also possible to
specify `null` as value, but this is **not** recommended as it could allow
unauthorized access. Instead one should simply omit the header.

```http
Access-Control-Allow-Origin: *
Access-Control-Allow-Origin: https://cat.com
```

#### Access-Control-Allow-Credentials

The `Access-Control-Allow-Credentials` header is used to specify whether a
request that contains credentials is allowed.

```http
Access-Control-Allow-Credentials: true
```

#### Access-Control-Allow-Headers

The `Access-Control-Allow-Headers` header is sent as part of the preflight
response it tells the user agent which HTTP headers are allowed for the actual
request. Next to the headers listed here the Headers on the CORS safelist, will
also be allowed, specifying them here is not necessary but will remove the
additional constraints of the safelist.  
The allowed headers can be specified as a comma-separated list, it is also
possible to use a wildcard (`*`).

```http
Access-Control-Allow-Headers: X-Custom-Header
Access-Control-Allow-Headers: Content-Type, X-Custom-Header
```

#### Access-Control-Allow-Methods

The `Access-Control-Allow-Methods` header works similar to the
`Access-Control-Allow-Headers` Header, it specifies which HTTP methods are
allowed for a request. The allowed methods can be specified as a comma-separated
list or as a wildcard (`*`).

```http
Access-Control-Allow-Methods: GET
Access-Control-Allow-Methods: GET, POST
Access-Control-Allow-Methods: *
```

#### Access-Control-Expose-Headers

By default, a client-side scripting language can only access the response
headers which are on the CORS safelist. With the `Access-Control-Expose-Headers`
a server can extend this list. The allowed headers can be specified as a
comma-separated list or by using a wildcard (`*`).

```http
Access-Control-Expose-Headers: X-Custom-Header
Access-Control-Expose-Headers: X-Custom-Header, Content-Encoding
Access-Control-Expose-Headers: *
```

### Request Headers

When sending a preflight request to the server the user agent may include the
following headers to inform the server about the actual request.

#### Access-Control-Request-Headers

The `Access-Control-Request-Headers` header of the preflight request must list
all headers that the client wants to use in the actual request. These must be
specified as a comma-separated list.

```http
Access-Control-Request-Headers: X-Custom-Header
```

#### Access-Control-Request-Method

The `Access-Control-Request-Method` header of the preflight request must specify
the method that the client wants to use in the actual request.

```http
Access-Control-Request-Method: GET
```

## Preflight Request

### Simple Request

A preflight request is only sent, if the user agent determines that a given
request is **not** a simple request.  
A request is considered a simple request if it meets the following criteria:

The request uses only the following methods:

- `GET`
- `HEAD`
- `POST`

The request uses only the following headers which are on the CORS safelist:

- `Accept`
- `Accept-Language`
- `Content-Language`
- `Content-Type`
- `Range`

In addition to the above, the following restrictions must be met:

- `Accpet-Language` and `Content-Language` may only contain a value which
  consists of the characters `A-Za-z`, `0-9` and ` *,-.;=`.
- `Content-Type` may only contain the values `application/x-www-form-urlencoded`,
  `multipart/form-data` or `text/plain`.

### Course of Action

When the user agent determines a request is not a simple request, it will first
send a preflight request. This request is an `OPTIONS` request that contains 2-3
headers:

```http
OPTIONS /resource/bar
Access-Control-Request-Method: PATCH
Access-Control-Requested-Headers: X-Custom-Header (Wird nur bei Bedarf gesendet)
Origin: https://cat.com
```

Based on the response of the server, the user agent will then decide whether to
send the actual request or not. A successful response to the preflight request
may look like this:

```http
HTTP/1.1 204 No Content
Connection: keep-alive
Access-Control-Allow-Origin: https://cat.com
Access-Control-Allow-Methods: GET, POST, PUT, PATCH
Access-Control-Allow-Headers: X-Custom-Header
Access-Control-Max-Age: 86400
```


## Resources

[Cross-Origin Resource Sharing (CORS)](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)  
[Cross-Origin Resource Sharing - W3C](https://www.w3.org/TR/2020/SPSD-cors-20200602/)

