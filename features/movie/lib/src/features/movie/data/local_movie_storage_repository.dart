import 'package:movie_storage_manager/movie_storage_manager.dart';

import '../../../core/errors/failure.dart';
import '../../../core/typedef/signatures.dart';
import '../domain/interfaces/movie_storage_repository.dart';

class LocalMovieStorageRepository implements MovieStorageRepository {
  LocalMovieStorageRepository({
    required MovieStorage storage,
  }) : _storage = storage;

  final MovieStorage _storage;

  @override
  Future<ResultContainsMovieStorage> contains({required String key}) async {
    try {
      final result = await _storage.containsKey(key);
      return ResultContainsMovieStorage.right(result);
    } catch (e) {
      return ResultContainsMovieStorage.left(
        MovieContainsStorageFailure(message: e.toString()),
      );
    }
  }
}
