---
title: "Spring Boot File upload with RestTemplate"
date: 2022-10-19T06:13:04-04:00
draft: false

  
---

## Introduction
This quick tutorial will show you how to use Spring Boot `RestTemplate` to upload a file to a server.

The prerequisites for this tutorial are the following

* the server that accepts requests for multipart file uploads
* A `RestTemplate` instance
* Of course, a text `file` to upload.

---

## What You Need
#### This tutorial uses following softwares
* Java: 1.8
* Spring Boot: 2.7.4
* Maven: 3.6.3


## How to upload a file

First we create an instance of RestTemplate as

```java
final RestTemplate restTemplate = new RestTemplate();
```

Next, by including the required headers in the requests, we should inform RestTemplate to accept multipart requests.

```java
final HttpHeaders httpHeaders = new HttpHeaders();
httpHeaders.setContentType(MediaType.MULTIPART_FORM_DATA);
```
> **Note**: HTTP multipart requests are used to transfer text or binary files to the server.


#### Create temporary text file 
To upload a file to the server, we need to create a file, which is what we will do in following snippet.

```java
private File getFile() {
    try {
        Path file = Files.createTempFile("test", ".txt");
        log.info("file is created with name {}", file.getFileName());
        return file.toFile();
    } catch (IOException e) {
        e.printStackTrace();
    }
    return null;
}
```

To upload this file, let's make a `FileSystemResource` out of newly created file and connect it to a HttpEntity.

```java 
final File uploadFile = getFile();
final FileSystemResource fileSystemResource = new FileSystemResource(uploadFile);
final MultiValueMap<String, Object> fileUploadMap = new LinkedMultiValueMap<>();
fileUploadMap.set("file", fileSystemResource);
```

Now, create a `HttpEntity` as

```java
HttpEntity<MultiValueMap<String, Object>> httpEntity = new HttpEntity<>(fileUploadMap, httpHeaders);
```

Since everything is in place, all that remains is to make the REST call to upload the file to the server.

To do so, add the following snippet

```java
ResponseEntity<String> responseEntity = restTemplate.postForEntity("http://localhost:8090/file-upload", httpEntity, String.class);
```
## Complete Source file 

Here is the complete service file code. 

#### FileUploadService.java
```java 
@Service
@Log4j2
public class FileUploadService {

    public static final String FILE_PARAMETER_NAME = "file";
    public static final String FILE_UPLOAD_URL = "http://localhost:8090/file-upload";
    private final RestTemplate restTemplate;

    public FileUploadService() {
        restTemplate = new RestTemplate();
    }

    @Scheduled(fixedDelay = 1000)
    public boolean uploadMultipartFile() {

        final HttpHeaders httpHeaders = new HttpHeaders();
        httpHeaders.setContentType(MediaType.MULTIPART_FORM_DATA);

        final File uploadFile = getFile();
        final FileSystemResource fileSystemResource = new FileSystemResource(uploadFile);
        final MultiValueMap<String, Object> fileUploadMap = new LinkedMultiValueMap<>();
        fileUploadMap.set(FILE_PARAMETER_NAME, fileSystemResource);

        HttpEntity<MultiValueMap<String, Object>> httpEntity = new HttpEntity<>(fileUploadMap, httpHeaders);
        ResponseEntity<String> responseEntity = restTemplate.postForEntity(FILE_UPLOAD_URL, httpEntity, String.class);
        return responseEntity.getStatusCode().equals(HttpStatus.OK);
    }

    private File getFile() {
        try {
            Path file = Files.createTempFile("test", ".txt");
            log.info("file is created with name {}", file.getFileName());
            return file.toFile();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}

```
You need a REST application to save the file in order to test this file upload service. The server-client code is ready on the Gituhb project, however this tutorial only showcases the client-side service.

Please check the Github project link at the tutorial's conclusion.

You will receive the subsequent type of response after starting the service and establishing a connection with the server.

 ```bash
 2022-10-19 08:58:03.090  INFO: file is created with name test181876724622311090.txt
 2022-10-19 08:58:03.105  INFO: Saved file with name test181876724622311090.txt
 ```
## Conclusion

Congratulations, you've just finished using RestTemplate to upload a file. As usual, a [Github](https://github.com/zainabed/tutorials/tree/master/maven/file-upload) project will contain the complete source code.