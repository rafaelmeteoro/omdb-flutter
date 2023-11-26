import '../../domain/entities/favorite_movie_entity.dart';

sealed class MovieListPageState {}

class MovieListPageStateLoading extends MovieListPageState {}

class MovieListPageStateError extends MovieListPageState {
  MovieListPageStateError(this.message);
  final String message;
}

class MovieListPageStateEmpty extends MovieListPageState {}

class MovieListPageStateSuccess extends MovieListPageState {
  MovieListPageStateSuccess(this.favorites);
  final List<FavoriteMovieEntity> favorites;
}
