import 'package:flutter/material.dart';

class MovieDetailError extends StatelessWidget {
  const MovieDetailError({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
    );
  }
}
