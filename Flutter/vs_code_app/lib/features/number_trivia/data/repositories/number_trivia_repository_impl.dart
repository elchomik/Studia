import 'package:dartz/dartz.dart';
import 'package:vs_code_app/core/error/exception.dart';
import 'package:vs_code_app/core/error/failures.dart';
import 'package:vs_code_app/core/network/network_info.dart';
import 'package:vs_code_app/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:vs_code_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:vs_code_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:vs_code_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:vs_code_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef Future<NumberTriviaModel> _ConcreteOrRandomChooser();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return await _getTrivia(
        () => remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(() => remoteDataSource.getRandomTrivia());
  }

  Future<Either<Failure, NumberTriviaModel>> _getTrivia(
      _ConcreteOrRandomChooser getConcreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        localDataSource.cacheNumberTrivia(localTrivia!);
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
