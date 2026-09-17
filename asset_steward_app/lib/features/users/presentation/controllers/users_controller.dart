import 'dart:async';

import 'package:asset_steward_app/features/profile/data/models/profile_data.dart';
import 'package:asset_steward_app/features/users/data/repositories/users_repository.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_controller.g.dart';

@Riverpod(keepAlive: true)
class UsersCtrl extends _$UsersCtrl {
  @override
  FutureOr<List<ProfileData>> build() async {
    return _fetchUsers();
  }

  Future<List<ProfileData>> _fetchUsers() async {
    final repo = GetIt.I<UsersRepository>();
    final result = await repo.getUsers();
    return result.fold((l) => throw l, (r) => r);
  }

  Future<Either<Failure, ProfileData>> createUser(QMap data) async {
    final repo = GetIt.I<UsersRepository>();
    final result = await repo.createUser(data);

    result.map((user) {
      if (state.value != null) {
        state = AsyncData([...state.value!, user]);
      } else {
        ref.invalidateSelf();
      }
    });

    return result;
  }
}
