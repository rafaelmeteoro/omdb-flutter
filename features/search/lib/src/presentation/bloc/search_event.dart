import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {}

class OnQueryChanged implements SearchEvent {
  final String query;

  OnQueryChanged({required this.query});

  @override
  List<Object?> get props => [query];

  @override
  bool? get stringify => true;
}
