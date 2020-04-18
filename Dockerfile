FROM gradle:jdk11 as build
COPY . /home/gradle/src
WORKDIR /home/gradle/src
RUN ./gradlew build --no-daemon

FROM openjdk:11-slim

COPY --from=build /home/gradle/src/build/libs/*.jar /home/gradle/src/app.jar

RUN chgrp -R 0 /home/gradle/ && \
        chmod -R g=u /home/gradle/

RUN ls -n /home/gradle/src

ENTRYPOINT ["java", "-jar","/home/gradle/src/app.jar"]