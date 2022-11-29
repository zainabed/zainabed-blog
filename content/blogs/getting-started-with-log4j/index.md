---
title: "Getting Started With Log4j"
date: 2022-05-30T09:30:34-04:00
authors: 
- Zainul
draft: false
cover:
  image: "image/cover.webp"
  alt: "Getting Started With Log4j"
categories: 
  - "Java"
---

## Introduction
For Java applications, ``Log4j`` is a commonly used and trusted logging tool.
When an application is deployed to an application server, logging is a must-have feature.

In this tutorial, we'll see how to set up Log4j for a simple Java application.

You can find all code related to this tutorial inside [GitHub](https://github.com/zainabed/tutorials/tree/master/maven/log4j-maven) project.



## Why do we need Logging
Logging is an important part of the application since it records user actions, input requests and output responses, error messages, and more.

This information aids in the understanding of the application both inside and outside of it, as well as providing faster feedback or support for any issues that may occur during the application's execution.



## Maven configuration
Add following dependencies into pom.xml

```xml
<dependencies>
    <dependency>
        <groupId>org.apache.logging.log4j</groupId>
        <artifactId>log4j-api</artifactId>
        <version>2.17.2</version>
    </dependency>
    <dependency>
        <groupId>org.apache.logging.log4j</groupId>
        <artifactId>log4j-core</artifactId>
        <version>2.17.2</version>
    </dependency>
</dependencies>
```

> **Note** : Choose the latest version of Log4J to guard against any unwanted vulnerabilities. 



## Sample code
Now lets add few log message and see the result.

```java
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class MainApp {

    public static void main(String[] args) {
        Logger logger = LogManager.getLogger();
        printLoggingLevels(logger);
    }

    private static void printLoggingLevels(Logger logger) {
        logger.trace("logging trace level");
        logger.debug("logging debug level");
        logger.info("logging info level");
        logger.warn("logging warn level");
        logger.error("logging error level");
        logger.fatal("logging fatal level");
    }
}
```

## Logging levels
All of the logging levels available in the Log4j package are demonstrated in the code sample above.

Let's look at what each level does.

- Trace : A fine-grained message that records all traces of the application's flow.
- Debug : Messages used to debug an application's behaviour during development.
- Info : Common application flow message.
- Warn : An event that may result in an error.
- Error : An exception occurred within the application, which may be recovered.
- Fatal : An application encounters an error that cannot be recovered from.


When we execute the application, Log4J starts logging into the console.

```bash
02:34:02.491 [main] ERROR com.zainabed.tutorials.logging.MainApp - logging error level
02:34:02.504 [main] FATAL com.zainabed.tutorials.logging.MainApp - logging fatal level
```

As we can see it logs only ``Error`` & ``Fatal`` level messages only.
This happens because of Logging level filtering.


## Logging level filter
Log4j has the following filter mechanism.

**All <  Trace < Debug < Info < Warn < Error < Fatal**

If the logging level is set to be info, then only info, warning, error, and fatal messages will be logged into the console.

When the logging level is set to "Error" both the Error and Fatal messages are displayed.

The default logging level is ``Error`` for applications. That is why we see only Error and Fatal log messages.

To override the default behavior, we need to add the Log4j2.xml configuration file and provide an appropriate logging level to log relevant messages.


## Conclusion

Every application requires a logging method to record the flow and behaviour of the application.
Log4j is a widely adopted tool to provide such a facility.

Log4j is extremely configurable, and application-specific parameters are set via ``Log4j2.xml``.


