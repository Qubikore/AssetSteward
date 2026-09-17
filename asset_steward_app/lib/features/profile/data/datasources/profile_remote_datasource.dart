import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../models/organization_data.dart';
import '../models/profile_data.dart';

@lazySingleton
class ProfileRemoteDS {
  ProfileRemoteDS(this._dio);

  final Dio _dio;

  Future<ProfileData> getProfile() async {
    final response = await _dio.get(Endpoints.profile);
    ProfileDataMapper.ensureInitialized();
    final res = ApiResponse.fromMap<ProfileData>(response.data);

    if (res case ApiResponse(success: true, data: final ProfileData data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<OrganizationData> getOrganization() async {
    final response = await _dio.get(Endpoints.organizationMe);
    final res = ApiResponse.fromMap<OrganizationData>(response.data);

    if (res case ApiResponse(success: true, data: final OrganizationData data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }

  Future<ProfileData> updateProfile(FormData data) async {
    final response = await _dio.put(Endpoints.profile, data: data);
    final res = ApiResponse.fromMap<ProfileData>(response.data);

    if (res case ApiResponse(success: true, data: final ProfileData data)) {
      return data;
    } else {
      throw Failure(res.message.isNotEmpty ? res.message : 'Invalid response format');
    }
  }
}
