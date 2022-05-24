import 'package:flutter/material.dart';
import 'package:mob_x_tutorial/data/model/weather.dart';
import 'package:mob_x_tutorial/data/weather_repository.dart';
import 'package:mob_x_tutorial/pages/weather_search_page.dart';
import 'package:mob_x_tutorial/state/weather_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Material App",
      home: Provider(
          create: (_) => WeatherStore(FakeWeatherRepository()),
          child: const WeatherSearchPage()),
    );
  }
}
