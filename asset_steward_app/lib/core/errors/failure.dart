class Failure implements Exception {
  final String message;
  final Object? exception;
  final StackTrace? stackTrace;

  const Failure(this.message, {this.exception, this.stackTrace});

  Future<T> toFuture<T>() => Future.error(this, stackTrace);

  @override
  String toString() => 'Failure(message: $message, exception: $exception)';
}
