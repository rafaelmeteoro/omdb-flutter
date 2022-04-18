import 'package:flutter/material.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';

class ItemCard extends StatelessWidget {
  final HomeMovieEntity _movie;

  const ItemCard({
    Key? key,
    required HomeMovieEntity movie,
  })  : _movie = movie,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Text(
        _movie.title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
