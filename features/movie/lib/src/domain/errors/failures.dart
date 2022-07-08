import 'package:app_core/failures.dart';

abstract class MovieFailure extends Failure {
  const MovieFailure({
    required String message,
  }) : super(message);
}

class MovieDataSourceFailure extends MovieFailure {
  const MovieDataSourceFailure({
    required String message,
  }) : super(message: message);
}

class MovieParseFailure extends MovieFailure {
  const MovieParseFailure({
    required String message,
  }) : super(message: message);
}

class MovieUnknownFailure extends MovieFailure {
  const MovieUnknownFailure({
    required String message,
  }) : super(message: message);
}
