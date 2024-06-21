---
weight: 100
title: "Annotations"
description: "Documentation about Java annotations."
icon: "alternate_email"
date: "2024-06-21T13:36:08+02:00"
lastmod: "2024-06-21T13:36:08+02:00"
draft: false
toc: true
---

## Introduction


In Java, annotations can be used. These do not have an influence on the functionality of the code themselves. They allow to add additional metadata to an element.
These can make the code more understandable for developers but can also be used by other parts of the program to work with. A good example for this is [Spring Boot](https://spring.io/projects/spring-boot).
In Spring Boot annotations are used to tell the framework which method of a controller should be called how. For example with `@GetMapping` it is defined that a method should be called when a GET request is sent to a specific URL.

## Creating Annotations

In Java, annotations can be created with the keyword `@interface`. For each annotation, a retention and target must be defined. The retention is set with the `@Retention` annotation and determines until when the annotation is retained. With SOURCE it is only present in the source code, with CLASS it is also written into the compiled `.class` file and with RUNTIME it is still present during the execution of the program. The target is set with `@Target` and determines on which elements the annotation can be applied. For example on methods, classes or variables.

### Example

CustomAnnotation.java
{{< prism lang="java" line-numbers="true"  >}}
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
 
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;
 
@Retention(RUNTIME)
@Target(FIELD)
public @interface CustomAnnotation {
    public String name() default = "";
}
{{< /prism >}}

Ball.java
{{< prism lang="java" line-numbers="true" >}}
import CustomAnnotation;
 
public class Ball {
    @CustomAnnotation
    public Color farbe;
 
    @CusotmAnnotation(name = "Ballgrösse")
    public String grösse;
}
{{< /prism >}}
