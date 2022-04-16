import 'package:omdb_flutter/app/core/failures.dart';

abstract class HomeFailure extends Failure {
  HomeFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}

class HomeShortTitleFailure extends HomeFailure {
  HomeShortTitleFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}
