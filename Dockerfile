# Dockerfile
FROM adoptopenjdk/openjdk11:alpine-slim

COPY src/target/helloworld-1.0-SNAPSHOT.jar helloworld-1.0-SNAPSHOT.jar
COPY run.sh run.sh
RUN  chmod 755 run.sh

CMD ["java", "-jar", "helloworld-1.0-SNAPSHOT.jar"]
