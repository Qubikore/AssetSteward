import 'package:dart_mappable/dart_mappable.dart';

part 'maintenance_request.mapper.dart';

@MappableClass(caseStyle: CaseStyle.camelCase)
class MaintenanceRequest with MaintenanceRequestMappable {
  static const fromMap = MaintenanceRequestMapper.fromMap;
  static const fromJson = MaintenanceRequestMapper.fromJson;

  final int assetId;
  final String description;
  final double cost;
  final String provider;
  final String startDate;

  MaintenanceRequest({
    required this.assetId,
    required this.description,
    required this.cost,
    required this.provider,
    required this.startDate,
  });
}
