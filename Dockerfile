# Use the official Gradle image to build the app
FROM gradle:6.8-jdk11 as builder
WORKDIR /home/gradle/project

# Copy the gradle wrapper and settings files
COPY app/gradle gradle
COPY app/gradlew .
COPY app/settings.gradle .
COPY app/build.gradle .

# Copy the source code
COPY app/src src

# Build the project
RUN ./gradlew build

# Use a smaller base image for the final image
FROM openjdk:11-jre-slim
WORKDIR /app

# Copy the built jar file from the builder stage
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar

# Command to run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
