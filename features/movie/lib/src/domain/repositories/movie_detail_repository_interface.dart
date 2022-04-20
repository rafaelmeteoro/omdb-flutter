import 'package:core/core.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/domain/errors/failures.dart';

abstract class MovieDetailRepositoryContract {
  Future<Either<MovieFailure, MovieDetail>> getMovieDetail({
    required String id,
  });
}
