FROM eclipse-temurin:17-jdk-jammy as builder
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN mvn -B package --file pom.xml

FROM eclipse-temurin:17-jdk-jammy
VOLUME /tmp
COPY /usr/app/target/*.jar app.jar
COPY --from=builder target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]