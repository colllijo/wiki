---
weight: 4110
title: "Java CLI"
description: "Documentation and information about the `java`and `javac` command"
icon: "emoji_food_beverage"
date: "2024-09-25T17:06:18+02:00"
lastmod: "2024-09-25T17:06:18+02:00"
draft: false
toc: true
---

## Introduction

Java is not only the name of the programming language but also the name of the
CLI responsible for the execution of Java programs on the JVM. Next to the
`java` command, which is included in the Java Runtime Environment (JRE) **and**
the Java Development Kit (JDK), there is also the `javac` command which is
responsible for the compilation of Java source code. As such `javac` is **only**
part of the JDK.

Those two commands are essential for the development of Java applications, tough
they are most often hidden behind other programs. Many Java Programms get
wrapped in an executable file and the build is done by a build tool like
[Maven](https://maven.apache.org/) or [Gradle](https://gradle.org/).

## Compilation

The compilation of Java source code (`.java` files) into Java bytecode (`.class`
Files) is done with the `javac` command. Depending on the size of the project
and the number of source files, it makes sense to approach the compilation
differently.

### Single Files

To compile single `.java` files, the `javac` command can be called with the
desired options followed by the files to be compiled. Here the path to the Java
file needs to be specified in terms of the file system and not the package.  
After running the `javac` command it either fails by outputting an error message
detailing what went wrong during the compilation of the program. If no error
appears the class was successfully compiled and a file with the same name but
suffix `.class` was created. This file contains the Java bytecode which can be
run with `java`.

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

If more than one Java file needs to be compiled, multiple files can be listed.
They then get compiled with the same call to `javac`.

### Complete Applications

If an entire application needs to be compiled, it is cumbersome to list each
Java file individually. Here are two good options to simplify the compilation.

The first options uses the `-sourcepath` option. This allows to compile files
based on their dependencies. The `-sourcepath` option is followed by the path
to the Java source directory. This source directory needs to contain the source
package of the application. After the source path, the path to the class with
the `public static void main(String[] args)` method is specified.

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

In this way, all classes that depend on the Main class and its dependencies are
automatically compiled. This is also the problem with this method, a class that
is not referenced is not compiled. To circumvent this problem, the `javac`
command can be executed with an argument file that contains all classes.

This file can then be extended when creating a new class to the application or
even directly using the `find` command.

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

### Java Archive (JAR)

When the compiled application should distributed, it is annoying to need to
distribute each and ever `.class` file. Therefore Java provides the Java Archive.
The Java Archive is a compressed file that contains all the compiled classes and
still allows people to run the application.  
To create such a Java Archive the `jar` command is used. The `jar` command takes
all the `.class` files and any other resources that are needed.

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

## Execution

A compiled Java application is all well and good, but if you can't run it it's
not worth much.  
For this purpose the `java` command is used. It makes sure that the compiled
application is run on the JVM.

### Bytecode

When a given application exists in form of Java bytecode (`.class` files), the
application can be run using the `java` command. For this the `java` command
must be run with the name of the class wich contains the entry point (the 
`public static void main(String[] args)` method). The name of this class needs
to be specified in Form of it's fully qualified name. In example
`com.example.Main` and not `com/example/Main`. For this command to work it
either needs to be executed in the source directory of the application or the
path to the source directory needs to be specified using the `-classpath`
option.

```shell
$ ls -l
total 8
-rw-r--r-- 1 liam liam 415 Sep 26 17:17 Main.class
-rw-r--r-- 1 liam liam 106 Sep 26 17:17 Main.java
$
$ java Main
Hello, World!
```

Or if the application consists of multiple classes:

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

### Java Archive (JAR)

The `java` command can also be used to execute Java Archives, for this the
`-jar` option and the path to the JAR must be specified.

```shell
$ java -jar App.jar
Hello, World!
```

## Useful Options

When compiling and running Java programs there are some useful options that can
passed to the `javac` and `java` commands to make life easier.

### Compilation

- `-d <directory>`: This option allows you to specified the directory where the
  compiled `class`-files will be stored. This is useful when you want to keep the
  source and compiled files separate.

```shell
$ javac -d ./bin ./src/Main.java
```

- `-sourcepath <directory>`: The `-sourcepath` directory specifies where the
  compiler should look for other `.java` files that the file being compiled
  depends on. This is useful when you have a project with many classes that
  depend on each other.

```shell
$ javac -sourcepath ./src ./src/Main.java
```

- `-cp <path>` or `-classpath <path>`: This option set the search path for
  user class files and annotation processors. If you use libraries or other
  classes that are not in the current directory, you need to use this option to
  tell the compiler where it can find them.

```shell
$ javac -cp ./lib/* ./src/Main.java
```

### Execution

- `-cp <path>` or `-classpath <path>`: This option, like when compiling, sets
  the search path for application classes and resources.

```shell
$ java -cp ./bin Main
```

- `-Xmx<size>`: This option sets the maximum size of the memory heap. If you
  have an application with high memory requirements, you can use this option to
  increase the amount of memory available to the JVM.

```shell
$ java -Xmx512m -cp ./bin Main
```

- `-jar <filename>`: This option specifies the JAR file to be executed.

```shell
$ java -jar ./dist/App.jar
```

- `-D<name>=<value>`: This option allows you to define a system property that
  can be retrieved by your application.

```shell
$ java -Dapp.env=production -cp ./bin Main

