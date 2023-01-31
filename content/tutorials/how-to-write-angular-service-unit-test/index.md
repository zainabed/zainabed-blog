---
title: "How To Write Angular Service Unit Test"
date: 2023-01-31T08:01:06-05:00
draft: false
---

## Introduction

This tutorial will walk you through the process of creating a basic unit test case for an Angular service. Angular services enable you to decompose complex business logic into small, reusable units that can then be injected into components or other services using dependency injection.

This tutorial is divided into two parts: 

* One for creating a service by instantiating it sing `new` keyword.
* And another for injecting it using the Angular `TestBed` module.



## Service

The structure of the `Token` class is shown in the following snippet. 

#### token.ts
```javascript
export class Token {
  timestamp: number = 0;
  userId: number = 0;
}
```

The Token class contains the token's expiration timestamp, user id, and token signature.

The next step is to validate this token object using an Angular service.


#### toke.service.ts
```javascript
import { Token } from './token';

export class TokenService {

  isValidToken(token: Token): boolean {
    let currentTime = Date.now();
    let timeDifference: number = token.timestamp - currentTime;
    
    if (timeDifference < 0) {
      return false;
    } else {
      return true;
    }
  }
}

```
To validate the token, the service will compute the difference between the current time and the moment it was created.
If the current time exceeds the token time or expiry time, the token is considered invalid, and the method returns the appropriate boolean value.


Now we can test the above method's behaviour against two scenarios: 
* One with an expired token, which should return a false value
* And one with a non-expired token, which should return a true value.

## Unit Test

#### token.service.spec.ts

```javascript
import { Token } from './token';
import { TokenService } from './token.service';

describe('TokenSerrvice test cases', () => {
  var tokenService: TokenService;
  var tokenTime: number;

  beforeEach(() => {
    tokenService = new TokenService();
  });

  it('Should return false for expired token', () => {
    tokenTime = Date.now() - 50;
    let token: Token = { timestamp: tokenTime, userId: 1212 };
    let result: boolean = tokenService.isValidToken(token);
    expect(result).toBeFalse();
  });

  it('Should return true for valid token', () => {
    tokenTime = Date.now() + 5000;
    let token: Token = { timestamp: tokenTime, userId: 1212 };
    let result: boolean = tokenService.isValidToken(token);
    expect(result).toBeTrue();
  });
});

```

`beforeEach` will create a new TokenService instance. Another way to obtain an instance of the service is to use the `TestBed` module, as seen below

## TestBed Configuration

```javascript
beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [TokenService]
    })
    tokenService = TestBed.inject(TokenService);
})
```

TestBed is an Angular-specific utility for unit testing; it allows us to auto-load services and any dependencies associated with them, and it provides a production-ready environment for unit testing.

Now the question is, which of these should I choose? The answer is dependent on your working style, if you want to control service creation, the first option is preferable, if you prefer Angular to handle service instantiation, the second option is advisable.


## Conclusion
Angular services are lightweight and independent of UI components. Therefore, you can build the service and verify its behaviour using unit test cases without the need to bootstrap your Angular application and browser.

You can find source code on the [Github](https://github.com/zainabed/tutorials/tree/master/angular/blog-app/src/app/services) page.