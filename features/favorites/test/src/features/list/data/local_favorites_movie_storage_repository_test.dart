import 'package:favorites/src/core/errors/failure.dart';
import 'package:favorites/src/features/list/data/dto/favorite_movie_dto.dart';
import 'package:favorites/src/features/list/data/dto/favorite_rating_dto.dart';
import 'package:favorites/src/features/list/data/local_favorites_movie_storage_repository.dart';
import 'package:favorites/src/features/list/domain/interfaces/favorite_movie_storage_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_storage_manager/movie_storage_manager.dart';

class MovieStorageMock extends Mock implements MovieStorage {}

void main() {
  late MovieStorage storageMock;
  late FavoriteMovieStorageRepository localRepository;

  setUp(() {
    storageMock = MovieStorageMock();
    localRepository = LocalFavoritesMovieStorageRepository(storage: storageMock);
  });

  group(LocalFavoritesMovieStorageRepository, () {
    test('return ResultFavorites.right empty when call getFavorites', () async {
      // Arrange
      when(() => storageMock.readAll()).thenAnswer(
        (_) async => [],
      );

      // Act
      final result = await localRepository.getFavorites();

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        [],
      );
      verify(() => storageMock.readAll()).called(1);
      verifyNoMoreInteractions(storageMock);
    });

    test('return ResultFavorites.right list when call getFavorites', () async {
      // Arrange
      final returnValue = [
        {
          "Title": "title",
          "Year": "year",
          "Rated": "rated",
          "Released": "released",
          "Runtime": "runtime",
          "Genre": ['genre'],
          "Director": ['director'],
          "Writer": ['writer'],
          "Actors": ['actors'],
          "Plot": "plot",
          "Language": ['language'],
          "Country": ['country'],
          "Awards": "awards",
          "Poster": "poster",
          "Metascore": "metascore",
          "imdbRating": "imdbRating",
          "imdbVotes": "imdbVotes",
          "imdbID": "imdbId",
          "Type": "type",
          "Ratings": [
            {
              "Source": 'source',
              "Value": 'value',
            },
          ],
        },
      ];
      final expectedValue = [
        FavoriteMovieDto(
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
            FavoriteRatingDto(
              source: 'source',
              value: 'value',
            ),
          ],
        ),
      ];
      when(() => storageMock.readAll()).thenAnswer(
        (_) async => returnValue,
      );

      // Act
      final result = await localRepository.getFavorites();

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        expectedValue,
      );
      verify(() => storageMock.readAll()).called(1);
      verifyNoMoreInteractions(storageMock);
    });

    test('return ResultFavorites.left when storea throw exception', () async {
      // Arrange
      when(() => storageMock.readAll()).thenThrow(
        MovieStorageException(message: 'message'),
      );

      // Act
      final result = await localRepository.getFavorites();

      // Assert
      expect(
        result.match((failure) => failure, (value) => value),
        isA<FavoritesStorageFailure>(),
      );
      verify(() => storageMock.readAll()).called(1);
      verifyNoMoreInteractions(storageMock);
    });
  });
}
