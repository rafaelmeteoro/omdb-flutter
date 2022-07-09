import 'package:equatable/equatable.dart';
import 'package:search/src/features/search/domain/entities/result_search_entity.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SearchEmptyState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchErrorState extends SearchState {
  final String message;

  SearchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class SearchSuccessState extends SearchState {
  final ResultSearchEntity result;

  SearchSuccessState({required this.result});

  @override
  List<Object?> get props => [result];
}
