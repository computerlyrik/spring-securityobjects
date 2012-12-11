Use JPA Objects as security prinicpals for string. Easily stored in own Table.


-------------TODO - clean up documentation and write example project


##Step 1 


::> scr/main/resources/import.sql
INSERT INTO USER_DETAILSSCS VALUES ('Admin',1,TRUE,TRUE,TRUE,TRUE,'ff474d8ef12de3f71a334597a8b8165b4d1db83214dd49b4ce93ddae5370b922','admin',0,NULL)

::> src/main/resources/spring/security.properties
scs.salt=mycoolsaltvalue

::> src/main/resources/META-INF/spring/applicationContext-security.xml

<?xml version="1.0" encoding="UTF-8"?>

<beans:beans xmlns="http://www.springframework.org/schema/security"
    xmlns:beans="http://www.springframework.org/schema/beans"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-3.0.xsd
                        http://www.springframework.org/schema/security http://www.springframework.org/schema/security/spring-security-3.0.xsd">

	<!-- HTTP security configurations -->
    <http auto-config="true" use-expressions="true">
    	<form-login login-processing-url="/resources/j_spring_security_check" login-page="/login" authentication-failure-url="/login?login_error=t"/>
        <logout logout-url="/resources/j_spring_security_logout"/>
        <!-- Configure these elements to secure URIs in your application -->
        <intercept-url pattern="/**" access="isAuthenticated()" />
    </http>
    
</beans:beans>

::> src/main/webapp/WEB-INF/web.xml [after HttpMethodFilter]
   <filter>
        <filter-name>springSecurityFilterChain</filter-name>
        <filter-class>org.springframework.web.filter.DelegatingFilterProxy</filter-class>
    </filter>
    <filter-mapping>
        <filter-name>springSecurityFilterChain</filter-name>
        <url-pattern>/*</url-pattern>
    </filter-mapping>

now you should start your webapp and login with username and password "admin" (without "")!


#Step2

in your Pom.xml add

        <repository>
            <id>computerlyrik-scs-releases</id>
            <url>https://github.com/w4ldmeister/Spring-Customer-Security/raw/master/repo/releases</url>

         </repository>


        <dependency>
            <groupId>de.computerlyrik.scs</groupId>
            <artifactId>SpringCustomerSecurity</artifactId>
            <version>0.9.9</version>
        </dependency>

