FROM eclipse-temurin:17-jdk-alpine as builder
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN mvn -B package --file pom.xml

FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
COPY target/*.jar app.jar
COPY --from=build target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]