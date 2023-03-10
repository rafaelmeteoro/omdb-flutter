import '../../../../core/typedef/signatures.dart';
import '../entities/movie_detail_entity.dart';
import '../interfaces/add_remove_movie_storage_use_case.dart';
import '../interfaces/movie_storage_repository.dart';

class AddRemoveMovie implements AddRemoveMovieStorageUseCase {
  AddRemoveMovie({
    required MovieStorageRepository repository,
  }) : _repository = repository;

  final MovieStorageRepository _repository;

  @override
  Future<ResultAddRemoveMovieStorage> call({required MovieDetailEntity movie}) async {
    final contains = await _repository.contains(key: movie.imdbId);
    final isFavorited = contains.fold((failure) => false, (value) => value);

    if (isFavorited) {
      return _repository.removeMovie(movie: movie);
    } else {
      return _repository.addMovie(movie: movie);
    }
  }
}
