import 'package:core/domain.dart';
import 'package:movie/src/domain/errors/failures.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/domain/repositories/movie_detail_repository_interface.dart';
import 'package:movie/src/infra/datasource/movie_detail_remote_datasource_interface.dart';

class MovieDetailRepository implements MovieDetailRepositoryContract {
  final MovieDetailRemoteDataSourceContract _remoteDataSource;

  MovieDetailRepository({
    required MovieDetailRemoteDataSourceContract remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<MovieFailure, MovieDetail>> getMovieDetail({
    required String id,
  }) async {
    try {
      final result = await _remoteDataSource.getMovieDetail(id: id);
      return right(result);
    } on CustomException catch (error) {
      return left(
        MovieDataSourceFailure(message: error.message),
      );
    } on TypeError {
      return left(
        const MovieParseFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
        ),
      );
    } on FormatException {
      return left(
        const MovieParseFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
        ),
      );
    } catch (error) {
      return left(
        const MovieUnknownFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
        ),
      );
    }
  }
}
