import '../../domain/entities/movie_detail_entity.dart';

sealed class MovieAddRemoveState {}

class MovieAddRemoveStateInitial extends MovieAddRemoveState {}

class MovieAddRemoveStateSuccess extends MovieAddRemoveState {
  MovieAddRemoveStateSuccess(this.movie);
  final MovieDetailEntity movie;
}

class MovieAddRemoveStateError extends MovieAddRemoveState {
  MovieAddRemoveStateError(this.message);
  final String message;
}
