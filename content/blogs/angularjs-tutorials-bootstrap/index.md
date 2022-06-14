---
title: "Angularjs Tutorials Bootstrap"
date: 2015-03-04T11:17:01-04:00
draft: false
authors:
  - Zainul

cover:
  image: "image/cover.png"
  alt: "AngularJs Getting Started"
categories: 
  - "Angular"
  - "JavaScript"
---



## Introduction

Every application starts with bootstrap process which initialize application and wire it other with dependencies and configurations.

AngularJs is not different from other application. It also starts application with bootstrap process.

Following operation happens inside AngularJs bootstrap process.

- Load application module.
- Create dependency injector and load dependencies.
- Compile HTML and create scope for application.

All these steps happens inside angular.js scripting file. therefore we need to include it first.
we can include it inside HEAD tag or at end of BODY tag.

> Note: Adding angular.js file at end of body tag will allow browser to load of HTML elements without any delay and afterwards load angular.js and begin bootstrapping process.

You can get angular.js source file from https://code.angularjs.org/


```html
<script src=”https://code.angularjs.org/1.3.0/angular.js” type=”text/javascript”>
```

AngularJs bootstrap process happens on document ready event.


lets see the simple AngularJs example.


```html
<html>
 <head>
    <title>Angular Application</title>
 </head>
 <body ng-app="myApp">
    <div ng-controller="myCtrl">
        <h3>{{title}}</h3>
    </div>

    <script src="https://code.angularjs.org/1.3.0/angular.js" type="text/javascript"></script>

    <script type="text/javascript">

        //angular module
        angular.module("myApp",[])
      

        //controller
        .controller("myCtrl", ["$scope", function($scope){
            $scope.title = "Angular Bootstrap Tutorial!"
        }])

    </script>

 </body>
</html>
```

Now lets look into AngularJs bootstrap process steps one by one.

## Load application module

AngularJs will look for module name which is associated with ng-app directive inside HTML page.


```html
<html ng-app="myApp" >
…
…
```

Then Angular will load this module from JavaScript snippet.

```javascript
angular.module("myApp", []) 
```

## Create dependency injector and load dependencies

After first step AngularJs will create injector and compiler objects. functionality of compiler object is listed in third step.

Here injector object will look for dependency of application module. In above example we have not specify any dependency.

Following example illustrate module dependency

```javascript
angular.module("myApp",[ "ngResource"])
```

These dependencies are nothing but angular modules. injector load this modules and allow them to be used inside angular application.

Services can also be injected on fly inside application controller or application services.


```javascript
.controller("myCtrl", ["$scope", function($scope){
  $scope.title = "Angular Bootstrap Tutorial!"
}])
```

in above example $scope is injected by injector inside controller and we can use it inside controller.


## Compile HTML and create scope for application.

Inside last step AngularJs compiles HTML elements using compiler object then creates scope for application and bind rootScope to html element where we have specified ng-app.
In above example ng-app is specified inside body tag which means rootScope is attached to body tag and all template logic get applied on this body tag.


Above scenario illustrates automatic bootstrapping process. but some time you may require to manually bootstrap AngularJs application where you need to perform some custom JavaScript task before initiating AngularJs application.

Following script snippet shows manual bootstrapping process.


```javascript
// document ready event
angular.element(document).ready( function() {

    // bootstrap document with myApp module
    angular.bootstrap(document, ["myApp"])

})
```

As stated earlier bootstrap happens on document ready event therefore you need to configure it first.
Then call **angular.bootstrap** function which will accept two parameters.

First parameter is html element e.g. document, html, body or particular div. this process is equivalent as specifying **ng-app** directive to HTML element.

Second parameter is AngularJs module name. in this case we have give **myApp**.

Note that you first need to add module scripting code then initiate bootstrap process otherwise bootstrap will throw error that unable to load given module.

With automatic or manual bootstrap, you are ready to create beautiful AngularJs application.

