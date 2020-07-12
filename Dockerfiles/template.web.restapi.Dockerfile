FROM maven:3.6.3-openjdk-14-slim AS builder
WORKDIR /app
COPY ./pom.xml ./
RUN mvn dependency:go-offline -B
COPY ./src ./src/
RUN mvn package


FROM openjdk:14-jdk-slim
ARG USER="demo"
RUN addgroup --system --gid 1001 $USER \
    && adduser --system --uid 1001 --group $USER
WORKDIR /app
COPY --from=builder --chown=$USER:$USER /app/target/template.web.restapi-0.0.1-SNAPSHOT.jar ./
EXPOSE 8080
USER $USER
ENTRYPOINT ["java", "-jar", "template.web.restapi-0.0.1-SNAPSHOT.jar"]
