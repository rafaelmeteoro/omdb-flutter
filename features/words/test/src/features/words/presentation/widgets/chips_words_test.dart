import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:words/src/features/words/presentation/widgets/chips_words.dart';

void main() {
  final wordsMock = [
    'banana',
    'maça',
    'mamão',
  ];

  group(ChipsWords, () {
    Widget chipWordsApp() {
      return MaterialApp(
        home: Material(
          child: ChipsWords(
            words: wordsMock,
            onDeletePressed: (word) {},
          ),
        ),
      );
    }

    testWidgets('show tips with words', (tester) async {
      await tester.pumpWidget(chipWordsApp());

      expect(find.byType(Chip), findsNWidgets(3));
      expect(find.text('banana'), findsOneWidget);
      expect(find.text('maça'), findsOneWidget);
      expect(find.text('mamão'), findsOneWidget);
    });

    testWidgets('call onDeletePressed when delete icon is tapped',
        (tester) async {
      String? deletedWord;

      await tester.pumpWidget(
        MaterialApp(
          home: Material(
            child: ChipsWords(
              words: wordsMock,
              onDeletePressed: (word) => deletedWord = word,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.cancel).first);
      await tester.pump();

      expect(deletedWord, 'banana');
    });
  });
}
