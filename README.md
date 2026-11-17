# Multiapp - Spring Boot + SQLite + Docker

A small Spring Boot REST API that stores Student records in a SQLite database file named `app.db`.

## Requirements

- Java 17
- Docker Desktop (for container deployment)
- Postman or another HTTP client (optional)

A local Maven installation is not required when using Docker. The Dockerfile builds the project with Maven inside the build container.

## Project structure

```text
multiapp/
├── src/
│   ├── main/
│   │   ├── java/com/example/multiapp/
│   │   │   ├── MultiappApplication.java
│   │   │   ├── Student.java
│   │   │   ├── StudentRepository.java
│   │   │   └── StudentController.java
│   │   └── resources/application.properties
│   └── test/
├── data/                 # SQLite database is stored here
├── .dockerignore
├── Dockerfile
├── docker-compose.yml
├── mvnw
├── mvnw.cmd
└── pom.xml
```

## Run locally on Windows

Open Command Prompt in the project directory:

```cmd
mkdir data
mvnw.cmd spring-boot:run
```

The application uses `data/app.db` by default and listens on port 8080.

## Run with Docker

1. Install and start Docker Desktop.
2. Open Command Prompt in the project directory.
3. Build and start the container:

```cmd
docker compose up --build
```

Docker builds the JAR inside a Maven/Java 17 build image. It does not require Maven to be installed on the laptop.

The API is available at:

```text
http://localhost:8080/students
```

The host folder `./data` is mounted into the container at `/app/data`. The database therefore remains at `data/app.db` on the laptop when the container is stopped or recreated.

Stop the container with:

```cmd
docker compose down
```

## REST API

Base URL: `http://localhost:8080/students`

| Method | Endpoint | Purpose |
|---|---|---|
| POST | `/students` | Add a student |
| GET | `/students` | List all students |
| DELETE | `/students/{id}` | Delete a student by ID |

### Add a student

Send a POST request to `http://localhost:8080/students` with Body > raw > JSON:

```json
{
  "name": "Sathwik",
  "department": "CSE"
}
```

### List students

Send a GET request to:

```text
http://localhost:8080/students
```

### Delete a student

Send a DELETE request to:

```text
http://localhost:8080/students/1
```

## Database configuration

`src/main/resources/application.properties` uses:

```properties
spring.datasource.url=jdbc:sqlite:${DB_PATH:./data/app.db}
spring.datasource.driver-class-name=org.sqlite.JDBC
spring.jpa.database-platform=org.hibernate.community.dialect.SQLiteDialect
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

- Local run: database at `./data/app.db`.
- Docker Compose: `DB_PATH=/app/data/app.db`, persisted through the `./data:/app/data` volume.

Do not delete `data/app.db` if you need to keep the student records.
