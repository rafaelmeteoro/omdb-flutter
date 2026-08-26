import 'dart:io';

import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/presentation/widgets/item_card_list.dart';

class _MockHttpClient extends Mock implements HttpClient {}

class _FailingHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = _MockHttpClient();
    when(() => client.openUrl(any(), any()))
        .thenThrow(const SocketException('Connection refused'));
    return client;
  }
}

void main() {
  final movieEntity = MovieEntity(
    imdbId: 'imdbId',
    title: 'title',
    year: 'year',
    type: 'type',
    poster: 'poster',
  );

  group(ItemCard, () {
    testWidgets('show error icon when image fails to load', (tester) async {
      HttpOverrides.global = _FailingHttpOverrides();
      addTearDown(() => HttpOverrides.global = null);

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ItemCard(
              movie: movieEntity,
              onPressed: (movie) {},
            ),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.byIcon(Icons.error), findsOneWidget);
    });
  });
}
