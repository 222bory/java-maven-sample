FROM docker.io/openjdk:8-alpine
ARG JAR_FILE=helloworld-1.0-SNAPSHOT.jar
COPY ${JAR_FILE} myboot.jar
ENTRYPOINT ["java","-jar","/myboot.jar"]
