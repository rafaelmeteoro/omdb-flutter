import 'package:board/src/features/board/presentation/page/board_page.dart';
import 'package:core/presentation.dart';
import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';

/// Stub shell: mirrors `boardModule`'s structure (a `/board` shell whose
/// `RouterOutlet` swaps between two child routes) with fake tab bodies, so the
/// real [BoardPage] widget is exercised without the favorites/words DI.
final _stubModule = createModule(
  register: (c) {
    c.route(
      '/board',
      child: (ctx, state) => const BoardPage(),
      children: (sub) {
        sub
          ..route(
            '/',
            guards: [(state) => '/board/favorites'],
            child: (ctx, state) => const SizedBox.shrink(),
          )
          ..route('/favorites', child: (ctx, state) => const Text('FAV'))
          ..route('/words', child: (ctx, state) => const Text('WORDS'));
      },
    );
  },
);

Widget _app() {
  final boot = bootstrapModule(_stubModule);
  return MaterialApp.router(
    routerConfig: modularRouterConfig(
      boot.routes,
      injector: boot.injector,
      manager: boot.manager,
      initialRoute: '/board',
    ),
  );
}

void main() {
  group(BoardPage, () {
    testWidgets('lands on the favorites tab (index redirect)', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      expect(find.text('FAV'), findsOneWidget);
      expect(find.text('Favorites'), findsOneWidget); // AppBar title
      expect(
        tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar)).currentIndex,
        0,
      );
    });

    testWidgets('tapping Words swaps the outlet body, shell persists', (
      tester,
    ) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Words'));
      await tester.pumpAndSettle();

      expect(find.text('WORDS'), findsOneWidget);
      expect(find.text('FAV'), findsNothing);
      expect(find.text('Favorites'), findsOneWidget); // shell still mounted
      expect(
        tester.widget<BottomNavigationBar>(find.byType(BottomNavigationBar)).currentIndex,
        1,
      );
    });
  });
}
