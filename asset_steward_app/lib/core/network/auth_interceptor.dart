import 'dart:async';

import 'package:asset_steward_app/main.export.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenStorage.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final path = err.requestOptions.path;

    if (path.contains(Endpoints.login)) return handler.next(err);

    if (err.response?.statusCode == 401) {
      AppEventBus().fire(const SessionExpiredEvent());
    }

    handler.next(err);
  }
}
