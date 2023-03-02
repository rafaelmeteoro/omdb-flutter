import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_info_list.dart';

void main() {
  group(MovieDetailInfoList, () {
    Widget detailInfoApp(List<String> values) {
      return MaterialApp(
        home: Material(
          child: MovieDetailInfoList(
            title: 'title',
            values: values,
          ),
        ),
      );
    }

    testWidgets('show info in detail info list', (tester) async {
      await tester.pumpWidget(detailInfoApp(['value1', 'value2']));

      expect(find.byType(MovieDetailInfoList), findsOneWidget);
      expect(find.text('title: value1, value2'), findsOneWidget);
    });

    testWidgets('show info in detail with info empty', (tester) async {
      await tester.pumpWidget(detailInfoApp([]));

      expect(find.byType(MovieDetailInfoList), findsOneWidget);
      expect(find.text('title: '), findsOneWidget);
    });
  });
}
