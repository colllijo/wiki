---
weight: 6310
title: "Basics"
description: "Basics for testing with K6"
icon: "analytics"
date: "2024-11-27T13:34:47+01:00"
lastmod: "2024-11-27T13:34:47+01:00"
draft: false
toc: true
---

## Introduction

[K6](https://k6.io/) is an open-source tool designed for performance and load testing. It is written in Go and provides an easy way to write tests using JavaScript. K6 can be used for both API testing and load testing.

## Installation

To use K6, the CLI must be installed. Grafana has created a [guide](https://k6.io/docs/getting-started/installation) that describes the process on different operating systems.
An easy way is to download the latest [GitHub release](https://github.com/grafana/k6/releases) of K6 and move the executable to the correct location.

```bash
wget https://github.com/grafana/k6/releases/download/v0.53.0/k6-v0.53.0-linux-amd64.tar.gz
tar -xvf k6-v0.53.0-linux-amd64.tar.gz
sudo mv k6-v0.53.0-linux-amd64/k6 /usr/local/bin/
```

## Developing

Load and performance tests for K6 are written in JavaScript and use the [k6 API](https://k6.io/docs/javascript-api/k6-http). Here is a simple example:

```javascript
import { check, sleep } from 'k6';
import http from 'k6/http';

export const options = {
  // Stages with number of virtual users and duration
  stages: [
    { duration: '30s', target: 20 },
    { duration: '1m', target: 10 },
    { duration: '30s', target: 0 }
  ],

  thresholds: {
    http_req_failed: ['rate<0.01'], // less than 1% of requests should fail
    http_req_duration: ['p(95)<500'], // 95% of requests should be under 500ms
  },
}

// Test function
export default function() {
  // Execute request
  const res = http.get('https://example.com');

  // Check result
  check(res, {
    'status is 200': (r) => r.status === 200,
  });
  sleep(0.1);
}
```

## Testing

A test can then be executed with the `run` command of k6, specifying the JavaScript file as a parameter.
For example, `k6 run test.js`. This will start the test, which may take some time. Once the test is finished, K6 will display a summary of the test with all metrics. This might look like this:

![K6 Test Result](/docs/images/testing/k6/k6-test.png "Running the K6 test in the terminal")
