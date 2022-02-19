


import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vs_code_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:vs_code_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository{}


void main(){

  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp((){
    mockNumberTriviaRepository=MockNumberTriviaRepository();
    usecase=GetConceteNumberTriviaRepository(mockNumberTriviaRepository);
  });

  final tNumber=1;
  final tNumberTrivia=NumberTrivia(text: 'test', number: 1);
  test('should get trivia for the number from the repository',() async{

    final result=await usecase.execute(number:tNumberTrivia);

    expect(result,Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });

}