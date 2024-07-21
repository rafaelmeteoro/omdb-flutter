import 'package:core/presentation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/favorite_movie_entity.dart';

class FavoriteDetailContentWidget extends StatelessWidget {
  const FavoriteDetailContentWidget({
    super.key,
    required this.favorites,
  });

  final List<FavoriteMovieEntity> favorites;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final favorite = favorites[index];
        return Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
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
                    imageUrl: favorite.poster,
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
                      favorite.title,
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
                      child: Text(favorite.year),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
