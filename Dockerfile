FROM openjdk:8-jdk-alpine
ARG JAR_FILE=helloworld-1.0-SNAPSHOT.jar
COPY ${JAR_FILE} myboot.jar
ENTRYPOINT ["java","-jar","/myboot.jar"]
