import 'package:flutter_test/flutter_test.dart';
import 'package:injectable_package/domain/i_counter_repository.dart';
import 'package:injectable_package/infrastructure/mock_counter_repository.dart';
import 'package:injectable_package/injection.dart';
import 'package:mockito/mockito.dart';

void main() {
  setUpAll(() {
    configureInjection();
  });

  test('should do something', () async {
    // arrange
    final mockCounterRepository = getIt<ICounterRepository>();
    when(mockCounterRepository.getIncrement()).thenReturn(123);

    // act
    // assert
    verify(mockCounterRepository.getIncrement()).called(10);
  });
}
