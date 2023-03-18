import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_wishlist_button.dart';

void main() {
  group(MovieDetailWishlistButton, () {
    Widget detailButtonApp(bool favorite) {
      return MaterialApp(
        home: Material(
          child: MovieDetailWishlistButton(
            isFavorited: favorite,
            action: () {},
          ),
        ),
      );
    }

    testWidgets('show info details button with favorite false', (tester) async {
      await tester.pumpWidget(detailButtonApp(false));

      expect(find.byType(MovieDetailWishlistButton), findsOneWidget);
      expect(find.text('Add to watchlist'), findsOneWidget);

      await tester.tap(find.byKey(Key('movieToWatchlist')));
    });

    testWidgets('show info details button with favorite true', (tester) async {
      await tester.pumpWidget(detailButtonApp(true));

      expect(find.byType(MovieDetailWishlistButton), findsOneWidget);
      expect(find.text('Remove to watchlist'), findsOneWidget);

      await tester.tap(find.byKey(Key('movieToWatchlist')));
    });
  });
}
