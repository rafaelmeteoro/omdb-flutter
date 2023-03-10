import '../../../../core/typedef/signatures.dart';
import '../entities/movie_detail_entity.dart';

abstract class RemoveMovieStorageUseCase {
  Future<ResultAddRemoveMovieStorage> call({
    required MovieDetailEntity movie,
  });
}
