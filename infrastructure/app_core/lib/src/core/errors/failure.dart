import 'package:core/domain.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String? message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message);
}
