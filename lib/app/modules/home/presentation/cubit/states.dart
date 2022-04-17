import 'package:equatable/equatable.dart';
import 'package:omdb_flutter/app/modules/home/domain/entities/home_entity.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState implements HomeState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class HomeLoadingState implements HomeState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}

class HomeSuccessState implements HomeState {
  final ResultSearch result;

  HomeSuccessState({
    required this.result,
  });

  @override
  List<Object?> get props => [result];

  @override
  bool? get stringify => true;
}

class HomeErrorState implements HomeState {
  final String errorMessage;

  HomeErrorState({
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [errorMessage];

  @override
  bool? get stringify => true;
}

class HomeEmptyState implements HomeState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => true;
}
