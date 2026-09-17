import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../main.export.dart';
import '../../data/models/organization_data.dart';
import '../../data/models/profile_data.dart';
import '../../data/repositories/profile_repository.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileCtrl extends _$ProfileCtrl {
  @override
  FutureOr<ProfileData> build() async {
    final repo = di.get<ProfileRepository>();
    final result = await repo.getProfile();
    return result.fold(
      (l) => throw l,
      (r) => r,
    );
  }

  FutureResult<ProfileData> updateProfile(FormData data) async {
    final repo = di.get<ProfileRepository>();
    final result = await repo.updateProfile(data);
    if (result.isRight()) {
      ref.invalidateSelf();
    }
    return result;
  }
}

@riverpod
class OrganizationCtrl extends _$OrganizationCtrl {
  @override
  FutureOr<OrganizationData> build() async {
    final repo = di.get<ProfileRepository>();
    final result = await repo.getOrganization();
    return result.fold(
      (l) => throw l,
      (r) => r,
    );
  }
}
