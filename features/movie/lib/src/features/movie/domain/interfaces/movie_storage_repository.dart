import '../../../../core/typedef/signatures.dart';
import '../entities/movie_detail_entity.dart';

abstract class MovieStorageRepository {
  Future<ResultContainsMovieStorage> contains({
    required String key,
  });
  Future<ResultAddRemoveMovieStorage> addMovie({
    required MovieDetailEntity movie,
  });
  Future<ResultAddRemoveMovieStorage> removeMovie({
    required MovieDetailEntity movie,
  });
}
