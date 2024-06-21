---
weight: 200
title: "Dependency Injection"
description: "Eine kurze Einführung in das Thema Depedency Injection mit einem kleinen Java Beispiel"
icon: "article"
date: "2024-06-14T16:56:19+02:00"
lastmod: "2024-06-14T16:56:19+02:00"
draft: false
toc: true
---

{{< rawhtml >}}
<style>
  .split-container {
    display: grid;
    grid-template-columns: 2fr 1fr;
    grid-gap: 2rem;
  }
</style>
{{< /rawhtml >}}

{{< rawhtml >}}
<div class="split-container">
  <div>
{{< /rawhtml >}}
## Einführung

Mit dependency Injection wird bewirkt das eine Klasse selber keine
Abhängigkeiten mehr verwalten muss, da diese automatisch zur Verfügung gestellt
werden. Dadurch soll es einfacher sein Abhängigkeiten zu verändern, da diese
weniger Anpassungen in ihren Abhängigkeiten zur folge haben, im besten fall
sogar gar keine Veränderungen mehr.

Eine Abhängigkeit kann mittels Dependency Injection an drei verschiedenen
Stellen eingeführt werden. Es ist möglich die Abhängigkeit bei der
Konstruktion des Clients zu erstellen, hierbei wird die Abhängigkeit in den
Konstruktor eingeführt, eine zweite Möglichkeit ist es, die Abhängigkeit mittels
einer Setter Method einzuführen, welche nach dem Konstruktor aufgerufen wird.
Die letzte Möglichkeit ist es die Abhängigkeit direkt im Feld einzuführen, sodass
weder eine Konstruktor noch eine spezifische Setter Methode benötigt wird.

Die Dependency Injection ist eine Erweiterung der Dependency Inversion unter dem
[SOLID Prinzip](/docs/design-patterns/solid), welche die Abhängigkeit von unten nach oben bringt.

## Rollen

Für die Umsetzung der Dependency Injection werden vier Rollen benötigt
Diese werden folgend kurz erläutert.

### Service

Der Service ist der Teil der Applikation, welcher an einer anderen Stelle
genutzt werden soll, da dieser einen Teil der Benötigten Geschäftslogik
implementiert. Damit die Applikation möglichst Modular bleibt und mit dem
Dependency Inversion Principle übereinstimmt, wird ein Service nie direkt in
einem Client genutzt. Anstelle dessen implementiert ein Service ein Interface,
welches wiederum von Clients verwendet werden kann.


### Client

Der Client bezeichnet den Teil der Applikation, welcher einen Service
konsummieren und benutzen soll. Die Abhängigkeit soll hier "eingespritzt"
werden. Dadurch kann der Client die Funktionalitäten des Interfaces, welche vom
Service implementiert werden einfach Nutzen ohne sich darum kümmern zu müssen,
welche implementation er jetzt benutzt.

### Interface

Das Interface ist die Abstraktion zwischen Client und Service. Es definiert eine
Schnittstelle wodurch ein Client weiss, welche Methoden ihm auf einem Service
zur Verfügung stehen und macht es für einen Service klar, welche Methoden
implementiert werden müssen.

### Injector

Die Aufgabe des Injectors ist es die jeweiligen Services mittels der
Interfaces in die Clients "einzuspritzen", damit diese sie benutzen
können. Der Injector ist im Vergleich zur Dependency Inversion die einzig neue
Rolle welche zu vor noch nicht benötigt wurde.
{{< rawhtml >}}
  </div>
  <div>
{{< /rawhtml >}}

## Ressourcen

[Wikipedia - Prinzipien objektorientierten Designs](https://de.wikipedia.org/wiki/Prinzipien_objektorientierten_Designs)  
[Wikipedia - Contexts and Dependency Injection](https://de.wikipedia.org/wiki/Contexts_and_Dependency_Injection)  
[Stackify - Dependency Injection](https://stackify.com/dependency-injection/)  
[Stackify - Dependency Inversion Principle](https://stackify.com/dependency-inversion-principle/)  

## CDI

Contexts and Dependency Injection (CDI) ist ein Java-Standard, welcher das Prinzip
der Dependency Injection erweitert. CDI ermöglicht es, die Abhängigkeiten der
verschiedenen Module automatisiert zu injizieren, wodurch es nicht mehr nötig ist
die benötigten Abhängigkeiten manuell mitzugeben. CDI entscheidet anhand der verschiedener
Zusammenhänge, sowie einer Konfiguration, welche Abhängigkeit wo benötigt wird.
{{< rawhtml >}}
  </div>
</div>
{{< /rawhtml >}}

## Beispiel

Um dieses Prinzip zu verdeutlichen gibt es hier ein kleines Beispiel in Java.
Dabei soll eine Applikation erstellt werden, welche genutzt werden kann um mit
unterschiedlichen Kaffeemaschine Kaffee zu brühen.

### Ausgangslage

Für die Ausgangslage gibt es zwei Kaffeemaschine, die `BasicCoffeeMachine` und die `PremiumCoffeeMachine`.
Beide Machinen haben eine Method um Kaffee zu brühen, jedoch kann die `PremiumCoffeeMachine` neben dem
Filterkaffee auch noch Espresso brühen.

{{< tabs tabTotal="2" >}}
{{< tab tabName="BasicCoffeeMachine.java" >}}
{{< prism lang="java" line-numbers="true" >}}
import java.util.Map;

public class BasicCoffeeMachine {
  private Configuration config;
  private Map<CoffeeSelection, GroundCoffee> groudnCoffee;
  private BrewingUnit brewingUnit;

  public BasicCoffeeMachine(Map<CoffeeSelection, GroundCoffee> coffee) {
    this.config = new Configuration(30, 480);
    this.groundCoffee = coffee;
    this.brewingUnit = new BrewingUnit();
  }

  public Coffee brewFilterCoffee() {
    GroundCoffee groundCoffee = this.groundCoffee.get(CoffeeSelection.FILTER_COFFEE);
    return this.brewingUnit.brew(CoffeeSelection.FILTER_COFFEE, groundCoffee, this.config.getQuantityWater());
  }

  public void addGroundCoffee(CoffeeSelection sel, GroundCoffee newBeans) throws CoffeeException {
    GourndCoffee existingCoffee = this.groundCoffee.get(sel);
    if (existingCoffee != null) {
      if (existingCoffee.getName().equals(newBeans.getName())) {
        existingCoffee.setQuantity(existingCoffee.getQuantity() + newBeans.getQuantity());
      } else {
        throw new CoffeeException("Only one kind of coffee supported for each CoffeeSelection.");
      }
    } else {
      this.groundCoffee.put(sel, coffee);
    }
  }
}
{{< /prism >}}
{{< /tab >}}

{{< tab tabName="PermiumCoffeeMachine.java" >}}
{{< prism lang="java" line-numbers="true" >}}
import java.util.HashMap;
import java.util.Map;

public class PremiumCoffeeMachine {
  private Map<CoffeeSelection, Configuration> configMap;
  private Map<CoffeeSelection, CoffeeBean> beans;
  private Grinder grinder
  private BrewingUnit brewingUnit;

  public PremiumCoffeeMachine(Map<CoffeeSelection, CoffeeBean> beans) {
    this.beans = beans;
    this.grinder = new Grinder();
    this.brewingUnit = new BrewingUnit();
    this.configMap = new HashMap<>();
    this.configMap.put(CoffeeSelection.FILTER_COFFEE, new Configuration(30, 480));
    this.configMap.put(CoffeeSelection.ESPRESSO, new Configuration(8, 28));
  }

  public Coffee brewEspresso() {
    Configuration config = configMap.get(CoffeeSelection.ESPRESSO);
    GroundCoffee groundCoffee = this.grinder.grind( this.beans.get(CoffeeSelection.ESPRESSO), config.getQuantityCoffee())
    return this.brewingUnit.brew(CoffeeSelection.ESPRESSO, groundCoffee, config.getQuantityWater());
  }

  public Coffee brewFilterCoffee() {
    Configuration config = configMap.get(CoffeeSelection.FILTER_COFFEE);
    GroundCoffee groundCoffee = this.grinder.grind( this.beans.get(CoffeeSelection.FILTER_COFFEE), config.getQuantityCoffee());
    return this.brewingUnit.brew(CoffeeSelection.FILTER_COFFEE, groundCoffee, config.getQuantityWater());
  }

  public void addCoffeeBeans(CoffeeSelection sel, CoffeeBean newBeans) throws CoffeeException {
    CoffeeBean existingBeans = this.beans.get(sel);
    if (existingBeans != null) {
      if (existingBeans.getName().equals(newBeans.getName())) {
        existingBeans.setQuantity(existingBeans.getQuantity() + newBeans.getQuantity());
      } else {
        throw new CoffeeException("Only one kind of coffee supported for each CoffeeSelection.");
      }
    } else {
      this.beans.put(sel, newBeans);
    }
  }
}
{{< /prism >}}
{{< /tab >}}
{{< /tabs >}}

### Abstraktion

Der erste Schritt zur Dependency Injection ist die Abstraktion der öffentlichen Methoden.
Dazu muss ein Interface für die Kaffeemaschine erstellt werden. Da nicht jede Kaffeemaschine
Espresso brühen kann gibt es hier zwei Interfaces, ein Grundlegendes für alle Kaffeemaschine,
welches Filterkaffee brühen kann und ein zweites für die Premium Kaffeemaschine, welche auch
Espresso brühen kann. Die `BasicCoffeeMachine` kann dann das einfach Interface implementieren
und die `PremiumCoffeeMachine` implementiert einfach beide.

{{< tabs tabTotal="2" >}}
{{< tab tabName="CoffeeMachine.java" >}}
{{< prism lang="java" line-numbers="true" >}}
public interface CoffeeMachine {
  Coffee brewFilterCoffee();
}
{{< /prism >}}
{{< /tab >}}
{{< tab tabName="EspressoMachine.java" >}}
{{< prism lang="java" line-numbers="true" line="3" >}}
public interface EspressoMachine {
  Coffee brewEspresso();
}
{{< /prism >}}
{{< /tab >}}
{{< /tabs >}}

**Refactoring**
{{< tabs tabTotal="2" >}}
{{< tab tabName="BasicCoffeeMachine.java" >}}
{{< prism lang="java" line-numbers="true" line="3,15-19" >}}
import java.util.Map;

public class BasicCoffeeMachine implements CoffeeMachine {

  private Configuration config;
  private Map<CoffeeSelection, GroundCoffee> groundCoffee;
  private BrewingUnit brewingUnit;

  public BasicCoffeeMachine(Map<CoffeeSelection, GroundCoffee> coffee).  
    this.groundCoffee = coffee;
    this.brewingUnit = new BrewingUnit();
    this.config = new Configuration(30, 480);
  }

  @Overrride
  public Coffee brewFilterCoffee() {
    GroundCoffee groundCoffee = this.groundCoffee.get(CoffeeSelection.FILTER_COFFEE);
    return this.brewingUnit.brew(CoffeeSelection.FILTER_COFFEE, groundCoffee, this.config.getQuantityWater());
  }

  public void addGroundCoffee(CoffeeSelection sel, GroundCoffee newCoffee) throws CoffeeException {
    GroundCoffee existingCoffee = this.groundCoffee.get(sel);
    if (existingCoffee != null) {
      if (existingCoffee.getName().equals(newCoffee.getName())) {
        existingCoffee.setQuantity(existingCoffee.getQuantity() + newCoffee.getQuantity())
      } else {
        throw new CoffeeException("Only one kind of coffee supported for each CoffeeSelection.")
      }
    } else {
      this.groundCoffee.put(sel, newCoffee)
    }
  }
}
{{< /prism >}}
{{< /tab >}}

{{< tab tabName="PermiumCoffeeMachine.java" >}}
{{< prism lang="java" line-numbers="true" line="4,19-24,26-31" >}}
import java.util.HashMap;
import java.util.Map;

public class PremiumCoffeeMachine implements CoffeeMachine, EspressoMachine {
  private Map<CoffeeSelection, Configuration> configMap;
  private Map<CoffeeSelection, CoffeeBean> beans;
  private Grinder grinder
  private BrewingUnit brewingUnit;

  public PremiumCoffeeMachine(Map<CoffeeSelection, CoffeeBean> beans) {
    this.beans = beans;
    this.grinder = new Grinder();
    this.brewingUnit = new BrewingUnit();
    this.configMap = new HashMap<>();
    this.configMap.put(CoffeeSelection.FILTER_COFFEE, new Configuration(30, 480));
    this.configMap.put(CoffeeSelection.ESPRESSO, new Configuration(8, 28));
  }

  @Override
  public Coffee brewEspresso() {
    Configuration config = configMap.get(CoffeeSelection.ESPRESSO);
    GroundCoffee groundCoffee = this.grinder.grind( this.beans.get(CoffeeSelection.ESPRESSO), config.getQuantityCoffee())
    return this.brewingUnit.brew(CoffeeSelection.ESPRESSO, groundCoffee, config.getQuantityWater());
  }

  @Override
  public Coffee brewFilterCoffee() {
    Configuration config = configMap.get(CoffeeSelection.FILTER_COFFEE);
    GroundCoffee groundCoffee = this.grinder.grind( this.beans.get(CoffeeSelection.FILTER_COFFEE), config.getQuantityCoffee());
    return this.brewingUnit.brew(CoffeeSelection.FILTER_COFFEE, groundCoffee, config.getQuantityWater());
  }

  public void addCoffeeBeans(CoffeeSelection sel, CoffeeBean newBeans) throws CoffeeException {
    CoffeeBean existingBeans = this.beans.get(sel);
    if (existingBeans != null) {
      if (existingBeans.getName().equals(newBeans.getName())) {
        existingBeans.setQuantity(existingBeans.getQuantity() + newBeans.getQuantity());
      } else {
        throw new CoffeeException("Only one kind of coffee supported for each CoffeeSelection.");
      }
    } else {
      this.beans.put(sel, newBeans);
    }
  }
}
{{< /prism >}}
{{< /tab >}}
{{< /tabs >}}

### Applikation

Da nun beide Klassen ihre Interfaces implementieren, kann die Kaffeeapplikation nach dem Dependency Injection
Prinzip erstellt werden. Die Applikation muss jetzt nicht mehr selber verwalten, welche Kaffeemaschine sie
benötigt, sondern kann einfach die Interfaces, welche sie benötigt über ihren Konstruktor anfordern.
Wodurch die richtige Kaffeemaschine bei der Erstellung der Kaffeeapplikation injiziert werden kann.

{{< tabs tabTotal="1" >}}
{{< tab tabName="CoffeeApp.java" >}}
{{< prism lang="java" line-numbers="true" >}}
public class CoffeeApp {
  private CoffeeMachine coffeeMachine;

  public CoffeeApp(CoffeeMachine coffeeMachine) {
    this.coffeeMachine = coffeeMachine;
  }

  public Coffee prepareCoffee() throws CoffeeException {
    Coffee coffee = this.coffeeMachine.brewFilterCoffee();
    System.out.println("Coffee is ready");
    return coffee;
  }
}
{{< /prism >}}
{{< /tab >}}
{{< /tabs >}}

{{< tabs tabTotal="1" >}}
{{< tab tabName="CoffeeAppStarter.java" >}}
{{< prism lang="java" line-numbers="true" >}}
import java.util.HashMap;
import java.util.Map;

public class CoffeeAppStarter {
  public static void main(String[] args) {
    Map<CoffeeSelection, CoffeeBean> beans = new HashMap<CoffeeSelection, CoffeeBean>();
    beans.put(CoffeeSelection.ESPRESSO, new CoffeeBean("My favorite espresso bean", 1000));
    beans.put(CoffeeSelection.FILTER_COFFEE, new CoffeeBean("My favorite filter coffee bean", 600));

    PremiumCoffeeMachine machine = new PremiumCoffeeMachine(beans);
    CoffeeApp app = new CoffeeApp(machine);

    try {
      app.prepareCoffee();
    } catch (CoffeeException e) {
      e.printStackTrace();
    }
  }
}
{{< /prism >}}
{{< /tab >}}
{{< /tabs >}}
