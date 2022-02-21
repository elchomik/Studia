
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vs_code_app/core/network/network_info.dart';

class MockDataConnectionChecker extends Mock implements DataConnectionChecker{}

void main(){

  late NetworkInfoImpl networkInfo;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp((){
    mockDataConnectionChecker=MockDataConnectionChecker();
    networkInfo=NetworkInfoImpl(mockDataConnectionChecker);
  });

  group('isConnected',(){
    test('should forward the call to DataConnectionChecker.hasConnection',() async{

      //arrange
      final tHasConnectionFuture=Future.value(true);

      when(mockDataConnectionChecker.hasConnection).thenAnswer((_) => tHasConnectionFuture);
      final result=networkInfo.isConnected;

      //assert
      verify(mockDataConnectionChecker.hasConnection);
      expect(result,tHasConnectionFuture);
    });
  });

}