What is Multi-staged-Dockerfile?  
----------------------------  

A multi-stage Dockerfile is a Dockerfile that uses multiple FROM instructions to build an image.   
Each FROM instruction defines a new stage of the build, and the artifacts from one stage can be copied to the next stage.  
This allows you to create images that are optimized for size and performance.  

Advantages:   
----------

Smaller images
Improved performance  
Reduced complexity  
Security

Java Multi-staged Dockerfile Example:  
-----------------------  
###Base stage #####  
FROM maven:3.8.5-jdk-11 AS build  

WORKDIR /app  

COPY pom.xml .  

RUN mvn -B dependency:resolve  

COPY src .  

RUN mvn -B package  

#####Final Stage ########  

FROM openjdk:11-jdk-slim  

COPY --from=build /app/target/my-app.jar /app/my-app.jar  

CMD ["java", "-jar", "/app/my-app.jar"]  


Python Multistage Docker file Example   
-----------------------  
 
#####Base image ######  
FROM python:3.8-slim AS build  

WORKDIR /app  

COPY requirements.txt .  

RUN pip install -r requirements.txt  

COPY src .  

RUN python setup.py install  

####final stage#####

FROM python:3.8-slim  

COPY --from=build /app/ /app  

CMD ["python", "app.py"]  
