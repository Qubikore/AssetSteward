import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import 'package:asset_steward_app/features/profile/data/models/profile_data.dart';

@lazySingleton
class UsersRemoteDS {
  UsersRemoteDS(this._dio);

  final Dio _dio;

  Future<List<ProfileData>> getUsers() async {
    final response = await _dio.get(Endpoints.users);
    ProfileDataMapper.ensureInitialized();
    final res = ApiResponse.fromMap<List<ProfileData>>(response.data);

    if (res case ApiResponse(success: true, data: final List<ProfileData> data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<ProfileData> createUser(QMap data) async {
    final response = await _dio.post(Endpoints.users, data: data);
    ProfileDataMapper.ensureInitialized();
    final res = ApiResponse.fromMap<ProfileData>(response.data);

    if (res case ApiResponse(success: true, data: final ProfileData user)) {
      return user;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
