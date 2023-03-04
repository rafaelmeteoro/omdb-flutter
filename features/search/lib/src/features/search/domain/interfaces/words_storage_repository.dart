import '../../../../core/typedef/signatures.dart';

abstract class WordsStorageRepository {
  Future<ResultWordsStorage> call({
    required String word,
  });
}
