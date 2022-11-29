---
title: "Angular: Getting Started With Httpclient Unit Testing"
date: 2022-07-26T01:39:41-04:00
publishDate: 2022-07-26T01:39:41-04:00
draft: false
authors:
  - Zainul
cover:
  image: "image/cover.webp"
  alt: "Angular: Getting Started With Httpclient Unit Testing"
categories: 
  - "Blog"
---

## Introduction

This tutorial will help you understand the basics of unit testing for Angular HttpClient. Angular includes a testing module named ``HttpClientTestingModule`` that provides an HTTP mocking service, ``HttpTestingController`` to intercept the HTTP request and provide a mock response for it.



## Setup

We begin by writing a service to fetch blogs from an application server.

Use the following Angular cli commands to generate a service.

#### Generate a module

```bash
ng g module blogs
```

#### Generate a service

```bash
ng g service blogs/blog
```

Now create the following classes inside the app folder.

### Blog model class
#### blog.ts
```typescript
export class Blog {
    title: string = "";
    content: string = "";
    createdAt: Date = new Date();
    author: string = "";
}
```
### Blog Service
#### blog.service.ts
```typescript
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Blog } from './blog';

@Injectable({
  providedIn: 'root'
})
export class BlogService {

  static readonly API_ENDPOINT = "http://localhost:8090/api/blogs";

  constructor(private http: HttpClient) { }

  public fetchBlogs(): Observable<Blog[]> {
    return this.http.get<Blog[]>(BlogService.API_ENDPOINT);
  }

}
```

Now we have the basic building blocks of the application. Next, we can write unit tests to verify HTTP client communication between the Angular application and API server. 


## Write Unit Test Case

Create a unit test case file as follows and import the HTTP testing module and its controller.

#### blog.service.spec.ts


```typescript
import {
  HttpClientTestingModule, 
  HttpTestingController} from '@angular/common/http/testing'
```


### HttpClient Testing Module
The Angular HTTP testing module provides a class named ``HttpTestingController`` which intercepts any HTTP request initiated by an Angular application. It also provides the stub response or error message to the HTTP request. 

In nutshell, it creates a mock server with the desired response for a particular HTTP request. Next, create an instance of the HTTP testing controller to emulate mock http calls.

```typescript
  beforeEach(() => {
    TestBed.configureTestingModule({
      imports:[HttpClientTestingModule]
    });
    service = TestBed.inject(BlogService);
    httpCtrl = TestBed.inject(HttpTestingController);
  });
```



## Unit Test For Success Response

```typescript
it('Should return blogs from Http Get call.', () => {
    service.fetchBlogs()
      .subscribe({
        next: (response) => {
          expect(response).toBeTruthy();
          expect(response.length).toBeGreaterThan(1);
        }
      });
});
```
The above snippet executes the blog service, then accepts the response and verifies it. 
As stated earlier, HTTP calls are intercepted by ``HttpTestingController`` and return a successful response with a 200 status code.

### Create success response

First, we need to create a mock HTTP request handler which will intercept the request originated for ``http://localhost:8090/api/blogs`` URL.

```typescript
const mockHttp = httpCtrl.expectOne('http://localhost:8090/api/blogs');
const httpRequest = mockHttp.request;
```

This will acquire the handler for the HTTP request. We can use it to validate the request's method type and send a mock response.

```typescript
  expect(httpRequest.method).toEqual("GET");
  mockHttp.flush(BLOG_RESPONSE);
```

## Error Response

The unit test case for HTTP error is shown in the snippet below.

```typescript
it('Should return error message for Blog Http request.', ()=>{
    service.fetchBlogs()
    .subscribe({
        error: (error) => {
          expect(error).toBeTruthy();
          expect(error.status).withContext('status').toEqual(401);
        }
    });

    const mockHttp = httpCtrl.expectOne(BlogService.API_ENDPOINT);
    const httpRequest = mockHttp.request;

    mockHttp.flush("error request", { status: 401, statusText: 'Unathorized access' });
  });
```

Here we flush the error message with an HTTP 401 status code. And while subscribing, we bind the request to the error block and verify it.

## Complete Unit Test

```typescript
import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing'

import { BlogService } from './blog.service';

describe('BlogService', () => {
  let service: BlogService;
  let httpCtrl: HttpTestingController;

  const BLOG_RESPONSE = [
    {
      title: "How to create service in Angular",
      content: "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.",
      createdAt: Date.now(),
      author: "Zainul"
    },
    {
      title: "How to create module in Angular",
      content: "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.",
      createdAt: Date.now(),
      author: "Zainul"
    }
  ];

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule]
    });
    service = TestBed.inject(BlogService);
    httpCtrl = TestBed.inject(HttpTestingController);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('Should return blogs from Http Get call.', () => {
    service.fetchBlogs()
      .subscribe({
        next: (response) => {
          expect(response).toBeTruthy();
          expect(response.length).toBeGreaterThan(1);
        }
      });

    const mockHttp = httpCtrl.expectOne(BlogService.API_ENDPOINT);
    const httpRequest = mockHttp.request;

    expect(httpRequest.method).toEqual("GET");

    mockHttp.flush(BLOG_RESPONSE);
  });

  it('Should return error message for Blog Http request.', () => {
    service.fetchBlogs()
    .subscribe({
        error: (error) => {
          expect(error).toBeTruthy();
          expect(error.status).withContext('status').toEqual(401);
        }
    });

    const mockHttp = httpCtrl.expectOne(BlogService.API_ENDPOINT);
    const httpRequest = mockHttp.request;

    mockHttp.flush("error request", { status: 401, statusText: 'Unathorized access' });
  });
});


```
## Conclusion
Developers are under the impression that they need a production-ready API server to test their Angular application, but it is a half-truth. Rather, we just need to verify the HTTP client communication, which could be served by the mock server and the Angular HTTP testing module does exactly the same.

## Source Code
You can find source code used in this tutorial on [Github](https://github.com/zainabed/tutorials/tree/master/angular/blog-app) page.

