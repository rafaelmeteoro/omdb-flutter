import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_app_bar.dart';

void main() {
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
    ratings: [],
  );
  group(MovieDetailAppBar, () {
    Widget appBarApp() {
      return MaterialApp(
        home: Material(
          child: CustomScrollView(
            slivers: [
              MovieDetailAppBar(
                movie: movieDetailEntity,
              )
            ],
          ),
        ),
      );
    }

    testWidgets('show info in app bar', (tester) async {
      await tester.pumpWidget(appBarApp());
      await tester.pumpAndSettle();

      expect(find.byType(MovieDetailAppBar), findsOneWidget);
    });
  });
}
