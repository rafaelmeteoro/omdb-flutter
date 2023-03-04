import '../../../../core/typedef/signatures.dart';
import '../interfaces/words_storage_repository.dart';
import '../interfaces/words_storage_use_case.dart';

class SaveQuery implements WordsStorageUseCase {
  SaveQuery({
    required WordsStorageRepository repository,
  }) : _repository = repository;

  final WordsStorageRepository _repository;

  @override
  Future<ResultWordsStorage> call({required String query}) {
    return _repository.call(word: query);
  }
}
