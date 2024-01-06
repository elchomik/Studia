package com.example.testcontainers.third_approach;

import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;

@ActiveProfiles("test")
@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class DefaultContainerConfigurationIT {

    @Container
    static final PostgreSQLContainer<?> POSTGRE_SQL_CONTAINER = new PostgreSQLContainer<>("postgres:16.1")
            .withDatabaseName("test")
            .withUsername("admin")
            .withPassword("admin")
            .withExposedPorts(5432);

    static {
        POSTGRE_SQL_CONTAINER.start();
        System.setProperty("spring.datasource.url", POSTGRE_SQL_CONTAINER.getJdbcUrl());
        System.setProperty("spring.datasource.username", POSTGRE_SQL_CONTAINER.getUsername());
        System.setProperty("spring.datasource.password", POSTGRE_SQL_CONTAINER.getPassword());
    }
}
