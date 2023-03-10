import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/core/typedef/signatures.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/add_movie_storage_use_case.dart';
import 'package:movie/src/features/movie/domain/interfaces/movie_storage_repository.dart';
import 'package:movie/src/features/movie/domain/usecases/add_movie.dart';

class MovieStorageRepositoryMock extends Mock implements MovieStorageRepository {}

void main() {
  late MovieStorageRepository repositoryMock;
  late AddMovieStorageUseCase useCase;

  setUp(() {
    repositoryMock = MovieStorageRepositoryMock();
    useCase = AddMovie(repository: repositoryMock);
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

  group(AddMovie, () {
    test('return unit when add movie', () async {
      // Arrange
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
      verify(() => repositoryMock.addMovie(movie: movieMock)).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });

    test('return a MovieAddRemoveStorageFailure when add movie', () async {
      // Arrange
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
      verify(() => repositoryMock.addMovie(movie: movieMock)).called(1);
      verifyNoMoreInteractions(repositoryMock);
    });
  });
}
