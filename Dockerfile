# Build the Spring Boot application with Java 17 and Maven.
FROM maven:3.9.11-eclipse-temurin-17 AS build
WORKDIR /workspace

COPY pom.xml .
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B clean package -DskipTests

# Run the packaged application in a smaller Java 17 image.
FROM eclipse-temurin:17-jre
WORKDIR /app

RUN mkdir -p /app/data
COPY --from=build /workspace/target/*.jar /app/app.jar

ENV DB_PATH=/app/data/app.db
EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
