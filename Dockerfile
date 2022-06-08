# Base Alpine Linux based image with OpenJDK JRE only
FROM openjdk:8-jre-alpine
# copy application WAR (with libraries inside)
COPY target/*.jar /data/springboot-helloworld/
# specify default command
CMD ["/usr/bin/java", "-jar", "helloworld-1.0-SNAPSHOT.jar"]
