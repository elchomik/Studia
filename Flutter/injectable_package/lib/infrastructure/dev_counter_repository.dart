import 'package:injectable/injectable.dart';
import 'package:injectable_package/domain/i_counter_repository.dart';

import '../injection.dart';

//@Environment(Env.dev)
@Named('Developer')
@Injectable(as: ICounterRepository)
class DevCounterRepository extends ICounterRepository {
  @override
  int getIncrement() => 2;
}
