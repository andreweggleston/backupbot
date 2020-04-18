FROM gradle:jdk11 as build
USER gradle:gradle
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon

FROM openjdk:11-slim

COPY --from=build /home/gradle/src/build/libs/*.jar /home/gradl/src/app.jar

ENTRYPOINT ["java", "-jar","/home/gradle/src/app.jar"]