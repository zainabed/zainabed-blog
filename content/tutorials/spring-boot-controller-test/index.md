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
There are three ways  to unit test Spring Boot Rest controller and this tutorials will demonstrate the one of this but fastest one.

### Tools
>  Spring Boot:  
>  Java :

## Rest Controller

Lets create a simple REST API controller with one service to fetch the data from db.

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
*  `createUser` method will accept `User` request and then it will be saved to database using service and at last response is return.

* Pay attention to the `UserServicve` interface, here we are not defining any implementatoin of it, rather we will utilized the unit test mocking to inject mock class which will provide test data for unit test cases.


##### UserService.java
```java
public interface UserService {
    User save(User user);
}

```

## Unit Test
To make this unit test faster we will not load the Spring Boot context (creation of beans, services and loading other Spring configuration), instead we will load only `UserController` and inject mock instance of `UserService` to it. Thats it.

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

Run the test case either by editor or by following command

```bash
mvn test
```

It will result into somthing like

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