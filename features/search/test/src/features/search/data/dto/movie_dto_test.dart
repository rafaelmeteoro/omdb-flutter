import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/features/search/data/dto/movie_dto.dart';

void main() {
  group('movie dto', () {
    test('movie dto from json', () {
      // Arrange
      const json = {
        'imdbID': 'imdbID',
        'Title': 'Title',
        'Year': 'Year',
        'Type': 'Type',
        'Poster': 'Poster',
      };

      // Act
      final movie = MovieDto.fromJson(json);

      // Assert
      expect(movie, isA<MovieDto>());
      expect(
        movie ==
            MovieDto(
              imdbId: 'imdbID',
              title: 'Title',
              year: 'Year',
              type: 'Type',
              poster: 'Poster',
            ),
        equals(true),
      );
    });
  });
}
