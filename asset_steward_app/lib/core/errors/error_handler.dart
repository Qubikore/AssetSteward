import 'package:asset_steward_app/core/errors/failure.dart';
import 'package:dio/dio.dart';

Failure mapError(Object e, [StackTrace? stackTrace]) {
  if (e is DioException) {
    stackTrace ??= e.stackTrace;
    return switch (e.type) {
      .connectionError => Failure('No internet connection', exception: e, stackTrace: stackTrace),
      .connectionTimeout || .receiveTimeout => Failure('Connection timed out', exception: e, stackTrace: stackTrace),
      .badResponse => _badResponse(e, stackTrace),
      .cancel => Failure('Request cancelled', exception: e, stackTrace: stackTrace),
      _ => Failure('Something went wrong', exception: e, stackTrace: stackTrace),
    };
  }

  if (e is Exception) return Failure('Something went wrong', exception: e, stackTrace: stackTrace);

  if (e is Failure) return e;

  return Failure('Something went wrong', exception: e, stackTrace: stackTrace);
}

Failure _badResponse(DioException e, StackTrace? stackTrace) {
  final data = e.response?.data;
  if (data case {'message': final String message}) {
    return Failure(message, exception: e, stackTrace: stackTrace);
  }
  return Failure('Something went wrong', exception: e, stackTrace: stackTrace);
}
