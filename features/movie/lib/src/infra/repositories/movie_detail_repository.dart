import 'package:core/core.dart';
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
    } on CustomException catch (error, stackTrace) {
      return left(
        MovieDataSourceFailure(
            message: error.message,
            stackTrace: stackTrace,
            label:
                'MovieDetailRepository: getMovideDetail() - MovieDetailSourceFailure'),
      );
    } on TypeError catch (error, stackTrace) {
      return left(
        MovieParseFailure(
            message: 'Erro inesperado. Por favor tente novamente.',
            stackTrace: stackTrace,
            label:
                'MovieDetailRepository: getMovideDetail() - MovieParseFailure'),
      );
    } on FormatException catch (error, stackTrace) {
      return left(
        MovieParseFailure(
            message: 'Erro inesperado. Por favor tente novamente.',
            stackTrace: stackTrace,
            label:
                'MovieDetailRepository: getMovideDetail() - MovieParseFailure'),
      );
    } catch (error, stackTrace) {
      return left(
        MovieUnknownFailure(
            message: 'Erro inesperado. Por favor tente novamente.',
            stackTrace: stackTrace,
            label:
                'MovieDetailRepository: getMovideDetail() - MovieUnknownFailure'),
      );
    }
  }
}
