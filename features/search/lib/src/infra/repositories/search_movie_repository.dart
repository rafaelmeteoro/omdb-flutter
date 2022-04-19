import 'package:core/core.dart';
import 'package:search/src/domain/errors/failures.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/domain/repositories/search_movie_repository_interface.dart';
import 'package:search/src/infra/datasource/search_remote_datasource_interface.dart';

class SearchMovieRepository implements SearchMovieRepositoryContract {
  final SearchRemoteDataSourceContract _remoteDataSource;

  SearchMovieRepository({
    required SearchRemoteDataSourceContract remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<SearchFailure, ResultSearch>> searchMovies({
    required String title,
  }) async {
    try {
      final result = await _remoteDataSource.searchMovies(title: title);
      return Right(result);
    } on CustomException catch (error, stackTrace) {
      return Left(
        SearchDataSourceFailure(
          message: error.message,
          stackTrace: stackTrace,
          label:
              'SearchMovieRepository: searchMovies() - SearchDataSourceFailure',
        ),
      );
    } on TypeError catch (error, stackTrace) {
      return Left(
        SearchParseFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
          stackTrace: stackTrace,
          label: 'SearchMovieRepository: searchMovies() - SearchParseFailure',
        ),
      );
    } on FormatException catch (error, stackTrace) {
      return Left(
        SearchParseFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
          stackTrace: stackTrace,
          label: 'SearchMovieRepository: searchMovies() - SearchParseFailure',
        ),
      );
    } catch (error, stackTrace) {
      return Left(
        SearchUnknownFailure(
          message: 'Error inesperado. Por favor tente novamente',
          stackTrace: stackTrace,
          label: 'SearchMovieRepository: searchMovies() - SearchUnknownFailure',
        ),
      );
    }
  }
}
