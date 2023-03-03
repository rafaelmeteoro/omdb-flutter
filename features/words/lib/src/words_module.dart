import 'package:core/presentation.dart';
import 'package:flutter/widgets.dart';

import 'features/words/presentation/pages/words_page.dart';

class WordsModule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const WordsPage(),
        )
      ];
}

class WordsWidgetModule extends WidgetModule {
  WordsWidgetModule({super.key});

  @override
  List<Bind<Object>> get binds => [];

  @override
  Widget get view => const WordsPage();
}
