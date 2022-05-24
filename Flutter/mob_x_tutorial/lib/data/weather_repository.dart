import 'dart:math';

import 'package:mob_x_tutorial/data/model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository implements WeatherRepository {
  double? cachedTempCelsius;

  @override
  Future<Weather> fetchWeather(String cityName) {
    return Future.delayed(Duration(seconds: 1), () {
      final random = Random();

      if (random.nextBool()) {
        throw NetworkError();
      }

      cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

      return Weather(cityName: cityName, temperatureCelsius: cachedTempCelsius);
    });
  }
}

class NetworkError extends Error {}
