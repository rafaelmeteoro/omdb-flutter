import 'package:flutter/material.dart';

class ChipsWords extends StatelessWidget {
  const ChipsWords({
    super.key,
    required this.words,
  });

  final List<String> words;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Wrap(
        children: words
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
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
