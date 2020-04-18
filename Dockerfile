FROM gradle:jdk11 as build
COPY --chown=1000:1000 . /home/gradle/src
WORKDIR /home/gradle/src
USER 1000
RUN ./gradlew build --no-daemon

FROM openjdk:11-slim

COPY --from=build --chown=1000 /home/gradle/src/build/libs/*.jar /home/gradle/src/app.jar

RUN chmod 777 /home/gradle/src/app.jar

ENTRYPOINT ["java", "-jar","/home/gradle/src/app.jar"]