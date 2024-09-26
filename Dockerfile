# Usa una imagen base de Java
FROM openjdk:17-jdk-slim

# Establece el directorio de trabajo
WORKDIR /app

# Copia el archivo pom.xml y los archivos mvnw y la carpeta .mvn
COPY pom.xml .
COPY .mvn .mvn
COPY mvnw .

# Copia el código fuente
COPY src ./src

# Cambia permisos de ejecución a mvnw
RUN chmod +x mvnw

# Construye el proyecto
RUN ./mvnw clean package -DskipTests

# Copia el jar generado
COPY target/*.jar app.jar

# Comando para ejecutar el jar
CMD ["java", "-jar", "app.jar"]
