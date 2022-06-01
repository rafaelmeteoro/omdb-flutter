import 'package:core/presentation.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/presentation/widgets/movie_detail_app_bar.dart';
import 'package:movie/src/presentation/widgets/movie_detail_info_list.dart';
import 'package:movie/src/presentation/widgets/movie_detail_infos.dart';
import 'package:movie/src/presentation/widgets/movie_detail_plot.dart';
import 'package:movie/src/presentation/widgets/movie_detail_title.dart';
import 'package:movie/src/presentation/widgets/movie_detail_wishlist_button.dart';

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final MovieDetail movie;

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
                  MovideDetailInfos(movie: movie),
                  const SizedBox(height: 16.0),
                  const MovieDetailWishlistButton(),
                  const SizedBox(height: 16.0),
                  MoviedetailPlot(movie: movie),
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
