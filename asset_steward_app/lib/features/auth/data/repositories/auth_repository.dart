import 'package:asset_steward_app/main.export.dart';
import 'package:injectable/injectable.dart';

import '../datasources/auth_remote_datasources.dart';

@lazySingleton
class AuthRepo with RepoRunner {
  final AuthRemoteDS remote;
  final TokenStorage _tokenStorage;

  AuthRepo(this.remote, this._tokenStorage);

  Future<bool> isLoggedIn() async {
    final token = await _tokenStorage.getAccessToken();
    return token != null;
  }

  FutureResult<String> login(QMap form) async {
    return runRepoTask(() => remote.login(form));
  }

  FutureResult<String> register(QMap form) async {
    return runRepoTask(() => remote.register(form));
  }
}
