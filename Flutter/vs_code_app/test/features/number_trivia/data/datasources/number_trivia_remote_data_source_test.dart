import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:vs_code_app/core/error/exception.dart';
import 'package:vs_code_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:vs_code_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:vs_code_app/fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'should perform a GET request on a URL with number being the endpoint and with application/json header',
        () {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      dataSource.getConcreteNumberTrivia(tNumber);

      //assert
      verify(mockHttpClient.get('http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'}));
    });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      //assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      setUpMockHttpClientFailure404();

      //act
      final call = dataSource.getConcreteNumberTrivia;

      //assert
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia',(){
    final tNumberTriviaModel=NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('should perform a GET request on a URL with *ranodm* endopoint with application/json header',
        (){
      //arrange
          setUpMockHttpClientSuccess200();
          //act
          dataSource.getRandomTrivia();
          // assert
          verify(mockHttpClient.get('http://numbersapi.com/random',headers: {'Content-Type':'application/json'}));
        });

    test('should return NumberTrivia when the response code is 200 (success)',
        () async{
          //arrange
          setUpMockHttpClientSuccess200();

          //act
          final result=await dataSource.getRandomTrivia();

          //assert
          expect(result,equals(tNumberTriviaModel));
        });

    test('should throw a ServerException when the response code is 404 or other',() async{
      //arrange
      setUpMockHttpClientFailure404();

      //act
      final call=dataSource.getRandomTrivia;

      //assert
      expect(()=>call(),throwsA(TypeMatcher<ServerException>()));
    });
  });


}
