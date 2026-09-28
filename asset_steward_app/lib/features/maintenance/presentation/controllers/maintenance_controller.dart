import 'dart:async';

import 'package:asset_steward_app/features/maintenance/data/models/maintenance_response.dart';
import 'package:asset_steward_app/features/maintenance/data/repositories/maintenance_repository.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'maintenance_controller.g.dart';

@Riverpod(keepAlive: true)
class MaintenanceCtrl extends _$MaintenanceCtrl {
  final _repo = di.get<MaintenanceRepository>();

  @override
  FutureOr<List<MaintenanceResponse>> build() async {
    return _fetchMaintenance();
  }

  Future<List<MaintenanceResponse>> _fetchMaintenance() async {
    final result = await _repo.getAllMaintenance();
    return result.fold((l) => throw l, (r) => r);
  }

  Future<bool> startMaintenance(QMap data) async {
    final result = await _repo.startMaintenance(data);

    return result.fold(
      (f) async {
        Toast.showError(f.message);
        return false;
      },
      (r) {
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
        return true;
      },
    );
  }
}
