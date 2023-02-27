import 'package:flutter/material.dart';

import '../../domain/entities/movie_detail_entity.dart';

class MovieDetailPlot extends StatelessWidget {
  const MovieDetailPlot({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetailEntity movie;

  @override
  Widget build(BuildContext context) {
    return Text(
      movie.plot,
      style: const TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2,
      ),
    );
  }
}
