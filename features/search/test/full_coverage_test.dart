// ignore_for_file: unused_import
import 'package:search/search.dart';
import 'package:search/src/core/typdef/signatures.dart';
import 'package:search/src/search_module.dart';
import 'package:search/src/features/search/infra/datasource/search_remote_datasource_interface.dart';
import 'package:search/src/features/search/infra/repositories/search_movie_repository.dart';
import 'package:search/src/features/search/external/datasource/search_remote_datasource.dart';
import 'package:search/src/features/search/data/dto/result_search_dto.dart';
import 'package:search/src/features/search/data/dto/movie_dto.dart';
import 'package:search/src/features/search/domain/repositories/search_movie_repository_interface.dart';
import 'package:search/src/features/search/domain/errors/failures.dart';
import 'package:search/src/features/search/domain/usecase/search_movies.dart';
import 'package:search/src/features/search/domain/entities/movie_entity.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_repository.dart';
import 'package:search/src/features/search/domain/interfaces/search_movie_use_case.dart';
import 'package:search/src/features/search/presentation/pages/search_page.dart';
import 'package:search/src/features/search/presentation/widgets/search_text_field.dart';
import 'package:search/src/features/search/presentation/widgets/item_card_list.dart';
import 'package:search/src/features/search/presentation/bloc/search_event.dart';
import 'package:search/src/features/search/presentation/bloc/search_state.dart';
import 'package:search/src/features/search/presentation/bloc/search_bloc.dart';

void main() {}
