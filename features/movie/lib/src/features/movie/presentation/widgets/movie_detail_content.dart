import 'package:core/presentation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie_detail_entity.dart';
import '../controller/movie_add_remove_controller.dart';
import '../controller/movie_detail_content_controller.dart';
import 'movie_detail_app_bar.dart';
import 'movie_detail_info_list.dart';
import 'movie_detail_infos.dart';
import 'movie_detail_plot.dart';
import 'movie_detail_title.dart';
import 'movie_detail_wishlist_button.dart';

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    super.key,
    required this.movie,
    required this.contentController,
    required this.addRemoveController,
  });

  final MovieDetailEntity movie;
  final MovieDetailContentController contentController;
  final MovieAddRemoveController addRemoveController;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      key: const Key('movieDetailScrollView'),
      slivers: [
        MovieDetailAppBar(movie: movie),
        SliverToBoxAdapter(
          child: FadeInUp(
            from: 20,
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieDetailTitle(movie: movie),
                  const SizedBox(height: 8.0),
                  MovieDetailInfos(movie: movie),
                  const SizedBox(height: 16.0),
                  ValueListenableBuilder<bool>(
                    valueListenable: contentController,
                    builder: (_, state, __) {
                      return MovieDetailWishlistButton(
                        isFavorited: state,
                        action: () async {
                          await addRemoveController.addOrRemove(movie: movie);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  MovieDetailPlot(movie: movie),
                  const SizedBox(height: 8.0),
                  MovieDetailInfoList(
                    title: 'Directors',
                    values: movie.director,
                  ),
                  const SizedBox(height: 8.0),
                  MovieDetailInfoList(
                    title: 'Genres',
                    values: movie.genre,
                  ),
                  const SizedBox(height: 8.0),
                  MovieDetailInfoList(
                    title: 'Writer',
                    values: movie.writer,
                  ),
                  const SizedBox(height: 8.0),
                  MovieDetailInfoList(
                    title: 'Actors',
                    values: movie.actors,
                  ),
                  const SizedBox(height: 8.0),
                  MovieDetailInfoList(
                    title: 'Language',
                    values: movie.language,
                  ),
                  const SizedBox(height: 8.0),
                  MovieDetailInfoList(
                    title: 'Country',
                    values: movie.country,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
