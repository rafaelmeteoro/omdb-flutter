import 'package:core/presentation.dart';
import 'package:flutter/material.dart';

import '../controller/movie_page_controller.dart';
import '../controller/movie_page_state.dart';
import '../widgets/movie_detail_content.dart';

class MoviePage extends StatefulWidget {
  final String id;

  const MoviePage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final pageController = Modular.get<MoviePageController>();

  @override
  void initState() {
    super.initState();
    pageController.getMovieDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<MoviePageState>(
        valueListenable: pageController,
        builder: (context, state, _) {
          return state.maybeWhen(
            loading: () => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            error: (message) => Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
              ),
            ),
            success: (movie) => MovieDetailContent(movie: movie),
            orElse: () => const SizedBox(),
          );
        },
      ),
    );
  }
}
