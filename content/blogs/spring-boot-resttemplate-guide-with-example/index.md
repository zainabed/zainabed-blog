---
title: "Spring Boot Resttemplate Guide With Example"
date: 2022-04-22T09:42:03-04:00
draft: false
authors:
  - Zainul
cover:
  image: "image/cover.jpg"
  alt: "Spring Boot Resttemplate Guide With Example"
categories: 
  - "Java"
  - "Spring Boot"
---

## What is RestTemplet?

RestTemplate is a HTTP Client library that provides basic APIs for executing different HTTP type requests.

RestTemplate is one of the HTTP libraries available on the market.

The Spring Boot team designed and maintains it.

As previously said, it is a client library, which means it may be utilised in our application as a stand-alone dependency. To utilise it, you don't require a complete Spring boot application.

It's suitable for use in simple Java applications as well as other frameworks such as Micronaut, Play and others.



## Setup

Add RestTemplate dependency to project, for this tutorial I am creating a simple java application to consume HTTP request and a node application to provide HTTP service.

## For Gradle build tool

Add the following dependency in the build.gradle file.

```groovy
// https://mvnrepository.com/artifact/org.springframework.boot/spring-boot-starter-web
implementation group: 'org.springframework.boot', name: 'spring-boot-starter-web', version: '2.6.3'
```

This will provide classes to create instance of RestTemplate.

```java
RestTemplate restTemplate = new RestTemplate();
```

## REST APIs

Node.js has a useful library that converts a json file to a RESTful service.

Install the npm library as

```bash
npm install json-server --save-dev
```


Now define the JSON structure for the HTTP service.

create db.json file and add following snippet

```json
{
  "projects": [
    {
      "id" :  1, 
      "name" :  "RestTemplate", 
      "description" :  "Project to demonstrate workflow of RestTemplate"
    }]
}
```

Now, run server as

```bash
node_modules/.bin/json-server db.json 
```

> Note:  Use following command to find location of  node_module executable
npm bin 


## Model

Define any POJO class which is use to exchange the request and response.


```java
public class ProjectModel {
    private Integer id;
    private String name;
    private String description;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "{id: " + id + ", name: " + name + ", description: " + description + "}";
    }
}
```


## HTTP Get Request

Use following snippet to get single records.


```java
// Instantiate RestTemplate
RestTemplate restTemplate = new RestTemplate();

String apiEndpoint = "http://localhost:3000/projects";

// HTTP GET single record
ResponseEntity<ProjectModel> entity = restTemplate.getForEntity(apiEndpoint + "/1", ProjectModel.class);
ProjectModel record = entity.getBody();
System.out.println("Fetch single records");
System.out.println(record);
```

First we defined restTemplate instance and endpoint to establish HTTP communication.
getForEntity method will fetch the resource and convert it into an appropriate Java class. Here, it is a ProjectModel class.


Use following snippet to fetch all records.

```java
// HTTP GET all records
System.out.println("Fetch all records");
ResponseEntity<List> records = restTemplate.getForEntity(apiEndpoint, List.class);
records.getBody().forEach(System.out::println);
```

This will create a list of Java objects. One thing to notice here is that the result is a list of Java objects.
It is necessary to iterate the list and cast each object in order to convert it into a project model.

The Spring framework provides a handy technique to cast a list of objects to avoid this complexity.

```java
// HTTP GET all with casting of entity
ParameterizedTypeReference<List<ProjectModel>> typeReference = new ParameterizedTypeReference<List<ProjectModel>>() {
};

ResponseEntity<List<ProjectModel>> responseEntity = restTemplate.exchange(apiEndpoint, HttpMethod.GET, null, typeReference);
List<ProjectModel> projectModels = responseEntity.getBody();

projectModels.forEach(System.out::println);
```

## HTTP POST Request

```java
 //HTTP POST Request
ProjectModel projectModel = new ProjectModel();
projectModel.setName("Blogger App");
projectModel.setDescription("Blog application to publish blogpost");

ResponseEntity<ProjectModel> response = restTemplate.postForEntity(apiEndpoint, projectModel, ProjectModel.class);
System.out.println(response.getBody());
```


The postForEntity function takes three arguments, API endpoint, the other payload and its class type.

Here we have not set the id of the ProjectModel. It should be created by the server and you should get it from the response object.



## HTTP PUT Request

```java
 //HTTP PUT request
projectModel = response.getBody();
projectModel.setName("Blog post app");
HttpHeaders httpHeaders = new HttpHeaders();
httpHeaders.setContentType(MediaType.APPLICATION_JSON);
httpHeaders.setAccept(Arrays.asList(MediaType.APPLICATION_JSON));
HttpEntity<ProjectModel> requestEntity = new HttpEntity<ProjectModel>(projectModel, httpHeaders);
response = restTemplate.exchange(apiEndpoint + "/" + projectModel.getId(), HttpMethod.PUT, requestEntity, ProjectModel.class);

System.out.println("PUT response");
System.out.println(response.getBody()); 

```

The above example shows another way to communicate with an API server.

The exchange method requires HttpEntity to pass request information to the server, and it also includes HTTP header information. 

## HTTP Delete Request

```java
// HTTP Delete request
restTemplate.delete(apiEndpoint + "/" + projectModel.getId());
```

There is no return type for this method, and even if you use the exchange method to perform an HTTP DELETE, you will get an empty response object.

## Conclusion

We went over the basic HTTP Verbs in this post and used RestTemplate to compose requests using all of them.

All of these examples and code snippets were implemented and can be found on [GitHub](https://github.com/zainabed/tutorials/tree/master/spring-boot/rest-template) .

