import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';

@lazySingleton
class AuthRemoteDS {
  AuthRemoteDS(this._dio);

  final Dio _dio;

  Future<String> login(QMap form) async {
    final response = await _dio.post(Endpoints.login, data: form);

    if (response.data case {'data': {'access_token': final String token}}) {
      return token;
    } else {
      throw const Failure('Invalid response format');
    }
  }

  Future<String> registerOrganization(QMap form) async {
    final response = await _dio.post(Endpoints.registerOrganization, data: form);

    if (response.data case {'data': {'access_token': final String token}}) {
      return token;
    } else {
      throw const Failure('Invalid response format');
    }
  }
}
