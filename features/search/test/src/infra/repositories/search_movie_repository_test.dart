import 'package:core/exceptions/exceptions.dart';
import 'package:dev_core/dev_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/errors/failures.dart';
import 'package:search/src/features/search/domain/repositories/search_movie_repository_interface.dart';
import 'package:search/src/features/search/infra/datasource/search_remote_datasource_interface.dart';
import 'package:search/src/features/search/infra/repositories/search_movie_repository.dart';

class SearchRemoteDataSourceMock extends Mock
    implements SearchRemoteDataSourceContract {}

const movieMock = MovieEntity(
  imdbId: 'imdbId',
  title: 'title',
  year: 'year',
  type: 'type',
  poster: 'poster',
);

const resultSearchMock = ResultSearchEntity(
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
        isA<ResultSearchEntity>(),
      );
      expect(
        result.fold((left) => left, (right) => right.search),
        isA<List<MovieEntity>>(),
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
