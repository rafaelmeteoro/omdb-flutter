import 'package:core/presentation.dart';
import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:search/src/features/search/presentation/pages/search_page_delegate.dart';

/// Probe screen: exercises [SearchPageFlow] with a real [BuildContext] living
/// under the Modular router.
class _ProbeScreen extends StatelessWidget {
  const _ProbeScreen();

  @override
  Widget build(BuildContext context) {
    final flow = SearchPageFlow();
    return Scaffold(
      body: Column(
        children: [
          TextButton(
            onPressed: () => flow.onActionClick(context),
            child: const Text('action'),
          ),
          TextButton(
            onPressed: () =>
                flow.onItemSearchSelected(context, movieId: 'movieId'),
            child: const Text('item'),
          ),
        ],
      ),
    );
  }
}

final _stubModule = createModule(
  register: (c) {
    c
      ..route('/', child: (ctx, state) => const _ProbeScreen())
      ..route(
        '/movie/',
        child: (ctx, state) => Scaffold(
          body: Text('movie ${state.arguments}'),
        ),
      )
      ..route(
        '/board/',
        child: (ctx, state) => const Scaffold(body: Text('board')),
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
    ),
  );
}

void main() {
  group(SearchPageFlow, () {
    testWidgets('onItemSearchSelected pushes /movie/ with the movie id', (
      tester,
    ) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('item'));
      await tester.pumpAndSettle();

      expect(find.text('movie movieId'), findsOneWidget);
    });

    testWidgets('onActionClick pushes /board/', (tester) async {
      await tester.pumpWidget(_app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('action'));
      await tester.pumpAndSettle();

      expect(find.text('board'), findsOneWidget);
    });
  });
}
