import 'package:equatable/equatable.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState implements HomeState {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
  // coverage:ignore-end
}

class HomeLoadingState implements HomeState {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
  // coverage:ignore-end
}

class HomeSuccessState implements HomeState {
  final ResultSearch result;

  HomeSuccessState({
    required this.result,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [result];

  @override
  bool? get stringify => true;
  // coverage:ignore-end
}

class HomeErrorState implements HomeState {
  final String errorMessage;

  HomeErrorState({
    required this.errorMessage,
  });

  // coverage:ignore-start
  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => true;
  // coverage:ignore-end
}

class HomeEmptyState implements HomeState {
  // coverage:ignore-start
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
  // coverage:ignore-end
}
