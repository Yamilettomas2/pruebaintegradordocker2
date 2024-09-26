# Usa una imagen base de Java
FROM openjdk:17-jdk-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo pom.xml y el código fuente
COPY pom.xml .
COPY src ./src

# Construye el proyecto
RUN ./mvnw clean package -DskipTests

# Copia el jar generado
COPY target/*.jar app.jar

# Comando para ejecutar el jar
CMD ["java", "-jar", "app.jar"]
