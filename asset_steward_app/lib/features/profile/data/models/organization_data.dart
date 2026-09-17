import 'package:dart_mappable/dart_mappable.dart';

part 'organization_data.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class OrganizationData with OrganizationDataMappable {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String location;

  const OrganizationData({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
  });

  static const fromMap = OrganizationDataMapper.fromMap;
  static const fromJson = OrganizationDataMapper.fromJson;
}
