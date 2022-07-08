import 'package:core/domain.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}
