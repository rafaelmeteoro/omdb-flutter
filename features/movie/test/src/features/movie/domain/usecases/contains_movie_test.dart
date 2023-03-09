import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/core/typedef/signatures.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/contains_movie_storage_use_case.dart';
import 'package:movie/src/features/movie/domain/interfaces/movie_storage_repository.dart';
import 'package:movie/src/features/movie/domain/usecases/contains_movie.dart';

class MovieStorageRepositoryMock extends Mock implements MovieStorageRepository {}

void main() {
  late MovieStorageRepository repositoryMock;
  late ContainsMovieStorageUseCase useCase;

  setUp(() {
    repositoryMock = MovieStorageRepositoryMock();
    useCase = ContainsMovie(repository: repositoryMock);
  });

  final movieMock = MovieDetailEntity(
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
    ratings: [],
  );

  group(ContainsMovie, () {
    test('return true when contains', () async {
      // Arrange
      when(() => repositoryMock.contains(key: any(named: 'key'))).thenAnswer(
        (_) async => ResultContainsMovieStorage.right(true),
      );

      // Act
      final result = await useCase.call(movie: movieMock);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        true,
      );
      verify(() => repositoryMock.contains(key: any(named: 'key'))).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });

    test('return false when not contains', () async {
      // Arrange
      when(() => repositoryMock.contains(key: any(named: 'key'))).thenAnswer(
        (_) async => ResultContainsMovieStorage.right(false),
      );

      // Act
      final result = await useCase.call(movie: movieMock);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        false,
      );
      verify(() => repositoryMock.contains(key: any(named: 'key'))).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });

    test('return a MovieContainsStorageFailure when execute repository', () async {
      // Arrange
      when(() => repositoryMock.contains(key: any(named: 'key'))).thenAnswer(
        (_) async => ResultContainsMovieStorage.left(MovieContainsStorageFailure()),
      );

      // Act
      final result = await useCase.call(movie: movieMock);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<MovieContainsStorageFailure>(),
      );
      verify(() => repositoryMock.contains(key: any(named: 'key'))).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });
  });
}
