import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_plot.dart';

void main() {
  final movieDetailEntity = MovieDetailEntity(
    title: 'title',
    year: 'year',
    rated: 'rated',
    released: 'released',
    runtime: 'N/A',
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
  group(MovieDetailPlot, () {
    Widget detailPlotApp() {
      return MaterialApp(
        home: Material(
          child: MovieDetailPlot(
            movie: movieDetailEntity,
          ),
        ),
      );
    }

    testWidgets('show info detail plot', (tester) async {
      await tester.pumpWidget(detailPlotApp());

      expect(find.byType(MovieDetailPlot), findsOneWidget);
      expect(find.text('plot'), findsOneWidget);
    });
  });
}
