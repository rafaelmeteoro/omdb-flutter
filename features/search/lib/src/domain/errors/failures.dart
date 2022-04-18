import 'package:core/failures/failures.dart';

abstract class SearchFailure extends Failure {
  SearchFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}

class SearchShortTitleFailure extends SearchFailure {
  SearchShortTitleFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}

class SearchDataSourceFailure extends SearchFailure {
  SearchDataSourceFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}

class SearchParseFailure extends SearchFailure {
  SearchParseFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}

class SearchUnknownFailure extends SearchFailure {
  SearchUnknownFailure({
    required String message,
    StackTrace? stackTrace,
    String? label,
  }) : super(
          message: message,
          stackTrace: stackTrace,
          label: label,
        );
}
