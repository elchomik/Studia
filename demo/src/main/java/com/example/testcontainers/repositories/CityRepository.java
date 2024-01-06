package com.example.testcontainers.repositories;

import com.example.testcontainers.enitities.City;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CityRepository  extends JpaRepository<City, Long> {
}
