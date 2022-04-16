abstract class CustomException {
  final String message;
  final StackTrace? stackTrace;

  CustomException({
    required this.message,
    required this.stackTrace,
  });
}

class DataSourceException extends CustomException {
  DataSourceException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}

class NoInternetException extends CustomException {
  NoInternetException({
    required String message,
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
