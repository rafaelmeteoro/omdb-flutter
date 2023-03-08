class MovieStorageException extends Error {
  MovieStorageException({
    required this.message,
  });

  final String message;
}
