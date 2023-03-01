import 'package:flutter/material.dart';

import '../controller/movie_page_controller.dart';
import '../controller/movie_page_state.dart';
import '../widgets/movie_detail_content.dart';
import '../widgets/movie_detail_error.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    super.key,
    required this.id,
    required this.controller,
  });

  final String id;
  final MoviePageController controller;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  MoviePageController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    _controller.getMovieDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<MoviePageState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          return state.when(
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (message) => Center(
              child: MovieDetailError(message: message),
            ),
            success: (movie) => MovieDetailContent(movie: movie),
          );
        },
      ),
    );
  }
}
