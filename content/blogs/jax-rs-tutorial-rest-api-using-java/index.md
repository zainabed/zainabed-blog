---
title: "Jax Rs Tutorial Rest Api Using Java"
date: 2014-07-24T05:25:34-04:00
draft: false
authors:
- Zainul
cover: 
  image: "image/cover.png"
  alt: "Jax Rs Tutorial Rest Api Using Java"
categories: 
  - "Java"
  - "Jax-Rs"
---

## Introdcution

JAX-RS is API specification for RESTful web services using Java. RESTful web services is implementation of REST (Representational State Transfer) which is architectural design for distributed system or in general we can say JAX-RS is a set of APIs to develop REST service. 

This is a brief introduction about REST and JAX-RS. You can find more information on REST on [Wiki](https://en.wikipedia.org/wiki/Jakarta_RESTful_Web_Services) and [JAX-RS](https://eclipse-ee4j.github.io/jersey/) Official Site.

## What is REST

> ### *Representational state transfer is an abstraction of the architecture of the World Wide Web. More precisely, REST is an architectural style consisting of a coordinated set of architectural constraints (source Wikipedia)*

As JAX-RS is only a specification, we need to use it's implemented library to create RESTful web service.

Following are such list of libraries

- [Apache CXF](http://en.wikipedia.org/wiki/Apache_CXF), an open source [Web service](http://en.wikipedia.org/wiki/Web_service) framework.
- [Jersey](http://jersey.java.net/), the reference implementation from [Sun](http://en.wikipedia.org/wiki/Sun_Microsystems) (now [Oracle](http://en.wikipedia.org/wiki/Oracle_Corporation)).
- RESTeasy, [JBoss](http://en.wikipedia.org/wiki/JBoss)'s implementation.
- [Restlet](http://en.wikipedia.org/wiki/Restlet), created by Jerome Louvel, a pioneer in REST frameworks
- [Apache Wink](http://en.wikipedia.org/wiki/Apache_Wink), [Apache Software Foundation](http://en.wikipedia.org/wiki/Apache_Software_Foundation) Incubator project, the server module implements JAX-RS.

For this JAX-RS tutorials set we will use ``Jersey`` library and Maven for dependency management.


 
## Quick Start
Following are some start-up JAX-RS examples.

- **Simple Hello World Example**

    simple JAX-RS tutorial, which sends “Hello World” text as response string using JAX-RS API and Jersey implementation.
- **JSON Response Example**

## References
- [Jersey Official Website](http://jersey.java.net/)
- [Jersey hello world example](http://www.mkyong.com/webservices/jax-rs/resteasy-hello-world-example/)
- [RESTful Web Services](http://www.oracle.com/technetwork/articles/javase/index-137171.html)
