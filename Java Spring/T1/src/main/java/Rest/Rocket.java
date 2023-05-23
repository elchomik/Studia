package Rest;

import java.util.Objects;

record Rocket(String rocketId, String rocketName, String country, String company, String rocketHeight, int stages,
              int rocketMass, int costPerLaunch, String firstFlight) {

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Rocket rocket = (Rocket) o;
        return stages == rocket.stages && rocketMass == rocket.rocketMass && costPerLaunch == rocket.costPerLaunch && Objects.equals(rocketId, rocket.rocketId) && Objects.equals(rocketName, rocket.rocketName) && Objects.equals(country, rocket.country) && Objects.equals(company, rocket.company) && Objects.equals(rocketHeight, rocket.rocketHeight) && Objects.equals(firstFlight, rocket.firstFlight);
    }

}
