import '../../../../core/typedef/signatures.dart';
import '../entities/movie_detail_entity.dart';
import '../interfaces/contains_movie_storage_use_case.dart';
import '../interfaces/movie_storage_repository.dart';

class ContainsMovie implements ContainsMovieStorageUseCase {
  ContainsMovie({
    required MovieStorageRepository repository,
  }) : _repository = repository;

  final MovieStorageRepository _repository;

  @override
  Future<ResultContainsMovieStorage> call({required MovieDetailEntity movie}) {
    return _repository.contains(key: movie.imdbId);
  }
}
