import 'package:asset_steward_app/main.export.dart';
import 'package:injectable/injectable.dart';

import '../datasources/auth_remote_datasources.dart';

@lazySingleton
class AuthRepo {
  final AuthRemoteDS remote;
  final TokenStorage _tokenStorage;

  AuthRepo(this.remote, this._tokenStorage);

  Future<bool> isLoggedIn() async {
    final token = await _tokenStorage.getAccessToken();
    return token != null;
  }

  Future<void> login(String email, String password) async {
    // final result = await remote.login(email, password);
    // return result.fold((f) => f.toFuture(), (r) => r);
  }
}
