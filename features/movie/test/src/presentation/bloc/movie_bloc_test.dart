import 'package:dev_core/dev_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/domain/entities/rating.dart';
import 'package:movie/src/domain/errors/failures.dart';
import 'package:movie/src/domain/usecase/get_movie_detail.dart';
import 'package:movie/src/presentation/bloc/movie_bloc.dart';
import 'package:movie/src/presentation/bloc/movie_event.dart';
import 'package:movie/src/presentation/bloc/movie_state.dart';

class GetMovieDetailUseCaseMock extends Mock
    implements GetMovieDetailUseCaseContract {}

void main() {
  late GetMovieDetailUseCaseContract getMovieDetailUseCase;
  late MovieBloc movieBloc;

  setUp(() {
    getMovieDetailUseCase = GetMovieDetailUseCaseMock();
    movieBloc = MovieBloc(getMovieDetailUseCase: getMovieDetailUseCase);
  });

  group('Movie Bloc', () {
    blocTest<MovieBloc, MovieState>(
      'should emit [MovieLoadingState, MovieSuccessState] when usecase return a movie detail',
      build: () {
        when(() => getMovieDetailUseCase.execute(id: 'test')).thenAnswer(
          (_) async => right(
            const MovieDetail(
              title: 'title',
              year: 'year',
              rated: 'rated',
              released: 'released',
              runtime: 'runtime',
              genre: ['genre'],
              director: ['director'],
              writer: ['writer'],
              actors: ['actors'],
              plot: 'plot',
              language: ['language'],
              country: ['country'],
              awards: 'awards',
              poster: 'poster',
              metascore: 'metascore',
              imdbRating: 'imdbRating',
              imdbVotes: 'imdbVotes',
              imdbId: 'imdbId',
              type: 'type',
              dvd: 'dvd',
              boxOffice: 'boxOffice',
              ratings: [
                Rating(
                  source: 'source',
                  value: 'value',
                ),
              ],
            ),
          ),
        );
        return movieBloc;
      },
      act: (bloc) async => movieBloc.add(GetMovieDetail(id: 'test')),
      expect: () {
        return [
          isA<MovieLoadingState>(),
          isA<MovieSuccessState>(),
        ];
      },
      verify: (_) {
        verify(() => getMovieDetailUseCase.execute(id: 'test')).called(1);
        verifyNoMoreInteractions(getMovieDetailUseCase);
      },
    );

    blocTest<MovieBloc, MovieState>(
      'should emit [MovieLoadingState, MovieErrorState] when usecase return a subclass os MovieFailure',
      build: () {
        when(() => getMovieDetailUseCase.execute(id: 'test')).thenAnswer(
          (_) async => left(const MovieDataSourceFailure(message: '')),
        );
        return movieBloc;
      },
      act: (bloc) async => movieBloc.add(GetMovieDetail(id: 'test')),
      expect: () {
        return [
          isA<MovieLoadingState>(),
          isA<MovieErrorState>(),
        ];
      },
      verify: (_) {
        verify(() => getMovieDetailUseCase.execute(id: 'test')).called(1);
        verifyNoMoreInteractions(getMovieDetailUseCase);
      },
    );
  });
}
