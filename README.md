tags: jsf java springframework spring security jpa passwordsalt primefaces


# Step 0 - Description
This library is made to set up Multi-User-Webapps fast and straightforward.
Use JPA Objects as security prinicpals for string. Easily stored in JPA Datastore.

Uses POJOs as user classes (e.g. Admin.java). Each instance of this class is called a user with the role 'ROLE_ADMIN'.

Extends RAD/RapidPrototyping with user capabilities. Meant to use in conjunction with spring roo

# Step 1 - Generate project skeleton
Generate a simple spring app with jsf capabilities.
Simplest way is to use (url=> roo)

Script:
```
project --topLevelPackage de.computerlyrik.spring.securityobjects.example --projectName SecurityobjectsExample
persistence setup --provider HIBERNATE --database HYPERSONIC_IN_MEMORY
entity jpa --class ~.domain.Category --testAutomatically
entity jpa --class ~.domain.Item --testAutomatically
field string --fieldName content --class ~.domain.Category
field string --fieldName content --class ~.domain.Item
field set --fieldName items --class ~.domain.Category --type ~.domain.Item --mappedBy category
field reference --fieldName category --class ~.domain.Item --type ~.domain.Category --notNull
web jsf setup
web jsf all --package ~.web
```

# Step 2 - Add Maven Dependencies
```xml
<repositories>
...
 <repository>
  <id>computerlyrik-securityobjects-releases</id>
  <url>https://github.com/computerlyrik/spring-securityobjects/raw/master/repo/releases</url>
 </repository>
<repositories>
```
```xml
<dependencies>
...
 <dependency>
  <groupId>de.computerlyrik.spring</groupId>
  <artifactId>spring-securityobjects</artifactId>
  <version>1.1.5</version>
 </dependency>
</dependencies>
```

# Step 3 - Set up your Security Classes
Create classes deriving from ```de.computerlyrik.spring.securityobjects.UserDetailsSO```

Using roo a single command:
```
entity jpa --class ~.domain.user.Admin --extends de.computerlyrik.spring.securityobjects.UserDetailsSO
```

Creates Source code:

```java
@RooJavaBean
@RooToString
@RooJpaActiveRecord
public class Admin extends UserDetailsSO {
}
```

If you don't use roo, use your personal JPA or any other setup here.

# Step 3 - Set up Security Context
applicationContext-security.xml
```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans:beans xmlns="http://www.springframework.org/schema/security"
    xmlns:beans="http://www.springframework.org/schema/beans" 
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans
                                        http://www.springframework.org/schema/beans/spring-beans-3.1.xsd
                                        http://www.springframework.org/schema/security
                                        http://www.springframework.org/schema/security/spring-security-3.1.xsd">


        <!-- Configure Authentication mechanism -->
        <authentication-manager alias="authenticationManager">
                <!-- SHA-256 values can be produced using 'echo -n your_desired_password | sha256sum' (using normal *nix environments) -->
                <authentication-provider user-service-ref="userDetailsService">
                        <password-encoder ref="hashingPasswordEncoder"/>
                </authentication-provider>
        </authentication-manager>

    <!-- HTTP security configurations -->
    <http auto-config="true" use-expressions="true">

        <session-management>
                <concurrency-control max-sessions="1" />
        </session-management>

        <form-login login-processing-url="/resources/j_spring_security_check"
                        login-page="/login.jsf" 
                        authentication-failure-url="/login.jsf" />
        <logout logout-url="/resources/j_spring_security_logout" />


        <intercept-url pattern="/login.jsf" access="permitAll" />
        <intercept-url pattern="/admin.jsf" access="hasRole('ROLE_ADMIN')" />
        <intercept-url pattern="/pages/*" access="isAuthenticated()" />
        <intercept-url pattern="/javax.faces.resource/*.css.jsf*" access="permitAll" />
        <intercept-url pattern="/javax.faces.resource/*.png.jsf*" access="permitAll" />
        <intercept-url pattern="/javax.faces.resource/*.js.jsf*" access="permitAll" />
  
    </http> 
</beans:beans>
```

In your web.xml add
```xml
<filter>
                <filter-name>springSecurityFilterChain</filter-name>
                <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
</filter>
<filter-mapping>
                <filter-name>springSecurityFilterChain</filter-name>
                <url-pattern>/*</url-pattern>
                <dispatcher>FORWARD</dispatcher>
                <dispatcher>REQUEST</dispatcher>
</filter-mapping>
```
# Step 4 - create JSF Login and Admin (page and beans)
TODO: see admin.xhtml and login.xhtml in example dir

TODO: see security bean 

Login Form for JSF
```xml
<h:form id="loginForm" prependId="false">
 <p:panel header="Login">
  <p:messages />
  <label for="j_username"><h:outputText value="Username:" /></label>
  <br />
  <h:inputText id="j_username"></h:inputText>
  <br />
  <br />
  <label for="j_password"><h:outputText value="Password:" /></label>
  <br />
  <h:inputSecret id="j_password"></h:inputSecret>
  <br />
  <h:commandButton type="submit" id="login"
  action="#{securityBean.doLogin}" value="Login" />
 </p:panel>
</h:form>
```

# Step 5 (optional) - create an import and an startup script
To create Users, do
```java
Admin a = new Admin();
a.setUsername("admin");
a.setPassword("admin");
a.setEnabled(true);
a.persist();
```

e.g. write a bean and include it in extra applicationContext-startup.xml

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.1.xsd">
        <bean id="exampleInitBean" class="de.computerlyrik.spring.securityobjects.example.Import"/>
</beans>
```

# Step 6 (optional) - add a LoginAuthSuccessHandler to redirect different users

