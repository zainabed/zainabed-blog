---
title: "How To Use json-server To Build Mock REST API Server"
date: 2022-11-03T05:19:14-04:00
draft: false
authors:
  - Zainul

categories: 
  - "Tutorial"

---

## Introduction

A mock REST API server will often expedite your integration testing, and this tutorial will give you insight into one such server.

This tutorial will walk through each step of setting up and using a fake server.

---
### Software used in this tutorial

* NPM : 8.3.1
* Node: 16.14.0
* Json-Server: 0.17.0

---
## Setup

The first step is to make sure you have `node` and `npm` installed on your workstation, then follow the next commands.

#### json-server installation 

Run the following command to install the latest version of `json-server`

```bash
npm install -g json-server
```

You can also install a specific version as

```bash
npm install -g json-server@0.17.0
```


## Resource Defination

`json-server` requires a JSON file to configure the HTTP routes.
For example, if we want to create a REST API for a user module, we need to provide the following kind of JSON structure.


#### resources.json 

```json
{
  "user": [
    { "id": 1, "name": "Jonathan" , "address" : "USA" }
  ]
}
```

The JSON mock server will convert this data structure to REST API routes as

* GET  http://localhost:{port}/user
* GET  http://localhost:{port}/user/{id}
* POST http://localhost:{port}/user
* PUT http://localhost:{port}/user/{id}
* DELETE http://localhost:{port}/user/{id}

#### Start the server

Run the following command to start the mock server.

```bash
json-server resources.json
```

And the server will start by emitting something like the following output.

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

We can use `Curl` commands to verify the mock server's REST API endpoints and their behaviour with different HTTP method calls.


#### GET Request
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

#### POST Request
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
In an agile world, we need smart tools that keep the feedback loop faster, increase productivity, and decrease dependency, and JSON-Server is one of those tools.

You can find the source code related to this tutorial on the [Github](https://github.com/zainabed/tutorials/tree/master/javascript/mock-server) page.
