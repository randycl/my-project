# Use the official Gradle image to build the application
FROM gradle:6.8-jdk11 as builder

# Set the working directory
WORKDIR /home/gradle/project

# Copy the Gradle wrapper and build files
COPY app/gradle gradle
COPY app/gradlew .
COPY app/settings.gradle .
COPY app/build.gradle .

# Copy the source code
COPY app/src src

# Run the Gradle build
RUN ./gradlew build

# Use the official OpenJDK image to run the application
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /home/gradle/project/build/libs/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
