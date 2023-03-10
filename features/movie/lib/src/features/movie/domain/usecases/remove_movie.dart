import '../../../../core/typedef/signatures.dart';
import '../entities/movie_detail_entity.dart';
import '../interfaces/movie_storage_repository.dart';
import '../interfaces/remove_movie_storage_use_case.dart';

class RemoveMovie implements RemoveMovieStorageUseCase {
  RemoveMovie({
    required MovieStorageRepository repository,
  }) : _repository = repository;

  final MovieStorageRepository _repository;

  @override
  Future<ResultAddRemoveMovieStorage> call({required MovieDetailEntity movie}) async {
    return _repository.removeMovie(movie: movie);
  }
}
