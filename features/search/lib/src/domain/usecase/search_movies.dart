import 'package:core/domain.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/domain/errors/failures.dart';
import 'package:search/src/domain/repositories/search_movie_repository_interface.dart';

abstract class SearchMoviesUseCaseContract {
  Future<Either<SearchFailure, ResultSearch>> execute({required String query});
}

class SearchMoviesUseCase implements SearchMoviesUseCaseContract {
  final SearchMovieRepositoryContract _searchRepository;

  SearchMoviesUseCase({
    required SearchMovieRepositoryContract searchRepository,
  }) : _searchRepository = searchRepository;

  @override
  Future<Either<SearchFailure, ResultSearch>> execute({
    required String query,
  }) async {
    final bool isShortQuery = query.replaceAll(' ', '').length < 3;
    if (isShortQuery) {
      return left(SearchShortTitleFailure(
        message: 'Search title must be more than 3 characters.',
      ));
    }
    return await _searchRepository.searchMovies(title: query);
  }
}
