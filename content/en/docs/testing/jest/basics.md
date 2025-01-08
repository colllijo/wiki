---
weight: 7110
title: "Basics"
description: "Basics for testing with Jest"
icon: "article"
date: "2024-11-27T13:34:15+01:00"
lastmod: "2024-11-27T13:34:15+01:00"
draft: false
toc: true
---

## Introduction

[Jest](https://jestjs.io/) is a testing framework for JavaScript developed by Facebook. It is known for its easy configuration and fast test execution. Jest can write both unit and integration tests. It offers a variety of features, such as mocking, snapshot tests, and code coverage reports.

## Configuration

One of Jest's goals is to require as little configuration as possible. By default, it is only necessary to add the Jest NPM package and ensure that NPM uses Jest as the test runner.

The first of these steps can be accomplished with the following command:

```bash
npm install --save-dev jest ts-jest @types/jest @jest/globals
```

To ensure that NPM uses Jest as the test runner, this must be specified in the `test` script in the `package.json` file:

```json
{
  "name": "my-project",
  ...
  "scripts": {
    ...
    "test": "jest",
    ...
  },
  ...
}
```

When Jest is started with `npm test`, it searches for all files ending with `.spec.js` or `.test.js`. (If TypeScript is used, of course, `.ts` instead of `.js`) and executes them.

If the configuration needs to be adjusted, for example, to exclude certain paths or use a specific reporter, a `jest.config.js|.ts|.json` file can be created. This file can be created using `npm init jest@latest`. During the installation, some questions will be asked to determine the basic configuration. After the file is created, additional configuration options can be added. All possible options are already present in the file and can be easily uncommented. Each option also has a short description, and for more detailed information, the [Jest documentation](https://jestjs.io/docs/configuration) provides comprehensive descriptions of all configuration options.

## Development

After Jest is configured, the first tests can be written. Information on the complete Jest API can be found in the [Jest documentation](https://jestjs.io/docs/api), where all functions and methods are explained and described in detail, usually with an example of usage.

There are different ways to structure the tests. Here is an example of how I write my Jest tests:

```typescript
// function.ts
import { config } from './config';

export function evaluate(a: number, b: number): number {
  if (config.debug) {
    config.log(`evaluate(${a}, ${b})`);
  }

  return a + b;
}
```

```typescript
// function.spec.ts
import { config } from './config';
import { evaluate } from './function';

describe('evaluate', () => {
  // Setup
  beforeEach(() => {
    config.debug = true;
  });

  // Teardown
  afterEach(() => {
    config.debug = false;
  });

  // Simple test
  it('should return the sum of two numbers', () => {
    expect(evaluate(1, 2)).toBe(3);
  });

  // Parameterized test
  it.each([
    [1, 2, 3],
    [2, 3, 5],
  ])('should return the sum of %i and %i', (a, b, expected) => {
    expect(evaluate(a, b)).toBe(expected);
  });

  // Test with mocked function
  it('should log the function call', () => {
    const log = jest.fn();
    config.log = log;

    evaluate(1, 2);

    expect(log).toHaveBeenCalledWith('evaluate(1, 2)');
  });
});
```

## Testing

After Jest is configured and the first test cases are written, Jest can be started using npm. The `test` script in the `package.json` can be used for this. It can be started with `npm run test` or simply `npm test`.  
If specific arguments need to be passed to Jest, it is also possible to start Jest with npx: `npx jest [arguments]`.

The result of the test run will be output in the console and might look like this:

![Jest Test Result](/docs/images/testing/jest/Jest-Result.png "Test execution with `npm test`")
