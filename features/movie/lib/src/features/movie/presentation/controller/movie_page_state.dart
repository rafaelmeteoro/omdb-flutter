import '../../domain/entities/movie_detail_entity.dart';

sealed class MoviePageState {}

class MoviePageStateLoading extends MoviePageState {}

class MoviePageStateError extends MoviePageState {
  MoviePageStateError(this.message);
  final String message;
}

class MoviePageStateSuccess extends MoviePageState {
  MoviePageStateSuccess(this.movie);
  final MovieDetailEntity movie;
}
