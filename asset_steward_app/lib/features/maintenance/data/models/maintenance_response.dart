import 'package:dart_mappable/dart_mappable.dart';

part 'maintenance_response.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.upperSnakeCase, defaultValue: MaintenanceStatus.unknown)
enum MaintenanceStatus {
  inProgress,
  completed,
  unknown,
}

@MappableClass(caseStyle: CaseStyle.camelCase)
class MaintenanceResponse with MaintenanceResponseMappable {
  static const fromMap = MaintenanceResponseMapper.fromMap;
  static const fromJson = MaintenanceResponseMapper.fromJson;

  final int id;
  final int assetId;
  final String? assetName;
  final String? description;
  final double? cost;
  final String? provider;
  final String? startDate;
  final String? endDate;
  final MaintenanceStatus? status;

  MaintenanceResponse({
    required this.id,
    required this.assetId,
    this.assetName,
    this.description,
    this.cost,
    this.provider,
    this.startDate,
    this.endDate,
    this.status,
  });
}
