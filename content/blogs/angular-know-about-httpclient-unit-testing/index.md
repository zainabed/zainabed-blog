---
title: "Angular Know About Httpclient Unit Testing"
date: 2022-06-21T01:39:41-04:00
draft: true
authors:
  - Zainul
cover:
  image: "image/cover.png"
  alt: "Angular Know About Httpclient Unit Testing"
categories: 
  - "Blog"
---

## Introduction

#### Generate a module

```bash
ng g module blogs
```

#### Generate a service

```bash
ng g service blogs/blog
```

## Blog model class

```typescript
export class Blog {
    title: string = "";
    content: string = "";
    createdAt: Date = new Date();
    author: string = "";
}
```
## Service

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


## HttpClient Testing Module
Angular HTTp testing module provides a class named ``HttpTestingController`` which intercepts the any HTTP request initiated by Angular application.
It also provides the stub response or error message to the HTTP request.
In nutsell it creates a mock server with desired response for a particular HTTP reqeust.


Import the Http testing module and controller as

```typescript
import {
  HttpClientTestingModule, 
  HttpTestingController} from '@angular/common/http/testing'
```

``HttpClientTestingModule`` is HTTP Testing module which injects the ``HttpTestingController`` as a service.

Next, Create instance of Http testing controller to emulate fake http calls.

```typescript
  beforeEach(() => {
    TestBed.configureTestingModule({
      imports:[HttpClientTestingModule]
    });
    service = TestBed.inject(BlogService);
    httpCtrl = TestBed.inject(HttpTestingController);
  });
```

## Write Service Unit Test Case

First, write test case to execute the service call

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
This will not execute a Http GET request as we have created mock Http Controller.
All HTTP requests will be respond by this Test Controller.

In order to return a success response we need to configure the Test controller to return
200 status response.

## Success Response

First we need to create a mock Http request handler which will intercept the request iniciated for ``http://localhost:8090/api/blogs`` URL.

```typescript
const mockHttp = httpCtrl.expectOne(BlogService.API_ENDPOINT);
const httpRequest = mockHttp.request;
```

## Error Response

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
});

```
## Conclusion
