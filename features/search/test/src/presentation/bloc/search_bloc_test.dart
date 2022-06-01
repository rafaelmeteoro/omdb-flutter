import 'package:dev_core/dev_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/src/domain/entities/movie.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/domain/errors/failures.dart';
import 'package:search/src/domain/usecase/search_movies.dart';
import 'package:search/src/presentation/bloc/search_bloc.dart';
import 'package:search/src/presentation/bloc/search_event.dart';
import 'package:search/src/presentation/bloc/search_state.dart';

class SearchMoviesUseCaseMock extends Mock
    implements SearchMoviesUseCaseContract {}

void main() {
  late SearchMoviesUseCaseContract searchUseCase;
  late SearchBloc searchBloc;

  setUp(() {
    searchUseCase = SearchMoviesUseCaseMock();
    searchBloc = SearchBloc(searchMoviesUseCase: searchUseCase);
  });

  group('Search Bloc', () {
    blocTest<SearchBloc, SearchState>(
      'should emit [SearchLoadingState, SearchSuccessState] when usecase return a non empty list',
      build: () {
        when(() => searchUseCase.execute(query: 'test')).thenAnswer(
          (_) async => right(
            const ResultSearch(
              search: [
                Movie(
                  imdbId: 'imdbId',
                  title: 'title',
                  year: 'year',
                  type: 'type',
                  poster: 'poster',
                )
              ],
              totalResults: '0',
              response: '',
            ),
          ),
        );
        return searchBloc;
      },
      wait: const Duration(milliseconds: 700),
      act: (bloc) async => searchBloc.add(OnQueryChanged(query: 'test')),
      expect: () {
        return [
          isA<SearchLoadingState>(),
          isA<SearchSuccessState>(),
        ];
      },
      verify: (_) {
        verify(() => searchUseCase.execute(query: 'test')).called(1);
        verifyNoMoreInteractions(searchUseCase);
      },
    );

    blocTest<SearchBloc, SearchState>(
      'should emit [SearchLoadingState, SearchEmptyState] when usecase return a empty list',
      build: () {
        when(() => searchUseCase.execute(query: 'test')).thenAnswer(
          (_) async => right(
            const ResultSearch(
              search: [],
              totalResults: '0',
              response: '',
            ),
          ),
        );
        return searchBloc;
      },
      wait: const Duration(milliseconds: 700),
      act: (bloc) async => searchBloc.add(OnQueryChanged(query: 'test')),
      expect: () {
        return [
          isA<SearchLoadingState>(),
          isA<SearchEmptyState>(),
        ];
      },
      verify: (_) {
        verify(() => searchUseCase.execute(query: 'test')).called(1);
        verifyNoMoreInteractions(searchUseCase);
      },
    );

    blocTest<SearchBloc, SearchState>(
      'should emit [SearchLoadingState, SearchErrorState] when usecase return a subclass of SearchFailure',
      build: () {
        when(() => searchUseCase.execute(query: 'test')).thenAnswer(
          (_) async => left(SearchShortTitleFailure(message: '')),
        );
        return searchBloc;
      },
      wait: const Duration(milliseconds: 700),
      act: (bloc) async => searchBloc.add(OnQueryChanged(query: 'test')),
      expect: () {
        return [
          isA<SearchLoadingState>(),
          isA<SearchErrorState>(),
        ];
      },
      verify: (_) {
        verify(() => searchUseCase.execute(query: 'test')).called(1);
        verifyNoMoreInteractions(searchUseCase);
      },
    );
  });
}
