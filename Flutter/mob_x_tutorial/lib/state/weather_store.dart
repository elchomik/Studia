import 'package:mob_x_tutorial/data/model/weather.dart';
import 'package:mob_x_tutorial/data/weather_repository.dart';
import 'package:mobx/mobx.dart';

part 'weather_store.g.dart';

class WeatherStore extends _WeatherStore with _$WeatherStore {
  WeatherStore(WeatherRepository weatherRepository) : super(weatherRepository);
}

enum StoreState { initial, loading, loaded }

abstract class _WeatherStore with Store {
  final WeatherRepository _weatherRepository;

  _WeatherStore(this._weatherRepository);

  @observable
  ObservableFuture<Weather>? _weatherFuture;

  @observable
  Weather? weather;

  @observable
  String? errorMessage;

  @computed
  StoreState get state {
    if (_weatherFuture!.status == FutureStatus.rejected) {
      return StoreState.initial;
    }
    return _weatherFuture!.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future<void> getWeather(String cityName) async {
    try {
      errorMessage = "";
      _weatherFuture =
          ObservableFuture(_weatherRepository.fetchWeather(cityName));
      weather = await _weatherFuture;
    } on NetworkError {
      errorMessage = "Couldn't fetch weather. Is the device online";
    }
  }
}
