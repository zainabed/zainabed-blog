---
title: "Create Mock Server Using Json Server"
date: 2022-11-02T05:19:14-04:00
draft: true
authors:
  - Zainul

categories: 
  - "Tutorial"
  
---

## Introduction

Mock REST API server will often expidite your testing.

This tutorial will give insight about one of such server and help you to configure and use it by following simple steps.

---
### Software used in this tutorial

* NPM : 8.3.1
* Node: 16.14.0
* Json-Server: 0.17.0

---
## Setup

First step is to make sure you have `node` and `npm` instsall on yor workstation then follow next steps

#### json-server installation 

Run following command the install latest version of `json-server`

```bash
npm install -g json-server
```

you can also install specific version as

```bash
npm install -g json-server@0.17.0
```


## Resource Defination

To create a mock server using json-server you need to provide a JSON file which includes the routes for mock server.
For an example if you want to have REST API for user model such as GET for getting all user's records, POST for registering new user record and DELETE for deleting the existing user record.

Such as 

#### resources.json 

```json
{
  "user": [
    { "id": 1, "name": "Jonathan" , "address" : "USA" }
  ]
}
```

Json mock server will convert this data structure to REST API routes as

* GET  http://localhost:{port}/user
* GET  http://localhost:{port}/user/{id}
* POST http://localhost:{port}/user
* PUT http://localhost:{port}/user/{id}
* DELETE http://localhost:{port}/user/{id}

#### Start the server

Run the following command to start the mock server

```bash
json-server resources.json
```

and server will start by emitting somthing like follwoing output

```bash
  \{^_^}/ hi!

  Loading resources.json
  Done

  Resources
  http://localhost:3000/user

  Home
  http://localhost:3000

  Type s + enter at any time to create a snapshot of the database

```
## Testing

We can use CURL commands to verify the mock server REST API endpoints and their behviour to different HTTP method calls.


#### GET request
```bash
curl --location --request GET 'http://localhost:3000/user/1'
```

#### Response
```bash
{
  "id": 1,
  "name": "Jonathan",
  "address": "USA"
}
```
---

#### POST request
```bash
curl --location --request POST 'http://localhost:3000/user' \
--header 'Content-Type: application/json' \
--data-raw ' {
    "name": "Stefan",
    "address": "Germany"
}'
```

#### Response
```bash
{
    "name": "Stefan",
    "address": "Germany",
    "id": 2
}
```

---
#### GET all users
```bash
curl --location --request GET 'http://localhost:3000/user'
```

#### Response
```bash
[
    {
        "id": 1,
        "name": "Jonathan",
        "address": "USA"
    },
    {
        "name": "Stefan",
        "address": "Germany",
        "id": 2
    }
]
```

---
#### Delete Request
```bash
curl --location --request DELETE 'http://localhost:3000/user/1'
```

## Conclusion 
In Agile world we nee smart tool which keeps feedback loop faster the increase the productivity and decrease the dependency,
And JSON-Server is the one of that tool.

You can find the source code related to this tutorial on [Github]() page.
