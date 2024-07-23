# Use the official Gradle image as the base image
FROM gradle:6.8-jdk11 as builder

# Set the working directory in the container
WORKDIR /home/gradle/project

# Copy the Gradle wrapper and build files
COPY gradle gradle
COPY gradlew .
COPY build.gradle .
COPY settings.gradle .

# Copy the source code
COPY src src

# Run the Gradle build
RUN ./gradlew build

# Use a new stage for the runtime environment
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built artifacts from the builder stage
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
