import 'package:flutter/material.dart';

class MovieDetailInfoList extends StatelessWidget {
  const MovieDetailInfoList({
    Key? key,
    required this.title,
    required this.values,
  }) : super(key: key);

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
    String result = '';
    for (var genre in genres) {
      result += genre + ', ';
    }

    if (result.isEmpty) return result;

    return result.substring(0, result.length - 2);
  }
}
