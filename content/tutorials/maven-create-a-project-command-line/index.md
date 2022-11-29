---
title: "Create Maven Project Through Command Line"
date: 2022-11-29T09:00:00-00:00
draft: false
authors:
  - Zainul

categories: 
  - "Tutorial"
  - "Maven"
  - "Java"
---


## Introduction

How often do you create a Maven project from your preferred editor? The response would be frequently or always.

But have you ever thought about what Maven command your editor used to create the project? Yes, maven projects are built solely with the maven command, exactly as "mvn clean install" is used to create a project's jar file.

This tutorial will teach you about such a command.


## Maven Command

Open your terminal and navigate to the directory in which you want to create a new Maven project. After that, run the following command.

```bash
mvn archetype:generate \
  -DgroupId=com.zainabed.project \
  -DartifactId=sample-maven-app \
  -DarchetypeArtifactId=maven-archetype-quickstart \
  -DarchetypeVersion=1.4 \
  -DinteractiveMode=false
```


> **Note**: You must have Maven installed on your workstation before running this command; otherwise, it will fail. 


The above command will create a new Maven project with an application class and its test file. The structure of the generated project will follow.


##### Directory Structure
```bash
sample-maven-app
    ├── pom.xml
    └── src
        ├── main
        │   └── java
        │       └── com
        │           └── zainabed
        │               └── project
        │                   └── App.java
        └── test
            └── java
                └── com
                    └── zainabed
                        └── project
                            └── AppTest.java

```
## Structure

Now let's have a look at each of the parameters of the above command.

| Parameter |	Description |
|-----------------------|-------------|
| archetype | Archetype is a Maven project template toolkit. Use the `mvn archetype: generate`  goal to create a project using the selected template. |
|groupId|The groupId identifies your project uniquely across all projects. |
|artifactId|It is the name of the jar without a version.|
|archetypeVersion| It is the jar version number, the typical version could be numbers and dots (1.0, 1.1, 1.0.1, ...).|
|archetypeArtifactId| It is the archetype template name, it helps Maven create the initial structure of the project.|
|interactiveMode| It allows Maven to interact with the user for input, a false value will disable it by picking up deficient values. |

## pom.xml

The following XML represents the Maven project structure.

```xml
<?xml version="1.0" encoding="UTF-8"?>

<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.zainabed.project</groupId>
  <artifactId>sample-maven-app</artifactId>
  <version>1.0-SNAPSHOT</version>

  <name>sample-maven-app</name>
  <!-- FIXME change it to the project's website -->
  <url>http://www.example.com</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>1.7</maven.compiler.source>
    <maven.compiler.target>1.7</maven.compiler.target>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>
  </dependencies>

  
</project>

```

## Start Application

Run the following command to verify the project structure and create a runable jar file. 

```bash
mvn clean install
```

Now, execute the JAR file using the following command.

```bash
java -cp target/sample-maven-app-1.0-SNAPSHOT.jar com.zainabed.project.App

Hello World!

```

> **Note**: Here `com.zainabed.project.App` is appended to the above command to help it identify the application starter class.

## Archetype List

This tutorial illustrated the use of the "maven-archetype-quickstart" archetype, however Maven is not restricted to this choice, there are several others listed below.



| Archetype ArtifactIds |	Description |
|-----------------------|-------------|
|maven-archetype-archetype|	An archetype to generate a sample archetype.|
|maven-archetype-j2ee-simple|	An archetype to generate a simplifed sample J2EE application.|
|maven-archetype-plugin|	An archetype to generate a sample Maven plugin.|
|maven-archetype-plugin-site|	An archetype to generate a sample Maven plugin site.|
|maven-archetype-portlet|	An archetype to generate a sample JSR-268 Portlet.|
|maven-archetype-quickstart|	An archetype to generate a sample Maven project.|
|maven-archetype-simple|	An archetype to generate a simple Maven project.|
|maven-archetype-site|	An archetype to generate a sample Maven site which demonstrates some of the supported document types like APT, Markdown, XDoc, and FML and demonstrates how to i18n your site.|
|maven-archetype-site-simple|	An archetype to generate a sample Maven site.|
|maven-archetype-site-skin|	An archetype to generate a sample Maven Site Skin.|
|maven-archetype-webapp|	An archetype to generate a sample Maven Webapp project.|

## Conclusion

I expect this tutorial has helped you better grasp the Maven command for creating a project. This tutorial's source code is accessible on [Github](https://github.com/zainabed/tutorials/tree/master/maven/getting-started/sample-maven-app).