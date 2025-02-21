---
weight: 5201
title: "Operator: this"
description: |
  Description of the `this` operator in JavaScript.  
  As well as some information about posible problems and solutions.
icon: "add_circle_outline"
date: "2025-02-21T09:04:14+01:00"
lastmod: "2025-02-21T09:04:14+01:00"
draft: false
toc: true
---

The `this` keyword in JavaScript references the context from which a piece of
code, such as a function, is called. However, since the value of `this` depends
on how a function is called, there can be certain difficulties.

## Value of `this`

The `this` keyword, references an object that serves as the execution context
for a block of code. The value of `this` depends on how a function is called,
this can lead to the `this` context of a function changing depending on how
it is called.  
These differences can lead to problems if you are not careful about which
context is actually being used.

Information about which context is passed to `this` when used can be found in
the [MDN documentation][mdn-this-description].

{{% alert context="warning" %}}

When `this` is used in strict mode ([`"use strict";`][mdn-strict-mode]) `this`
may be of any value.

{{% /alert %}}

## Example of problem

To better illustrate the problems that can arise from the `this` operator, I'd
like to show an example that I've encountered in practice.

In our very simple example, we have an application class that controls our
application and a class that is responsible for converting objects:

{{< expand title="Source code for the example" open="true" >}}

{{< prism line-numbers="true" lang="javascript" >}}

class App {
  constructor(mapper) {
    this.mapper = mapper;
  }

  greetPerson(name) {
    console.log(this.mapper.mapNameToGreeting(name));
  }

  greetPeople(people) {
    people
      .map(this.mapper.mapNameToGreeting)
      .forEach((greeting) => console.log(greeting));
  }
}

class Mapper {
  constructor() {}

  mapNameToGreeting(name) {
    return `It's a pleasure to meet you Mr./Mrs. ${this.mapNameToLastname(name)}.`;
  }

  mapNameToLastname(name) {
    return name.split(' ')[1];
  }
}

let mapper = new Mapper();
let app = new App(mapper);

app.greetPerson('John Doe');
app.greetPeople(['John Doe', 'Jane Doe']);

{{< /prism >}}

{{< /expand >}}

Our application allows us to greet a single person or multiple people. For this
our Application uses the `Mapper` class to create a greeting. Internally, the
`Mapper` uses its own method `mapNameToLastname` to extract the last name from
the name passed.

If we run this application now, we will get an error:

{{< prism lang="plaintext" >}}

It's a pleasure to meet you Mr./Mrs. Doe.
/src/index.js:21
    return `It's a pleasure to meet you Mr./Mrs. ${this.mapNameToLastname(name)}.`;
                                                        ^

TypeError: Cannot read properties of undefined (reading 'mapNameToLastname')

{{< /prism >}}

We can see that the `greetPerson` method works as expected, but the
`greetPeople` throws an error. For some reason the `this` operator is
`undefined` in our `Mapper` leading to it trying to call the Method
`mapNameToLastname` on `undefined`, which isn't possible.

The Problem? We are using the `mapNameToGreeting` method as a callback for the
`Array.prototype.map` method. For callbacks like the one of the map function
the `this` context is set to `undefined`.

To fix this problem we either have to wrap our call to `mapNameToGreeting` in
an `Arrow function`, which doesn't change the context of `this`. Or we use
the second parameter of the `map` function which allows us to bind a specific
context to the execution of the method.

**Arrow Function:**

{{< prism line-numbers="true" start="10" lang="javascript" >}}

  greetPeople(people) {
    people
      .map((name) => this.mapper.mapNameToGreeting(name))
      .forEach((greeting) => console.log(greeting));
  }

{{< /prism >}}

**Bind Methode:**

{{< prism line-numbers="true" start="10" lang="javascript" >}}

  greetPeople(people) {
    people
      .map(this.mapper.mapNameToGreeting, this.mapper)
      .forEach((greeting) => console.log(greeting));
  }

{{< /prism >}}

## Resources

[`this` Operator - MDN Web Docs][mdn-this]  

[mdn-this]: https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/this
[mdn-this-description]: https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Operators/this#description
[mdn-strict-mode]: https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Strict_mode
