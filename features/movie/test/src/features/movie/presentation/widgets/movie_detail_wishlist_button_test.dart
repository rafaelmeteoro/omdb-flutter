import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_wishlist_button.dart';

void main() {
  group(MovieDetailWishlistButton, () {
    Widget detailButtonApp() {
      return MaterialApp(
        home: Material(
          child: MovieDetailWishlistButton(),
        ),
      );
    }

    testWidgets('show info details button', (tester) async {
      await tester.pumpWidget(detailButtonApp());

      expect(find.byType(MovieDetailWishlistButton), findsOneWidget);
      expect(find.text('Add to watchlist'), findsOneWidget);

      await tester.tap(find.byKey(Key('movieToWatchlist')));
    });
  });
}
