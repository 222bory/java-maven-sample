FROM maven:3-jdk-8-alpine

COPY ./target/*.jar /data/springboot-helloworld/
WORKDIR /data/springboot-helloworld

EXPOSE 8080

CMD ["java", "-jar", "helloworld-1.0-SNAPSHOT.jar"]
