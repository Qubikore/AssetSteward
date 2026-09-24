import 'package:dart_mappable/dart_mappable.dart';

part 'location_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class LocationModel with LocationModelMappable {
  static const fromMap = LocationModelMapper.fromMap;
  static const fromJson = LocationModelMapper.fromJson;

  final int id;
  final String name;
  final String? address;

  const LocationModel({
    required this.id,
    required this.name,
    this.address,
  });
}
