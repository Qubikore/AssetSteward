import 'package:dart_mappable/dart_mappable.dart';

part 'asset_utilization.mapper.dart';

@MappableClass(caseStyle: CaseStyle.camelCase)
class AssetUtilization with AssetUtilizationMappable {
  static const fromMap = AssetUtilizationMapper.fromMap;
  static const fromJson = AssetUtilizationMapper.fromJson;

  final int assetId;
  final String assetName;
  final String assetCode;
  final String status;
  final int assignmentCount;
  final int maintenanceCount;

  const AssetUtilization({
    required this.assetId,
    required this.assetName,
    required this.assetCode,
    required this.status,
    this.assignmentCount = 0,
    this.maintenanceCount = 0,
  });
}
