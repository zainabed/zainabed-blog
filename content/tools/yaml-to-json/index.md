---
title: "Online YAML to JSON Converter"
date: 2023-01-11T04:48:06-05:00
draft: true
authors:
  - Zainul
categories: 
  - "Tools"
  
---


## What is YAML to JSON converter tool

Convert YAML to JSON for free, quickly, and conveniently in your browser.

Enter your input below and click the `Convert` button. The result will be displayed below the Convert button.

<fieldset>
    <label for="fname">Enter the <b>YAML</b></span>
      <button onclick="clearYamlJSON()" class="right">Clear</button>
    </label>
    <textarea type="text" id="input" name="fname" style="min-height:450px" class="hljs yaml" ></textarea><br><br>
    
</fieldset>
  <button onclick="execute()" class="active">Convert</button>
<fieldset>
    <h3><label for="fname">JSON</label></h3>
    <pre type="text"  name="fname" id="outputBox" >
      <code class="hljs json" id="output" >
      </code>
    </pre>
    <br><br>
   
</fieldset>
 <p id="message"></p>



## What is YAML

YAML is a human-readable data-serialization language. It is frequently used in configuration files as well as programmes that store or transport data.


YAML is typically used to build application `configuration` and system `specifications`. It's a popular configuration language in well-known frameworks like Spring Boot, Docker and Kubernetes and many more. 


## What is JSON

JSON, which stands for `JavaScript Object Notation`, is a well known text formatted structured data.

In general, JSON can represent

* No SQL database record
* Application configuration
* Application configuration  No SQL database record

As you can see, JSON is utilised in a variety of scenarios, implying that it has a standard data structure.

JSON is a language-independent data format that is based on a subset of the JavaScript scripting language. It is often used with JavaScript.

The JSON website lists JSON libraries by language.
<script type="text/javascript" src="/js/yaml.min.js"></script>
<style>
  #outputBox {
    width: 100%;
  }
  </style>