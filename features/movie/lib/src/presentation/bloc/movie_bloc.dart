import 'package:core/core.dart';
import 'package:movie/src/domain/usecase/get_movie_detail.dart';
import 'package:movie/src/presentation/bloc/movie_event.dart';
import 'package:movie/src/presentation/bloc/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovieDetailUseCaseContract _getMovieDetailUseCase;

  MovieBloc({
    required GetMovieDetailUseCaseContract getMovieDetailUseCase,
  })  : _getMovieDetailUseCase = getMovieDetailUseCase,
        super(MovieEmptyState()) {
    on<GetMovieDetail>((event, emit) => _getMovieDetail(event, emit));
  }

  Future<void> _getMovieDetail(
    GetMovieDetail event,
    Emitter<MovieState> emit,
  ) async {
    emit(MovieLoadingState());
    final id = event.id;
    final result = await _getMovieDetailUseCase.execute(id: id);

    result.fold(
      (failure) => emit(MovieErrorState(message: failure.message)),
      (data) => emit(MovieSuccessState(movie: data)),
    );
  }
}
