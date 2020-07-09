FROM maven:3.6.3-openjdk-14-slim
WORKDIR /app
COPY ./pom.xml ./
RUN mvn dependency:go-offline -B
COPY ./src ./src/
RUN mvn package


FROM openjdk:14-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/template.web.restapi-0.0.1-SNAPSHOT.jar ./
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "template.web.restapi-0.0.1-SNAPSHOT.jar"]
