---
title: "Two Steps To Add Log4j2 To Spring Boot Application"
date: 2022-11-17T02:10:33-05:00
draft: false
authors:
  - Zainul
categories: 
  - "Tutorial"
  - "Spring Boot"
  - "Log4j2"
  - "Java"
---

## Introduction
`Log4j2` is a comprehensive and modern framework for logging messages in applications.

And Spring Boot, which is widely used in industry, provides excellent support for Log4j2. 

In this tutorial, we will look at how to configure it using an `XML` and `YAML` file.

## Setup

Download the Spring Boot application from [Spring Boot Starter](https://start.spring.io/) and extract the zip file.


## POM Configuration

Add log4j2 as a dependency to the `pom.xml` file. 

##### pom.xml

```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-log4j2</artifactId>
</dependency>
```
> **Note**: Because Spring Boot Web includes `Logback` as a default logging dependency, we must remove it from the classpath to avoid a collision with `Log4j2`.

Remove default Logback logging by updating pom.xml as follows

##### pom.xml
```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-web</artifactId>
  <exclusions>
    <exclusion>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-logging</artifactId>
    </exclusion>
  </exclusions>
</dependency>
```

## Gradle Configuration

For the Gradle project, add the following dependencies to enable log4j2.

```groovy
dependencies {
  ---
  implementation 'org.springframework.boot:spring-boot-starter-log4j2:2.6.13'
  ---
}
```

## XML Log4j2 File
To enable console logging, create a log4j2.xml file in the application resources folder and add the following configuration.

##### src/main/resources/log4j2.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="ERROR">
    <Properties>
        <Property name="LOG_PATTERN">%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"</Property>
    </Properties>
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="${LOG_PATTERN}"/>
        </Console>
    </Appenders>
    <Loggers>
        <Root level="INFO">
            <AppenderRef ref="Console"/>
        </Root>
    </Loggers>
</Configuration>
```
This adequate configuration will log INFO messages into `Console`.


Now, add some **INFO** logs to application as,

##### DemoLog4j2Application.java
```java
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoLog4j2Application {
    private static final Logger LOGGER = LogManager.getLogger(DemoLog4j2Application.class);
    public static void main(String[] args) {
        LOGGER.info("Application starts");
        SpringApplication.run(DemoLog4j2Application.class, args);
        LOGGER.info("Application ends");
    }
}
```

When you run the application, the log messages will display in the configure logs pattern.

##### Terminal
```bash
04:37:04.009 [main] INFO  com.zainabed.tutorial.demolog4j2.DemoLog4j2Application - Application starts
.....
.....
.....
04:37:07.430 [main] INFO  com.zainabed.tutorial.demolog4j2.DemoLog4j2Application - Started DemoLog4j2Application in 3.278 seconds (JVM running for 4.868)
04:37:07.434 [main] INFO  com.zainabed.tutorial.demolog4j2.DemoLog4j2Application - Application ends
```
## YAML Log4j2 File
A YAML file can also be used to configure log4j2.
We can achieve this goal with minimal effort by using following configuration.

##### log4j2.yml
```yaml
Configutation:
  status: warn

  Properties:
    Property:
    - name: Pattern
      value: '%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n'

  Appenders:
    Console:
      name: CONSOLE
      target: SYSTEM_OUT
      PatternLayout:
        Pattern: "${Pattern}"

  Loggers:
    Root:
      level: info
      AppenderRef:
        - ref: CONSOLE
        - ref: APPLICATION

```

Keep in mind that the `log4j2.xml` file is Spring Boot's default logging configuration, just specifying a YAML file will not help you select it.

To force the application to use YAML configuration, we must make two changes.

First add following dependency 

#### pom.xml
```xml
<dependency>
  <groupId>com.fasterxml.jackson.dataformat</groupId>
  <artifactId>jackson-dataformat-yaml</artifactId>
  <version>2.6.0-rc4</version>
</dependency>
```
It will help the application translate the YAML configuration.


And for Gradle project update following file

#### build.gradle

```groovy
dependencies {
  ---
  ---
  implementation 'com.fasterxml.jackson.dataformat:jackson-dataformat-yaml:2.6.0-rc4'
}
```

The second step is to include a reference to YAML in the application property file.

#### application.properties
```property
logging.config=src/main/resources/log4j2.yml
```
## Conclusion

This post taught you how to enable Lo4j2 logging in your Spring Boot application using various configuration approaches.

You can find the source code for this tutorial at the [Github](https://github.com/zainabed/tutorials/tree/master/maven/demo-log4j2) project.

