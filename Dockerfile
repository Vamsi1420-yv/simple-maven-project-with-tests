# Use official Maven image with Java 8
FROM maven:3.9.6-eclipse-temurin-8 as build

# Set working directory
WORKDIR /app

# Copy everything to /app
COPY . .

# Build the project and skip tests
RUN mvn clean install -DskipTests

# Second stage: use only the final JAR
FROM eclipse-temurin:8-jre

WORKDIR /app

# Copy the JAR from the build stage
COPY --from=build /app/target/simple-maven-project-with-tests-1.0-SNAPSHOT.jar app.jar

# Default command
CMD ["java", "-jar", "app.jar"]
