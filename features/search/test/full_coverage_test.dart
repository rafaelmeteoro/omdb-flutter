// ignore_for_file: unused_import
import 'package:search/search.dart';
import 'package:search/src/infra/datasource/search_remote_datasource_interface.dart';
import 'package:search/src/infra/repositories/search_movie_repository.dart';
import 'package:search/src/search_module.dart';
import 'package:search/src/external/datasource/search_remote_datasource.dart';
import 'package:search/src/external/adapter/search_result_adapter.dart';
import 'package:search/src/external/adapter/search_movie_adapter.dart';
import 'package:search/src/data/dto/result_search_dto.dart';
import 'package:search/src/data/dto/movie_dto.dart';
import 'package:search/src/domain/repositories/search_movie_repository_interface.dart';
import 'package:search/src/domain/errors/failures.dart';
import 'package:search/src/domain/usecase/search_movies.dart';
import 'package:search/src/domain/entities/movie_entity.dart';
import 'package:search/src/domain/entities/result_search.dart';
import 'package:search/src/domain/entities/movie.dart';
import 'package:search/src/domain/entities/result_search_entity.dart';
import 'package:search/src/domain/interfaces/search_movie_repository.dart';
import 'package:search/src/presentation/pages/search_page.dart';
import 'package:search/src/presentation/widgets/search_text_field.dart';
import 'package:search/src/presentation/widgets/item_card_list.dart';
import 'package:search/src/presentation/bloc/search_event.dart';
import 'package:search/src/presentation/bloc/search_state.dart';
import 'package:search/src/presentation/bloc/search_bloc.dart';

void main() {}
