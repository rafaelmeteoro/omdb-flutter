import 'package:flutter/material.dart';

import '../../domain/entities/movie_detail_entity.dart';

class MovideDetailInfos extends StatelessWidget {
  const MovideDetailInfos({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetailEntity movie;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 4.0,
            horizontal: 8.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            movie.year,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        Row(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 20.0,
            ),
            const SizedBox(width: 4.0),
            Text(
              movie.imdbRating,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 4.0),
            Text(
              movie.imdbRating,
              style: const TextStyle(
                fontSize: 1.0,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Text(
          _showDuration(movie.runtime),
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  String _showDuration(String runtime) {
    if (runtime == 'N/A') return runtime;
    final timeMinutesString = runtime.split(' ')[0];
    final timeMinutes = int.parse(timeMinutesString);
    final int hours = timeMinutes ~/ 60;
    final int minutes = timeMinutes % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
