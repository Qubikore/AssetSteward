import 'dart:async';

import 'package:asset_steward_app/main.export.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  final Dio _refreshDio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl));
  Future<bool>? _refreshTokenFuture;

  static final StreamController<void> sessionExpiredController = StreamController<void>.broadcast();
  static Stream<void> get onSessionExpired => sessionExpiredController.stream;

  static CancelToken _sessionCancelToken = CancelToken();

  static void cancelOngoingRequests() {
    _sessionCancelToken.cancel('Session expired. Canceling ongoing requests.');
    _sessionCancelToken = CancelToken();
  }

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.cancelToken ??= _sessionCancelToken;

    final token = await _tokenStorage.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final path = err.requestOptions.path;

    if (path.contains(Endpoints.refresh) || path.contains(Endpoints.login)) return handler.next(err);

    if (err.response?.statusCode == 401) {
      final success = await _refreshToken();

      if (success) {
        try {
          final newToken = await _tokenStorage.getAccessToken();
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';

          final response = await _refreshDio.fetch(options);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }

    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    // If a refresh is already in progress, wait for it
    if (_refreshTokenFuture != null) return await _refreshTokenFuture!;

    _refreshTokenFuture = _performRefresh();
    final result = await _refreshTokenFuture!;
    _refreshTokenFuture = null;
    return result;
  }

  Future<bool> _performRefresh() async {
    try {
      final refreshToken = await _tokenStorage.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await _refreshDio.post(Endpoints.refresh, data: {'refreshToken': refreshToken});

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data case {'accessToken': final String access, 'refreshToken': final String refresh}) {
          await _tokenStorage.saveTokens(accessToken: access, refreshToken: refresh);
          return true;
        }
      }

      // If refresh failed, clean up
      await _tokenStorage.clearTokens();
      return false;
    } catch (e) {
      await _tokenStorage.clearTokens();
      return false;
    }
  }
}
