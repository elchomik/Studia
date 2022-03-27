import 'package:injectable/injectable.dart';
import 'package:injectable_package/domain/i_counter_repository.dart';
import 'package:mockito/mockito.dart';

@Named('test')
@Injectable(as: ICounterRepository, env: [Environment.test])
class MockCounterRepository extends Mock implements ICounterRepository {}
