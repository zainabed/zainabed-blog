---
title: "Upload MultipartFile with Spring Resttemplate"
date: 2022-10-19T06:13:04-04:00
draft: true

  
---

# What this tutorial will do
We will se how to upload a file to server using Spring Boot `RestTemplate`.
The prericusite for this tutorials is to have a server which accept the multipart file upload request
and RestTemplate client instance and ofcourse a file to upload.

# How this tutorials will do what it do

First we create instatance of RestTemplate as

```java
final RestTemplate restTemplate = new RestTemplate();
```

Next, we to instruct restemplate to accept multipart request by addeding required headers to it as

```java
final HttpHeaders httpHeaders = new HttpHeaders();
httpHeaders.setContentType(MediaType.MULTIPART_FORM_DATA);
```
We need a file to upload to server, it could be any thing, for this tutorial we are creating a simple text file

```bash
echo "Test file" >>> test.text
```

Lets create file system resource out of this file and bind ii to request entity in order to upload it.

```java 
final File uploadFile = getFile();
final FileSystemResource fileSystemResource = new FileSystemResource(uploadFile);
final MultiValueMap<String, Object> fileUploadMap = new LinkedMultiValueMap<>();
fileUploadMap.set("file", fileSystemResource);
```

Create a request entity as

```java
HttpEntity<MultiValueMap<String, Object>> httpEntity = new HttpEntity<>(fileUploadMap, httpHeaders);
```

Now all things are set we just need to invoke the REST call to upload the file to server.
To do so add following snippet

```java
ResponseEntity<String> responseEntity = restTemplate.postForEntity("http://localhost:8090/file-upload", httpEntity, String.class);
```
# Tutotials result

Here is complete service code 

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
 In order to test this file upload service you need a REST application to consume the file and save it.
 This tutorial is limited to showcase the client side service of file upload, but you can find completed server-client code on Gituhb project. 

 Please check link in end of this tutorial.

 Once you run the service and connect with server you will get following kind of response

 ```bash
 2022-10-19 08:58:03.090  INFO: file is created with name test181876724622311090.txt
 2022-10-19 08:58:03.105  INFO: Saved file with name test181876724622311090.txt
 ```
# Conclusion

Congratulation, you have completed the file upload process using RestTemplate.
As usual you will find completed source code on [Github]() project.