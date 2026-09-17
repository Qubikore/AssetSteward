import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/organization_data.dart';
import '../models/profile_data.dart';

@lazySingleton
class ProfileRepository with RepoRunner {
  ProfileRepository(this._remoteDS);

  final ProfileRemoteDS _remoteDS;

  FutureResult<ProfileData> getProfile() async {
    return runRepoTask(() => _remoteDS.getProfile());
  }

  FutureResult<OrganizationData> getOrganization() async {
    return runRepoTask(() => _remoteDS.getOrganization());
  }

  FutureResult<ProfileData> updateProfile(FormData data) async {
    return runRepoTask(() => _remoteDS.updateProfile(data));
  }
}
