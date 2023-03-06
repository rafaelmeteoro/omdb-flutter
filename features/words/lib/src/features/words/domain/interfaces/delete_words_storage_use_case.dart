import '../../../../core/typedef/signatures.dart';

abstract class DeleteWordsStorageUseCase {
  Future<ResultDeleteWordsStorage> call({
    required String value,
  });
}
