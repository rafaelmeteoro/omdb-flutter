import '../../../../core/typedef/signatures.dart';
import '../interfaces/delete_words_storage_use_case.dart';
import '../interfaces/words_storage_repository.dart';

class DeleteWords implements DeleteWordsStorageUseCase {
  DeleteWords({
    required WordsStorageRepository repository,
  }) : _repository = repository;

  final WordsStorageRepository _repository;

  @override
  Future<ResultDeleteWordsStorage> call({required String value}) async {
    return _repository.deleteWord(value: value);
  }
}
