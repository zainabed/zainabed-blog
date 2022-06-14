---
title: "Sass Tutorials"
date: 2014-07-27T05:26:34-04:00
draft: false
authors:
  - Zainul
cover:
  image: "image/cover.png"
  alt: "Sass Tutorials"
categories: 
  - "Sass"
  
---

## Introduction

Sass (Syntactically Awesome Stylesheets) is scripting language which produces Cascading Style Sheets (CSS).

Sass is compatible with all CSS version and has assorted features. It is open source and developed in Ruby.

## What does Sass do

In simple terms by using Sass and its features we can create robust and large Style sheet with less effort and in less time.

## How to Install Sass

Sass requires Ruby, so if you are using Windows System then you need to install Ruby first.
Here is URL of [Ruby Installer](http://rubyinstaller.org/downloads/).

Otherwise if you use Mac or Linux System then you don’t need Ruby, it is pre-configured.

Use following commands to install Sass

```bash
sudo gem install sass
```

use following command to verify  Sass is installed properly or not.

```bash
sass  -v
```

To begin with Sass, create Sass “main.scss” file and CSS “main.css” file

Then run following command

```bash
sass --watch main.scss:main.css
```

It will update main.css file whenever you do changes and save Sass file.

## Sass Script

1. ### Variable

Sass variable is use to store information at one place and can be used at various place through out the whole Style Sheet.


```csss
$base-font: Arial, sans-serif;

$base-color: #555;
```

```css
h1{
  font: 100% $base-font;
  color: $base-color;
}
```

2. ### Nesting

Nesting is associated to CSS control structure define under enclosing brackets.

```css
section {
  
  div {
    padding: 10px;
    position: relative; 
  }
  
  p {
     margin: 10px;
  }
} 
```

Which produce following CSS style.


section div {
  padding: 10px;
  position: relative;
}

section p {
  margin: 10px;
}

3. ### Mixins

Mixins allow you to group set of CSS code and reuse it by including whole set of those code inside other CSS selectors. it looks like function with parameter.



```css
@mixin border-radius($box-sizing) {

  -webkit-box-sizing: $box-sizing;
 -moz-box-sizing: $box-sizing;  -ms-box-sizing: $box-sizing;  box-sizing: $box-sizing;  

}

.container{
  @include border-radius(border-box);
}
```

4. ### Extends
Extends is like inheritance where you can share CSS properties from one selector to another.

```css
.button {
  padding: 10px;
  height :30px;
  line-height: 30px;
}

.red-button{
  @extend .button;
  background: red;
}
.green-button {
 @extend .button;
 background: green;
}
```

5. ### Partials / Import
Partials are Sass files starts with underscore in beginning of their names.  underscore indicate Sass that it is a Partial and Sass does not convert it into CSS file. you rather include this Partial in other Sass files using @import keyword. Partials create structure of Style files and can be reuse in many other files.


```css
/* _base.scss */

body {
  font-family : Arial, Verdana;
  margin: 0 10px;
}
```
```css
/* home.scss */

@import 'base';

p {
    background-color: #eee;
}
```

6. ### Operators

Sass provides +, -, *,  % and / operators to perform mathematical operations.

```css
$width: 900px;

.md-1 {
  width: $width;
}

.md-2{
  width: $width/2;
}

.md-4{
  width: $width/4;
}

```

## References

- [Sass Official Site](http://sass-lang.com/)
- [Sass Wiki](http://en.wikipedia.org/wiki/Sass_(stylesheet_language))