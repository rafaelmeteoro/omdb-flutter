import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_app_bar.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_content.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_info_list.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_infos.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_plot.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_title.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_wishlist_button.dart';

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
  group('MovieDetailContent', () {
    Widget detailContentApp() {
      return MaterialApp(
        home: Material(
          child: MovieDetailContent(
            movie: movieDetailEntity,
          ),
        ),
      );
    }

    testWidgets('show info movie detail content', (tester) async {
      await tester.pumpWidget(detailContentApp());
      await tester.pumpAndSettle();

      expect(find.byType(MovieDetailContent), findsOneWidget);
      expect(find.byType(MovieDetailAppBar), findsOneWidget);
      expect(find.byType(MovieDetailTitle), findsOneWidget);
      expect(find.byType(MovideDetailInfos), findsOneWidget);
      expect(find.byType(MovieDetailWishlistButton), findsOneWidget);
      expect(find.byType(MoviedetailPlot), findsOneWidget);
      expect(find.byType(MovieDetailInfoList), findsNWidgets(6));
    });
  });
}
