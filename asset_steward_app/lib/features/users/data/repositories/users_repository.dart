import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import 'package:asset_steward_app/features/profile/data/models/profile_data.dart';
import '../datasources/users_remote_datasource.dart';

@lazySingleton
class UsersRepository with RepoRunner {
  UsersRepository(this._remoteDS);

  final UsersRemoteDS _remoteDS;

  FutureResult<List<ProfileData>> getUsers() async {
    return runRepoTask(() => _remoteDS.getUsers());
  }

  FutureResult<ProfileData> createUser(QMap data) async {
    return runRepoTask(() => _remoteDS.createUser(data));
  }
}
