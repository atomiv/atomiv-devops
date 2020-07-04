FROM maven:3.6.3-ibmjava-8-alpine AS builder
WORKDIR /app
COPY ./pom.xml ./
RUN mvn dependency:go-offline -B
COPY ./src ./src/
RUN mvn package


FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/template.web.restapi-0.0.1-SNAPSHOT.jar ./
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "template.web.restapi-0.0.1-SNAPSHOT.jar"]