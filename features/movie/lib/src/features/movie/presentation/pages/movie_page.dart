import 'package:flutter/material.dart';

import '../controller/movie_add_remove_controller.dart';
import '../controller/movie_add_remove_state.dart';
import '../controller/movie_detail_content_controller.dart';
import '../controller/movie_page_controller.dart';
import '../controller/movie_page_state.dart';
import '../widgets/movie_detail_content.dart';
import '../widgets/movie_detail_error.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({
    super.key,
    required this.id,
    required this.controller,
    required this.contentController,
    required this.addRemoveController,
  });

  final String id;
  final MoviePageController controller;
  final MovieDetailContentController contentController;
  final MovieAddRemoveController addRemoveController;

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  MoviePageController get _controller => widget.controller;
  MovieDetailContentController get _contentController => widget.contentController;
  MovieAddRemoveController get _addRemoveController => widget.addRemoveController;

  @override
  void initState() {
    super.initState();
    _controller
      ..getMovieDetail(id: widget.id)
      ..addListener(_onStateSuccess);
    _addRemoveController.addListener(_onAddRemoveListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    _addRemoveController.dispose();
    super.dispose();
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
            success: (movie) => MovieDetailContent(
              movie: movie,
              contentController: _contentController,
              addRemoveController: _addRemoveController,
            ),
          );
        },
      ),
    );
  }

  void _onStateSuccess() {
    if (_controller.value is MoviePageStateSuccess) {
      final value = _controller.value as MoviePageStateSuccess;
      _contentController.isFavorited(value.movie);
    }
  }

  void _onAddRemoveListener() {
    if (_addRemoveController.value is MovieAddRemoveStateSuccess) {
      final value = _addRemoveController.value as MovieAddRemoveStateSuccess;
      _contentController.isFavorited(value.movie);
    }
  }
}
