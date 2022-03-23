import 'package:dartz/dartz.dart';
import 'package:firebase_flutter_ddd/domain/core/failures.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'errors.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  T getOrCrash() => value.fold((l) => throw UnexpectedValueError(l), id);

  bool isValid() => value.isRight();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}
