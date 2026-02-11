import 'package:dartz/dartz.dart';

// Base class for failures
abstract class Failure {
  final String message;
  const Failure(this.message);
}

// Storage failures
class StorageFailure extends Failure {
  const StorageFailure(super.message);
}

// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

// Generic type alias for results
typedef Result<T> = Either<Failure, T>;
