package com.example.testcontainers.controllers;

import com.example.testcontainers.enitities.Country;
import com.example.testcontainers.service.CountryService;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/country")
class CountryController {

    private final CountryService countryService;

    public CountryController(final CountryService countryService) {
        this.countryService = countryService;
    }

    @GetMapping("/getCountry/{id}")
    ResponseEntity<Country> getCountry(@PathVariable Long id) {
        final Optional<Country> country = countryService.findCountryById(id);
        return country.map(ResponseEntity::ok)
                .orElseGet(() -> new ResponseEntity<>(HttpStatusCode.valueOf(404)));
    }

    @PostMapping("/addCountry")
    ResponseEntity<Long> addCountry(@RequestBody CountryDTO countryDTO) {
        return ResponseEntity.ok(countryService.addCountry(countryDTO));
    }
}

