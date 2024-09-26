# Usa una imagen oficial de Maven con JDK 17 como imagen base
FROM maven:3.8.5-openjdk-17 AS build

# Configura el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo pom.xml y los archivos mvnw y la carpeta .mvn
COPY pom.xml . 
COPY .mvn .mvn
COPY mvnw .

# Cambia permisos de ejecución a mvnw
RUN chmod +x mvnw

# Copia el código fuente
COPY src ./src

# Construye el proyecto
RUN ./mvnw clean package -DskipTests

# Usa una imagen de OpenJDK para ejecutar la aplicación
FROM openjdk:17-jdk-slim

# Configura el directorio de trabajo en el contenedor
WORKDIR /app

# Copia el archivo JAR generado desde la etapa de construcción
COPY --from=build /app/target/*.jar app.jar

# Expone el puerto en el que la aplicación escucha (ajusta si es necesario)
EXPOSE 8080

# Comando para ejecutar el jar
CMD ["java", "-jar", "app.jar"]
