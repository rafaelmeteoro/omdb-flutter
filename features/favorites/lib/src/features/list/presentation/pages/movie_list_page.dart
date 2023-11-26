import 'package:flutter/material.dart';

import '../controller/movie_list_page_controller.dart';
import '../controller/movie_list_page_state.dart';
import '../widgets/favorite_detail_content.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({
    super.key,
    required this.controller,
  });

  final MovieListPageController controller;

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  MovieListPageController get _controller => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.loadFavorites();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<MovieListPageState>(
        valueListenable: _controller,
        builder: (context, state, _) {
          return switch (state) {
            MovieListPageStateLoading _ => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            final MovieListPageStateError state => Center(
                child: Text(
                  state.message,
                  textAlign: TextAlign.center,
                ),
              ),
            MovieListPageStateEmpty _ => const Center(
                child: Text(
                  'Nenhum filme favoritado',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            final MovieListPageStateSuccess state => FavoriteDetailContent(
                favorites: state.favorites,
              ),
          };
        },
      ),
    );
  }
}
