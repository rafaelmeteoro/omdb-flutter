import 'package:core/domain.dart';
import 'package:core/presentation.dart';

import 'features/movie/data/remote_movie_detail_repository.dart';
import 'features/movie/domain/interfaces/get_movie_detail_use_case.dart';
import 'features/movie/domain/interfaces/movie_detail_repository.dart';
import 'features/movie/domain/usecases/get_movie_detail.dart';
import 'features/movie/presentation/controller/movie_page_controller.dart';
import 'features/movie/presentation/pages/movie_page.dart';

class MovieModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // Repository
        Bind.lazySingleton<MovieDetailRepository>(
          (i) => RemoteMovieDetailRepository(
            dio: i.get<Dio>(),
          ),
        ),
        // UseCase
        Bind.lazySingleton<GetMovieDetailUseCase>(
          (i) => GetMovieDetail(
            repository: i.get<MovieDetailRepository>(),
          ),
        ),
        // Controller
        Bind.lazySingleton<MoviePageController>(
          (i) => MoviePageController(
            getMovieDetailUseCase: i.get<GetMovieDetailUseCase>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => MoviePage(
            id: args.data as String,
            controller: Modular.get<MoviePageController>(),
          ),
        ),
      ];
}
