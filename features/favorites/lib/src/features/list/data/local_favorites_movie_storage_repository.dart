import 'package:app_core/app_core.dart';
import 'package:movie_storage_manager/movie_storage_manager.dart';

import '../../../core/errors/failure.dart';
import '../../../core/typedef/signatures.dart';
import '../domain/interfaces/favorite_movie_storage_repository.dart';
import 'dto/favorite_movie_dto.dart';

class LocalFavoritesMovieStorageRepository implements FavoriteMovieStorageRepository {
  LocalFavoritesMovieStorageRepository({
    required MovieStorage storage,
  }) : _storage = storage;

  final MovieStorage _storage;

  @override
  Future<ResultFavorites> getFavorites() async {
    try {
      final result = await _storage.readAll();
      final favorites =
          result.map(JsonFormat.from).map(FavoriteMovieDto.fromJson).toList();
      return ResultFavorites.right(favorites);
    } catch (e) {
      return ResultFavorites.left(FavoritesStorageFailure(message: e.toString()));
    }
  }
}
