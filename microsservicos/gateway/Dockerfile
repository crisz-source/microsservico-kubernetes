#essa imagem vai servir apenas para compilar
FROM maven:3.9.6-eclipse-temurin-17-focal AS Build 
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Imagem que vai servir para rodar o projeto com o java 17
FROM eclipse-temurin:17.0.11_9-jre-focal
WORKDIR /app
EXPOSE 8082
COPY --from=build /app/target/gateway-0.0.1-SNAPSHOT.jar .
CMD [ "java", "-jar", "gateway-0.0.1-SNAPSHOT.jar" ]