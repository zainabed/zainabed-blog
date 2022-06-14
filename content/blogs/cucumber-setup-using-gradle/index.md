---
title: "Cucumber Setup Using Gradle"
date: 2022-04-05T09:56:50-04:00
draft: false
authors:
- Zainul
cover:
  image: "image/cover.jpg"
  alt: "Cucumber Setup Using Gradle"
categories: 
  - "Cucumber"
  - "Java"
  - "Gradle"
---


## Introduction

This tutorial will help you configure Cucumber into a Java project using the Gradle build tool.


Cucumber is a test automation tool that supports Behavior-Driven Development (BDD). It is written in plain English text called "Gherkin." Cucumber enables you to write test cases that anyone can easily understand, regardless of their technical knowledge.

## Setup
First, create a Gradle project using the gradle init command.

```bash
gradle init
```

Complete the Gradle wizard to create a project.


Now update the gradle.build file to add the Gradle Cucumber dependency.

```groovy
testImplementation 'io.cucumber:cucumber-java8:7.0.0'
```

This will add Cucumber implementation to your project.



## Task Configuration
Add the following configuration to gradle.build
This will enable the Cucumber runtime to execute BDD test cases.

```groovy
configurations {
    cucumberRuntime {
        extendsFrom testImplementation
    }
}
```

Create a new custom task to execute Cucumber 

```groovy
task cucumber() {
    dependsOn assemble, testClasses
    doLast {
        javaexec {
            main = "io.cucumber.core.cli.Main"
            classpath = configurations.cucumberRuntime + sourceSets.main.output + sourceSets.test.output
            args = [
                    '--plugin', 'pretty',
                    '--plugin', 'html:target/cucumber-report.html',
                    '--glue', 'com.zainabed.cucumber.bdd',
                    'src/test/resources']
        }
    }
}
```
> NOTE: com.zainabed.cucumber.bdd is reference to a package name, You should put in your project package name..

Cucumber Options/Args

- glue:    Project package name where you define the glue code.
- plugin:    Plugins which you want to add in the project.
- pretty:    Generate a pretty report
- html:    Generate Cucumber HTML report.
- src/test/resources:     Location of feature files.

## Feature File
Cucumber interprets the Gherkins feature file and executes the glue code associated with it.
Therefore, create a features folder inside the test resources section src/test/resources/ and add the Gherkin feature which gets executed by cucumber.

```gherkin
Feature: User Registration
  User will initiate registration request to system and
  system will validate the information and add user to system

  Scenario: Basic Flow
    Given User visit registration
    When User enter his registration details
    Then System validate the information
    And User get registered
```

## Run the Task
Next, run the following command to execute Cucumber test cases.

```bash
./gradlew cucumber
```

It will fail and give you the glue code that you need to add to your project like this.

```bash
Task :app:cucumber FAILED

Scenario: Basic Flow                       # src/test/resources/features/user-registration.feature:5
  Given User visit registration
  When User enter his registration details
  Then System validate the information
  And User get registered

Undefined scenarios:
You can implement missing steps with the snippets below:

Given("User visit registration", () -> {
    // Write code here that turns the phrase above into concrete actions
    throw new io.cucumber.java8.PendingException();
});
When("User enter his registration details", () -> {
    // Write code here that turns the phrase above into concrete actions
    throw new io.cucumber.java8.PendingException();
});
Then("System validate the information", () -> {
    // Write code here that turns the phrase above into concrete actions
    throw new io.cucumber.java8.PendingException();
});
Then("User get registered", () -> {
    // Write code here that turns the phrase above into concrete actions
    throw new io.cucumber.java8.PendingException();
});
```

## Glue Code
In order to fix the cucumber task error, we need to provide glue code, which is nothing but a Java class.

Create a new Java file named UserRegistrationBDD.java inside bdd package and add the above code into it.

```java
package com.zainabed.cucumber.bdd;

import io.cucumber.java8.En;

public class UserRegistrationBDD implements En {

    public UserRegistrationBDD() {

        Given("User visit registration", () -> {
            // Write code here that turns the phrase above into concrete actions
            throw new io.cucumber.java8.PendingException();
        });

        When("User enter his registration details", () -> {
            // Write code here that turns the phrase above into concrete actions
            throw new io.cucumber.java8.PendingException();
        });

        Then("System validate the information", () -> {
            // Write code here that turns the phrase above into concrete actions
            throw new io.cucumber.java8.PendingException();
        });

        Then("User get registered", () -> {
            // Write code here that turns the phrase above into concrete actions
            throw new io.cucumber.java8.PendingException();
        });
    }

}
```

Add some business logic to it, then rerun it.

> Note: Cucumber Java 8 dependency uses constructor and English "En" interface to implement glue code.

Add your business logic and assertions to execute features. 



## Re-Run the Cucumber Task
At the end, execute the cucumber tasks.


```bash
Task :app:cucumber
Scenario: Basic Flow                       # src/test/resources/features/user-registration.feature:5
  Given User visit registration            # com.zainabed.cucumber.bdd.UserRegistrationBDD.<init>(UserRegistrationBDD.java:9)
  When User enter his registration details # com.zainabed.cucumber.bdd.UserRegistrationBDD.<init>(UserRegistrationBDD.java:13)
  Then System validate the information     # com.zainabed.cucumber.bdd.UserRegistrationBDD.<init>(UserRegistrationBDD.java:17)
  And User get registered                  # com.zainabed.cucumber.bdd.UserRegistrationBDD.<init>(UserRegistrationBDD.java:21)
1 Scenarios (1 passed)
4 Steps (4 passed)
```

## Conclusion 
This tutorial demonstrated the setup and configuration of the Cucumber test framework using the Gradle build tool.

Full source can be found on the Github page.