// ignore_for_file: unused_import
import 'package:movie/movie.dart';
import 'package:movie/src/infra/datasource/movie_detail_remote_datasource_interface.dart';
import 'package:movie/src/infra/repositories/movie_detail_repository.dart';
import 'package:movie/src/movie_module.dart';
import 'package:movie/src/external/datasource/movie_detail_remote_datasource.dart';
import 'package:movie/src/external/adapter/rating_adapter.dart';
import 'package:movie/src/external/adapter/movie_detail_adapter.dart';
import 'package:movie/src/domain/repositories/movie_detail_repository_interface.dart';
import 'package:movie/src/domain/errors/failures.dart';
import 'package:movie/src/domain/usecase/get_movie_detail.dart';
import 'package:movie/src/domain/entities/movie_detail.dart';
import 'package:movie/src/domain/entities/rating.dart';
import 'package:movie/src/presentation/pages/movie_page.dart';
import 'package:movie/src/presentation/widgets/movie_detail_app_bar.dart';
import 'package:movie/src/presentation/widgets/movie_detail_title.dart';
import 'package:movie/src/presentation/widgets/movie_detail_plot.dart';
import 'package:movie/src/presentation/widgets/movie_detail_infos.dart';
import 'package:movie/src/presentation/widgets/movie_detail_info_list.dart';
import 'package:movie/src/presentation/widgets/movie_detail_content.dart';
import 'package:movie/src/presentation/widgets/movie_detail_wishlist_button.dart';
import 'package:movie/src/presentation/bloc/movie_bloc.dart';
import 'package:movie/src/presentation/bloc/movie_state.dart';
import 'package:movie/src/presentation/bloc/movie_event.dart';

void main() {}
