import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/features/search/presentation/widgets/search_text_field.dart';

void main() {
  group('SearchTextField', () {
    Widget searchTextApp() {
      return MaterialApp(
        home: Material(
          child: SearchTextField(
            onQueryChanged: (string) {},
          ),
        ),
      );
    }

    testWidgets('show search text field', (tester) async {
      await tester.pumpWidget(searchTextApp());

      expect(find.byType(SearchTextField), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key('enterMovieQuery')),
        'movie search',
      );
      await tester.pumpAndSettle();

      expect(find.text('movie search'), findsOneWidget);
    });
  });
}
