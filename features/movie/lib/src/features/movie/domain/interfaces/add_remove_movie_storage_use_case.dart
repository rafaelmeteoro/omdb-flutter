import '../../../../core/typedef/signatures.dart';
import '../entities/movie_detail_entity.dart';

abstract class AddRemoveMovieStorageUseCase {
  Future<ResultAddRemoveMovieStorage> call({
    required MovieDetailEntity movie,
  });
}
