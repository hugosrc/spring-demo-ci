FROM maven:3.8.3-openjdk-17 AS builder

WORKDIR /src

COPY . .
COPY ./src .
RUN mvn -B package --file pom.xml -DskipTests

FROM openjdk:17-alpine

COPY --from=builder /src/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "app.jar" ]