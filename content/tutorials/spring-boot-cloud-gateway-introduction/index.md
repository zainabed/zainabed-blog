---
title: "First Step Toward Spring Boot Cloud Gateway "
date: 2022-11-07T10:39:48-05:00
draft: false
authors:
  - Zainul
categories: 
  - "Tutorial"
  
---


## Introduction

This tutorial is a short introduction to **Spring Cloud Gateway**. 

By following the quick and easy steps provided below, you will be able to start the REST API gateway project.


## Prerequisite

* Java
* Maven
* Spring Boot

Download the Spring Boot project from [Spring Initializr](https://start.spring.io/) and select `Gateway ` as dependency.

Now generate and download the project and use your favourite editor to import it.

## Gateway Configuration

You can use a **YAML** file or **Java** code to configure routes. Either way, you will see both of these approaches in this tutorial.

### YAML configuration
Edit `application.yml` and add following snippet

```yaml
spring:
  cloud:
    gateway:
      routes:
        - id: user-service
          uri: http://localhost:3000

```

> **Note** : The Spring Boot Gateway is a bridge between clients and your application server. Therefore, clients will interact with Gateway instead of your application server.
In this tutorial, your server is running at `http://localhost:3000`.


For this tutorial, we are using **mock-server** which is running on port 3000. You can run the Spring Boot application on its default 8080 port.

Check out [How To Use json-server To Build Mock REST API Server](https://www.zainabed.com/tutorials/create-mock-server-using-json-server/) tutorial.

Now that Gateway and the mock-server are up and running, we can `Curl` to test the end-to-end flow.

Run the following curl command to verify the mock-server is functioning well.

```bash
curl --location --request GET 'http://localhost:3000/user'
```
the result should be something like this,

```bash
[
  {
    "id": 1,
    "name": "Jonathan",
    "address": "USA"
  }
]
```

Now we will execute the same Curl command, but instead of port `3000` we will use `8080` (Gateway application).

And we expect the result should be the same as Gateway is the bridge for the backend server (the mock-server in this tutorial).


```bash
curl --location --request GET 'http://localhost:8080/user'
```

and response must be


```bash
[
  {
    "id": 1,
    "name": "Jonathan",
    "address": "USA"
  }
]
```
### Bean Configuration

Create a bean to configure the routes for the mock user service.

##### RouteConfiguration.java
```java
@Configuration
public class RouteConfiguration {

    @Bean
    public RouteLocator userServiceRoutes(RouteLocatorBuilder builder) {
        return builder.routes()
                .route(config -> config.path("/user")
                        .uri("http://localhost:3000")
                ).build();
    }
}

```
Here, `userServiceRoutes` method creates `RouteLocator` bean, and this bean will configure the routes inside Spring Boot Gateway.

Using a lambda expression, we setup the uri as `http://localhost:3000`, the endpoint to mock-server and the path as `/user` the user service path of mock-server.

> **Note**: To work with Spring Beans, we first need to turn off the `application.yml` configurations by commenting on them.

Now run the application and test the end-to-end flow.

```bash
curl --location --request GET 'http://localhost:8080/user'
```

and response should be


```bash
[
  {
    "id": 1,
    "name": "Jonathan",
    "address": "USA"
  }
]
```
## Conclusion

Congratulations! You have just finished developing your first Spring Cloud Gateway application. As is customary, you can obtain the source code for this tutorial on [Github](https://github.com/zainabed/tutorials/tree/master/maven/gateway).