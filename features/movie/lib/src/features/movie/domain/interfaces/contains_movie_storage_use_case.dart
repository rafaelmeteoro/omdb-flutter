import '../../../../core/typedef/signatures.dart';
import '../entities/movie_detail_entity.dart';

abstract class ContainsMovieStorageUseCase {
  Future<ResultContainsMovieStorage> call({
    required MovieDetailEntity movie,
  });
}
