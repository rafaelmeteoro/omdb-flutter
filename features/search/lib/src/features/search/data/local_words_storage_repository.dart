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
  Future<ResultWordsStorage> call({required String word}) async {
    try {
      final result = await _storage.put('words_of_search', word);
      return ResultWordsStorage.right(result);
    } catch (e) {
      return ResultWordsStorage.left(
        WordsStorageFailure(message: e.toString()),
      );
    }
  }
}
