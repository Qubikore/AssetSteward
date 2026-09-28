import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../datasources/maintenance_remote_datasource.dart';
import '../models/maintenance_response.dart';

@lazySingleton
class MaintenanceRepository with RepoRunner {
  MaintenanceRepository(this._remoteDS);

  final MaintenanceRemoteDS _remoteDS;

  FutureResult<List<MaintenanceResponse>> getAllMaintenance() async {
    return runRepoTask(() => _remoteDS.getAllMaintenance());
  }

  FutureResult<MaintenanceResponse> startMaintenance(QMap data) async {
    return runRepoTask(() => _remoteDS.startMaintenance(data));
  }

  FutureResult<MaintenanceResponse> completeMaintenance(int id) async {
    return runRepoTask(() => _remoteDS.completeMaintenance(id));
  }
}
