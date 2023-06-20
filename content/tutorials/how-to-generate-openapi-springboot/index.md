---
title: "Create OpenAPI Specification In Existing SpringBoot Project"
date: 2023-06-19T06:52:38-04:00
draft: true
authors:
  - Zainul
categories: 
  - "Tutorial"
  
---

## Introduction
The `OpenAPI` specification is used to design the REST API structure, it is an agreement that clients use to call those REST API services.

As per industry standard, we design the OpenAPI specification first, then utilise it in applications to generate REST API services. This phase is not helpful for ongoing projects if a `REST API` has already been developed because it is a new practise.

We need a clever solution to automatically build OpenAPI specifications for these kinds of projects so that their clients can utilise the specifications to create client applications or conduct testing.

In this tutorial we will be talking about such library.

For this tutorial I am using existing Spring Boot project present at [Github]() location.



## OpenAPI plugin
Here we are using the `springdoc-openapi-ui` library of the official Spring Boot to generate specifications.

First, we need to add the following plugin to the application's `pom.xml` file:

##### pom.xml
```xml
<dependency>
  <groupId>org.springdoc</groupId>
  <artifactId>springdoc-openapi-ui</artifactId>
  <version>1.7.0</version>
</dependency>
```

This existing application has a single REST controller

```java
@RestController
public class UserController {

    private final UserService userService;

    public UserController(final UserService userService) {
        this.userService = userService;
    }

    @PostMapping(path = "/user", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<User> createUser(@RequestBody User user) {
        final User savedUser = userService.save(user);
        return ResponseEntity.ok(savedUser);
    }
}

```

Now, to generate OpenAPI specifications for the above REST controller, we just need to build the application.
The OpenAPI plugin will generate the necessary artifacts in the target folder location.

The plugin will generate the OpenAPI specification at the http://server:port/context-path/v3/api-docs URI.

For this project it will be `http://localhost:8080/v3/api-docs.yaml` 

##### api-docs.yaml
```yaml
openapi: 3.0.1
info:
  title: OpenAPI definition
  version: v0
servers:
- url: http://localhost:8080
  description: Generated server url
paths:
  /user:
    post:
      tags:
      - user-controller
      operationId: createUser
      requestBody:
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/User'
        required: true
      responses:
        "200":
          description: OK
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
components:
  schemas:
    User:
      type: object
      properties:
        uuid:
          type: string
          format: uuid
        name:
          type: string
        address:
          type: string
```

  ***NOTE**: If you have explicitly defined the project context path, then mention it above the URL, by default, the context path is empty.* 

Plugin also generates following URLs
* http://server:port/context-path/swagger-ui.html  Swagger UI
* http://server:port/context-path/v3/api-docs JSON specification



