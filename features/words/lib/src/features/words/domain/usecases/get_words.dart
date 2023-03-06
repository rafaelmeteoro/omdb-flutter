import '../../../../core/typedef/signatures.dart';
import '../interfaces/get_words_storage_use_case.dart';
import '../interfaces/words_storage_repository.dart';

class GetWords implements GetWordsStorageUseCase {
  GetWords({
    required WordsStorageRepository repository,
  }) : _repository = repository;

  final WordsStorageRepository _repository;

  @override
  Future<ResultGetWordsStorage> call() async {
    return _repository.getWords();
  }
}
