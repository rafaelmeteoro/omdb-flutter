import 'package:bloc/bloc.dart';
import 'package:search/src/presentation/bloc/search_event.dart';
import 'package:search/src/presentation/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchEmptyState());
}
