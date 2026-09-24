import 'package:dart_mappable/dart_mappable.dart';

part 'category_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.camelCase)
class CategoryModel with CategoryModelMappable {
  static const fromMap = CategoryModelMapper.fromMap;
  static const fromJson = CategoryModelMapper.fromJson;

  final int id;
  final String name;

  const CategoryModel({
    required this.id,
    required this.name,
  });
}
