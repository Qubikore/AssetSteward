import 'package:dart_mappable/dart_mappable.dart';

part 'dashboard_metrics.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class DashboardMetrics with DashboardMetricsMappable {
  static const fromMap = DashboardMetricsMapper.fromMap;
  static const fromJson = DashboardMetricsMapper.fromJson;

  final int totalAssets;
  final int availableAssets;
  final int assignedAssets;
  final int maintenanceAssets;
  final double totalAssetValue;

  const DashboardMetrics({
    this.totalAssets = 0,
    this.availableAssets = 0,
    this.assignedAssets = 0,
    this.maintenanceAssets = 0,
    this.totalAssetValue = 0,
  });
}
