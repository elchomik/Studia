package com.example.testcontainers.controllers;

import com.example.testcontainers.enitities.City;
import com.example.testcontainers.service.CityService;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/cities")
class CityController {

    private final CityService cityService;

    CityController(final CityService cityService) {
        this.cityService = cityService;
    }

    @GetMapping("/getCity/{id}")
    ResponseEntity<City> getSingleCity(@PathVariable Long id) {
        final Optional<City> city = cityService.findCityById(id);
        return city.map(ResponseEntity::ok)
                .orElseGet(() -> new ResponseEntity<>(HttpStatusCode.valueOf(404)));
    }

    @PostMapping("/addCity")
    ResponseEntity<Long> addCity(@RequestBody CityDTO cityDTO) {
        Optional<Long> city = cityService.addCity(cityDTO);

        return city.map(ResponseEntity::ok)
                .orElseGet(() -> new ResponseEntity<>(HttpStatusCode.valueOf(404)));
    }
}
