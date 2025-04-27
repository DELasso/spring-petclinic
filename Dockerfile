FROM openjdk:17-jdk-slim
LABEL maintainer="shanem@liatrio.com"
COPY /target/spring-petclinic-*.jar /home/spring-petclinic.jar
CMD ["java", "-jar", "/home/spring-petclinic.jar"]