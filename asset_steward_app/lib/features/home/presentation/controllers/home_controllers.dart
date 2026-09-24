import 'dart:async';

import 'package:asset_steward_app/features/home/data/models/asset_utilization.dart';
import 'package:asset_steward_app/features/home/data/models/dashboard_metrics.dart';
import 'package:asset_steward_app/features/home/data/repositories/home_repository.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controllers.g.dart';

@Riverpod(keepAlive: true)
class DashboardMetricsCtrl extends _$DashboardMetricsCtrl {
  final _repo = di.get<HomeRepository>();

  @override
  FutureOr<DashboardMetrics> build() async {
    final result = await _repo.getMetrics();
    return result.fold((l) => throw l, (r) => r);
  }
}

@Riverpod(keepAlive: true)
class AssetUtilizationCtrl extends _$AssetUtilizationCtrl {
  final _repo = di.get<HomeRepository>();

  @override
  FutureOr<List<AssetUtilization>> build() async {
    final result = await _repo.getUtilization();
    return result.fold((l) => throw l, (r) => r);
  }
}
