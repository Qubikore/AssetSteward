import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/profile/data/models/profile_model.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'maintenance_model.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.upperSnakeCase, defaultValue: MaintenanceStatus.unknown)
enum MaintenanceStatus { inProgress, completed, unknown }

@MappableClass(caseStyle: CaseStyle.camelCase)
class MaintenanceModel with MaintenanceModelMappable {
  static const fromMap = MaintenanceModelMapper.fromMap;
  static const fromJson = MaintenanceModelMapper.fromJson;

  final int id;
  final AssetModel asset;
  final String description;
  final double cost;
  final String? provider;
  final String startDate;
  final String? endDate;
  final MaintenanceStatus status;
  final ProfileModel? startedBy;
  final ProfileModel? endedBy;

  MaintenanceModel({
    required this.id,
    required this.asset,
    required this.description,
    required this.cost,
    this.provider,
    required this.startDate,
    this.endDate,
    required this.status,
    this.startedBy,
    this.endedBy,
  });

  // Helper getters for backward compatibility with UI if needed
  int get assetId => asset.id;
  String? get assetName => asset.name;
}
