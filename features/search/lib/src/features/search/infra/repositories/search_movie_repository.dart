import 'package:core/domain.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/errors/failures.dart';
import 'package:search/src/features/search/domain/repositories/search_movie_repository_interface.dart';
import 'package:search/src/features/search/infra/datasource/search_remote_datasource_interface.dart';

class SearchMovieRepository implements SearchMovieRepositoryContract {
  final SearchRemoteDataSourceContract _remoteDataSource;

  SearchMovieRepository({
    required SearchRemoteDataSourceContract remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<SearchFailure, ResultSearchEntity>> searchMovies({
    required String title,
  }) async {
    try {
      final result = await _remoteDataSource.searchMovies(title: title);
      return right(result);
    } on CustomException catch (error) {
      return left(
        SearchDataSourceFailure(
          message: error.message,
        ),
      );
    } on TypeError {
      return left(
        const SearchParseFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
        ),
      );
    } on FormatException {
      return left(
        const SearchParseFailure(
          message: 'Erro inesperado. Por favor tente novamente.',
        ),
      );
    } catch (error) {
      return left(
        const SearchUnknownFailure(
          message: 'Error inesperado. Por favor tente novamente',
        ),
      );
    }
  }
}
