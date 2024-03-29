---
title: "Base64 Online Tool"
date: 2023-01-05T00:40:20-05:00
draft: false
authors:
  - Zainul

categories: 
  - "Tools"
  
---



<div>
  <button onclick="changeMode('encode',this)" class="tab tab-active">Encode</button>
  <button onclick="changeMode('decode',this)" class="tab">Decode</button>
</div>

<fieldset>
    <label for="fname">Enter the text for <span class="modeName"></span>
      <button onclick="clearInputOutput()" class="right">Clear</button>
    </label>
    <textarea type="text" id="input" name="fname"></textarea><br><br>
    
</fieldset>
  <button onclick="execute()" class="active">Base64 <span class="modeName"></span></button>
<fieldset>
    <label for="fname">Base64 <span class="modeName"></span></label>
    <textarea type="text" id="output" name="fname"></textarea><br><br>
    <p id="message"></p>
</fieldset>


## Base64 Encoder / Decoder Online

Base64 Decode is a simple utility for decoding or encoding base64 data to plain text.


## What exactly is Base64?

Base64 is a family of binary-to-text encoding techniques that convert binary data in an ASCII string format into a radix-64 representation.

Base64 is commonly used to encode binary data in email messages and web pages. It is also used to send binary files over channels that are not 8-bit clean or where byte order is not an issue.

Please see the [Base64 Wikipedia](https://en.wikipedia.org/wiki/Base64) page for further information.

<script type="text/javascript" src="/js/base64.js"></script>
