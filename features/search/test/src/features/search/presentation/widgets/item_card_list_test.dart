import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/presentation/widgets/item_card_list.dart';

void main() {
  final movieEntity = MovieEntity(
    imdbId: 'imdbId',
    title: 'title',
    year: 'year',
    type: 'type',
    poster: 'poster',
  );

  group('ItemCard', () {
    Widget itemCardApp() {
      return MaterialApp(
        home: Material(
          child: ItemCard(
            movie: movieEntity,
            onPressed: (movie) {},
          ),
        ),
      );
    }

    testWidgets('show info from movie', (tester) async {
      await tester.pumpWidget(itemCardApp());

      expect(find.byType(ItemCard), findsOneWidget);
      expect(find.text('title'), findsOneWidget);
      expect(find.text('year'), findsOneWidget);

      await tester.tap(find.byKey(Key('itemCard')));
    });
  });
}
