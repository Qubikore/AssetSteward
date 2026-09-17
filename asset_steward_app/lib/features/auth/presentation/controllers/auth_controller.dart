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
      // Refresh auth state which redirects to home
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
}
