import 'dart:developer' show log;

import 'package:asset_steward_app/main.export.dart';
import 'package:chirp_addons/chirp_addons.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

final chirpDioLogger = ChirpLogger(name: 'DIO')
  ..addConsoleWriter(
    output: (x) => log(x),
    capabilities: TerminalCapabilities(colorSupport: .ansi256),
    formatter: DioChirpFormatter(),
  );

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio(AuthInterceptor authInterceptor) {
    final dio = Dio(BaseOptions(baseUrl: Endpoints.baseUrl));

    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(ChirpDioInterceptor(chirpDioLogger));

    return dio;
  }
}
