---
weight: 5201
title: "Operator: this"
description: |
  Beschreibung des `this` Operators in JavaScript.  
  Sowie Informationen zu möglichen Problemen und Lösungen.
icon: "add_circle_outline"
date: "2025-02-21T09:04:10+01:00"
lastmod: "2025-02-21T09:04:10+01:00"
draft: false
toc: true
---

Das Schlüsselwort `this` referenziert in JavaScript den Kontext, aus welchem ein
Stück Code, zum Beispiel eine Funktion, aufgerufen wird. Da der Wert von `this`
jedoch abhängig davon ist wie eine Funktion aufgerufen wird, kann es zu gewissen
Schwierigkeiten kommen.

## Wert von `this`

Das `this` Schlüsselwort, referenziert jeweils ein Objekt, welches als
Ausführungskontext für einen Codeblock dient. Der Wert von `this` ist jedoch
abhängig davon, wie eine Funktion aufgerufen wird, was dazu führen kann das
der `this` Kontext, welcher in eine Funktion geschrieben wird unterschiedlich
ist je nachdem wie die Funktion aufgerufen wird.  
Diese Unterschiede können zu Problemen führen, wenn nicht darauf geachtet wird,
welcher Kontext jetzt tatsächlich verwendet wird.

Welcher Kontext bei welcher Verwendung an `this` übergeben wird, kann aus der
[MDN Dokumentation][mdn-this-description] entnommen werden.

{{% alert context="warning" %}}

Wird `this` im strikten Modus ([`"use strict";`][mdn-strict-mode]) verwendet so
kann `this` jeglichen Wert besitzen

{{% /alert %}}

## Beispiel eines Problems

Um die Probleme, welche durch den `this` Operator entstehen können zu
verdeutlichen, möchte ich hier ein Beispiel aufzeigen, welches ich bereits in
der Praxis angetroffen habe.

Unser sehr einfaches Beispiel besteht aus einer Applikationsklasse, welche
unsere Applikation steuert und einer Klasse, welche dafür zuständig ist.
Objekte umzuwandeln:

{{< expand title="Quellcode für das Beispiel" open="true" >}}

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

Unsere Applikation erlaubt es uns eine oder mehrere Personen zu grüssen. Dabei
benutzt unser Applikation den `Mapper` um den Gruss zu erstellen. Der `Mapper`
benutzt intern zusätzlich seine eigene Methode `mapNameToLastname` um den
Nachnamen zu extrahieren.

Führen wir jedoch jetzt diese Applikation aus so erhalten wir einen Fehler:

{{< prism lang="plaintext" >}}

user@pc:/src$ node index.js 
It's a pleasure to meet you Mr./Mrs. Doe.
/src/index.js:21
    return `It's a pleasure to meet you Mr./Mrs. ${this.mapNameToLastname(name)}.`;
                                                        ^

TypeError: Cannot read properties of undefined (reading 'mapNameToLastname')

{{< /prism >}}

Wir sehen der Aufruf von `greetPerson` funktioniert, jedoch der Aufruf von
`greetPeople` schlägt fehl. Aus irgendeinem Grund ist `this` `undefined` und
sobald wir versuchen `mapNameToLastname` aufzurufen, erhalten wir einen Fehler,
da dieses Feld nicht existiert.

Das Problem? Wir benutzen unsere `mapNameToGreeting` Methode als Callback für
die `Array.prototype.map` Methode. Bei Callbacks wie diesem wird der Kontext für
`this` auf `undefied` gesetzt.

Um dieses Problem zu beheben müssen wir entweder den Aufruf von
`mapNameToGreeting` in eine `Arrow Function` umwandeln, welche den Kontext für
`this` nicht verändert, oder wir verwenden den zweiten Parameter von `map`,
welcher es uns erlaubt einen Kontext an die Methode zu binden.

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

## Ressourcen

[`this` Operator - MDN Web Docs][mdn-this]  

[mdn-this]: https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Operators/this
[mdn-this-description]: https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Operators/this#beschreibung
[mdn-strict-mode]: https://developer.mozilla.org/de/docs/Web/JavaScript/Reference/Strict_mode
