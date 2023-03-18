import 'package:dev_core/dev_core.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/add_remove_movie_storage_use_case.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_add_remove_controller.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_add_remove_state.dart';

class AddRemoveMovieStorageUseCaseMock extends Mock implements AddRemoveMovieStorageUseCase {}

void main() {
  late AddRemoveMovieStorageUseCase useCaseMock;
  late MovieAddRemoveController controller;

  setUp(() {
    useCaseMock = AddRemoveMovieStorageUseCaseMock();
    controller = MovieAddRemoveController(useCase: useCaseMock);
  });

  final movieDetailEntity = MovieDetailEntity(
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
    ratings: [
      RatingEntity(
        source: 'source',
        value: 'value',
      ),
    ],
  );

  group(MovieAddRemoveController, () {
    test('should return state MovieAddRemoveStateInitial when create', () async {
      // Assert
      expect(controller.value, isA<MovieAddRemoveStateInitial>());
    });

    test('return state MovieAddRemoveStateSuccess when add or remove movie', () async {
      // Arrange
      when(() => useCaseMock.call(movie: movieDetailEntity)).thenAnswer(
        (_) async => right(unit),
      );

      // Act
      await controller.addOrRemove(movie: movieDetailEntity);

      // Assert
      expect(controller.value, isA<MovieAddRemoveStateSuccess>());
    });

    test('return state MovieAddRemoveStateError when add or remove movie', () async {
      // Arrange
      when(() => useCaseMock.call(movie: movieDetailEntity)).thenAnswer(
        (_) async => left(MovieAddRemoveStorageFailure()),
      );

      // Act
      await controller.addOrRemove(movie: movieDetailEntity);

      // Assert
      expect(controller.value, isA<MovieAddRemoveStateError>());
    });
  });
}
