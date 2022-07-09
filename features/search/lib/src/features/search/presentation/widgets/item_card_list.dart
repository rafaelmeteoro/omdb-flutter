import 'package:core/presentation.dart';
import 'package:flutter/material.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';

class ItemCard extends StatelessWidget {
  final MovieEntity _movie;
  final Function(MovieEntity movie) _onPressed;

  const ItemCard({
    Key? key,
    required MovieEntity movie,
    required Function(MovieEntity movie) onPressed,
  })  : _movie = movie,
        _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _onPressed(_movie);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  imageUrl: _movie.poster,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _movie.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: kHeading6,
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(_movie.year),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
