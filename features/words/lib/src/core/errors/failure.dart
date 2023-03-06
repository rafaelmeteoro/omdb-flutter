import 'package:app_core/app_core.dart';

class WordsGetStorageFailure extends Failure {
  const WordsGetStorageFailure({String? message}) : super(message);
}

class WordsDeleteStorageFailure extends Failure {
  const WordsDeleteStorageFailure({String? message}) : super(message);
}
