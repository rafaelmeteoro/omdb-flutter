import 'package:flutter/material.dart';

import '../controller/words_page_controller.dart';
import '../controller/words_page_state.dart';
import '../widgets/chips_words.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({
    super.key,
    required this.controller,
  });

  final WordsPageController controller;

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  WordsPageController get _controller => widget.controller;

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
            success: (result) => ChipsWords(
              words: result,
              onDeletePressed: (word) async {
                await _controller.deleteWord(word: word);
              },
            ),
          );
        },
      ),
    );
  }
}
