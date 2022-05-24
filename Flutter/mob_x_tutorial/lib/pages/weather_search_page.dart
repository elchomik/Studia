import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mob_x_tutorial/data/model/weather.dart';
import 'package:mob_x_tutorial/state/weather_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage({Key? key}) : super(key: key);

  @override
  State<WeatherSearchPage> createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  WeatherStore? _weatherStore;

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  late final List<ReactionDisposer> _disposers;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _weatherStore = Provider.of<WeatherStore>(context);
    _disposers = [
      reaction((_) => _weatherStore!.errorMessage, (String? message) {
        _scaffoldKey.currentState?.showSnackBar(
          SnackBar(
            content: Text(message!),
          ),
        );
      })
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Search"),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Observer(builder: (_) {
            switch (_weatherStore!.state) {
              case StoreState.initial:
                return buildInitialInput();
              case StoreState.loading:
                return buildLoading();
              case StoreState.loaded:
                return builColumnWithData(_weatherStore?.weather);
            }
          })),
    );
  }

  Widget buildInitialInput() {
    return const Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Column builColumnWithData(Weather? weather) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text(
        weather!.cityName.toString(),
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w700,
        ),
      ),
      Text(
        "${weather.temperatureCelsius!.toStringAsFixed(1)} C",
        style: const TextStyle(fontSize: 80),
      ),
      const CityInputField(),
    ],
  );
}

class CityInputField extends StatelessWidget {
  const CityInputField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final weatherStore = Provider.of<WeatherStore>(context);
    weatherStore.getWeather(cityName);
  }
}
