import 'dart:convert';

import 'package:asset_steward_app/core/errors/failure.dart';
import 'package:chirp/chirp.dart';
import 'package:dio/dio.dart';

class ErrorHandler {
  const ErrorHandler._();

  /// Maps any thrown object to a clean domain [Failure].
  static Failure handle(Object e, [StackTrace? stackTrace]) {
    if (e is Failure) return e;

    if (e is DioException) {
      return _handleDioException(e, stackTrace ?? e.stackTrace);
    }

    // Log unexpected errors so they aren't silently swallowed
    Chirp.error('Unexpected Error', error: e, stackTrace: stackTrace);
    return Failure('An unexpected error occurred.', exception: e, stackTrace: stackTrace);
  }

  static Failure _handleDioException(DioException e, StackTrace? stackTrace) {
    if (e.type == .connectionError || e.type == .connectionTimeout || e.type == .unknown) {
      return const Failure('No internet connection. Please check your network.');
    }

    if (e.type == .receiveTimeout || e.type == .sendTimeout) {
      return const Failure('Connection timed out. Please try again.');
    }

    if (e.type == .cancel) {
      return const Failure('Request was cancelled.');
    }

    final status = e.response?.statusCode ?? 0;
    var data = e.response?.data;

    if (data is String && !data.toLowerCase().startsWith('<!doctype html>')) {
      try {
        data = jsonDecode(data);
      } catch (_) {}
    }

    String? serverMessage;
    if (data is Map<String, dynamic>) {
      if (data['message'] != null && data['message'] != 'Validation Error') {
        serverMessage = data['message'].toString();
      } else if (data['error'] != null) {
        serverMessage = data['error'].toString();
      }
    }

    if (serverMessage != null && serverMessage.isNotEmpty) {
      return Failure(serverMessage, exception: e, stackTrace: stackTrace);
    }

    return Failure('Server error occurred (Code: $status)', exception: e, stackTrace: stackTrace);
  }
}
