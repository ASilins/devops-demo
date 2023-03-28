FROM maven:3.8.5-eclipse-temurin-17-alpine AS build
RUN mkdir -p /app
WORKDIR /app
COPY pom.xml /app
COPY src /app
run mvn -b package --file pom.xml -DskipTest

FROM eclipse-temurin:17-jdk-alpine

EXPOSE 8080
COPY --from=build /app/target/*jar devops-demo-1.0.jar
ENTRYPOINT ["java","jar","devops-demo-1.0.jar"]