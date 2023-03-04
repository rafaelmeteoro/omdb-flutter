import '../../../../core/typedef/signatures.dart';

abstract class WordsStorageRepository {
  Future<ResultGetWordsStorage> getWords();
}
