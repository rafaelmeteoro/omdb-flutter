import '../../../../core/typedef/signatures.dart';
import '../interfaces/favorite_movie_storage_repository.dart';
import '../interfaces/get_movies_use_case.dart';

class GetMovies implements GetMoviesUseCase {
  GetMovies({
    required FavoriteMovieStorageRepository repository,
  }) : _repository = repository;

  final FavoriteMovieStorageRepository _repository;

  @override
  Future<ResultFavorites> call() async {
    return _repository.getFavorites();
  }
}
