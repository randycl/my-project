FROM gradle:6.8-jdk11 AS builder
WORKDIR /home/gradle/project
COPY gradle gradle
COPY gradlew .
COPY settings.gradle .
COPY app app
RUN ./gradlew build

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=builder /home/gradle/project/app/build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
