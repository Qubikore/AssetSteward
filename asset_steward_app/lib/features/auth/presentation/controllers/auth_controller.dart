import 'package:asset_steward_app/features/profile/presentation/controllers/profile_controller.dart';
import 'package:asset_steward_app/features/users/presentation/controllers/users_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../main.export.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthCtrl extends _$AuthCtrl {
  final _repo = di.get<AuthRepo>();
  @override
  Future<bool> build() async {
    return _repo.isLoggedIn();
  }

  FutureResult<String> login(Map<String, dynamic> form) async {
    final result = await _repo.login(form);
    if (result.isRight()) {
      ref.invalidate(usersCtrlProvider);
      ref.invalidate(profileCtrlProvider, asReload: true);
      // ref.invalidate(organizationCtrlProvider);
      ref.invalidateSelf();
    }
    return result;
  }

  FutureResult<String> registerOrganization(Map<String, dynamic> form) async {
    final result = await _repo.registerOrganization(form);
    if (result.isRight()) {
      ref.invalidateSelf();
    }
    return result;
  }

  FutureResult<void> logout() async {
    final result = await _repo.logout();
    if (result.isRight()) {
      ref.invalidateSelf();
    }
    return result;
  }
}
