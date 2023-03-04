import '../../../../core/typedef/signatures.dart';

abstract class WordsStorageUseCase {
  Future<ResultWordsStorage> call({
    required String query,
  });
}
