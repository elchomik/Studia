import 'package:dartz/dartz.dart';
import 'package:vs_code_app/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(str) {
    try {
      final result = int.parse(str);
      if (result < 0) {
        throw FormatException();
      }
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
