import '../../../../core/typedef/signatures.dart';
import '../entities/movie_detail_entity.dart';
import '../interfaces/add_movie_storage_use_case.dart';
import '../interfaces/movie_storage_repository.dart';

class AddMovie implements AddMovieStorageUseCase {
  AddMovie({
    required MovieStorageRepository repository,
  }) : _repository = repository;

  final MovieStorageRepository _repository;

  @override
  Future<ResultAddRemoveMovieStorage> call({required MovieDetailEntity movie}) async {
    return _repository.addMovie(movie: movie);
  }
}
