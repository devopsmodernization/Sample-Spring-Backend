FROM eclipse-temurin:17-jdk-jammy as builder
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN chmod +x ./mvnw
RUN ./mvnw -f $HOME/pom.xml -B package 


FROM eclipse-temurin:17-jdk-jammy
VOLUME /tmp
COPY --from=builder /usr/app/target/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]