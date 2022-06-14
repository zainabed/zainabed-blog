---
title: "Twig Tutorials Install and Configure"
date: 2014-10-16T05:30:27-04:00
draft: false
authors:
  - Zainul

cover:
  image: "image/cover.png"
  alt: "Twig Tutorials Install and Configure"
categories: 
  - "PHP"
  
---

## Introdcution

In this tutorial, we'll look at how to install Twig within your PHP project and thereafter configure it so that we can create and use a Twig template inside our PHP web application.

Later on, we'll see a simple Twig template example that displays a ``Welcome to Twig template`` message.

Let's take it one step at a time.

## Installation

The Twig template can be installed using Composer, Git, or PEAR.

In this tutorial, we will use Composer to install Twig.

To do so, we'll need to make a "composer.json" file.

```json
{
    "require": {
        "twig/twig": "1.*"
    }
}
```

From the console, run the following command.

```bash
php composer.phar install 
```

This command will install Twig library.



## Configuration

To use the Twig template, we should first configure it. To achieve this, we will write an index.php file which will configure the Twig autoloader and generate the Twig environment.

We will render the Twig template using this Twig environment.

```php
<?php

include __DIR__ . "/vendor/twig/twig/lib/Twig/Autoloader.php";

//register autoloader
Twig_Autoloader::register();

//loader for template files
$loader = new Twig_Loader_Filesystem('templates');

//twig instance
$twig = new Twig_Environment($loader, array('cache' => 'cache'));

//load template file
$template = $twig->loadTemplate('index.html');

//render a template
echo $template->render(array('title' => 'Welcome to Twig template'));

```

Next, we will create a "template.html" file inside template folder.

```html
<html>
  <head></head>
  <body>
    <h1>{{ title }}</h1>
  </body>
</html>
```

As a result, you will get the following output when you run the index.php file on localhost.


![Twing HTML outpur](image/twig-installtion-configuaration-output.png)



That's it. We are done with the Twig installation and configuration process.


## Source Code

Download source code from this [Github](https://github.com/zainabed/tutorials/tree/master/php/twig).