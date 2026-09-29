import 'dart:async';

import 'package:asset_steward_app/features/assets/presentation/controllers/assets_controller.dart';
import 'package:asset_steward_app/features/maintenance/data/models/maintenance_model.dart';
import 'package:asset_steward_app/features/maintenance/data/repositories/maintenance_repository.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'maintenance_controller.g.dart';

@Riverpod(keepAlive: true)
class MaintenanceCtrl extends _$MaintenanceCtrl {
  final _repo = di.get<MaintenanceRepository>();

  @override
  FutureOr<List<MaintenanceModel>> build() async {
    return _fetchMaintenance();
  }

  Future<List<MaintenanceModel>> _fetchMaintenance() async {
    final result = await _repo.getAllMaintenance();
    return result.fold((l) => throw l, (r) => r);
  }

  Future<void> refresh([bool silent = true]) async {
    if (!silent) state = const AsyncLoading();

    state = await AsyncValue.guard(_fetchMaintenance);
  }

  Future<bool> startMaintenance(QMap data) async {
    final result = await _repo.startMaintenance(data);

    return result.fold(
      (f) async {
        Toast.showError(f.message);
        return false;
      },
      (r) {
        ref.invalidate(assetsCtrlProvider);
        ref.invalidate(myAssetsCtrlProvider);
        Toast.showSuccess('Maintenance started');
        ref.invalidateSelf();
        return true;
      },
    );
  }

  Future<bool> completeMaintenance(int id) async {
    final result = await _repo.completeMaintenance(id);

    return result.fold(
      (f) {
        Toast.showError(f.message);
        return false;
      },
      (r) {
        Toast.showSuccess('Maintenance completed');
        ref.invalidateSelf();
        ref.invalidate(assetsCtrlProvider);
        ref.invalidate(myAssetsCtrlProvider);
        return true;
      },
    );
  }
}
