import 'package:movie_storage_manager/movie_storage_manager.dart';

import '../../../core/errors/failure.dart';
import '../../../core/typedef/signatures.dart';
import '../domain/entities/movie_detail_entity.dart';
import '../domain/interfaces/movie_storage_repository.dart';
import 'dto/movie_detail_dto.dart';

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

  @override
  Future<ResultAddRemoveMovieStorage> addMovie({required MovieDetailEntity movie}) async {
    try {
      final result = await _storage.put(
        movie.imdbId,
        MovieDetailDto.fromEntity(movie).toMap(),
      );
      return ResultAddRemoveMovieStorage.right(result);
    } catch (e) {
      return ResultAddRemoveMovieStorage.left(
        MovieAddRemoveStorageFailure(message: e.toString()),
      );
    }
  }

  @override
  Future<ResultAddRemoveMovieStorage> removeMovie({required MovieDetailEntity movie}) async {
    try {
      final result = await _storage.delete(movie.imdbId);
      return ResultAddRemoveMovieStorage.right(result);
    } catch (e) {
      return ResultAddRemoveMovieStorage.left(
        MovieAddRemoveStorageFailure(message: e.toString()),
      );
    }
  }
}
