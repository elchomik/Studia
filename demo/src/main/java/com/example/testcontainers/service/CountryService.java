package com.example.testcontainers.service;

import com.example.testcontainers.controllers.CountryDTO;
import com.example.testcontainers.enitities.Country;
import com.example.testcontainers.repositories.CountryRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CountryService {

    private final CountryRepository countryRepository;

    public CountryService(final CountryRepository countryRepository) {
        this.countryRepository = countryRepository;
    }


    public Optional<Country> findCountryById(Long countryId) {
        return countryRepository.findById(countryId);
    }

    public Long addCountry(CountryDTO countryDTO) {
        Country country = countryRepository.save(Country.of(countryDTO));
        return country.getCountryId();
    }
}
