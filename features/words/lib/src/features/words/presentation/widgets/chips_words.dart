import 'package:flutter/material.dart';

class ChipsWords extends StatelessWidget {
  const ChipsWords({
    super.key,
    required List<String> words,
    required Function(String word) onDeletePressed,
  })  : _words = words,
        _onDeletePressed = onDeletePressed;

  final List<String> _words;
  final Function(String word) _onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Wrap(
        children: _words
            .map(
              (word) => Padding(
                padding: const EdgeInsets.all(4.0),
                child: Chip(
                  labelPadding: const EdgeInsets.symmetric(
                    vertical: 2.0,
                    horizontal: 10.0,
                  ),
                  avatar: CircleAvatar(
                    child: Text(word[0].toUpperCase()),
                  ),
                  label: Text(word),
                  onDeleted: () {
                    _onDeletePressed(word);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
