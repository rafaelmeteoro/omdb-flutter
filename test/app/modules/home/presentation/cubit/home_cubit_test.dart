import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';
import 'package:omdb_flutter/app/modules/home/domain/errors/failures.dart';
import 'package:omdb_flutter/app/modules/home/domain/usecases/get_movies.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/events.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/home_cubit.dart';
import 'package:omdb_flutter/app/modules/home/presentation/cubit/states.dart';

class GetMoviesUseCaseMock extends Mock implements IGetMoviesUseCase {}

void main() {
  late IGetMoviesUseCase getMoviesUseCase;
  late HomeCubit homeCubit;

  setUp(() {
    getMoviesUseCase = GetMoviesUseCaseMock();
    homeCubit = HomeCubit(getMoviesUseCase: getMoviesUseCase);
  });

  group('Home Cubit - No BlockTest', () {
    test(
        'should emit [HomeLoadingState, HomeSuccessState] when usecase returns a non empty list',
        () async {
      // Arrange
      const String searchText = 'anything';
      when(() => getMoviesUseCase.call(title: searchText)).thenAnswer(
        (_) async => ResultSearch(
          search: [
            HomeMovieEntity(
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
      );

      // Assert
      expectLater(
        homeCubit.stream,
        emitsInOrder(
          [
            isA<HomeLoadingState>(),
            isA<HomeSuccessState>(),
          ],
        ),
      );

      // Act
      homeCubit.add(SearchMoviesEvent(searchText: searchText));
    });

    test(
        'should emit [HomeLoadingState, HomeEmptyState] when usecase returns an empty list',
        () async {
      // Arrange
      const String searchText = 'anything';
      when(() => getMoviesUseCase.call(title: searchText)).thenAnswer(
        (_) async => ResultSearch(
          search: [],
          totalResults: '0',
          response: '',
        ),
      );

      // Assert
      expectLater(
        homeCubit.stream,
        emitsInOrder(
          [
            isA<HomeLoadingState>(),
            isA<HomeEmptyState>(),
          ],
        ),
      );

      // Act
      homeCubit.add(SearchMoviesEvent(searchText: searchText));
    });

    test(
        'should emit [HomeLoadingState, HomeErrorState] when usecase throws a subclass of HomeFailure',
        () async {
      // Arrange
      const String searchText = 'anything';
      when(() => getMoviesUseCase.call(title: searchText))
          .thenThrow(HomeShortTitleFailure(message: ''));

      // Assert
      expectLater(
        homeCubit.stream,
        emitsInOrder(
          [
            isA<HomeLoadingState>(),
            isA<HomeErrorState>(),
          ],
        ),
      );

      // Act
      homeCubit.add(SearchMoviesEvent(searchText: searchText));
    });
  });

  group('Home Cubit - BlockTest', () {
    blocTest<HomeCubit, HomeState>(
      'should emit [HomeLoadingState, HomeSuccessState] when usecase returns a non empty list',
      build: () {
        when(() => getMoviesUseCase.call(title: 'test')).thenAnswer(
          (_) async => ResultSearch(
            search: [
              HomeMovieEntity(
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
        );
        return homeCubit;
      },
      wait: const Duration(milliseconds: 700),
      act: (bloc) async => homeCubit.add(SearchMoviesEvent(searchText: 'test')),
      expect: () {
        return [
          isA<HomeLoadingState>(),
          isA<HomeSuccessState>(),
        ];
      },
      verify: (_) {
        verify(() => getMoviesUseCase.call(title: 'test')).called(1);
        verifyNoMoreInteractions(getMoviesUseCase);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'should emit [HomeLoadingState, HomeEmptyState] when usecase returns an empty list',
      build: () {
        when(() => getMoviesUseCase.call(title: 'test')).thenAnswer(
          (_) async => ResultSearch(
            search: [],
            totalResults: '0',
            response: '',
          ),
        );
        return homeCubit;
      },
      wait: const Duration(milliseconds: 700),
      act: (bloc) async => homeCubit.add(SearchMoviesEvent(searchText: 'test')),
      expect: () {
        return [
          isA<HomeLoadingState>(),
          isA<HomeEmptyState>(),
        ];
      },
      verify: (_) {
        verify(() => getMoviesUseCase.call(title: 'test')).called(1);
        verifyNoMoreInteractions(getMoviesUseCase);
      },
    );

    blocTest<HomeCubit, HomeState>(
      'should emit [HomeLoadingState, HomeErrorState] when usecase throws a subclass of HomeFailure',
      build: () {
        when(() => getMoviesUseCase.call(title: 'test'))
            .thenThrow(HomeShortTitleFailure(message: ''));
        return homeCubit;
      },
      wait: const Duration(milliseconds: 700),
      act: (bloc) async => homeCubit.add(SearchMoviesEvent(searchText: 'test')),
      expect: () {
        return [
          isA<HomeLoadingState>(),
          isA<HomeErrorState>(),
        ];
      },
      verify: (_) {
        verify(() => getMoviesUseCase.call(title: 'test')).called(1);
        verifyNoMoreInteractions(getMoviesUseCase);
      },
    );
  });
}
