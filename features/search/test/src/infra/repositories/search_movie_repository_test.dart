import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/src/domain/entities/movie.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/domain/errors/failures.dart';
import 'package:search/src/domain/repositories/search_movie_repository_interface.dart';
import 'package:search/src/infra/datasource/search_remote_datasource_interface.dart';
import 'package:search/src/infra/repositories/search_movie_repository.dart';

class SearchRemoteDataSourceMock extends Mock
    implements SearchRemoteDataSourceContract {}

const movieMock = Movie(
  imdbId: 'imdbId',
  title: 'title',
  year: 'year',
  type: 'type',
  poster: 'poster',
);

const resultSearchMock = ResultSearch(
  search: [movieMock],
  totalResults: '0',
  response: 'True',
);

void main() {
  late SearchRemoteDataSourceContract remoteDataSource;
  late SearchMovieRepositoryContract searchRepository;

  setUp(() {
    remoteDataSource = SearchRemoteDataSourceMock();
    searchRepository = SearchMovieRepository(
      remoteDataSource: remoteDataSource,
    );
  });

  group('Search Movies Remote DataSource', () {
    test(
        'should return result search when call remote datasource is successfull',
        () async {
      // Arrange
      when(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .thenAnswer(
        (_) async => resultSearchMock,
      );

      // Act
      final result = await searchRepository.searchMovies(title: 'text');

      // Assert
      expect(
        result.fold((left) => left, (right) => right),
        isA<ResultSearch>(),
      );
      expect(
        result.fold((left) => left, (right) => right.search),
        isA<List<Movie>>(),
      );
      verify(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return SearchDataSourceFailure when throws a subclass of CustomException',
        () async {
      // Arrange
      when(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .thenThrow(DataSourceException(message: ''));

      // Act
      final result = await searchRepository.searchMovies(title: 'text');

      // Assert
      expect(
        result.fold((left) => left, (right) => right),
        isA<SearchDataSourceFailure>(),
      );
      verify(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return SearchParseFailure when throws a TypeError', () async {
      // Arrange
      when(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .thenThrow(TypeError());

      // Act
      final result = await searchRepository.searchMovies(title: 'text');

      // Assert
      expect(
        result.fold((left) => left, (right) => right),
        isA<SearchParseFailure>(),
      );
      verify(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return SearchParseFailure when throws a FormatException',
        () async {
      // Arrange
      when(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .thenThrow(const FormatException());

      // Act
      final result = await searchRepository.searchMovies(title: 'text');

      // Assert
      expect(
        result.fold((left) => left, (right) => right),
        isA<SearchParseFailure>(),
      );
      verify(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return SearchUnkndownFailure when throws a Exception',
        () async {
      // Arrange
      when(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .thenThrow(Exception());

      // Act
      final result = await searchRepository.searchMovies(title: 'text');

      // Assert
      expect(
        result.fold((left) => left, (right) => right),
        isA<SearchUnknownFailure>(),
      );
      verify(() => remoteDataSource.searchMovies(title: any(named: 'title')))
          .called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
