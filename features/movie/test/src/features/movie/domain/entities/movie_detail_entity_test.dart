import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';

void main() {
  group(MovieDetailEntity, () {
    test('movie detail has same parameters', () {
      // Arrange
      const movieDetail = MovieDetailEntity(
        title: 'title',
        year: 'year',
        rated: 'rated',
        released: 'release',
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
        type: 'type',
        imdbRating: 'imdbgRating',
        imdbId: 'imdbId',
        imdbVotes: 'imdbVotes',
        ratings: [
          RatingEntity(
            source: 'source',
            value: 'value',
          ),
        ],
      );

      // Assert
      expect(movieDetail, isA<MovieDetailEntity>());
      expect(
        movieDetail ==
            MovieDetailEntity(
              title: 'title',
              year: 'year',
              rated: 'rated',
              released: 'release',
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
              type: 'type',
              imdbRating: 'imdbgRating',
              imdbId: 'imdbId',
              imdbVotes: 'imdbVotes',
              ratings: [
                RatingEntity(
                  source: 'source',
                  value: 'value',
                )
              ],
            ),
        equals(true),
      );
    });
  });
}
