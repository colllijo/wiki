---
weight: 5110
title: "Java CLI"
description: "Dokumentation und Informationen zum `java` und `javac` Befehl."
icon: "emoji_food_beverage"
date: "2024-09-25T17:06:18+02:00"
lastmod: "2024-09-25T17:06:18+02:00"
draft: false
toc: true
---

## Einführung

Java ist neben der Programmiersprache auch der Name des Kommandozeilenprogramms, welches für die Ausführung von Java Programmen benötigt wird.
Neben dem `java` Befehl, welcher Teil des Java Runtime Environment (JRE) und Java Development Kit (JDK) ist, gibt es auch noch den
`javac` Befehl, welcher für das Kompilieren von Java Quellcode benötigt wird und deshalb nur Teil des JDKs ist.

Diese beiden Programme sind essentiell für die Entwicklung von Java Programmen werden jedoch meist hinter anderen Programmen versteckt.
So werden viele Java Programme in eine Ausführbare Datei verpackt oder mittels Shortcut gestartet und mit einem Build-Tool wie
[Maven](https://maven.apache.org/) oder [Gradle](https://gradle.org/) gebaut.

## Kompilieren

Das Kompilieren von Java Quellcode (`.java` Dateien) in Java Bytecode (`.class` Dateien) wird mit dem `javac` Befehl durchgeführt.
Je nach Grösse des Projekts und Anzahl der Quellcodedateien macht es Sinn die Kompilierung unterschiedlich anzugehen.

### Einzeln Dateien

Um einzelne `.java` Dateien zu kompilieren kann der `javac` Befehl mit dem gewünschten Optionen gefolgt von den zu kompilierenden Dateien
aufgerufen werden. Dabei muss der Pfad zur Java Datei angegeben werden im Sinne des Dateisystems und nicht des Packages.  
Nachdem der `javac` Befehl gestartet wurde, wird entweder eine Fehlermeldung, welche bei der Kompilierung des Programms aufgetreten ist ausgegeben.
Wird keine Fehlermeldung ausgegeben so wurde die Klasse erfolgreich Kompiliert und es wurde eine Datei mit dem gleichen Name jedoch der Endung `.class` erstellt.
Diese Datei enthält den Java Bytecode welcher mit `java` ausgeführt werden kann.

```shell
$ ls -l
total 4
-rw-r--r-- 1 liam liam 106 Sep 26 17:10 Main.java
$
$ javac Main.java
$ ls -l
total 8
-rw-r--r-- 1 liam liam 415 Sep 26 17:17 Main.class
-rw-r--r-- 1 liam liam 106 Sep 26 17:17 Main.java
$
$ java Main
Hello, World!
```

Falls nicht nur eine Java Datei kompiliert werden soll, können auch mehrere Dateien nacheinander aufgelistet werden um diese gleichzeitig zu kompilieren.

### Ganze Applikationen

Wenn eine ganze Applikation kompiliert werden soll ist es aufwändig jede Java-Datei einzeln aufzulisten.
Hier gibt es zwei gute Optionen um die Kompilierung zu vereinfachen.

Die erste Option benutzt die `-sourcepath` Option, diese ermöglicht es die Dateien nach ihren Abhängigkeiten zu kompilieren.
Hier wird die Option `-sourcepath` mit dem Java-Sourcen Verzeichnis angegeben, dieses Verzeichnis enthält das Quellpaket der Applikation.
Und Danach wird der Pfad zur Klasse mit der `public static void main(String[] args)` Methode angegeben.

```shell
$ tree src
src
└── com
    └── example
        ├── Greeter.java
        └── Main.java

2 directories, 2 files
$
$ javac -sourcepath ./src -d ./target src/com/example/Main.java
$
$ tree target
target
└── com
    └── example
        ├── Greeter.class
        └── Main.class

2 directories, 2 files
```

Auf diese Weise werden alle Klassen, welche vom der Main Klasse und deren Abhängigkeiten abhängen sind automatisch kompiliert.
Das ist auch schon das Problem dieser Method, eine Klasse welche nicht referenziert wird wird auch nicht kompiliert.
Um dieses Problem zu umgehen kann der javac Befehl mit einer Argumentendatei ausgeführt werden, welche alle Klassen beinhaltet.

Diese Datei kann dann einfach mit der Erstellung einer neuer Klasse erweitert werden oder sogar direkt mit dem `find` Befehl erstellt werden.

```shell
$ tree src
src
└── com
    └── example
        ├── Greeter.java
        └── Main.java

2 directories, 2 files
$
$ find ./ -type f -name "*.java" > sources.txt
$
$ cat sources.txt
./src/com/example/Main.java
./src/com/example/Greeter.java
./src/com/example/Unreferenced.java
$
$ javac -d ./target @sources.txt
$
$ tree target/
target/
└── com
    └── example
        ├── Greeter.class
        ├── Main.class
        └── Unreferenced.class

2 directories, 3 files
```

### Java-Archive (JAR)

Wenn die Kompilierte Applikation nun verteilt werden soll ist es nicht angenehm alle `.class` Dateien kopieren zu müssen.
Hier würde es viel mehr Sinn machen, wenn alle Dateien in ein Archive verpackt werden könnten, welches als eenzelne Datei kopiert werden kann.
Dafür gibt es Java-Archive kurz JARs. Diese Archive können mit dem `jar` Befehl erstellt werden anhand der kompilierten Dateien und
allfälligen Ressourcen erstellt werden.

```shell
$ jar -cvfe App.jar com.example.Main -C target .
added manifest
adding: com/(in = 0) (out= 0)(stored 0%)
adding: com/example/(in = 0) (out= 0)(stored 0%)
adding: com/example/Greeter.class(in = 412) (out= 293)(deflated 28%)
adding: com/example/Main.class(in = 336) (out= 255)(deflated 24%)
adding: com/example/Unreferenced.class(in = 210) (out= 175)(deflated 16%)
$
$ java -jar App.jar
Hello, World!
```

## Ausführen

Ein Kompiliertes Java Programm ist zwar nett und gut aber wenn man es nicht ausführen kann ist es nicht viel wert.  
Dazu gibt es den `java` Befehl welcher für das Ausführen von Java Programmen zuständig ist.

### Bytecode

Wenn für eine von einer Applikation nur der Bytecode `.class` Dateien vorhanden sind, kann das Programm mit dem `java` Befehl ausgeführt werden.
Dazu muss der `java` Befehl mit dem Namen der Klasse, welche die `public static void main(String[] args)` Methode enthält aufgerufen werden.
Der der Name dieser Klasse muss in Form ihrer Packagestruktur und nicht in Form des Dateipfads angegeben werden. Das heisst, com.example.Main
und nicht com/example/Main.class. Damit dieser Befehl funktioniert, muss der `java` Befehl im `src` Verzeichnis der Applikation ausgeführt werden
oder falls dass nicht möglich oder umständlich ist kann der Pfad zum `src` Verzeichnis mit der `-classpath` Option angegeben werden.

```shell
$ ls -l
total 8
-rw-r--r-- 1 liam liam 415 Sep 26 17:17 Main.class
-rw-r--r-- 1 liam liam 106 Sep 26 17:17 Main.java
$
$ java Main
Hello, World!
```

Oder für eine Applikation mit mehreren Klassen:

```shell
$ tree classes/
classes/
└── com
    └── example
        ├── Greeter.class
        └── Main.class

2 directories, 2 files
$
$ java -cp classes/ com.example.Main
Hello, World!
```

### Java-Archive (JAR)

Java Archive können auch direkt mit dem `java` Befehl ausgeführt werden, dazu muss der `java` Befehl mit der `-jar` Option und dem Pfad zum JAR aufgerufen werden.

```shell
$ java -jar App.jar
Hello, World!
```

## Nützliche Optionen

Beim Kompilieren und Ausführen von Java Programmen gibt es einige nützliche Optionen, welche das Leben einfacher machen können.

### Kompilieren

- `-d <Verzeichnis>`: Mit dieser Option können Sie das Verzeichnis angeben, in dem die kompilierten `.class`-Dateien abgelegt werden sollen. Dies ist besonders nützlich, wenn Sie Ihre Quell- und Kompilatdateien getrennt halten möchten.

```shell
$ javac -d ./bin ./src/Main.java
```

- `-sourcepath <Verzeichnis>`: Diese Option gibt an, wo der Compiler nach anderen `.java`-Dateien suchen soll, die von der zu kompilierenden Datei abhängig sind. Dies ist nützlich, wenn Sie ein Projekt mit vielen Klassen haben, die voneinander abhängen.

```shell
$ javac -sourcepath ./src ./src/Main.java
```

- `-cp <Pfad>` oder `-classpath <Pfad>`: Diese Optionen legen den Suchpfad für Benutzerklassendateien und Annotation-Prozessoren fest. Wenn Sie Bibliotheken oder andere Klassen verwenden, die sich nicht im aktuellen Verzeichnis befinden, müssen Sie diese Option verwenden, um dem Compiler mitzuteilen, wo er sie finden kann.

```shell
$ javac -cp ./lib/* ./src/Main.java
```

### Ausführen

- `-cp <Pfad>` oder `-classpath <Pfad>`: Wie beim Kompilieren legt diese Option den Suchpfad für Anwendungsklassen und Ressourcen fest.

```shell
$ java -cp ./bin Main
```

- `-Xmx<size>`: Diese Option legt die maximale Grösse des Speicher-Heap fest. Wenn Sie eine Anwendung mit hohem Speicherbedarf haben, können Sie diese Option verwenden, um die Menge des für die JVM verfügbaren Speichers zu erhöhen.

```shell
$ java -Xmx512m -cp ./bin Main
```

- `-jar <Dateiname>`: Mit dieser Option können Sie eine Anwendung aus einer JAR-Datei ausführen. Der JAR-Dateiname wird in diesem Fall benötigt.

```shell
$ java -jar ./dist/App.jar
```

- `-D<Name>=<Wert>`: Mit dieser Option können Sie ein Systemeigenschaft definieren, die von Ihrer Anwendung abgerufen werden kann.

```shell
$ java -Dapp.env=production -cp ./bin Main

