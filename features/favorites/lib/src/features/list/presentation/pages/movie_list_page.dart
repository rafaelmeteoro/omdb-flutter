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
          return state.when(
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (message) => Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
              ),
            ),
            empty: () => const Center(
              child: Text(
                'Nenhum filme favoritado',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            success: (favorites) => FavoriteDetailContent(
              favorites: favorites,
            ),
          );
        },
      ),
    );
  }
}
