// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'domain/i_counter_repository.dart' as _i3;
import 'infrastructure/counter_repository.dart' as _i4;
import 'infrastructure/dev_counter_repository.dart' as _i5;
import 'presentation/counter_change_notifier.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.factory<_i3.ICounterRepository>(() => _i4.CounterRepository(),
      instanceName: 'production');
  gh.factory<_i3.ICounterRepository>(() => _i5.DevCounterRepository(),
      instanceName: 'Developer');
  gh.factory<_i6.CounterChangeNotifier>(() => _i6.CounterChangeNotifier(
      get<_i3.ICounterRepository>(instanceName: 'production')));
  return get;
}
