import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';

@lazySingleton
class AuthRemoteDS {
  AuthRemoteDS(this._dio);

  final Dio _dio;

  Future<String> login(String email, String password) async {
    final response = await _dio.get(Endpoints.login);

    if (response.data case {'token': String token}) {
      return token;
    } else {
      throw Failure('Invalid response format');
    }
  }
}
