---
title: "Easy Steps To Create Log4j2 Rolling File For Spring Boot"
date: 2022-11-20T01:50:08-05:00
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
Spring Boot applications can save informative messages or application errors to a file. This functionality allows you to monitor the application's health and take necessary action when problems arise.

Logging all of this information to a single file, on the other hand, will cause the file to expand in size, which would be a nightmare if the file size rose to MB or GB and you wanted to trace a specific exception throughout the whole log file.

Therefore, each logging library provides a feature to distribute application logs into an n-number of files.
And in this tutorial, we'll look into a `Log4j2` functionality like that.

This feauture is names as `RollingFile Appender` in Log4j2.
## RollingFile Configuration

Log4j2's `RollingFile` appender setting allows you to separate logs based on date and time, size, or both rules.

To begin with the initial setup of log4j, please see the [Two Steps To Add Log4j2 To Spring Boot Application](https://www.zainabed.com/tutorials/spring-boot-log4j2-setup/) tutorial.

Now, to apply the RollingFile configuration, modify the `log4j2.xml` file.

##### src/main/resources/log4j2-rolling-file.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="ERROR">
    <Properties>
        <Property name="LOG_PATTERN">%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"</Property>
        <Property name="LOG_DIR">logs</Property>
        <Property name="LOG_FILE_NAME">logging</Property>
    </Properties>
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"/>
        </Console>
        <RollingFile name="dailyFileLog"
                     fileName="${LOG_DIR}/${LOG_FILE_NAME}.log"
                     filePattern="${LOG_DIR}/${LOG_FILE_NAME}-%d{dd-MM-yyyy}.log">
            <Policies>
                <TimeBasedTriggeringPolicy/>
            </Policies>
        </RollingFile>
    </Appenders>
    <Loggers>
        <Logger name="com.zainabed" level="INFO">
            <AppenderRef ref="dailyFileLog"/>
        </Logger>
        <Root level="INFO">
            <AppenderRef ref="Console"/>
        </Root>
    </Loggers>
</Configuration>
```

The "RollingFile" setup will be in charge of breaking logs into different log files.
It has the following characteristics:

* **name**: the name of the RollingFile configuration to be used in the Logger tag.
* **fileName**: path to the system log file.
* **filePattern**: pattern for creating rolling log files.

The policy for splitting files is defined in the preceding code snippet. Here, the policy indicates that logs should be distributed based on a time-based policy.

```xml
<Policies>
    <TimeBasedTriggeringPolicy/>
</Policies>
```

> **Note**: Log4j2 creates files based on `filePattern`, and you can find previous days' logs according to those patterns.

## Result

You can put everything together and run application.

```bash
$ ls logs/

logging.log

```

And if you run the same application the next day, old logs are archived and saved in a file that conforms to the pattern specified in the RollingFile setting.

```bash
$ ls logs/
logging-08-11-2022.log  logging.log

```
`logging-08-11-2022.log` contains logs of 8/11/2022 and `logging.log` will contain current days log.

## YAML configuration

The same configurations can be established using an application. yml file as,

##### src/main/resources/log4j2-rolling-file.yml
```yaml
Configutation:
  status: warn

  Properties:
    Property:
    - name: LOG_DIR
      value: logs
    - name: LOG_FILE_NAME
      value: logging
  Appenders:
    Console:
      name: CONSOLE
      target: SYSTEM_OUT
      PatternLayout:
        Pattern: "%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"
    RollingFile:
      - name: APPLICATION
        fileName: "${LOG_DIR}/${LOG_FILE_NAME}.log"
        filePattern: "${LOG_DIR}/${LOG_FILE_NAME}-%d{dd-MM-yyyy}.log"
        PatternLayout:
          Pattern: "%d{HH:mm:ss.SSS} [%t] %-5level %logger{36} - %msg%n"
        policies:
          TimeBasedTriggeringPolicy:
            interval: 1
            modulate: true

  Loggers:
    Root:
      level: info
      AppenderRef:
        - ref: CONSOLE
        - ref: APPLICATION
    Logger:
      - name: com.zainabed
        additivity: false
        level: info
        AppenderRef:
          - ref: CONSOLE
          - ref: APPLICATION
      - name: com.myco.myapp.Bar
        additivity: false
        level: debug
        AppenderRef:
          - ref: CONSOLE
          - ref: APPLICATION
```

## Conclusion

Congratulation! You've learned about Log4j2's RollingFile appender, and as always, the source code for this tutorial can be found on [Github](https://github.com/zainabed/tutorials/tree/master/maven/demo-log4j2).