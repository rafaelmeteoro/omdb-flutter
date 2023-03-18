import 'package:dev_core/dev_core.dart';
import 'package:flutter/material.dart';
import 'package:movie/src/core/typedef/signatures.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/add_remove_movie_storage_use_case.dart';
import 'package:movie/src/features/movie/domain/interfaces/contains_movie_storage_use_case.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_add_remove_controller.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_detail_content_controller.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_app_bar.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_content.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_info_list.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_infos.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_plot.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_title.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_wishlist_button.dart';

class ContainsMovieStorageUseCaseMock extends Mock implements ContainsMovieStorageUseCase {}

class AddRemoveMovieStorageUseCaseMock extends Mock implements AddRemoveMovieStorageUseCase {}

void main() {
  final movieDetailEntity = MovieDetailEntity(
    title: 'title',
    year: 'year',
    rated: 'rated',
    released: 'released',
    runtime: 'N/A',
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
    ratings: [],
  );

  late ContainsMovieStorageUseCase useCase;
  late AddRemoveMovieStorageUseCase addRemoveUseCase;
  late MovieDetailContentController controller;
  late MovieAddRemoveController addRemoveController;

  setUp(() {
    useCase = ContainsMovieStorageUseCaseMock();
    addRemoveUseCase = AddRemoveMovieStorageUseCaseMock();
    controller = MovieDetailContentController(containsMovieStorageUseCase: useCase);
    addRemoveController = MovieAddRemoveController(useCase: addRemoveUseCase);
  });

  group(MovieDetailContent, () {
    Widget detailContentApp() {
      return MaterialApp(
        home: Material(
          child: MovieDetailContent(
            movie: movieDetailEntity,
            contentController: controller,
            addRemoveController: addRemoveController,
          ),
        ),
      );
    }

    testWidgets('show info movie detail content', (tester) async {
      when(() => useCase.call(movie: movieDetailEntity)).thenAnswer(
        (_) async => ResultContainsMovieStorage.right(false),
      );
      await tester.pumpWidget(detailContentApp());
      await tester.pumpAndSettle();

      expect(find.byType(MovieDetailContent), findsOneWidget);
      expect(find.byType(MovieDetailAppBar), findsOneWidget);
      expect(find.byType(MovieDetailTitle), findsOneWidget);
      expect(find.byType(MovieDetailInfos), findsOneWidget);
      expect(find.byType(MovieDetailWishlistButton), findsOneWidget);
      expect(find.byType(MovieDetailPlot), findsOneWidget);
      expect(find.byType(MovieDetailInfoList), findsNWidgets(6));
    });
  });
}
