---
title: "SHA-256 Online Tool"
date: 2023-01-07T08:48:53-05:00
draft: false
authors:
  - Zainul

categories: 
  - "Tools"
  
---




<fieldset>
    <label for="fname">Enter the input</span>
      <button onclick="clearInputOutput()" class="right">Clear</button>
    </label>
    <textarea type="text" id="input" name="fname"></textarea><br><br>
    
</fieldset>
  <button onclick="execute()" class="active">Hash</button>
<fieldset>
    <label for="fname">SHA-256</label>
    <textarea type="text" id="output" name="fname"></textarea><br><br>
    <p id="message"></p>
</fieldset>





## What is SHA-256?

SHA-256 is a cryptographic hash function that accepts a random-sized input and returns a 256-bit fixed-size hash as an output.

Because of their one-way output, such hashes are extremely powerful. Simply said, you can generate a hash output from any given input, but you cannot reconstruct the original data from the same hash output.


<script type="text/javascript" src="/js/sha256.min.js"></script>
