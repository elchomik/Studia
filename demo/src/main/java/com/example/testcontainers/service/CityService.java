package com.example.testcontainers.service;

import com.example.testcontainers.controllers.CityDTO;
import com.example.testcontainers.enitities.City;
import com.example.testcontainers.enitities.Country;
import com.example.testcontainers.repositories.CityRepository;
import com.example.testcontainers.repositories.CountryRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class CityService {
    private final CityRepository cityRepository;
    private final CountryRepository countryRepository;

    public CityService(final CityRepository cityRepository, CountryRepository countryRepository) {
        this.cityRepository = cityRepository;
        this.countryRepository = countryRepository;
    }

    public Optional<City> findCityById(Long cityId) {
        return cityRepository.findById(cityId);
    }

    public Optional<Long> addCity(final CityDTO cityDTO) {
        Optional<Country> country = countryRepository.findById(cityDTO.countryId());

        if(country.isEmpty()) {
            return Optional.empty();
        }
        City saved = cityRepository.save(City.of(cityDTO, country.get()));
        return Optional.of(saved.getCityId());
    }
}
