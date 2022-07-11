// ignore_for_file: unused_import
import 'package:movie/movie.dart';
import 'package:movie/src/core/typedef/signatures.dart';
import 'package:movie/src/core/errors/failure.dart';
import 'package:movie/src/features/movie/data/dto/movie_detail_dto.dart';
import 'package:movie/src/features/movie/data/dto/rating_dto.dart';
import 'package:movie/src/features/movie/data/remote_movie_detail_repository.dart';
import 'package:movie/src/features/movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/src/features/movie/domain/entities/movie_detail_entity.dart';
import 'package:movie/src/features/movie/domain/entities/rating_entity.dart';
import 'package:movie/src/features/movie/domain/interfaces/movie_detail_repository.dart';
import 'package:movie/src/features/movie/domain/interfaces/get_movie_detail_use_case.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_page_state.dart';
import 'package:movie/src/features/movie/presentation/controller/movie_page_controller.dart';
import 'package:movie/src/features/movie/presentation/pages/movie_page.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_app_bar.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_title.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_plot.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_infos.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_info_list.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_content.dart';
import 'package:movie/src/features/movie/presentation/widgets/movie_detail_wishlist_button.dart';
import 'package:movie/src/movie_module.dart';

void main() {}
