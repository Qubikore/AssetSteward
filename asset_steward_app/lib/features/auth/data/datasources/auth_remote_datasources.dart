import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';

@lazySingleton
class AuthRemoteDS {
  AuthRemoteDS(this._dio);

  final Dio _dio;

  Future<String> login(QMap form) async {
    final response = await _dio.post(Endpoints.login, data: form);
    final res = ApiResponse.fromMap<QMap>(response.data);

    if (res case ApiResponse(success: true, data: {'access_token': final String token})) {
      return token;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<String> registerOrganization(QMap form) async {
    final response = await _dio.post(Endpoints.registerOrganization, data: form);
    final res = ApiResponse.fromMap<QMap>(response.data);

    if (res case ApiResponse(success: true, data: {'access_token': final String token})) {
      return token;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
