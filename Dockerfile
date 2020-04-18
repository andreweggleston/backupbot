FROM gradle:jdk11 as build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew build --no-daemon

FROM openjdk:11-slim

COPY --from=build /home/gradle/src/build/libs/*.jar /home/gradle/src/app.jar

ENTRYPOINT ["java", "-jar","/home/gradle/src/app.jar"]