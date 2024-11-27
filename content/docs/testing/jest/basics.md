---
weight: 6110
title: "Grundlagen"
description: "Grundlagen zum Testen mit Jest."
icon: "article"
date: "2024-08-22T16:54:01+02:00"
lastmod: "2024-08-22T16:54:01+02:00"
draft: false
toc: true
---

## Einführung

[Jest](https://jestjs.io/) ist ein Testing Framework für JavaScript, welches von Facebook entwickelt wurde. Es ist bekannt für seine einfache Konfiguration und die schnelle Ausführung von Tests. Jest ist in der Lage, sowohl Unit- als auch Integrationstests zu schreiben. Es bietet eine Vielzahl von Funktionen, wie z.B. Mocking, Snapshot-Tests und Code-Coverage-Reports.

## Konfiguration

Ein Ziel von Jest ist es mit möglichst wenig Konfiguration auszukommen.
Standardmässig ist es nur notwendig das Jest NPM-Paket hinzuzufügen und sicherzustellen
das NPM Jest als Testrunner verwendet.

Den ersten dieser beiden Schritte kann mit folgendem Befehl erledigt werden:

```bash
npm install --save-dev jest ts-jest @types/jest @jest/globals
```

Damit NPM Jest als Testrunner verwendet muss dies im `test` Skript in der `package.json` Datei hinterlegt werden:

```json
{
  "name": "mein-projekt",
  ...
  "scripts": {
    ...
    "test": "jest",
    ...
  },
  ...
}
```
Falls nun Jest mit `npm test` gestartet wird Sucht Jest alle Dateien, welche mit `.spec.js` oder `.test.js` enden. (Falls TypeScript verwendet wird natürlich `.ts` und nicht `.js`)
Und führt diese aus.

Falls die Konfiguration doch angepasst werden kann, damit z.B. bestimmte Pfade nicht durchsucht werden oder ein spezieller Reporter verwendet wird, kann eine `jest.config.js|.ts|.json` Datei
erstellt werden. Diese Datei kann mittels `npm init jest@latest` erstellt werden. Während der Installation werden einige Fragen gestellt, welche die Grundkonfiguration bestimmen.
Nachdem die Datei erstellt wurde können weitere Konfigurationsoptionen hinzugefügt werden. Dabei sind bereits alle Möglichen Optionen in der Datei vorhanden und können einfach Ein-kommentiert werden.
Zu jeder Option gibt es ebenfalls eine kurze Beschreibung, falls diese nicht genügt gibt es zu allen Konfigurationsoptionen eine Ausführliche Beschreibung in der [Jest Dokumentation](https://jestjs.io/docs/configuration).

## Entwickeln

Nachdem Jest konfiguriert wurde können die ersten Tests geschrieben werden. Informationen zur kompletten Jest API können in der [Jest Dokumentation](https://jestjs.io/docs/api) gefunden werden, dort werden alle Funktionen und Methoden ausführlich erklärt und beschrieben, dazu gibt es meist ein Beispiel für die Verwendung.  

Dabei gibt es unterschiedliche Möglichkeiten die Tests zu strukturieren. Folgend kommt ein Beispiel wie ich meine Jest-Tests schreibe:

{{< expand title="function.ts" open="true" >}}
  {{< prism lang="ts" line-numbers="true" >}}
    import { config } from './config';

    export function evaluate(a: number, b: number): number {
      if (config.debug) {
        config.log(`evaluate(${a}, ${b})`);
      }

      return a + b;
    }
  {{< /prism >}}
{{< /expand >}}

{{< expand title="function.spec.ts" open="true" >}}
  {{< prism lang="ts" line-numbers="true" >}}
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
  {{< /prism >}}
{{< /expand >}}

## Testen

Nachdem Jest konfiguriert und die ersten Testfälle geschrieben wurde kann Jest mittles npm gestartet werden. Dazu kann das `test` Skript im `package.json` genutzt werden.
Dieses kann mit `npm run test` oder kurz `npm test` gestartet werden.  
Falls noch spezifische Argumente an Jest übergeben werden sollen ist es auch Möglich Jest mit npx zu starten. `npx jest [Argumente]`.

Das Resultat vom Testlauf wird dann in der Konsole ausgegeben und könnte etwa so aussehen:

![Jest Test Resultat](/docs/images/testing/jest/Jest-Result.png "Ausführung des Tests mit `npm test`")
