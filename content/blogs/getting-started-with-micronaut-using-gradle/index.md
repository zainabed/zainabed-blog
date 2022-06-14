---
title: "Getting Started With Micronaut Using Gradle"
date: 2022-03-15T10:54:51-04:00
draft: false
authors:
  - Zainul
cover:
  image: "image/cover.jpg"
  alt: "Getting Started With Micronaut Using Gradle"
categories: 
  - "Java"
  - "Micronaut"
---


## Introduction

In this tutorial, we will create a Micronaut application using Gradle.


## What you will need

- Java installed on your machine
- Gradle installed on your machine
- Text Editor

## Steps

First create your project folder, we will make a folder called "micronaut-project" for this tutorial.

The second step is to add the build.gradle file inside the project folder.

This will contain a script to build the Micronaut application.

Now update the build.gradle file.


Add following plugin

```groovy
plugins {
    id("com.github.johnrengelman.shadow") version "7.1.1"
    id("io.micronaut.application") version "3.2.0"

}
```

This will help to build application executable jars.
     
Next, add dependencies.

```groovy
dependencies {
   annotationProcessor("io.micronaut:micronaut-http-validation")
    implementation("io.micronaut:micronaut-http-client")
    implementation("io.micronaut:micronaut-jackson-databind")
    implementation("io.micronaut:micronaut-runtime")
    implementation("jakarta.annotation:jakarta.annotation-api")
    runtimeOnly("ch.qos.logback:logback-classic")
    implementation("io.micronaut:micronaut-validation")
    implementation("io.micronaut:micronaut-http-server-netty")
}

```

To download and install these dependencies, you need to configure the repository.


```groovy
repositories {
    mavenCentral()
}
```

Include a micronaut task to configure the application's runtime and Micronaut annotations.


```groovy
micronaut {
    runtime("netty")

    processing {
        incremental(true)
        annotations("com.tutorial.project.*")
    }
}

```

> NOTE: com.tutorial.project is the project package name. Replace it with your project package name.


To enable the Micornaut application starter, add the following configuration:

```java
application {
    mainClass.set("com.tutorial.project.Application")
}
```

> NOTE: com.tutorial.project is the project package name. Replace it with your project package name. 

Now create Application class and add following code

```java
package com.tutorial.project;

import io.micronaut.runtime.Micronaut;

public class Application {
    public static void main(String[] args) {
        Micronaut.run(Application.class, args);
    }
}
```

> NOTE: location of this file should be in ```micronaut-project/src/main/java/com/tutorial/project```

 
The last step is to create a gradle.properties file and add the following configuration.

```property
micronautVersion=3.3.0
```


Now run the following command to build the application and create executable jars.

```bash
gradle build
```

It will create application jars in build/lib folder.

Use the following command to launch the application

```bash
java -jar build/libs/micronaut-project-all.jar 
```


You can access the source code of this tutorial on [Github](https://github.com/zainabed/tutorials/tree/master/gradle/getting-started-with-micronaut/micronaut-project).













