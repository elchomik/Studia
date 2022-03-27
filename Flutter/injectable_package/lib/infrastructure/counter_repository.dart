import 'package:injectable/injectable.dart';
import 'package:injectable_package/domain/i_counter_repository.dart';

//@Environment(Env.prod)
@Named('production')
@Injectable(as: ICounterRepository)
class CounterRepository extends ICounterRepository {
  @override
  int getIncrement() => 1;
}
