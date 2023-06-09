import 'package:favorites/src/core/errors/failure.dart';
import 'package:favorites/src/features/list/domain/entities/favorite_movie_entity.dart';
import 'package:favorites/src/features/list/domain/entities/favorite_rating_entity.dart';
import 'package:favorites/src/features/list/domain/interfaces/get_movies_use_case.dart';
import 'package:favorites/src/features/list/presentation/controller/movie_list_page_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:favorites/src/features/list/presentation/controller/movie_list_page_controller.dart';

class GetMoviesUseCaseMock extends Mock implements GetMoviesUseCase {}

void main() {
  late GetMoviesUseCase useCase;
  late MovieListPageController controller;

  setUp(() {
    useCase = GetMoviesUseCaseMock();
    controller = MovieListPageController(useCase: useCase);
  });

  group(MovieListPageController, () {
    test('return state loading when create', () async {
      // Assert
      expect(
        controller.value,
        isA<MovieListPageStateLoading>(),
      );
    });

    test('return state error when usecase return failure', () async {
      // Arrange
      when(() => useCase()).thenAnswer(
        (_) async => left(FavoritesStorageFailure()),
      );

      // Act
      await controller.loadFavorites();

      // Assert
      expect(
        controller.value,
        isA<MovieListPageStateError>(),
      );
    });

    test('return state empty when usecase return value empty', () async {
      // Arrange
      when(() => useCase()).thenAnswer(
        (_) async => right([]),
      );

      // Act
      await controller.loadFavorites();

      // Assert
      expect(
        controller.value,
        isA<MovieListPageStateEmpty>(),
      );
    });

    test('return state success when usecase return value list', () async {
      // Arrange
      final favorites = [
        FavoriteMovieEntity(
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
            FavoriteRatingEntity(
              source: 'source',
              value: 'value',
            ),
          ],
        ),
      ];
      when(() => useCase()).thenAnswer(
        (_) async => right(favorites),
      );

      // Act
      await controller.loadFavorites();

      // Assert
      expect(
        controller.value,
        isA<MovieListPageStateSuccess>(),
      );
    });
  });
}
