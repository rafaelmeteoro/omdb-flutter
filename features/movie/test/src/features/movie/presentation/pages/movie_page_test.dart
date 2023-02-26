import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/get_movie_detail_use_case.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_page_controller.dart';
import 'package:movie/src/features/movie/presentation/pages/movie_page.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_content.dart';

class GetMovieDetailUseCaseMock extends Mock implements GetMovieDetailUseCase {}

void main() {
  late GetMovieDetailUseCase mockUseCase;
  late MoviePageController controller;

  setUp(() {
    mockUseCase = GetMovieDetailUseCaseMock();
    controller = MoviePageController(getMovieDetailUseCase: mockUseCase);
  });

  group('MoviePage', () {
    Widget moviePageApp() {
      return MaterialApp(
        home: Material(
          child: MoviePage(
            id: 'some-id',
            controller: controller,
          ),
        ),
      );
    }

    final movieDetailEntity = MovieDetailEntity(
      title: 'title',
      year: 'year',
      rated: 'rated',
      released: 'released',
      runtime: '120 min',
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
      ratings: [
        RatingEntity(
          source: 'source',
          value: 'value',
        ),
      ],
    );

    testWidgets('show progress indicator when state is loading',
        (tester) async {
      when(() => mockUseCase.call(id: any(named: 'id'))).thenAnswer(
        (_) async => right(movieDetailEntity),
      );

      await tester.pumpWidget(moviePageApp());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('show detail content when state is success', (tester) async {
      when(() => mockUseCase.call(id: any(named: 'id'))).thenAnswer(
        (_) async => right(movieDetailEntity),
      );

      await tester.pumpWidget(moviePageApp());
      await tester.pumpAndSettle();

      expect(find.byType(MovieDetailContent), findsOneWidget);
    });

    testWidgets('show text when state is error', (tester) async {
      when(() => mockUseCase.call(id: any(named: 'id'))).thenAnswer(
        (_) async => left(MovieDetailFailure(message: 'server failure')),
      );

      await tester.pumpWidget(moviePageApp());
      await tester.pumpAndSettle();
    });
  });
}
