import 'package:app_core/failures.dart';

abstract class SearchFailure extends Failure {
  const SearchFailure({
    required String message,
  }) : super(message);
}

class SearchShortTitleFailure extends SearchFailure {
  const SearchShortTitleFailure({
    required String message,
  }) : super(message: message);
}

class SearchDataSourceFailure extends SearchFailure {
  const SearchDataSourceFailure({
    required String message,
  }) : super(message: message);
}

class SearchParseFailure extends SearchFailure {
  const SearchParseFailure({
    required String message,
  }) : super(message: message);
}

class SearchUnknownFailure extends SearchFailure {
  const SearchUnknownFailure({
    required String message,
  }) : super(message: message);
}
