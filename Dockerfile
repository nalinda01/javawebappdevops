# =========================
# Stage 1: Build
# =========================
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy Maven configuration
COPY pom.xml .

# Copy source code
COPY src ./src

# Build the Spring Boot application
RUN mvn clean package -DskipTests


# =========================
# Stage 2: Run
# =========================
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/javawebapp-0.0.1-SNAPSHOT.jar app.jar

# Application port
EXPOSE 9099

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]