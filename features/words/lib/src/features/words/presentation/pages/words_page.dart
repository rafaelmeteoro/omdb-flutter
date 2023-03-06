import 'package:core/presentation.dart';
import 'package:flutter/material.dart';

import '../controller/words_page_controller.dart';
import '../controller/words_page_state.dart';
import '../widgets/chips_words.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({
    super.key,
  });

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  WordsPageController get _controller => Modular.get<WordsPageController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.getWords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<WordsPageState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          return state.when(
            empty: () => const Center(
              child: Text(
                'Nenhum resultado encontrado.',
                textAlign: TextAlign.center,
              ),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (message) => Center(
              child: Text(message),
            ),
            success: (result) => ChipsWords(words: result),
          );
        },
      ),
    );
  }
}
