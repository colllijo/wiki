---
weight: 120
title: "Dependency Injection"
description: "Short documentation of the Dependency Injection design pattern, including a simple example."
icon: "article"
date: "2024-06-14T16:56:21+02:00"
lastmod: "2024-06-14T16:56:21+02:00"
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
## Introduction

With dependency injection, a class no longer has to manage its dependencies
itself, as they are automatically provided. This is intended to make it easier
to change dependencies, as they will have fewer adjustments to their
dependencies, and ideally no adjustments at all.

Using dependency injection, the dependency can be injected a three points in a
class. It is possible to introduce the dependency when constructing the client,
where the dependency is introduced in the constructor. A second possibility is
to introduce the dependency using a setter method, which is called after the
constructor. The last possibility is to introduce the dependency directly in
the field, so that neither a constructor nor a specific setter method is needed.

Dependency injection is an extension of the Dependency Inversion under the
[SOLID principle](/docs/design-patterns/solid), which brings the dependency
from bottom to top.

## Roles

To implement dependency injection four roles are needed.
These will be explained in the following sections.

### Service

The service is the part of the application that should be used elsewhere, as it
implements part of the required business logic. To keep the application as
modular as possible and in line with the Dependency Inversion Principle, a
service is never used directly in a client. Instead, a service implements an
interface that can be used by clients.

### Client

The client refers to the part of the application that should consume and use a
service. The dependency should be "injected" here. This allows the client to
easily use the functionalities of the interface implemented by the service
without having to worry about which implementation it is using.

### Interface

The interface is the abstraction between client and service. It defines an
contract that tells a client which methods are available on a service and makes
it clear to a service which methods need to be implemented.

### Injector

The task of the injector is to "inject" the respective services into
the clients using the different interfaces, so that they can use them. In comparison
to the Dependency Inversion, the injector is the only new role that was not
needed before.

{{< rawhtml >}}
  </div>
  <div>
{{< /rawhtml >}}

## Sources

[Wikipedia - Prinzipien objektorientierten Designs](https://de.wikipedia.org/wiki/Prinzipien_objektorientierten_Designs)  
[Wikipedia - Contexts and Dependency Injection](https://de.wikipedia.org/wiki/Contexts_and_Dependency_Injection)  
[Stackify - Dependency Injection](https://stackify.com/dependency-injection/)  
[Stackify - Dependency Inversion Principle](https://stackify.com/dependency-inversion-principle/)  

## CDI

Contexts and Dependency Injection (CDI) is a Java standard that extends the
principle of dependency injection. CDI allows the dependencies of the
different modules to be automatically injected, eliminating the need to
manually pass the required dependencies. CDI decides based on different
contexts and a configuration which dependency is needed where.

{{< rawhtml >}}
  </div>
</div>
{{< /rawhtml >}}

## Example

To illustrate this principle, here is a small example in Java.
Here we want to create an application that can be used to brew coffee
with different coffee machines.

### Starting Point

For the starters there are two coffee machines, the `BasicCoffeeMachine`
Both machines have a method to brew coffee, but the `PremiumCoffeeMachine` can
also brew espresso next to the filter coffee.

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

### Abstraction

The first step to Dependency Injection is the abstraction of the public methods.
To do this, an interface for the coffee machine must be created. Since not every
Coffee machine can brew espresso there are two interfaces here, a basic one for all
Coffee machines, which can brew filter coffee and a second one for the premium coffee machine,
which can also brew espresso. The `BasicCoffeeMachine` can then implement the simple interface
and the `PremiumCoffeeMachine` implements both.

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

### Application

Now that both classes implement their interfaces, the coffee application can be created using the
Dependency Injection principle. The application no longer has to manage which coffee machine it needs,
but can simply request the interfaces it needs via its constructor.
This allows the correct coffee machine to be injected when creating the coffee application.

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
