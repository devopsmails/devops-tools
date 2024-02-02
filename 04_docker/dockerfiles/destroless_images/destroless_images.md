GH: https://github.com/GoogleContainerTools/distroless  

What is destroless_images ?  
------------

Distroless container images are ultra-small images that only include an application and its runtime dependencies without additional libraries or   
utilities from a Linux distribution.  

JAVA Destoless Multi-staged Dockerfile Example:  
------------------------
##### base image #######  
FROM maven:3.8.5-jdk-11 AS build  
 
WORKDIR /app  

COPY pom.xml .  

RUN mvn -B dependency:resolve  

COPY src .  

RUN mvn -B package  

#####final stage with Desrtoless image#####  
FROM gcr.io/distroless/java:11  

COPY --from=build /app/target/my-app.jar /app/my-app.jar  

CMD ["java", "-jar", "/app/my-app.jar"]  
