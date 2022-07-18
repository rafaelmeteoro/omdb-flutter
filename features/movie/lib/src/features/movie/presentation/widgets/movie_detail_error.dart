import 'package:flutter/material.dart';

class MovieDetailError extends StatelessWidget {
  const MovieDetailError({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
    );
  }
}
