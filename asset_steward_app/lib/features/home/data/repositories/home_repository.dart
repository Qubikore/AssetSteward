import 'package:injectable/injectable.dart';

import '../../../../main.export.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/asset_utilization.dart';
import '../models/dashboard_metrics.dart';

@lazySingleton
class HomeRepository with RepoRunner {
  HomeRepository(this._remoteDS);

  final HomeRemoteDS _remoteDS;

  FutureResult<DashboardMetrics> getMetrics() async {
    return runRepoTask(() => _remoteDS.getMetrics());
  }

  FutureResult<List<AssetUtilization>> getUtilization() async {
    return runRepoTask(() => _remoteDS.getUtilization());
  }
}
