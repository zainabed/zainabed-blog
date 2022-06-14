---
title: "Mongodb Crud Operations Using Java"
date: 2014-06-03T05:24:31-04:00
draft: false
authors:
  - Zainul
cover:
  image: "image/cover.png"
  alt: "Mongodb Crud Operations Using Java"
categories: 
  - "Java"
  - "MongoDB"
---

## Introduction

This article will show you how to use Java to perform CRUD operations on MongoDB records.

If you're new to MongoDB, we recommend starting with the Getting Started With MongoDB tutorial.

To begin, we'll establish a Person and Person Images table (a collection in MongoDB) to make CRUD operations in MongoDB easier.

## Define Data Structure
The following is the data structure of the Person and Person Images table (collection in MongoDB).

#### Person

| id | Int (primary) | 
| -- | ------------- |
| username | String |
| first_name | String |
| last_name | String |
| email | String |
| description | String |
| birthdate | Date |
| country | String |
| state | String |
| city | String |
| lat | String |
| lang | String |
| job | String |


#### Person Images

| id | Int(Primary) |
| -- | ------------ |
| person_id | Int |
| image_path | String |
| width | Int |
| height | Int |
| aspect_ration | Double |
| like | Int |
| dislike | Int |
  
We'll use these data structures and associated records to develop interactive image galleries and search engine systems in later tutorial posts.

## Create maven project

Now, create a new project in eclipse and select


- File -> New -> Other -> Maven Project -> Next
- Select maven-archetype-quickstart
- Select Next
- Type Group Id, Artifact Id and Package name
- And select Finish

This will create Maven based Java project .

> **Note**: What is Maven's purpose? Although Maven is not required, it allows us to avoid manually installing external libraries such as the MongoDB Java library. Maven aids in the reduction of time and effort by adding the library and its version.

Add following snippet inside pom.xml file inside dependencies tag.

```xml
<dependency>
      <groupId>org.mongodb</groupId>
      <artifactId>mongo-java-driver</artifactId>
      <version>2.12.2</version>
</dependency>
```

> **Note**: You can find this dependency (java library and drivers) and its version for Maven on [http://mvnrepository.com](http://mvnrepository.com)


## MongoDB connection

```java
MongoClient mongoClient= new MongoClient("localhost",27017);

/**
Other methods to create client
MongoClient mongoClient= new MongoClient();
                    
MongoClient mongoClient= new MongoClient("localhost");
*/
```

The MongoDb client can be obtained in three ways.
One without any contractor parameters, or others with a server address or port number.

To create database use following snippet.

```java
DB zainabedDB = mongoClient.getDB("zainabed");
```

If “zainabed” database is not present in MongoDB then it get created.

## Print All Available Database

```java
List<String> databaseNames = mongoClient.getDatabaseNames();

for (String dbName : databaseNames) {
  System.out.println("Database : " + dbName);
}
```

It will print all database names presents in MongoDB.

## Select or Create Collection

The collection acts as a table (RDBMS) and in this tutorial it will be Person and Person Images.

Use the following code to create a collection.

```java
DBCollection personCollection = zainabedDB.getCollection("person");
```

The code above will either choose the collection or create it if it does not already exist.

Use the following code to get a list of all available collection names for a given database.

```java
Set<String> collectionNames = zainabedDB.getCollectionNames();
             
for(String collection : collectionNames){
       System.out.println("collection : " + collection);
}
```

## Create Record (Person)

``BasicDBObject`` is used to create a row object which get inserted into collection.

Following code inserts a row into Person collection.

```java
BasicDBObject person = new BasicDBObject()
                     .append("username","zainabed")
                     .append("first_name","Zainul")
                     .append("last_name","Shaikh")
                     .append("email","xyz@gmail.com")
                     .append("description","Software Developer")
                     .append("birthdate",new SimpleDateFormat("yyyy-MM-dd").parse("1985-03-13"))
                     .append("country","india")
                     .append("state","maharashtra")
                     .append("city","pune")
                     .append("job","Software Developer")
                     .append("lat","18.526895")
                     .append("long","73.856101");
                    
personCollection.save(person);
```

Now, we will insert a record inside ``Person Image`` collection.

To do so, first we need to select or create Person Image collection.

```java
DBCollection personImagesCollection = zainabedDB.getCollection("person_images");
```

Later,  we will create person image ``BasicDBobject`` as,

```java
BasicDBObject personImage = new BasicDBObject()
                     .append("person_id", person.get("_id"))
                     .append("image_path", "/23gfd945j4k4.png")
                     .append("width", 400)
                     .append("height", 400)
                     .append("aspect_ration", 1.0)
                     .append("like", 1000)
                     .append("dislike", 45);

```

Here we have used “_id” field of ``Person`` object to create association.

Now this object is ready for insert into db.

```java
personImagesCollection.save(personImage);
```

## Read MongoDB Records

MongoDB read operation is very simple, we will see possible read operations such as

- Find single record
- Find all records using cursor object
- Find records using condition

## Find Single Record:
To find single record from given collection we will use find() method of collection object.

```java
DBObject result = personCollection.findOne();
System.out.println(result);
```

It will print single result object.

## Find All Records Using Cursor Object

To fetch all person records we will use find() method of collection and it will provide a cursor to iterate through all records.

```java
DBCursor personCursor = personCollection.find();
                    
while(personCursor.hasNext()){
  System.out.println(personCursor.next());
}
```

## Find records using condition object

We will use condition object (BasicDBObject) to filter out desired results.

```java
BasicDBObject coditionObject = new BasicDBObject("job","Software Developer");

result = personCollection.findOne(coditionObject);
System.out.println(result);
```

To filter that column, we specify a condition object with a field and a value.

## Update MongoDB Records

The update method of a collection object is used to update a record.

Two objects are required for the update method, one to filter out the targeted row and the other to alter the value of a specific column.

```java
BasicDBObject queryObject = new BasicDBObject("username","zainabed");
BasicDBObject updateObject = new BasicDBObject("$set", new BasicDBObject("email","abc@gmail.com");
                    
personCollection.update(queryObject, updateObject);
```

> **Note**: Here we used the "$set" option to update a record, otherwise it will replace the entire row with the given update column values.

## Delete MongoDB Records

The remove () method of collection is used to remove a record from a collection.

To filter records that need to be deleted, we'll need a query object.

```java
queryObject = new BasicDBObject("email","abc@gmail.com");

personCollection.remove(queryObject);
```

## Conclusion

This post provided a quick overview of how to use MongoDB from Java.

All of these samples and code snippets can be found on the Github page.