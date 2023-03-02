import 'package:flutter/material.dart';

class MovieDetailInfoList extends StatelessWidget {
  const MovieDetailInfoList({
    super.key,
    required this.title,
    required this.values,
  });

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$title: ${_showValues(values)}',
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.2,
      ),
    );
  }

  String _showValues(List<String> genres) {
    final result = StringBuffer();
    for (final genre in genres) {
      result.write('$genre, ');
    }

    if (result.isEmpty) {
      return result.toString();
    }

    return result.toString().substring(0, result.length - 2);
  }
}
