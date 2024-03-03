FROM eclipse-temurin:17-jdk-jammy as builder
ENV HOME=/usr/app
RUN mkdir -p $HOME
WORKDIR $HOME
ADD . $HOME
RUN wget https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/latest/download/opentelemetry-javaagent.jar
RUN chmod +x ./mvnw
RUN ./mvnw -f $HOME/pom.xml -B package 


FROM eclipse-temurin:17-jdk-jammy
VOLUME /tmp
WORKDIR /app
COPY --from=builder /usr/app/target/*.jar app.jar
COPY --from=builder /usr/app/opentelemetry-javaagent.jar opentelemetry-javaagent.jar
ENV JAVA_TOOL_OPTIONS="-javaagent:/app/opentelemetry-javaagent.jar"
ENV OTEL_SERVICE_NAME="api-backend"
ENTRYPOINT ["java","-jar","/app.jar"]