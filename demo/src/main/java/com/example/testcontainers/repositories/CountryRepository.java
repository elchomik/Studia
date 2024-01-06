package com.example.testcontainers.repositories;

import com.example.testcontainers.enitities.Country;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CountryRepository extends JpaRepository<Country, Long> {
}
