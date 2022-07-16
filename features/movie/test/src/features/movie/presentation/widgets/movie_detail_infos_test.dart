import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_infos.dart';

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
  final movieRuntimeWithMinutes = MovieDetailEntity(
    title: 'title',
    year: 'year',
    rated: 'rated',
    released: 'released',
    runtime: '140 min',
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
  final movieRuntimeWithoutMinutes = MovieDetailEntity(
    title: 'title',
    year: 'year',
    rated: 'rated',
    released: 'released',
    runtime: '56 min',
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

  group('MovieDetailInfos', () {
    testWidgets('show info movie detail runtime N/A', (tester) async {
      Widget itemCardListApp() {
        return MaterialApp(
          home: Material(
            child: MovideDetailInfos(
              movie: movieDetailEntity,
            ),
          ),
        );
      }

      await tester.pumpWidget(itemCardListApp());

      expect(find.byType(MovideDetailInfos), findsOneWidget);
      expect(find.text('year'), findsOneWidget);
      expect(find.text('imdbRating'), findsNWidgets(2));
      expect(find.text('N/A'), findsOneWidget);
    });

    testWidgets('show info movie detail runtime with minutes', (tester) async {
      Widget itemCardListApp() {
        return MaterialApp(
          home: Material(
            child: MovideDetailInfos(
              movie: movieRuntimeWithMinutes,
            ),
          ),
        );
      }

      await tester.pumpWidget(itemCardListApp());

      expect(find.byType(MovideDetailInfos), findsOneWidget);
      expect(find.text('year'), findsOneWidget);
      expect(find.text('imdbRating'), findsNWidgets(2));
      expect(find.text('N/A'), findsNothing);
      expect(find.text('2h 20m'), findsOneWidget);
    });

    testWidgets('show info movie detail runtime without hours', (tester) async {
      Widget itemCardListApp() {
        return MaterialApp(
          home: Material(
            child: MovideDetailInfos(
              movie: movieRuntimeWithoutMinutes,
            ),
          ),
        );
      }

      await tester.pumpWidget(itemCardListApp());

      expect(find.byType(MovideDetailInfos), findsOneWidget);
      expect(find.text('year'), findsOneWidget);
      expect(find.text('imdbRating'), findsNWidgets(2));
      expect(find.text('N/A'), findsNothing);
      expect(find.text('56m'), findsOneWidget);
    });
  });
}
