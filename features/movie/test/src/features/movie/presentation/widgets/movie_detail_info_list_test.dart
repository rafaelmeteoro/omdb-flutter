import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_info_list.dart';

void main() {
  group(MovieDetailInfoList, () {
    Widget detailInfoApp() {
      return MaterialApp(
        home: Material(
          child: MovieDetailInfoList(
            title: 'title',
            values: ['value1', 'value2'],
          ),
        ),
      );
    }

    testWidgets('show infor in detail info list', (tester) async {
      await tester.pumpWidget(detailInfoApp());

      expect(find.byType(MovieDetailInfoList), findsOneWidget);
      expect(find.text('title: value1, value2'), findsOneWidget);
    });
  });
}
