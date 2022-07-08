import 'package:dev_core/dev_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/domain/entities/rating.dart';
import 'package:movie/src/domain/errors/failures.dart';
import 'package:movie/src/domain/repositories/movie_detail_repository_interface.dart';
import 'package:movie/src/domain/usecase/get_movie_detail.dart';

class MovieDetailRepositoryMock extends Mock
    implements MovieDetailRepositoryContract {}

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
  late MovieDetailRepositoryContract movieDetailRepository;
  late GetMovieDetailUseCaseContract getMovieDetailUseCase;

  setUp(() {
    movieDetailRepository = MovieDetailRepositoryMock();
    getMovieDetailUseCase = GetMovieDetailUseCase(
      movieDetailRepository: movieDetailRepository,
    );
  });

  group('Get MovieDetail UseCase', () {
    test('should return MovieDetail when execute to repository is successfull',
        () async {
      // Arrange
      const String id = 'abcdefg';
      when(() => movieDetailRepository.getMovieDetail(id: id))
          .thenAnswer((_) async => right(movieDetail));

      // Act
      final result = await getMovieDetailUseCase.execute(id: id);

      // Asert
      expect(result.fold((l) => l, (r) => r), isA<MovieDetail>());
      expect(result.fold((l) => l, (r) => r.ratings), isA<List<Rating>>());
      expect(result.fold((l) => l, (r) => r), equals(movieDetail));
      verify(() => movieDetailRepository.getMovieDetail(id: id)).called(1);
      verifyNoMoreInteractions(movieDetailRepository);
    });

    test(
        'should return MovieDataSourceFailure when execute to repository is MovieDataSourceFailure',
        () async {
      // Arrange
      const String id = 'abcdefg';
      when(() => movieDetailRepository.getMovieDetail(id: id)).thenAnswer(
          (_) async => left(const MovieDataSourceFailure(message: '')));

      // Act
      final result = await getMovieDetailUseCase.execute(id: id);

      // Asert
      expect(result.fold((l) => l, (r) => r), isA<MovieDataSourceFailure>());
      verify(() => movieDetailRepository.getMovieDetail(id: id)).called(1);
      verifyNoMoreInteractions(movieDetailRepository);
    });

    test(
        'should return MovieParseFailure when execute to repository is MovieParseFailure',
        () async {
      // Arrange
      const String id = 'abcdefg';
      when(() => movieDetailRepository.getMovieDetail(id: id))
          .thenAnswer((_) async => left(const MovieParseFailure(message: '')));

      // Act
      final result = await getMovieDetailUseCase.execute(id: id);

      // Asert
      expect(result.fold((l) => l, (r) => r), isA<MovieParseFailure>());
      verify(() => movieDetailRepository.getMovieDetail(id: id)).called(1);
      verifyNoMoreInteractions(movieDetailRepository);
    });

    test(
        'should return MovieUnknownFailure when execute to repository is MovieUnknownFailure',
        () async {
      // Arrange
      const String id = 'abcdefg';
      when(() => movieDetailRepository.getMovieDetail(id: id)).thenAnswer(
          (_) async => left(const MovieUnknownFailure(message: '')));

      // Act
      final result = await getMovieDetailUseCase.execute(id: id);

      // Asert
      expect(result.fold((l) => l, (r) => r), isA<MovieUnknownFailure>());
      verify(() => movieDetailRepository.getMovieDetail(id: id)).called(1);
      verifyNoMoreInteractions(movieDetailRepository);
    });
  });
}
