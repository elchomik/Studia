package com.example.testcontainers.enitities;


import com.example.testcontainers.controllers.CountryDTO;
import jakarta.persistence.*;

import java.util.Set;

@Entity
@Table
public class Country {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long countryId;

    private String name;

    private String code;

    @OneToMany(mappedBy = "country")
    private Set<City> cities;

    public Country() {
    }

    private Country(String name, String code) {
        this.name = name;
        this.code = code;
    }

    public static Country of(CountryDTO countryDTO) {
        return new Country(countryDTO.name(), countryDTO.code());
    }

    public Long getCountryId() {
        return countryId;
    }

    public String getName() {
        return name;
    }

    public String getCode() {
        return code;
    }
}
