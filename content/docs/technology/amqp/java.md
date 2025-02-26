---
weight: 4330
title: "RabbitMQ mit Java"
description: "Dokumentation wie RabbitMQ mit Java verwendet werden kann."
icon: "code"
date: "2024-10-23T16:24:05+02:00"
lastmod: "2024-10-23T16:24:05+02:00"
draft: false
toc: true
---

## Client Bibliothek

RabbitMQ bietet eine Java Client Bibliothek an, die verwendet werden kann um mit
RabbitMQ zu kommunizieren. Die Bibliothek kann als JAR heruntergeladen werden
es gibt sie auch im Maven Central Repository, was einfacher ist:

{{< prism lang="xml" line-numbers="true" line="19,23-27" >}}
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>dev.coll</groupId>
  <artifactId>rabbit-example</artifactId>
  <version>1.0.0</version>

  <name>rabbit-example</name>
  <url>https://wiki.coll.dev</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.21</maven.compiler.source>
    <maven.compiler.target>1.21</maven.compiler.target>

    <rabbitmq.version>5.22.0</rabbitmq.version>
  </properties>

  <dependencies>
    <dependency>
      <groupId>com.rabbitmq</groupId>
      <artifactId>amqp-client</artifactId>
      <version>${rabbitmq.version}</version>
    </dependency>
    ...
{{< /prism >}}

{{% alert context="info" %}}

Damit RabbitMQ Produktiv genutzt werden kann wird ein Logger benötigt, welcher
das SLF4J Interface implementiert. Ein Möglichkeit ist die Verwendung von
`logback`.

{{% /alert %}}

## Hello World Beispiel

Als Einsteig in die Verwendung von RabbitMQ mit Java ist hier ein einfaches
Beispiel ähnlich dem [Hello World](https://www.rabbitmq.com/tutorials/tutorial-one-java) der RabbitMQ Dokumentation.

### Producer

Der `Producer` wird in diesem Beispiel eine einfache Nachricht veröffentlichen,
welche dam vom `Consumer` gelesen werden kann. Dazu muss der Producer folgende
Schritte ausführen:

1. Eine `Connection` zum RabbitMQ Server herstellen.
2. Einen `Channel` für die `Connection` öffnen.
3. Die `Queue` deklarieren in die die Nachricht gesendet wird.
4. Die Nachricht `Hello, World!` veröffentlichen.

{{< prism lang="java" line-numbers="true" >}}

import java.text.MessageFormat;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

public class Producer implements Runnable {
  private final ConnectionFactory factory;
  private final String queueName;

  public Producer(ConnectionFactory factory, String queueName) {
    this.factory = factory;
    this.queueName = queueName;
  }

  @Override
  public void run() {
    try (Connection connection = factory.newConnection();
        Channel channel = connection.createChannel()) {
      // Declare the queue: name, durable, exclusive, auto-delete, arguments
      channel.queueDeclare(queueName, false, false, false, null);

      String message = "Hello, World!";
      // Publish the message: exchange, routingKey, props, message
      channel.basicPublish("", queueName, null, message.getBytes());

      System.out.println(MessageFormat.format("Producer: [x] Sent: {0}", message));
    } catch (Exception e) {
      e.printStackTrace();
    }
  }
}

{{< /prism >}}

### Consumer

Der `Consumer` meldet sich in diesem Beispiel an der `Queue` an und wartet auf
Nachrichten und liest diese aus. Dabei muss der Consumer folgende Schritte
ausführen:

1. Eine `Connection` zum RabbitMQ Server herstellen.
2. Einen `Channel` für die `Connection` öffnen.
3. Die `Queue` deklarieren in die die Nachricht gesendet wird.
4. Ein `DeliveryCallback` definieren, welches beim erhalten von Nachrichten
   ausgeführt wird.
5. Die `Queue` konsumieren.

{{% alert context="warning" %}}

Es ist wichtig, dass der `Consumer` die `Connection` und den `Channel` nicht wie
der `Producer` in einem `try-with-resources` Block verwendet, da sonst die 
Ausführung der Applikation nicht blockiert wird und das Programm endet, bevor
die Nachricht ausgelesen werden kann.

{{% /alert %}}

{{< prism lang="java" line-numbers="true" >}}

import java.text.MessageFormat;

import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;
import com.rabbitmq.client.DeliverCallback;

public class Consumer {
  private final ConnectionFactory factory;
  private final String queueName;

  public Consumer(ConnectionFactory factory, String queueName) {
    this.factory = factory;
    this.queueName = queueName;
  }

  public void run() throws Exception {
    Connection connection = factory.newConnection();
    Channel channel = connection.createChannel();

    // Declare the queue: name, durable, exclusive, auto-delete, arguments
    channel.queueDeclare(queueName, false, false, false, null);

    System.out.println("Consumer: [*] Waiting for messages.");

    DeliverCallback deliverCallback = (consumerTag, delivery) -> {
      String message = new String(delivery.getBody(), "UTF-8");
      System.out.println(MessageFormat.format("Consumer: [x] Received: {0}", message));
    };

    // Consume the message: queue, autoAck, deliverCallback, cancelCallback
    channel.basicConsume(queueName, true, deliverCallback, consumerTag -> {});
  }
}

{{< /prism >}}

### Applikation

Um den `Producer` und den `Consumer` zu starten, wird eine einfache
Applikationsklasse verwendet, diese startet den `Producer` im Hintergrund und
führt dann den `Consumer` aus.

{{< prism lang="java" line-numbers="true" >}}

import com.rabbitmq.client.ConnectionFactory;

public class App {
  private final static String QUEUE_NAME = "greetings";

  public static void main(String[] args) throws Exception {
    ConnectionFactory factory = new ConnectionFactory();
    factory.setHost("localhost");

    Thread.startVirtualThread(new Producer(factory, QUEUE_NAME));
    new Consumer(factory, QUEUE_NAME).run();
  }
}

{{< /prism >}}
