package com.example.testcontainers.third_approach;

import com.example.testcontainers.controllers.CityDTO;
import com.example.testcontainers.controllers.CountryDTO;
import com.example.testcontainers.enitities.City;
import com.example.testcontainers.enitities.Status;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.Objects;

import static org.assertj.core.api.Assertions.assertThat;

class CityIntegrationTest extends DefaultContainerConfigurationIT {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;


    @Test
    void addCity_shouldPass() {
        CountryDTO country = new CountryDTO("Poland", "POL");
        ResponseEntity<Long> countryResponse = restTemplate.postForEntity(getBaseUrl(), country, Long.class);

        assertThat(countryResponse.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(countryResponse.getBody()).isEqualTo(2L);
        CityDTO cityToAdd = new CityDTO("Lublin", Status.ACTIVE, countryResponse.getBody());

        ResponseEntity<Long> cityResponse = restTemplate.postForEntity(getCityBaseUrl(), cityToAdd, Long.class);
        assertThat(cityResponse.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(cityResponse.getBody()).isEqualTo(2L);
    }

    @Test
    void addCity_shouldFailed_countryDoesNotExists() {
        CityDTO cityToAdd = new CityDTO("Poznań", Status.INACTIVE, 2L);
        ResponseEntity<Long> cityResponse = restTemplate.postForEntity(getCityBaseUrl(), cityToAdd, Long.class);

        assertThat(cityResponse.getStatusCode()).isEqualTo(HttpStatus.valueOf(404));
    }

    @Test
    void getCity_shouldPass() {
        ResponseEntity<City> cityResponse = restTemplate.getForEntity(getSingleCityUrl() + "/" + 2L, City.class);

        assertThat(cityResponse.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(Objects.requireNonNull(cityResponse.getBody()).getCityId()).isEqualTo(2);
        assertThat(Objects.requireNonNull(cityResponse.getBody().getAggregateStatus())).isEqualTo(Status.ACTIVE);
        assertThat(Objects.requireNonNull(cityResponse.getBody().getName())).isEqualTo("Lublin");
        assertThat(Objects.requireNonNull(cityResponse.getBody()).getCountry().getCode()).isEqualTo("POL");
        assertThat(Objects.requireNonNull(cityResponse.getBody()).getCountry().getName()).isEqualTo("Poland");
    }


    String getBaseUrl() {
        return "http://localhost:" + port + "/country/addCountry";
    }

    String getCityBaseUrl() {
        return "http://localhost:" + port + "/cities/addCity";
    }

    String getSingleCityUrl() {
        return "http://localhost:" + port + "/cities/getCity/";
    }
}
