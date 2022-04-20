import 'package:movie/src/domain/entities/movie_detail.dart';

abstract class MovieDetailRemoteDataSourceContract {
  Future<MovieDetail> getMovieDetail({required String id});
}
