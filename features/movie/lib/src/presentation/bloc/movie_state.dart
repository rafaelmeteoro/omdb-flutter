import 'package:core/core.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';

abstract class MovieState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieEmptyState extends MovieState {}

class MovieLoadingState extends MovieState {}

class MovieErrorState extends MovieState {
  final String message;

  MovieErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class MovieSuccessState extends MovieState {
  final MovieDetail movie;

  MovieSuccessState({required this.movie});

  @override
  List<Object?> get props => [movie];
}
