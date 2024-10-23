---
weight: 4130
title: "Graalvm"
description: "Dokumentation zu GraalVM."
icon: "article"
date: "2024-07-01T15:35:11+02:00"
lastmod: "2024-07-01T15:35:11+02:00"
draft: false
toc: true
---

## Einleitung

GraalVM ist ein erweitertes Java Development Kit (JDK), welches es ermöglicht,
Java-Applikationen zu Native-Images zu kompilieren. Ein Native-Image ist eine
ausführbare Datei ohne Abhängigkeiten zu Java. Das heisst, sobald aus einer
Java-Applikation ein Native-Image erstellt wurde, kann dieses direkt ausgeführt werden,
ohne das Java installiert sein muss.
Dadurch muss man nicht mehr Java installieren, um das Programm zu nutzen und es
ist einfacher möglich, das Programm zu starten, da es direkt und nicht über Java
gestartet werden kann.  
Anstelle von `java -jar App.jar` kann das Programm direkt mit `./App` gestartet.
Ein Nachteil von Native-Images ist es jedoch, dass diese wieder
plattformabhängig sind, im Gegensatz zu Java-Archiven funktioniert ein
Native-Image entweder auf Unix **oder** Windows.

## Installation

Alle Releases der GraalVM JDK sind im [GraalVM-CE-Builds](https://github.com/graalvm/graalvm-ce-builds) GitHub-Repository
unter den Releases zu finden. Die heruntergeladene JDK kann gleich jeder anderen
JDK, zum Beispiel temurin ausgepackt und in einen Ordner verschoben werden.  
*Auf Unix werden die Java Versionen meist unter `/lib/jvm/` gespeichert.*

{{% alert context="info" %}}
Damit GraalVM genutzt werden kann muss die `JAVA_HOME` Umgebungsvariable auf
das Verzeichnis der GraalVM-JDK gesetzt werden.
{{% /alert %}}

## Erstellung eines Native-Images

Native-Images können mit dem `native-image` Programm, welches im `bin/` Verzeichnis der
GraalVM-JDK ist, erstellt werden. Dies ist auf verschiedene Art und Weisen möglich,
einerseits können kompilierte Java-Dateien oder Java-Archive (Jar-Dateien) direkt
mittels des `native-image` Programms in eine ausführbare Datei verwandelt werden,
anderseits ist es auch möglich, die Native-Image Erstellung als Teil des normalen
Buildprozesses, zum Beispiel mit Maven durchzuführen.

### Prinzip

Bei der Erstellung eines Native-Images untersucht GraalVM Quellcode des Programms
und erkennt anhand dessen, welche Klassen und Funktionalitäten aus welchen
Bibliotheken für die Applikation benötigt werden, so kann GraalVM nur die nötigen
Klassen ins Native-Image bündeln, wodurch dieses nicht unnötig gross wird. Im
Endeffekt beinhaltet das Native-Image schlussendlich den Quellcode des Programms
sowie aller Bibliotheken und Java-Klassen, welche in dieser Applikation genutzt
werden. Da GraalVM für diese Untersuchung jedoch nur eine statische Codeanalyse
durchführen kann, ist es GraalVM nicht möglich, dynamische Abhängigkeiten zu
erkennen. Falls solche Abhängigkeiten bestehen, da zum Beispiel Java Reflection
benutzt wird, wodurch der effektive Programmablauf erst während der Runtime
bekannt wird, muss für die Erstellung noch ein weiterer Schritt durchgeführt
werden.

Damit GraalVM auch dynamische Programme in ein Native-Image verwandeln kann,
benötigt es eine Konfiguration, in welcher beschrieben ist, welche Klassen und
Methoden benötigt werden, diese kann manuell erstellt werden oder einfacher
mittels des `native-image-agent` Javaagenten. Dieser Javaagent kann an die
Programmausführung angebunden werden, woraufhin er alle benutzten Klassen und
Methoden in der Konfiguration aufschreibt. Nachdem alle Programmpfade mit dem
Agenten verfolgt wurden, kann das Native-Image mit der erstellten Konfiguration
erstellt werden.

#### Nutzung des native-image-agent

Um den `native-image-agent` zu nutzen, kann die Applikation fast wie gewohnt
gestartet werden, es muss einfach die `-agentlib:native-image-agent` Option im
Java-Befehl ergänzt werden. Der Javaagent kann auch noch weiter konfiguriert
werden, so kann das Verzeichnis, in dem die Konfiguration gespeichert werden soll,
mit dem Parameter `config-output-dir` mitgegeben werden oder falls bereits ein
Teil der Konfiguration existiert, kann das Verzeichnis dieser mit dem Parameter
`config-merge-dir` mitgegeben werden, wodurch dieses erweitert wird. Die
Konfiguration an den Javaagenten wird im Format
`-agentlib:native-image-agent=param1=value1,param2=value2` angegeben.

Beispiel: [Konfiguration mit einem Tracing Agent](https://www.graalvm.org/latest/reference-manual/native-image/guides/configure-with-tracing-agent/)

*Weiter Informationen:*  
[Automatische Erstellung der Metadaten](https://www.graalvm.org/latest/reference-manual/native-image/metadata/AutomaticMetadataCollection/)

### Erstellung mit der CLI

Mit der `native-image` CLI können kompilierte Java Klassen direkt in ein
ausführbares Programm verwandelt werden. Dazu kann die Klasse mittels `javac`
kompiliert und dann mittels `native-image` gebaut werden:

```shell
native-image [options] class [imagename] [options]
```

Ein einfaches Beispiel mit einem `HelloWorld` Programm sieht wie folgt aus:

HelloWorld.java

{{< prism lang="java" line-numbers="true" >}}
public class HelloWorld {
  public static void main(String[] args) {
    System.out.println("Hello, world!");
  }
}
{{< /prism >}}

```shell
# Build
javac HelloWorld.java
native-image HelloWorld
# Programm starten
./helloworld
```

Da jedoch nicht jedes Programm Platz in einer Klasse hat, ist es auch möglich,
Java-Archive sowie Java-Module in ausführbare Dateien zu verwandeln.  
Um aus einem Java-Archive ein Native-Image zu erstellen, kann der `native-image` Befehl mit
den gleichen Argumenten wie der Java Befehl ausgeführt werden, wie wenn die Jar-Datei
gestartet werden soll. Hierbei dürfen einfach die Argumente an das Programm
selber nicht mitgegeben werden, diese werden dann erst dem Native-Image
mitgegeben. So kann die Datei `App.jar`, welche mit `java -jar App.jar`  ausgeführt
wird mit, dem Befehl `native-image -jar App.jar`  in ein Native-Image verwandelt
werden und später mit dem Befehl `./App`  ausgeführt werden.

*Weitere Informationen:*  
[Native-Image CLI](https://www.graalvm.org/latest/reference-manual/native-image/)  
[Native-Image Programm erstellen](https://www.graalvm.org/latest/reference-manual/native-image/guides/build-native-executable-from-jar/)

### Erstellung mit Maven

Damit das Native-Image nicht jeweils von Hand erstellt werden muss, gibt es von
GraalVM das `native-image-maven` Plugin, welches im Plugins Abschnitt der pom.xml
Datei hinzugefügt werden kann. Da der Build eines Native-Images meist jedoch
länger dauert als andere Arten, ist es empfehlenswert, ein Maven Profil zu
erstellen, welches das Programm buildet, ohne ein Native-Image zu erstellen,
wenn das Programm trotzdem nicht als Java-Archiv ausgeführt werden soll, ist das
[`really-exeutable-jar-maven-plugin`](https://github.com/brianm/really-executable-jars-maven-plugin) eine einfache Möglichkeit, die Applikation
schnell zu testen.

```xml
<!-- ... -->
<plugin>
  <groupId>org.graalvm.buildtools</groupId>
  <artifactId>native-maven-plugin</artifactId>
  <version>${native.maven.plugin.version}</version>
  <extensions>true</extensions>
  <executions>
    <execution>
      <id>build-native</id>
      <goals>
        <goal>compile-no-fork</goal>
      </goals>
      <phase>package</phase>
    </execution>
  </executions>
  <configuration>
    <imageName>executable-name</imageName>
    <mainClass>ch.coll.ClassName</mainClass>
    <fallback>false</fallback>
    <!-- ... -->
  </configuration>
</plugin>
<!-- ... -->
```

*Weitere Informationen:*  
[Native-Build Maven plugin](https://graalvm.github.io/native-build-tools/latest/maven-plugin.html)

## Build mit einer Pipeline

Um ein Native-Image per Pipeline zu erstellen, kann dies ähnlich einer normalen
Java-Applikation gemacht werden. Dabei gibt es wesentlich zwei Unterschiede,
einerseits muss anstelle des Java-Archives das Binary so wie die *shared object's*
(Dateiendung `.so`) verteilt werden, dies ist zum Beispiel als Pipeline Artefakt,
NPM-Packet möglich. Der zweite Unterschied ist, dass
der Build ebenfalls mittels der GraalVM-JDK ausgeführt werden muss. Diese ist
momentan noch nicht standardmässig in den Pipelines verfügbar, weshalb diese
zuerst heruntergeladen werden muss. Im Build muss dann auch sichergestellt
werden, dass die GraalVM JDK genutzt wird.

## Mögliche Probleme

- **Unvollständige Konfiguration**  
  Bei der Erstellung der Konfiguration mittels des `native-image-agent's` ist es
  möglich, das nicht alle Klassen korrekt erfasst werden. Diese Unterschiede können
  von System zu System unterschiedlich sein, so ist es zum Beispiel möglich, das
  lokal die korrekte Konfiguration generiert wird, in der Build-Pipeline jedoch
  eine unvollständige. Die Erstellung des Native-Images funktioniert auch mit
  einer unvollständigen Konfiguration und das Problem wird erst bei der Ausführung
  des Programmes klar ersichtlich, da gewisse Klassen und Methoden nicht gefunden
  werden können. Um dieses Problem zu erkennen, sollte das Native-Image nach der
  Erstellung erneut getestet werden, um solche Fehler zu verhindern. Eine andere
  Möglichkeit, solche Fehler zu erkennen, bietet sich in der Ausgabe des
  Native-Image Build Schrittes. Im zweiten Unterschritt listet GraalVM alle
  Programmteile auf, welche in das Executable eingebunden werden, falls es hier
  zwischen dem lokalen Build und dem Pipeline-Build Unterschiede gibt, ist eine
  unvollständige Konfiguration vorhanden.

  Der Grund, weshalb die Konfiguration nicht immer gleich ist, ist mir noch nicht
  bekannt jedoch gibt es einen Workaround für dieses Problem, die nicht erkannten
  Klassen können per manuelle Konfiguration hinzugefügt werden, hierbei kann die
  `merge` Funktion des Javaagenten genutzt werden, damit nicht die vollständige
  Konfiguration manuell erstellt werden muss. Falls die unvollständige
  Konfiguration in der Pipeline entsteht, ist es möglich, die Pipeline zu
  modifizieren, um die dort erstellte Konfiguration als Artefakt in der Pipeline
  zu veröffentlichen, wodurch einfach die Differenz zwischen der
  Pipeline-Konfiguration und der lokalen Konfiguration manuell hinzugefügt werden
  kann.
