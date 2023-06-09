import 'package:favorites/src/core/typedef/signatures.dart';
import 'package:favorites/src/features/list/domain/entities/favorite_movie_entity.dart';
import 'package:favorites/src/features/list/domain/entities/favorite_rating_entity.dart';
import 'package:favorites/src/features/list/domain/interfaces/favorite_movie_storage_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:favorites/src/features/list/domain/interfaces/get_movies_use_case.dart';
import 'package:favorites/src/features/list/domain/usecases/get_movies.dart';

class FavoriteMovieStorageRepositoryMock extends Mock implements FavoriteMovieStorageRepository {}

const ratings = [
  FavoriteRatingEntity(
    source: 'source',
    value: 'value',
  )
];

const favoriteMovie = FavoriteMovieEntity(
  title: 'title',
  year: 'year',
  rated: 'rated',
  released: 'released',
  runtime: 'runtime',
  genre: ['genre'],
  director: ['director'],
  writer: ['wirter'],
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
  ratings: ratings,
);

void main() {
  late FavoriteMovieStorageRepository repository;
  late GetMoviesUseCase useCase;

  setUp(() {
    repository = FavoriteMovieStorageRepositoryMock();
    useCase = GetMovies(repository: repository);
  });

  group(GetMovies, () {
    test('should return MovieDetailEntity when repository is successfull', () async {
      // Arrange
      when(() => repository.getFavorites()).thenAnswer(
        (_) async => ResultFavorites.right([favoriteMovie]),
      );

      // Act
      final result = await useCase.call();

      // assert
      expect(
        result.match((failure) => failure, (value) => value),
        [favoriteMovie],
      );
      verify(() => repository.getFavorites()).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
