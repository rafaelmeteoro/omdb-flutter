import '../../../../core/typedef/signatures.dart';

abstract class FavoriteMovieStorageRepository {
  Future<ResultFavorites> getFavorites();
}
