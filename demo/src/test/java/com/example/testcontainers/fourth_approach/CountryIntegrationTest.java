package com.example.testcontainers.fourth_approach;

import com.example.testcontainers.controllers.CityDTO;
import com.example.testcontainers.controllers.CountryDTO;
import com.example.testcontainers.enitities.Country;
import com.example.testcontainers.enitities.Status;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import static org.assertj.core.api.Assertions.assertThat;

@IntegrationTestConfiguration
class CountryIntegrationTest {

    @LocalServerPort
    private int port;

    @Autowired
    private TestRestTemplate restTemplate;

    @Test
    void addCountry() {
        //GIVEN
        CountryDTO country = new CountryDTO("Poland", "POL");

        //WHEN
        ResponseEntity<Long> postResponse = restTemplate.postForEntity(getBaseUrl(), country, Long.class);
        Long countryId = postResponse.getBody();

        //THEN
        assertThat(postResponse.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(countryId).isNotNull();
        ResponseEntity<Country> getResponse = restTemplate.getForEntity(getForEntityUrl() + "/" + countryId, Country.class);
        assertThat(getResponse.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(getResponse.getBody()).isNotNull();
        assertThat(getResponse.getBody().getCountryId()).isEqualTo(1L);
        assertThat(getResponse.getBody().getCode()).isEqualTo("POL");
        assertThat(getResponse.getBody().getName()).isEqualTo("Poland");
    }

    @Test
    void addCity() {
        //GIVEN
        CityDTO warsaw = new CityDTO("Warsaw", Status.ACTIVE, 1L);

        //WHEN
        ResponseEntity<Long> cityAdded = restTemplate.postForEntity(getCityBaseUrl(), warsaw, Long.class);

        //THEN
        assertThat(cityAdded.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(cityAdded.getBody()).isEqualTo(1L);
    }


    String getBaseUrl() {
        return "http://localhost:" + port + "/country/addCountry";
    }

    String getForEntityUrl() {
        return "http://localhost:" + port + "/country/getCountry";
    }

    String getCityBaseUrl() {
        return "http://localhost:" + port + "/cities/addCity";
    }
}
