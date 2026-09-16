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
}
