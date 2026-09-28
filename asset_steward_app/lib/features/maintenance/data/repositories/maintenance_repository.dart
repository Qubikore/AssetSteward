import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../datasources/maintenance_remote_datasource.dart';
import '../models/maintenance_model.dart';

@lazySingleton
class MaintenanceRepository with RepoRunner {
  MaintenanceRepository(this._remoteDS);

  final MaintenanceRemoteDS _remoteDS;

  FutureResult<List<MaintenanceModel>> getAllMaintenance() async {
    return runRepoTask(() => _remoteDS.getAllMaintenance());
  }

  FutureResult<MaintenanceModel> startMaintenance(QMap data) async {
    return runRepoTask(() => _remoteDS.startMaintenance(data));
  }

  FutureResult<MaintenanceModel> completeMaintenance(int id) async {
    return runRepoTask(() => _remoteDS.completeMaintenance(id));
  }
}
