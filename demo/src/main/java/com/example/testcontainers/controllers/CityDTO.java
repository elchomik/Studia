package com.example.testcontainers.controllers;

import com.example.testcontainers.enitities.Status;

public record CityDTO(String name, Status aggregateStatus, Long countryId) {
}
