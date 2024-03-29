# BUILD
FROM maven:3-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -Dmaven.test.skip=true

# DEPLOY
FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar ./app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
