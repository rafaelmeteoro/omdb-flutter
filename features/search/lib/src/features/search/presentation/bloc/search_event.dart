import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class OnQueryChanged extends SearchEvent {
  final String query;

  OnQueryChanged({required this.query});

  @override
  List<Object?> get props => [query];
}
