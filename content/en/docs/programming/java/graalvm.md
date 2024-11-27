---
weight: 4130
title: "Graalvm"
description: "Documentation on GraalVM."
icon: "article"
date: "2024-07-01T15:37:43+02:00"
lastmod: "2024-07-01T15:37:43+02:00"
draft: false
toc: true
---

## Introduction

GraalVM is an enhanced Java Development Kit (JDK) that allows Java applications
to be compiled to native images. A native image is an executable file without
dependencies on Java. This means that once a Java application has been compiled
to a native image, it can be run directly on all systems of the target platform
without the need to install Java. This means that you no longer need to install
Java to use the program, and it is easier to start the program, as it can be
started directly and not via Java.  
Instead of `java -jar App.jar` the program can be started directly with
`./App`. However, one disadvantage of native images is that they are platform
dependent again, in contrast to Java archives a native image works either on
Unix **or** Windows.

## Installation

All releases of the GraalVM JDK are available in the [GraalVM-CE-Builds](https://github.com/graalvm/graalvm-ce-builds) GitHub repository
under the releases. The downloaded JDK can be unpacked and moved to a folder
just like any other JDK, for example temurin.  
*On Unix, the Java versions are usually stored under `/lib/jvm/`.*

{{% alert context="info" %}}
To use GraalVM the `JAVA_HOME` environment variable must be set to the directory
of the GraalVM JDK.
{{% /alert %}}

## Creating a Native-Image

Native images can be created with the `native-image` program, which is in the
`bin/` directory of the GraalVM JDK. This can be done in different ways, on the
one hand, compiled Java files or Java archives (jar files) can be transformed
into an executable file directly using the `native-image` program, on the other
hand, it is also possible to perform the native image creation as part of the
normal build process, for example with Maven.

### Principle

When creating a native image, GraalVM examines the source code of the program
and recognizes which classes and functionalities from which libraries are
required for the application, so GraalVM can bundle only the necessary classes
into the native image, making it not unnecessarily large. In the end, the native
image contains the source code of the program, as well as all libraries and Java
classes used in this application. However, since GraalVM can only perform a
static code analysis for this examination, it is not possible for GraalVM to
recognize dynamic dependencies. If such dependencies exist, for example, because
Java Reflection is used, which means that the actual program flow is only known
during runtime, another step must be performed for the creation.

In order for GraalVM to be able to transform dynamic programs into a native image,
it needs a configuration that describes which classes and methods are needed,
this can be created manually or more easily using the `native-image-agent` Java
agent. This Java agent can be attached to the program execution, whereupon it
writes down all used classes and methods in the configuration. After all program
paths have been traced with the agent, the native image can be created with the
created configuration.

### Using the native-image-agent

To use the `native-image-agent`, the application can be started almost as usual,
just add the `-agentlib:native-image-agent` option to the Java command. The Java
agent can also be further configured, so the directory where the configuration
is to be stored can be supplemented with the parameter `config-output-dir` or if
part of the configuration already exists, the directory of this with the
parameter `config-merge-dir` can be given, which will be extended. The
configuration to the Java agent is specified in the format
`-agentlib:native-image-agent=param1=value1,param2=value2`.

Example: [Configuration with a Tracing Agent](https://www.graalvm.org/latest/reference-manual/native-image/guides/configure-with-tracing-agent/)

*Further information:*  
[Automatic Creation of Metadata](https://www.graalvm.org/latest/reference-manual/native-image/metadata/AutomaticMetadataCollection/)

### Creation with the CLI

With the `native-image` CLI, compiled Java classes can be directly transformed
into an executable program. For this purpose, the class can be compiled using
`javac` and then built using `native-image`.

```shell
native-image [options] class [imagename] [options]
```

A simple example with a `HelloWorld` program looks like this.

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
# Start program
./helloworld
```

However, since not every program fits into a class, it is also possible to
transform Java Archives as well as Java Modules into executable files. To create
a native image from a Java Archive, the `native-image` command can be executed
with the same arguments as the Java command, as if the jar file were to be
started. However, the arguments to the program itself must not be passed, they
are only passed to the native image. This way, the file `App.jar` which is
executed with `java -jar App.jar` can be transformed into a native image with the
command `native-image -jar App.jar` and later executed with the command `./App`.

*Further information:*  
[Native-Image CLI](https://www.graalvm.org/latest/reference-manual/native-image/)  
[Create Native-Image Program](https://www.graalvm.org/latest/reference-manual/native-image/guides/build-native-executable-from-jar/)

### Creation with Maven

To avoid having to create the native image by hand each time, there is the
`native-image-maven` Plugin from GraalVM, which can be added to the plugins
section of the pom.xml file. Since the build of a native image usually takes
longer than other types, it is recommended to create a Maven profile that builds
the program without creating a native image if the program should not be executed
as a Java archive, the [`really-exeutable-jar-maven-plugin`](https://github.com/brianm/really-executable-jars-maven-plugin)
is a simple way to test the application quickly.

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

*Further information:*  
[Native-Build Maven plugin](https://graalvm.github.io/native-build-tools/latest/maven-plugin.html)

## Building with a Pipeline

To create a native image via a pipeline, this can be done similarly to a normal
Java application. There are two main differences, on the one hand, instead of
the Java Archives, the binary as well as the shared object's (file extension
`.so`) must be distributed, this can be done for example as a pipeline artifact,
NPM package. The second difference is that the build must also be executed using
the GraalVM JDK. This is currently not yet available in the pipelines, which is
why it must first be downloaded. In the build, it must then be ensured that the
GraalVM JDK is used.

## Possible Problems

- **Incomplete Configuration**  
  When creating the configuration using the `native-image-agent`, it is possible
  that not all classes are correctly captured. These differences can be different
  from system to system, so it is possible that the correct configuration is
  generated locally, but an incomplete one in the build pipeline. Creating the
  native image also works with an incomplete configuration and the problem only
  becomes apparent during program execution, as certain classes and methods cannot
  be found. To detect this problem, the native image should be tested again after
  creation to prevent such errors. Another way to detect such errors is in the
  output of the native image build step. In the second substep, GraalVM lists all
  program parts that are included in the executable, if there are differences
  between the local build and the pipeline build, an incomplete configuration
  is present.

  The reason why the configuration is not always the same is not yet known to me
  , but there is a workaround for this problem, the unrecognized classes can be
  added manually via configuration, the `merge` function of the Java agent can be
  used so that the complete configuration does not have to be created manually.
  If the incomplete configuration arises in the pipeline, it is possible to
  modify the pipeline to publish the configuration created there as an artifact
  in the pipeline, which makes it easy to manually add the difference between the
  pipeline configuration and the local configuration.
