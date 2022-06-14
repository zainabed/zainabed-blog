---
title: "Abstract Factory Design Pattern Analysis"
date: 2020-04-24T11:01:00-04:00
draft: false
authors:
  - Zainul

cover:
    image: "image/cover.png"
    alt: "Abstract Factory"
categories: 
  - "Design Pattern"
---


## What is the ``Abstract Factory`` design pattern? 


The intent or definition of Abstract Factory is

> # “Provide an interface for creating families of related or dependent objects without specifying their concrete classes”

It's a bit of a complicated definition, so we'll need to break it down into meaningful chunks to understand it.


## 1.  "Provide an interface" 

When we discuss the Abstract Factory, we are referring to interfaces rather than abstract classes. Essentially, this design pattern provides us with an interface, similar to those found in Java, C#, or Typescript (abstract class).  


``Why interface?`` Whenever we talk about any design pattern, we focus on how we will use it rather than how we will implement it.

Because a concrete class creates tight coupling, whereas an interface isolates it from the rest of the system, an interface is always the better choice. We can get different solutions at runtime without having to update our code.


For example

```java
interface SecurityFactory {

   AuthenticationManager getAuthenticationManager();

   AuthorizationManager getAuthorizationManager();

}
```

Here we have an abstract factory which defines the behaviour of creating objects related to application security, like authentication and authorization. 

Here we can have different authentication schemes like Basic, Bearer, or Digest, and authorizations like simple or JWT. 

Our client code is unconcerned about which implementation we use, it just uses Abstract Factory interfaces to perform security-related actions.



## 2. “for creating families of related or dependent objects”

The second part states that the Abstract Factory, aka Interface, creates objects.
Interfaces contain methods, and each method should return an object.


```java
AuthenticationManager getAuthenticationManager();

AuthorizationManager getAuthorizationManager();
```

When we call these methods, we get instances of security objects that are related to a context. Here, the context is security.



## 3. “without specifying their concrete classes”

The last part of the definition states that the return type of each abstract method is an **interface**, not a *concrete class*.
  
It makes sense because the Abstract Factory is an interface in and of itself, therefore the return type of each of its methods should also be an interface. 
Clients can now obtain many types of objects from the Abstract Factory without having to make any changes on their end.
  
For example, when I use SecurityFactory like this,


```java
public TestApp(SecurityFactory securityFactory ) {

  AuthorizationManager authorizationManager = securityFactory.getAuthorizationManager();

  if(authorizationManager.isLoggedIn()){
    // allow user to access resource
  }else{
    // notify unauthorized user
  }
}
```

Here, the object **authorizationManager** can represent any kind of authorization model, like basic authorization, JWT, or session based authorization.
 
To have different authorization behaviors, we don't need to change anything on the client side. Instead, we add a different securityFactory dependency at runtime.
 
Another example would be as follow.


```java
void AuthenticateUser(String username, String password){

   AuthenticationManager authManager = securityFactory.getAuthenticationManager();

   if (authManager.authenticate(username, password)  == true){
      // User is authenticated
   }else {
     // Invalid User
   }
}    
```

The authentication model in this situation could range from basic authentication to custom authentication.


This implementation will not impact the client code, it only knows about the interface, not its implementation.


The concrete implementations of SecurityFactory will be the only thing that changes inside your application, this can be done using dependency injection.



## Benefits

Every application requires the construction of a number of objects, each with its own set of creation procedures. 

To instantiate objects, some developers prefer new keywords, while others prefer dependency injection, such as singleton. 
The first technique leads to tight coupling, which is difficult to verify, and the second way is difficult to maintain and can lead to a verbose constructor definition.


When we group all related objects of an application together, we get only a few abstract factories that are easy to manage and maintain throughout the entire application.
 
AbstractFactory is easy to test. We can create mock objects and test application behaviour easily.
 
AbstractFactory follows the Open/Close principle. We can change the behaviour of an application without updating any client code. 



## Example 

Security Abstract Factory [Github](https://github.com/zainabed/web-client-security) link.

Security Abstract Factory Implementation [Github](https://github.com/zainabed/web-security-soteria) link


## Conclusion

It is a creational pattern to create a set of related objects. 
Rather than creating objects with new keywords, which is difficult to maintain and verify, we should encapsulate them within creational patterns. The Abstract Factory is a great pattern to create such related items.

Please let me know what you think of this pattern and how you've implemented it in your app.