---
title: "Json Tutorials Getting Started"
date: 2014-10-25T05:32:31-04:00
draft: fase
authors:
  - Zainul
cover:
  image: "image/cover.png"
  alt: "Json Tutorials Getting Started"
---

## Introduction

JSON is widely accepted text formatted structured data. JSON stands for "JavaScript Object Notation".

In general JSON can represent 

- Object of database record.
- Object to represent a list of HTML elements.
- Result of search query.
- Response of an Ajax call. 

Here you can see JSON is used in many different areas and for many different scenarios. This means it has simple data structure. most of programming languages adopt it and it can flow easily from one connection to another.

You can find JSON office definition here JSON [Official Site](https://www.json.org/json-en.html).

JSON is represented by two structural types, which includes two primitive types.
 
## Structural types


- **Array**: A sequential list of primitive data types between square brackets [ ]

- **Object**: Collection of key, value pair stored inside curly braces { }, where value would be primitive data type



## Primitive types

There are two primitive types key and value. "key" should be string and "value (data type)" could be anything like integer, string , Boolean , empty or null.

Lets see some example of JSON objects.

### Array 

```javascript
[
    "apple",
    "orange",
    "blackberry",
    "grape"
]
```

### Object

```javascript
{
    "username": "zainabed",
    "first_name": "Zainul",
    "country": "India"
}
```

### Mix Object

```javascript
{
    "username": "zainabed",
    "first_name": "Zainul",
    "country": "India",
    "hobby": [
        "reading",
        "programming",
        "sports"
    ]
}
```

JSON is widely accepted and used because


- It is lightweight, that is why it is possible to transfer large set of data without exhausting internet bandwidth.

- It is language independent, which means most of the programing languages have mechanism to accept or generate JSON objects, it doesn’t need extra functionality to make JSON objects compatible with other languages.

- JSON can be as primary object for database system. it is used to store and read or perform CRUD operation on JSON which can be stored as documents. MongoDB is popular database system which based on JSON documents.

- JSON can have Embedded documents as well, it helps to avoid expensive join operations on related documents. here rather using joins, one JSON documents can be embedded inside another.

- JSON object can be used to represent HTML entities like list of user, tables or image gallery. AngularJs is most powerful tool to transform JSON to HTML.

- JSON can also represent search result. search result could include search count, search title and description list , etc. all this can be included in a JSON object. Elasticsearch represent its search result in JSON object. as it is JSON object it can be used in any programming languages as result.

- JSON play important role in drawing of charts. charts requires data set to create a particular chart and JSON object is perfect data model for it. D3 charts are always use JSON objects.

## Frequently Asked Questions

1: Can JSON starts with Array?
Answer: Yes, JSON can start with Array or Object, there is no such restriction.
  
2: What is the correct JSON content type for HTTP response?
Answer: Correct content type for JSON is application/json

 3: Safely turning a JSON string into an object inside a JavaScript?
Answer: Following two function call will turn string to JSON object

```javascript
jQuery.parseJSON( jsonString ); //Jquery

JSON.parse(jsonString); //plain JavaScript
```