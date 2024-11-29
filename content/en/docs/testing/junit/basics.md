---
weight: 6210
title: "Basics"
description: "Basics for thesting with JUnit and Mockito"
icon: "article"
date: "2024-11-27T13:34:32+01:00"
lastmod: "2024-11-27T13:34:32+01:00"
draft: false
toc: true
---

## Introduction

[JUnit](https://junit.org/junit5/) is a framework for testing Java applications. It describes itself as a programmer-friendly testing framework for Java and the JVM. JUnit can write both unit and integration tests. It offers a variety of features, such as test methods, assertions, and test runners.

One functionality that JUnit does not directly support is mocking. For this, there are other libraries, such as [Mockito](https://site.mockito.org/). JUnit is often used together with Mockito, referred to as JUnit-Mockito.

## Development

JUnit can be used in different types of Java projects. Since I mainly work with Maven projects, I will describe the procedures with Maven here. To use the JUnit framework, it must be added as a dependency in the `pom.xml`:

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

With these dependencies, JUnit and Mockito can now be used in the tests. The documentation for all functionalities of JUnit can be found in the [JUnit documentation](https://junit.org/junit5/docs/current/user-guide/) and for Mockito in the [Mockito JavaDoc](https://site.mockito.org/javadoc/current/org/mockito/Mockito.html).

A simple test class could look like this:

```java
// CalculatorTest.java
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.mockito.Mockito;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

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
```

## Testing

After the tests are written, they can be executed. The Maven command `mvn test` can be used for this. This command runs all tests in the project and writes the result to the console. After the tests have run, a summary of the tests is displayed. It will either show that everything is okay or which tests failed. For more detailed information on the failed test, the previously output information in the console can be used.
