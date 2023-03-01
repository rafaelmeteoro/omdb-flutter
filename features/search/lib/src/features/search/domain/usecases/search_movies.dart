import '../../../../core/errors/failure.dart';
import '../../../../core/typedef/signatures.dart';
import '../interfaces/search_movie_repository.dart';
import '../interfaces/search_movie_use_case.dart';

class SearchMovie implements SearchMovieUseCase {
  SearchMovie({
    required SearchMovieRepository repository,
  }) : _repository = repository;

  final SearchMovieRepository _repository;

  @override
  Future<ResultSearch> call({required String query}) async {
    final isShortQuery = query.replaceAll(' ', '').length < 3;
    if (isShortQuery) {
      return ResultSearch.left(
        const ShortTitleFailure(
          message: 'Search title must be more than 3 characters.',
        ),
      );
    }

    return _repository.call(title: query);
  }
}
