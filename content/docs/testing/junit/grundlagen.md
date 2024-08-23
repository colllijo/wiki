---
weight: 421
title: "Grundlagen"
description: "Grundlagen zum Testen mit JUnit und Mockito."
icon: "article"
date: "2024-08-23T15:47:44+02:00"
lastmod: "2024-08-23T15:47:44+02:00"
draft: false
toc: true
---

## Einführung

[JUnit](https://junit.org/junit5/) ist ein Framework für das Testen von Java-Anwendungen.
Es Beschreibt sich als Programmierer-freundliches Test-Framework für Java und die JVM.
JUnit ist in der Lage sowohl Unit- als auch Integrationstests zu schreiben.
Es bietet eine Vielzahl von Funktionen, wie z.B. Test-Methoden, Assertions und Test-Runner.

Eine Funktionalität, welche JUnit nicht direkt unterstützt ist das Mocking.  
Hierfür gibt es andere Bibliotheken, wie z.B. [Mockito](https://site.mockito.org/).
Meist wird JUnit zusammen mit Mockito als JUnito-Mockito verwendet.

## Entwickeln

JUnit kann in unterschiedlichen Java Projekttypen verwendet werden.
Da ich hauptsächlich mit Maven Projekten arbeite, werde ich hier die Vorgänge mit Maven beschreiben.
Damit das JUnit Framework verwendet werden kann muss es als Abhängigkeit im `pom.xml` hinzugefügt werden:

```xml
...
  <dependencies>
    ...
    <dependency>
      <groupId>org.junit.jupiter</groupId>
      <artifactId>junit-jupiter</artifactId>
      <version>${junit-jupiter.version}</version>
      <scope>test</scope>
    </dependency>
    <dependency>
      <groupId>org.mockito</groupId>
      <artifactId>mockito-core</artifactId>
      <version>${mockito-core.version}</version>
      <scope>test</scope>
    </dependency>
  </dependencies>
...
```

Mit diesen Abhängigkeiten kann nun JUnit und Mockito in den Tests verwendet werden.
Die Dokumentation für alle Funktionalitäten für JUnit können in der [JUnit Dokumentation](https://junit.org/junit5/docs/current/user-guide/) und
für Mockito im [Mockito JavaDoc](https://site.mockito.org/javadoc/current/org/mockito/Mockito.html) gefunden werden.

Eine einfache Testklasse könnte wie folgt aussehen:

{{< expand title="CalculatorTest.java" open="true" >}}
  {{< prism lang="java" line-numbers="true" >}}
    import org.junit.jupiter.api.Test;
    import org.junit.jupiter.api.BeforeEach;
    import org.mockito.Mockito;

    import static org.junit.jupiter.api.Assertions.assertEquals;

    public class CalculatorTest {
      private Calculator testee;

      private CalculatorMemory mockMemory;

      @BeforeEach
      void setUp() {
        // Method run before each test used to set up the test environment.
        mockMemory = Mockito.mock(CalculatorMemory.class);

        testee = new Calculator(mockMemory);
      }

      @Test
      void testAdd() {
        // Simple test case
        Calculator calculator = new Calculator();
        assertEquals(4, calculator.add(2, 2));
      }

      @Test
      void testAddWithMemory() {
        // Test case with mocked object
        Mockito.when(mockMemory.getMemory()).thenReturn(2);
        assertEquals(4, testee.addToLast(2));
      }

      @Test
      void testDivideByZero() {
        // Test case with exception
        assertThrows(ArithmeticException.class, () -> testee.divide(1, 0));
      }
    }
  {{< /prism >}}
{{< /expand >}}

## Testen

Nachdem die Tests geschrieben wurden können diese ausgeführt werden.
Dazu kann der Maven Befehl `mvn test` verwendet werden.  
Mit diesem Befehl werden alle Tests im Projekt ausgeführt und das Resultat in die Konsole geschrieben.
Nachdem die Tests durchgelaufen sind wird eine Zusammenfassung der Tests angezeigt.
Hier wird entweder angezeigt, dass alles okay ist oder welche Tests fehlgeschlagen sind.
Für genauere Informationen zum Fehlgeschlagenen Test können die zuvor in der Konsole ausgegeben Informationen genutzt werden.
