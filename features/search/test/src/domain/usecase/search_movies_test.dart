import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/src/domain/entities/movie.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/domain/errors/failures.dart';
import 'package:search/src/domain/repositories/search_movie_repository_interface.dart';
import 'package:search/src/domain/usecase/search_movies.dart';

class SearchMovieRepositoryMock extends Mock
    implements SearchMovieRepositoryContract {}

const searchMovie = Movie(
  imdbId: 'imdbId',
  title: 'title',
  year: 'year',
  type: 'type',
  poster: 'poster',
);

const resultSearch = ResultSearch(
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
      expect(result.fold((l) => l, (r) => r), isA<ResultSearch>());
      expect(result.fold((l) => l, (r) => r.search), isA<List<Movie>>());
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
      expect(result.fold((l) => l, (r) => r), isA<ResultSearch>());
      expect(result.fold((l) => l, (r) => r.search), isA<List<Movie>>());
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
