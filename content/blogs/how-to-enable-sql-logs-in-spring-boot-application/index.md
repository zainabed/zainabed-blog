---
title: "How to Enable Sql Logs in Spring Boot Application"
date: 2022-04-08T10:49:12-04:00
draft: false
authors:
  - Zainul
cover:
  image: "image/cover.jpg"
  alt: "How to Enable Sql Logs in Spring Boot Application"
categories: 
  - "Spring Boot"
  - "Java"
---

## Introduction

This tutorial will demonstrate how to enable and disable SQL log statements in a Spring Boot application in order to debug SQL flow.



## Problem

You will frequently need to debug the SQL statement while developing a Spring Boot application with a SQL database.

SQL debug logs can assist you figure out what's wrong with JPA statements and whether or not there's a problem with database connectivity.

## Example 

If you've built custom Spring data JPA methods and need to know what SQL statement is being utilized behind them,

```java
return repository.findByUsernameIn(usernames);
```

Then you can enable Hibernet debug mode to log SQL statements.

## Solution

Update the application.yml file with the Hibernet configuration as

```yml
logging:
  level:
    org:
      hibernate: DEBUG
```

or application.properties as

```property
logging.level.org.hibernate=DEBUG
```


The SQL statement will appear in the application logs after modifying the configuration file and restarting the application.

```bash
2022-04-07 08:41:45.118 DEBUG 14561 --- [nio-8080-exec-1] org.hibernate.SQL                        : 
select user0_.id as id1_0_, user0_.password as password2_0_, user0_.username as username3_0_ from user user0_ where user0_.username in (?)
```

## Spring Boot Profiles

This setup is great for debugging and testing your application while you are building or improving its features, but it's not appropriate for staging or production situations.

To turn off the debugging logs in the production environment, you should prefer to use Spring boot profiles.

- application.properties :            Local machine
- application-dev.properties:      Development environment.
- application-stage.properties:   Stage/Test environment
- application-prod.properties:    Production environment 

Inside **application-prod.properties**, specifically turn off SQL debug logs, like

```property
logging.level.org.hibernate=OFF
```
> Note: It is not a rule to name your application properties file as mentioned in this tutorial. You are free to give it whatever name you like.


## Conclusion

SQL debugging can be activated or deactivated by application configuration. The production environment should explicitly disable this configuration.

You can access tutorial code from [Github](https://github.com/zainabed/tutorials/tree/master/spring-boot/sql-logging) page.