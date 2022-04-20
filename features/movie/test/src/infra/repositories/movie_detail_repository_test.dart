import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/domain/entities/rating.dart';
import 'package:movie/src/domain/errors/failures.dart';
import 'package:movie/src/domain/repositories/movie_detail_repository_interface.dart';
import 'package:movie/src/infra/datasource/movie_detail_remote_datasource_interface.dart';
import 'package:movie/src/infra/repositories/movie_detail_repository.dart';

class MovieDetailRemoteDataSourceMock extends Mock
    implements MovieDetailRemoteDataSourceContract {}

const ratings = [
  Rating(
    source: 'source',
    value: 'value',
  )
];

const movieDetail = MovieDetail(
  title: 'title',
  year: 'year',
  rated: 'rated',
  released: 'released',
  runtime: 'runtime',
  genre: ['genre'],
  director: ['director'],
  writer: ['writer'],
  actors: ['actors'],
  plot: 'plot',
  language: ['language'],
  country: ['country'],
  awards: 'awards',
  poster: 'poster',
  metascore: 'metascore',
  imdbRating: 'imdbRating',
  imdbVotes: 'imdbVotes',
  imdbId: 'imdbId',
  type: 'type',
  dvd: 'dvd',
  boxOffice: 'boxOffice',
  ratings: ratings,
);

void main() {
  late MovieDetailRemoteDataSourceContract remoteDataSource;
  late MovieDetailRepositoryContract movieDetailRepository;

  setUp(() {
    remoteDataSource = MovieDetailRemoteDataSourceMock();
    movieDetailRepository = MovieDetailRepository(
      remoteDataSource: remoteDataSource,
    );
  });

  group('MovieDetail Remote DataSource', () {
    test(
        'should return movie detail when call remote datasource is successfull',
        () async {
      // Arrange
      when(() => remoteDataSource.getMovieDetail(id: any(named: 'id')))
          .thenAnswer(
        (_) async => movieDetail,
      );

      // Act
      final result = await movieDetailRepository.getMovieDetail(id: 'id');

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<MovieDetail>());
      expect(result.fold((l) => l, (r) => r.ratings), isA<List<Rating>>());
      expect(result.fold((l) => l, (r) => r), equals(movieDetail));
      verify(() => remoteDataSource.getMovieDetail(id: any(named: 'id')));
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
        'should return MovieDataSourceFailure when throws a subclass of CustomException',
        () async {
      // Arrange
      when(() => remoteDataSource.getMovieDetail(id: any(named: 'id')))
          .thenThrow(DataSourceException(message: ''));

      // Act
      final result = await movieDetailRepository.getMovieDetail(id: 'id');

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<MovieDataSourceFailure>());
      verify(() => remoteDataSource.getMovieDetail(id: any(named: 'id')));
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return MovieParseFailure when throws a TypeError', () async {
      // Arrange
      when(() => remoteDataSource.getMovieDetail(id: any(named: 'id')))
          .thenThrow(TypeError());

      // Act
      final result = await movieDetailRepository.getMovieDetail(id: 'id');

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<MovieParseFailure>());
      verify(() => remoteDataSource.getMovieDetail(id: any(named: 'id')));
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return MovieParseFailure when throws a FormatException',
        () async {
      // Arrange
      when(() => remoteDataSource.getMovieDetail(id: any(named: 'id')))
          .thenThrow(const FormatException());

      // Act
      final result = await movieDetailRepository.getMovieDetail(id: 'id');

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<MovieParseFailure>());
      verify(() => remoteDataSource.getMovieDetail(id: any(named: 'id')));
      verifyNoMoreInteractions(remoteDataSource);
    });

    test('should return MovieUnknowFailure when throws a Exception', () async {
      // Arrange
      when(() => remoteDataSource.getMovieDetail(id: any(named: 'id')))
          .thenThrow(Exception());

      // Act
      final result = await movieDetailRepository.getMovieDetail(id: 'id');

      // Assert
      expect(result.fold((l) => l, (r) => r), isA<MovieUnknownFailure>());
      verify(() => remoteDataSource.getMovieDetail(id: any(named: 'id')));
      verifyNoMoreInteractions(remoteDataSource);
    });
  });
}
