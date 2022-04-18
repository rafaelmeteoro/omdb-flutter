import 'package:bloc/bloc.dart';
import 'package:omdb_flutter/app/modules/home/domain/errors/failures.dart';
import 'package:omdb_flutter/app/modules/home/domain/usecases/get_movies.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/events.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/states.dart';
import 'package:rxdart/rxdart.dart';

class HomeCubit extends Bloc<HomeEvent, HomeState> {
  final IGetMoviesUseCase _getMoviesUseCase;
  HomeCubit({
    required IGetMoviesUseCase getMoviesUseCase,
  })  : _getMoviesUseCase = getMoviesUseCase,
        super(HomeInitialState()) {
    on<SearchMoviesEvent>((event, emit) => _searchMovies(event, emit),
        transformer: debounce(const Duration(milliseconds: 700)));
  }

  Future<void> _searchMovies(
    SearchMoviesEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeLoadingState());
      final result = await _getMoviesUseCase.call(title: event.searchText);
      if (result.search.isEmpty) {
        emit(HomeEmptyState());
      } else {
        emit(HomeSuccessState(result: result));
      }
    } on HomeFailure catch (error) {
      emit(HomeErrorState(errorMessage: error.message));
    }
  }
}

EventTransformer<HomeEvent> debounce<HomeEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
