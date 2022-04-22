import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/presentation/bloc/movie_bloc.dart';
import 'package:movie/src/presentation/bloc/movie_event.dart';
import 'package:movie/src/presentation/bloc/movie_state.dart';
import 'package:movie/src/presentation/widgets/movie_detail_content.dart';

class MoviePage extends StatefulWidget {
  final MovieBloc movieBloc;
  final String id;

  const MoviePage({
    Key? key,
    required this.movieBloc,
    required this.id,
  }) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  @override
  void initState() {
    super.initState();
    widget.movieBloc.add(GetMovieDetail(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieBloc, MovieState>(
        bloc: widget.movieBloc,
        builder: (context, state) {
          if (state is MovieLoadingState) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is MovieErrorState) {
            return Center(
              child: Text(
                state.message,
                textAlign: TextAlign.center,
              ),
            );
          } else if (state is MovieSuccessState) {
            final movie = state.movie;
            return MovieDetailContent(movie: movie);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
