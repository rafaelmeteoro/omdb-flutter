import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_error.dart';

void main() {
  group('MovieDetailError', () {
    Widget detailErrorApp() {
      return MaterialApp(
        home: Material(
            child: MovieDetailError(
          message: 'message error',
        )),
      );
    }

    testWidgets('show message error', (tester) async {
      await tester.pumpWidget(detailErrorApp());

      expect(find.byType(MovieDetailError), findsOneWidget);
      expect(find.text('message error'), findsOneWidget);
    });
  });
}
