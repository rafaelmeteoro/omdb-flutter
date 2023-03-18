import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/core/typedef/signatures.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/add_remove_movie_storage_use_case.dart';
import 'package:movie/src/features/movie/domain/interfaces/movie_storage_repository.dart';
import 'package:movie/src/features/movie/domain/usecases/add_remove_movie.dart';

class MovieStorageRepositoryMock extends Mock implements MovieStorageRepository {}

void main() {
  late MovieStorageRepository repositoryMock;
  late AddRemoveMovieStorageUseCase useCase;

  setUp(() {
    repositoryMock = MovieStorageRepositoryMock();
    useCase = AddRemoveMovie(repository: repositoryMock);
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

  group(AddRemoveMovie, () {
    test('add movie and return unit when is not favorited', () async {
      // Arrange
      when(() => repositoryMock.contains(key: any(named: 'key'))).thenAnswer(
        (_) async => ResultContainsMovieStorage.right(false),
      );
      when(() => repositoryMock.addMovie(movie: movieMock)).thenAnswer(
        (_) async => ResultAddRemoveMovieStorage.right(unit),
      );

      // Act
      final result = await useCase.call(movie: movieMock);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        unit,
      );
      verify(() => repositoryMock.contains(key: any(named: 'key'))).called(1);
      verify(() => repositoryMock.addMovie(movie: movieMock)).called(1);
      verifyNever(() => repositoryMock.removeMovie(movie: movieMock));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('remove movie and return unit when is favorited', () async {
      // Arrange
      when(() => repositoryMock.contains(key: any(named: 'key'))).thenAnswer(
        (_) async => ResultContainsMovieStorage.right(true),
      );
      when(() => repositoryMock.removeMovie(movie: movieMock)).thenAnswer(
        (_) async => ResultAddRemoveMovieStorage.right(unit),
      );

      // Act
      final result = await useCase.call(movie: movieMock);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        unit,
      );
      verify(() => repositoryMock.contains(key: any(named: 'key'))).called(1);
      verify(() => repositoryMock.removeMovie(movie: movieMock)).called(1);
      verifyNever(() => repositoryMock.addMovie(movie: movieMock));
      verifyNoMoreInteractions(repositoryMock);
    });

    test('return a MovieAddRemoveStorageFailure when contains return failure', () async {
      // Arrange
      when(() => repositoryMock.contains(key: any(named: 'key'))).thenAnswer(
        (_) async => ResultContainsMovieStorage.left(MovieContainsStorageFailure()),
      );
      when(() => repositoryMock.addMovie(movie: movieMock)).thenAnswer(
        (_) async => ResultAddRemoveMovieStorage.left(MovieAddRemoveStorageFailure()),
      );

      // Act
      final result = await useCase.call(movie: movieMock);

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<MovieAddRemoveStorageFailure>(),
      );
      verify(() => repositoryMock.contains(key: any(named: 'key'))).called(1);
      verify(() => repositoryMock.addMovie(movie: movieMock)).called(1);
      verifyNever(() => repositoryMock.removeMovie(movie: movieMock));
      verifyNoMoreInteractions(repositoryMock);
    });
  });
}
