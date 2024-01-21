# Maven build container 

#FROM maven:3.8.5-openjdk-11 AS maven_build
FROM maven:3.8.5-openjdk-17-slim AS BUILD

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn package

#pull base image

FROM eclipse-temurin:11

#copy hello world to docker image from builder image

COPY --from=BUILD /tmp/target/rak.jar /data/rak.jar

#default command
CMD ["java", "-jar", "/data/hello-world-0.1.0.jar"]

EXPOSE 8080

