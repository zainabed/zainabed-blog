---
title: "Doctrine2 Installation Configuration"
date: 2014-10-23T05:31:23-04:00
draft: false
authors:
  - Zainul
cover:
  image: "image/cover.png"
  alt: "Doctrine2 Installation Configuration"
categories: 
  - "PHP"
  
---

## Introduction

In this tutorial, we will look at how to install Doctrine2 in your PHP project.

This post will make use of Doctrine2's Composer tool.

## Installation

First, create a directory for your project.

```bash
mkdir zainabed   

cd zainabed
```

Now, create a composer.json file.

```bash
vi composer.json
```

Then, add the following repository information to it.

```json
{
    "require": {
        "doctrine/orm": "*"
    }
}
```

You are now ready to use Composer to install Doctrine, but first you must install Composer on your machine.

```bash
curl -sS https://getcomposer.org/installer | php
```


To install Doctrine2, run the following command.

```bash
php composer.phar install
```


> Note: Composer generates a "autoload.php" file to help in the autoloading of all PHP classes in the Doctrine2 ORM project.


## Configuration

First, create a configuration file, configuration.php for Doctrine2 and include autoload.php inside it.

```php
<?php

// configuration.php

// Include Composer Autoload 
require_once "vendor/autoload.php";



Then, create the database configuration details, like database name, username and password.

// database configuration

$databaseParams = array(
    'driver'   => 'pdo_mysql',
    'user'     => 'root',
    'password' => '',
    'dbname'   => 'zainabed',
);
```

Now, specify the entity path where you want all ORM entities to be stored.

```php
//entity path
$entityPath = array("src/Entity");
```

## Create an Entity Manager 

ORM's fundamental source is the Entity Manager, which manages interactions between entities and databases.

```php
//annotation configuration
$config = Setup::createAnnotationMetadataConfiguration($entityPath, false);

//entity manager object
$entityManager = EntityManager::create($databaseParams, $config);
```

Finally, you are ready to use Doctrine2 within your PHP project.

The following is a complete configuration example that includes XML and YAML configuration.

```php
<?php

// configuration.php

// Include Composer Autoload 
require_once "vendor/autoload.php";

use Doctrine\ORM\Tools\Setup;
use Doctrine\ORM\EntityManager;

// database configuration
$databaseParams = array(
    'driver'   => 'pdo_mysql',
    'user'     => 'root',
    'password' => '',
    'dbname'   => 'zainabed',
);

//entity path
$entityPath = array("src/Entity");


//annotation configuration
$config = Setup::createAnnotationMetadataConfiguration($entityPath, false);

//entity manager object
$entityManager = EntityManager::create($databaseParams, $config);

//xml configuration
//$xmlEntituPath = array("/path/to/xml-mappings");
//$config = Setup::createXMLMetadataConfiguration($xmlEntituPath, false);
//$entityManager = EntityManager::create($databaseParams, $config);

//yml configuration
//$ymlEntityPath = array("/path/to/yml-mappings");
//$config = Setup::createYAMLMetadataConfiguration($ymlEntityPath, false);
//$entityManager = EntityManager::create($databaseParams, $config);
```

Doctrine 2 is now configured and ready to use.
