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

    if (res.success && res.data?['access_token'] != null) {
      return res.data!['access_token'] as String;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<String> registerOrganization(QMap form) async {
    final response = await _dio.post(Endpoints.registerOrganization, data: form);
    final res = ApiResponse.fromMap<QMap>(response.data);

    if (res.success && res.data?['access_token'] != null) {
      return res.data!['access_token'] as String;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
