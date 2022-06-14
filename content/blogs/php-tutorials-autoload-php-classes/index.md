---
title: "Php Tutorials Autoload Php Classes"
date: 2014-11-02T05:33:18-04:00
draft: false
authors:
  - Zainul
cover:
  image: "image/cover.png"
  alt: "Php Tutorials Autoload Php Classes"
categories: 
  - "PHP"
  
---

## Introduction

With some examples, this tutorial post will teach the PHP autoloader and namespace concepts.

## What is Autoloading in PHP
PHP autoload's primary function is to load PHP files into the application context. The import statement is the default method to include PHP file into context.

However, we may avoid the issue by using the PHP autoload capability to autoload essential PHP files, which keeps your code clean and composable.

## Why do we need auto loading
When creating object-oriented applications, many developers create one PHP source file per class declaration. One of the major inconveniences is having to start each script with a huge list of required includes.

Autloading allows us to include an arbitrary number of PHP files in the application context if they aren't already included by other include statements. 

## PHP Autoloading Methods
PHP uses two functions; one is the magic method spl_autoload_register and the other is  ``__autoload``.

> **NOTE**: Although ``__autoload`` has been DEPRECATED as of PHP 7.2.0, and REMOVED as of PHP 8.0.0, relying on this function is highly discouraged.

Whenever PHP encounters an instantiation of a class, it triggers the autoloading function by providing it as a parameter.

You can also define the path of the class and include it in context within the atoloading method.


## What is difference between __autoload and sp_autload_resgister function

Because the ``_autoload`` method is a magic method, you can only declare it once. As a result, you'd just need one logic to incorporate PHP class files.

``spl_autoload_register``, on the other hand, takes a function as a parameter, which we can use to create the specific logic for including the PHP file.

With the help of ``spl_autoload_register``, we can have multiple implementations of the inclusion of PHP files.

## Example

```php
<?php

/**
 * autoload method
 */
function __autoload($class)
{
  require $class.'.php';
}

//spl_autoload_register

/**
 * autoload method one
 */
function autoloadOne($class)
{
  require "/dir-one/".$class.".php";
}

/**
 * autoload method two
 */
function autoloadTwo($class)
{
  require "/dir-two/".$class.".php";
}

//register auto loader
spl_autoload_register("autoloadOne");
spl_autoload_register("autoloadTwo");
```

## What exactly is namespace

In most cases, PHP won't let you have two classes with the same name. However, in version 5.3, the idea of namespace was added, which created class ownership, allowing two classes with the same name but distinct ownership to exist.

## What is the importance of namespace in autloading

Namespaces were created to solve the problem of name clashes and to allow extra-long class names to be shortened.

Namespaces are a technique of encapsulating objects in the broadest sense.

Namespaces in PHP allow you to organise related classes, interfaces, methods, and constants together.

For example 

```php
<?php

namespace Module\User\Controller;
namespace Module\User\Entity;
namespace Module\User\Form;
namespace Module\User\Validator;
```

If we autoload the above class, we will get the whole namespace of that class along with the class name.

```php
 namespace_autoload.php
<?php

spl_autoload_register(function ($class_name) {

  echo "class path = ".$class;
  die ;
}

new \Module\User\Controller();

// it will print
// class path = Module\User\Controller
```

With the help of this information, we can organize classes according to our project directory structure.

Let's say you have the following project structure.

```
project
 |__Module
      |__User
          |__Controller
          |__Entity
          |__Form
 |
 |__autoload.php
```

Then you can create PHP classes with a namespace as

```
 project
 |__Module
     |__User
   |__Controller   \\ class : IndexController , namespace Module\User\Controller
          |__Entity   \\ class : User , namespace Module\User\Entity
          |__Form  \\ class : UserForm , namespace Module\User\Form
 |
 |__autoload.php
 ```


#### file: autoload.php

```php
<?php

//include namespace

use Module\User\Controller\IndexController;
use Module\User\Entity\User;
use Module\User\Form\UserForm;

/**
 * Autload project files
 */
spl_autoload_register(function ($class_name) {

  echo $class;
  require $class;
}

// instantiate classes
$controller = new IndexController();
//(it will print)  Module\User\Controller\IndexController and load this class

$user = new User();
//(it will print)  Module\User\Entity\User  and load this class

$userForm = new UserForm();
//(it will print) Module\User\Form\UserForm  and load this class
```

As you can see, namespaces aid in the organisation of the project structure and the autoloading of classes. 

## What is the difference between the following two sets of statements?

| Namespace autloading | Direct include files |
| -------------------- | -------------------- |
| use Module\User\Controller\IndexController; | require "Module\User\Controller\IndexController"; |
| use Module\User\Entity\User; | require "Module\User\Entity\User"; |
| use Module\User\Form\UserForm; | require "Module\User\Form\UserForm"; |

The main difference is that the ``require`` statement accepts the full directory path, whereas with ``namespace`` we can set logic to autoload PHP files with different directory structures and minimise the namespace length. 


Let's see the following example. Suppose you have the following directory for your project library files.

 
 ```
project
 |
 |__vendor
 |
 |__lib
  |
  |__src
   |
   |__components
    |
    |__HTTP  //Request, Response classes
    |
    |__Controller  //BaseController classes
    |
    |__Form //BaseForm classes
 ..... many more files
```

You write the following code to use the require statement. 

```php
<?php

 require "/vendor/lib/src/components/HTTP/Request";
 require "/vendor/lib/src/components/HTTP/Response";
 require "/vendor/lib/src/components/Controller/BaseController";
 require "/vendor/lib/src/components/Form/BaseForm";
```

We can reduce the above class path and organize the structure much more properly with the help of autoload and namespace as follows.

```php
<?php

define("LIB_PATH", "/vendor/lib/src/components");

use HTTP\Request;
use HTTP\Response;
use Controller\BaseController;
use Form\BaseForm;

/**
 *  autoload lib class files
 */
spl_autoload_register(function ($class_name) {

  // set class path
  $class_path = LIB_PATH.$class;

  //include class file
  echo $class_path;
  require $class_path;
}

$request = new Request;
// (it will print)  /vendor/lib/src/components/HTTP/Request

$controller = new BaseController;
// (it will print)  /vendor/lib/src/components/Controller/BaseController
```

## Conclusion
- An autoload helps load all the PHP classes of a PHP project. 
- The combination of autoload and namespace standardises the organisation and loading of PHP projects.
- Namespace helps organise your PHP classes.

