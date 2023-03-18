import 'package:app_core/app_core.dart';

class MovieDetailFailure extends Failure {
  const MovieDetailFailure({String? message}) : super(message);
}

class MovieContainsStorageFailure extends Failure {
  const MovieContainsStorageFailure({String? message}) : super(message);
}

class MovieAddRemoveStorageFailure extends Failure {
  const MovieAddRemoveStorageFailure({String? message}) : super(message);
}
