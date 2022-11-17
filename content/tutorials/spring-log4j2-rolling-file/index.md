---
title: "Spring Log4j2 Rolling File"
date: 2022-11-16T01:50:08-05:00
draft: true
authors:
  - Zainul

categories: 
  - "Tutorial"
  
---

## Introduction
Your Spring Boot application can log information or errors into a file which is very convenient for develpoment or testing.

But if you apply same strategy for production enviorment then single log file will grow over the time and it is hard to manage it.

Therefore each logging libarary provide feature to distribute application logs into n-number of files.
And in this tutorial we will check about such feature of `log4j2` libaray.

## RollingFile Configuration

`RollingFile` configuration of `log4j2` allow you to split the logs based on date & time , size of or both policies.

Please checkout [Setup log4j in Spring Boot application]() tutorial to start with initial setup from log4j.

Now editor `log4j2.xml` file to apply RollingFile configuration


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

Here `<RollingFile \>` configuration will responsible for spliting logs into files.
It has following properties

* **name** : name of RollingFile configuration which will be used in Logger tag
* **fileName**:  log file location in system
* **filePattern**: patternt in which rolling log files is created

```xml
<Policies>
    <TimeBasedTriggeringPolicy/>
</Policies>
```
Above code snippet is define the policy to split file, here policy says logs should be distributed according to time based policy and default acrhives old logs according to previous day.

## Result

When we run application first time the log file is created as 

```bash
$ ls logs/

logging.log

```

And if you run same application next day then old logs get archived and stored in file which follows the pattern define in RollingFile configuration

```bash
$ ls logs/
logging-08-11-2022.log  logging.log

```
`logging-08-11-2022.log` contains logs of 8/11/2022 and logging.log will contain current day logs.

## YAML configuration

Same configurations can be established using application.yml file as,

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
