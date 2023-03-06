import 'package:words_storage_manager/words_storage_manager.dart';

import '../../../core/errors/failure.dart';
import '../../../core/typedef/signatures.dart';
import '../domain/interfaces/words_storage_repository.dart';

class LocalWordsStorageRepository implements WordsStorageRepository {
  LocalWordsStorageRepository({
    required WordsStorage storage,
  }) : _storage = storage;

  final WordsStorage _storage;

  @override
  Future<ResultGetWordsStorage> getWords() async {
    try {
      final result = await _storage.read('words_of_search');
      return ResultGetWordsStorage.right(result);
    } catch (e) {
      return ResultGetWordsStorage.left(
        WordsGetStorageFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<ResultDeleteWordsStorage> deleteWord(String value) async {
    try {
      final result = await _storage.delete('words_of_search', value);
      return ResultDeleteWordsStorage.right(result);
    } catch (e) {
      return ResultDeleteWordsStorage.left(
        WordsDeleteStorageFailure(message: e.toString()),
      );
    }
  }
}
