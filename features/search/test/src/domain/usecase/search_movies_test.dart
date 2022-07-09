import 'package:dev_core/dev_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/errors/failures.dart';
import 'package:search/src/features/search/domain/repositories/search_movie_repository_interface.dart';
import 'package:search/src/features/search/domain/usecase/search_movies.dart';

class SearchMovieRepositoryMock extends Mock
    implements SearchMovieRepositoryContract {}

const searchMovie = MovieEntity(
  imdbId: 'imdbId',
  title: 'title',
  year: 'year',
  type: 'type',
  poster: 'poster',
);

const resultSearch = ResultSearchEntity(
  search: [searchMovie],
  totalResults: '0',
  response: 'True',
);

void main() {
  late SearchMovieRepositoryContract searchRepository;
  late SearchMoviesUseCaseContract searchMoviesUseCase;

  setUp(() {
    searchRepository = SearchMovieRepositoryMock();
    searchMoviesUseCase = SearchMoviesUseCase(
      searchRepository: searchRepository,
    );
  });

  group('Search Movies UseCase', () {
    test(
        'should return ResultSearch when execute to repository is successfull and when query.lenght > 3',
        () async {
      // Arrange
      const String query = 'anything ore than 3 characters';
      when(() => searchRepository.searchMovies(title: query))
          .thenAnswer((_) async => right(resultSearch));

      // Act
      final result = await searchMoviesUseCase.execute(query: query);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<ResultSearchEntity>());
      expect(result.fold((l) => l, (r) => r.search), isA<List<MovieEntity>>());
      verify(() => searchRepository.searchMovies(title: query)).called(1);
      verifyNoMoreInteractions(searchRepository);
    });

    test(
        'should return ResultSearch when execute to repository is successfull and when query.lenght = 3',
        () async {
      // Arrange
      const String query = '123';
      when(() => searchRepository.searchMovies(title: query))
          .thenAnswer((_) async => right(resultSearch));

      // Act
      final result = await searchMoviesUseCase.execute(query: query);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<ResultSearchEntity>());
      expect(result.fold((l) => l, (r) => r.search), isA<List<MovieEntity>>());
      verify(() => searchRepository.searchMovies(title: query)).called(1);
      verifyNoMoreInteractions(searchRepository);
    });

    test('should return SearchShortTitleFailure when query.lenght < 3',
        () async {
      // Arrange
      const String query = '12';

      // Act
      final result = await searchMoviesUseCase.execute(query: query);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<SearchShortTitleFailure>());
      verifyNever(() => searchRepository.searchMovies(title: query));
      verifyNoMoreInteractions(searchRepository);
    });

    test(
        'should return SearchShortTitleFailure when query.lenght without witespaces < 3',
        () async {
      // Arrange
      const String query = ' 1 2 ';

      // Act
      final result = await searchMoviesUseCase.execute(query: query);

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<SearchShortTitleFailure>());
      verifyNever(() => searchRepository.searchMovies(title: query));
      verifyNoMoreInteractions(searchRepository);
    });
  });
}
