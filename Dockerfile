FROM gradle:jdk11 as build
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM openjdk:11-slim

RUN mkdir /app

COPY --from=build /home/gradle/src/build/libs/*.jar /app/backupboy.jar

ENTRYPOINT ["java", "-jar","/app/backupboy.jar"]