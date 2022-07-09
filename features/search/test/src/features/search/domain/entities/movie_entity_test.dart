import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';

void main() {
  group('movie entity', () {
    test('movie has same parmeters', () {
      // Arrange
      const movie = MovieEntity(
        imdbId: 'imdbId',
        title: 'title',
        year: 'year',
        type: 'type',
        poster: 'poster',
      );

      // Assert
      expect(movie, isA<MovieEntity>());
      expect(
        movie ==
            const MovieEntity(
              imdbId: 'imdbId',
              title: 'title',
              year: 'year',
              type: 'type',
              poster: 'poster',
            ),
        equals(true),
      );
    });
  });
}
