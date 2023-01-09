---
title: "Spring Boot Controller Test"
date: 2022-12-21T09:46:44-05:00
draft: true
authors:
  - Zainul
categories: 
  - "Tutorial"
  - "Spring Boot"
  - "Unit Test"
  - "Java"
  
---


## Introduction
There are several methods for testing Rest controllers in the Spring Boot framework, and this post will demonstrate one of the quickest.

### Tools
>  Spring Boot: 2.7.6  
>  Java : 11

## Rest Controller

Let's create a simple REST API controller with one service to fetch the data from the database.

##### UserController.java
```java
@RestController
public class UserController {

    private final UserService userService;

    public UserController(final UserService userService) {
        this.userService = userService;
    }

    @PostMapping(path = "/user", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<User> createUser(@RequestBody User user) {
        final User savedUser = userService.save(user);
        return ResponseEntity.ok(savedUser);
    }
}

```
The code above is self-explanatory, but we'll go over a few topics.

* The `createUser` method takes a `User` object request and passes it to the serice, which saves it in the database and returns the saved User object as a response.


* Pay close attention to the `UserServicve` interface, we will not define any implementation of it here; Instead, we will use unit test mocking to inject a dummy class that will function as a service to store User instances.


##### UserService.java
```java
public interface UserService {
    User save(User user);
}

```

## Unit Test
Only `UserController` will be loaded into the web context, and the Spring Boot application context will be left out of the test suite. The test suite is lighter and faster when the complete application context is removed.

We also need to mock `UserService` because Spring context isn't available to autowire it. This adds another benefit to our test suite because we don't have to worry about implementing business logic while developing the REST controller.

Here, we will simply test the REST controller's input and output, ensuring that all essential business service calls are triggered and provide an appropriate response.

##### UserControllerTest.java
```java

@WebMvcTest(UserController.class)
class UserControllerTest {

    @MockBean
    private UserService userService;

    @Autowired
    MockMvc mockMvc;
    private User userRequest;
    private User userResponse;

    @BeforeEach
    void setUp() {
        final String username = "test name";
        final String userAddress = "test address";
        userRequest = new User(username, userAddress);
        userResponse = new User(username, userAddress);
        when(userService.save(userRequest)).thenReturn(userResponse);
    }

    @Test
    void should_save_requested_user() throws Exception {
        final String requestBody = new ObjectMapper().writeValueAsString(userRequest);
        mockMvc.perform(post("/user").contentType(MediaType.APPLICATION_JSON)
                .content(requestBody))
                .andExpect(status().isOk());
    }
}
```
Within the `@BeforeEach` function, we imitate the `UserService` behaviour of saving the `User` record into the database.

We assert the REST call status after sending the required User record to the controller and returning the stored User object as a response.

Run the test case using the editor or the command.

```bash
mvn test
```

It will result in something like

```bash
022-12-21 12:34:49.968  INFO 53510 --- [           main] c.z.tutorials.user.UserControllerTest    : Started UserControllerTest in 3.531 seconds (JVM running for 5.266)
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 4.818 s - in com.zainabed.tutorials.user.UserControllerTest
[INFO] 
[INFO] Results:
[INFO] 
[INFO] Tests run: 1, Failures: 0, Errors: 0, Skipped: 0
[INFO] 
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS

```
## Conclusion

Loading only the REST Controller into the test suite context is a great feature of the Spring Boot application, and it makes writing and testing the REST Controller faster.

But don't make this your default method of writing test cases; remember, this is a unit test for the REST Controller, not an integration test. To make an application behave properly with rest of services, such as business logic, a database, or a third-party library or service, the entire application context must be loaded and the REST controller tested. 

You can find the source code used in this tutorial on the [Github]() page.