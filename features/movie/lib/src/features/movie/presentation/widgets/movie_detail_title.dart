import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie_detail_entity.dart';

class MovieDetailTitle extends StatelessWidget {
  const MovieDetailTitle({
    super.key,
    required this.movie,
  });

  final MovieDetailEntity movie;

  @override
  Widget build(BuildContext context) {
    return Text(
      movie.title,
      style: kHeading5.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
      ),
    );
  }
}
