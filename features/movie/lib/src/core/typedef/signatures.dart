import 'package:app_core/app_core.dart';
import 'package:core/domain.dart';

import '../../features/movie/domain/entities/movie_detail_entity.dart';

typedef MovieDetail = Result<MovieDetailEntity>;
typedef ResultContainsMovieStorage = Result<bool>;
typedef ResultAddRemoveMovieStorage = Result<Unit>;
