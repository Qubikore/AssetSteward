import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';

import 'package:asset_steward_app/features/profile/data/models/profile_model.dart';

@lazySingleton
class UsersRemoteDS {
  UsersRemoteDS(this._dio);

  final Dio _dio;

  Future<List<ProfileModel>> getUsers() async {
    final response = await _dio.get(Endpoints.users);
    ProfileModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<List<ProfileModel>>(response.data);

    if (res case ApiResponse(
      success: true,
      data: final List<ProfileModel> data,
    )) {
      return data;
    } else {
      throw Failure(
        res.message.isNotEmpty ? res.message : 'Invalid response format',
      );
    }
  }

  Future<ProfileModel> createUser(QMap data) async {
    final response = await _dio.post(Endpoints.users, data: data);
    ProfileModelMapper.ensureInitialized();
    final res = ApiResponse.fromMap<ProfileModel>(response.data);

    if (res case ApiResponse(success: true, data: final ProfileModel user)) {
      return user;
    } else {
      throw Failure(
        res.message.isNotEmpty ? res.message : 'Invalid response format',
      );
    }
  }
}
