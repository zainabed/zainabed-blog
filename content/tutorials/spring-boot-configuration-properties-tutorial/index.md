---
title: "How To Use @ConfigurationProperties In Spring Boot "
date: 2023-02-09T03:08:11-05:00
draft: false
authors:
  - Zainul
categories: 
  - "Tutorial"
  - "Spring Boot"
  - "Java"
  
---


## Introduction
This tutorial will show you how to use `@ConfigurationProperties` in a Spring Boot application. This annotation is designed to load properties from an application property file into an application context and configure them using a Java object.


## Why do we need @ConfigurationProperties? What about the @Value annotation?

The typical method of registering configuration properties to a Java object field in a Spring Boot application is the `@Value` annotation, but it is only acceptable for single independent configuration. If we want contextual settings for a specific task, as explained below, the <b>@Value</b> annotation is redundant and ineffective.

```yaml
    services:
      - name: HTTP_SERVICE
        type: REST
        enable: true
        setting:
          endpoint: http://test.com/test
          content-type: application/json
      
```

Now let's try to configure the above properties for Java class fields as

```java
class AppSetting {
  @Value("${services.name}") serviceName;
  @Value("${services.type}") serviceType;
  @Value("${services.enable}") serviceEnable;
  @Value("${services.setting.endpoint}") serviceSettingEndpoint;
  @Value("${services.setting.content-tpe}") serviceSettingContentType;
}
```

You can see how difficult it is to map complicated properties using the @Value annotation, which is why Spring Boot created the new annotation `@ConfigurationProperties` to address the issue.


## Application Properties

For this tutorial, we have defined the following application properties in a YAML file.

#### application.yml
```yaml
app:
  settings:
    services:
      - name: HTTP_SERVICE
        type: REST
        enable: true
      - name: JMS_SERVICE
        type: MESSAGE
        enable: false
    file:
      name: archive
      path: /archive
```

Now lets work on Java code to map above configurations

## Java Code

#### ServiceSettingConfig

```java
public class ServiceSettingConfig {
}
```

To make it configurable with YAML services, we will use @ConfigurationProperties with a prefix of `app.settings`.

```java
@ConfigurationProperties(prefix = "app.settings")
public class ServiceSettingConfig {
}
```
Now we can map configurations to Java fields as

```java
@ConfigurationProperties(prefix = "app.settings")
public class ServiceSettingConfig {
  private List<?> services;
}
```
Here `?` represents a Java object that represents the following YAML configurations.

```YAML
name: HTTP_SERVICE
type: REST
enable: true
```

As a result, we must define a new Java class that represents these as fields. 

#### ServiceSetting.java
```java
public class ServiceSetting {
    private String name;
    private String type;
    private Boolean enable;

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(final String type) {
        this.type = type;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(final Boolean enable) {
        this.enable = enable;
    }
}
```

Now we can complete our configurations as 

#### ServiceSettingConfig.java
```java
@Configuration
@ConfigurationProperties(prefix = "app.settings")
public class ServiceSettingConfig {
    private List<ServiceSetting> services;

    public List<ServiceSetting> getServices() {
        return services;
    }

    public void setServices(final List<ServiceSetting> services) {
        this.services = services;
    }
}
```

Pay attention to two things

* first, the `@Configuration` annotation; in order to use this class within the application, you must load it as a configuration bean. 

* Second is the field name, <b>private ListServiceSetting> `services`</b>, which maps to <b>app.settings.`services`</b> of YAML, though the class name is different, <b>ServiceSetting</b>. It makes no difference what the class name is, but the field name must match the YAML configuration property.



## Conclusion
I hope this tutorial helps you understand the basic usage of @ConfigurationProperties. The source code related to this tutorial is present on my [Github](https://github.com/zainabed/tutorials/tree/master/spring-boot/spring-boot-test/src/main/java/com/zainabed/tutorials/config) page.
