import 'package:app_core/app_core.dart';

class ResultSearchFailure extends Failure {
  const ResultSearchFailure({String? message}) : super(message);
}

class ShortTitleFailure extends Failure {
  const ShortTitleFailure({String? message}) : super(message);
}

class WordsStorageFailure extends Failure {
  const WordsStorageFailure({String? message}) : super(message);
}
