import 'package:dart_mappable/dart_mappable.dart';

part 'department_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.snakeCase)
class DepartmentModel with DepartmentModelMappable {
  static const fromMap = DepartmentModelMapper.fromMap;
  static const fromJson = DepartmentModelMapper.fromJson;

  final int id;
  final String name;

  const DepartmentModel({
    required this.id,
    required this.name,
  });
}
