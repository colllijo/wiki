---
weight: 5120
title: "Annotations"
description: "Dokumentation zu Java-Annotationen."
icon: "alternate_email"
date: "2024-06-21T13:36:06+02:00"
lastmod: "2024-06-21T13:36:06+02:00"
draft: false
toc: true
---

## Einführung

In Java können Annotation verwendet werden. Diese haben selber keinen Einfluss auf die Funktionalität des Codes.
Sie ermöglichen es jedoch, zusätzliche Metadaten zu einem Element hinzuzufügen. Diese können den Code für Entwickler verständlicher,
aber auch von anderen Teilen des Programms genutzt werden, um damit zu arbeiten. Ein gutes Beispiel dafür ist [Spring Boot](https://spring.io/projects/spring-boot).
In Spring Boot werden Annotationen genutzt, um dem Framework zu sagen, welche Methode eines Controllers wie aufgerufen werden sollen.
Zum Beispiel wird mit `@GetMapping` definiert, dass eine Methode aufgerufen werden soll, wenn ein GET-Request an eine bestimmte URL gesendet wird.

## Annotationen erstellen

In Java können Annotationen mit dem Schlüsselwort `@interface` erstellt werden. Für jede Annotation muss noch eine Erhaltung und Ziel definiert werden.
Die Erhaltung wird mit der `@Retention` Annotation gesetzt und bestimmt, bis wann die Annotation erhalten bleibt.
Das Ziel wird mit `@Target` gesetzt und bestimmt, auf welche Elemente die Annotation angewendet werden kann. Zum Beispiel auf Methoden, Klassen oder Variablen.

{{% alert context="info" %}}

**`RetentionPolicy.SOURCE`:** Die Annotation ist nur im Quellcode vorhanden, beim Kompilieren wird sie entfernt.  
**`RetentionPolicy.CLASS`:** Die Annotation ist auch im kompilierten Bytecode (`.class` Datei) vorhanden, wird aber beim Laden des Programms entfernt.  
**`RetentionPolicy.RUNTIME`:** Die Annotation ist auch während der Ausführung des Programms noch vorhanden.  

{{% /alert %}}

### Beispiel

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
