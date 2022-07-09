import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:search/src/features/search/domain/usecase/search_movies.dart';
import 'package:search/src/features/search/presentation/bloc/search_event.dart';
import 'package:search/src/features/search/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMoviesUseCaseContract _searchMoviesUseCase;

  SearchBloc({
    required SearchMoviesUseCaseContract searchMoviesUseCase,
  })  : _searchMoviesUseCase = searchMoviesUseCase,
        super(SearchEmptyState()) {
    on<OnQueryChanged>((event, emit) => _searchMovies(event, emit),
        transformer: debounce(const Duration(milliseconds: 700)));
  }

  Future<void> _searchMovies(
    OnQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoadingState());
    final query = event.query;
    final result = await _searchMoviesUseCase.execute(query: query);

    result.fold((failure) {
      emit(SearchErrorState(message: failure.message ?? ""));
    }, (data) {
      if (data.search.isEmpty) {
        emit(SearchEmptyState());
      } else {
        emit(SearchSuccessState(result: data));
      }
    });
  }
}

EventTransformer<SearchEvent> debounce<SearchEvent>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
