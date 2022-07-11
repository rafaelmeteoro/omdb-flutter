import 'package:core/presentation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie_detail_entity.dart';

class MovieDetailAppBar extends StatelessWidget {
  const MovieDetailAppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetailEntity movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        background: FadeIn(
          duration: const Duration(milliseconds: 500),
          child: ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                ],
                stops: [0.0, 0.5, 1.0, 1.0],
              ).createShader(
                Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
              );
            },
            blendMode: BlendMode.dstIn,
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              imageUrl: movie.poster,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
