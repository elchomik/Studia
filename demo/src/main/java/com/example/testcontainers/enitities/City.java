package com.example.testcontainers.enitities;

import com.example.testcontainers.controllers.CityDTO;
import jakarta.persistence.*;

@Entity
@Table
public class City {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long cityId;

    private String name;

    @Enumerated(EnumType.STRING)
    private Status aggregateStatus;

    @ManyToOne
    @JoinColumn(name = "country_id", nullable = false)
    private Country country;

    private City() {
    //to make testcontainers happy
    }

    private City(final String name, final Status aggregateStatus, final Country country) {
        this.name = name;
        this.aggregateStatus = aggregateStatus;
        this.country = country;
    }

    public static City of(final CityDTO cityDTO, final Country country) {
        return new City(cityDTO.name(), cityDTO.aggregateStatus(), country);
    }

    public Long getCityId() {
        return cityId;
    }

    public String getName() {
        return name;
    }

    public Status getAggregateStatus() {
        return aggregateStatus;
    }

    public Country getCountry() {
        return country;
    }
}
