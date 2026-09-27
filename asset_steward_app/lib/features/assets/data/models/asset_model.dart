import 'package:asset_steward_app/features/categories/data/models/category_model.dart';
import 'package:asset_steward_app/features/locations/data/models/location_model.dart';
import 'package:asset_steward_app/features/departments/data/models/department_model.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'asset_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.camelCase)
class AssetModel with AssetModelMappable {
  static const fromMap = AssetModelMapper.fromMap;
  static const fromJson = AssetModelMapper.fromJson;

  final int id;
  final String assetCode;
  final String name;
  final String? serialNumber;
  final String purchaseDate;
  final String? expireDate;
  final double purchasePrice;
  final String? vendor;
  final int quantity;
  final String status;
  final CategoryModel? category;
  final LocationModel? location;
  final DepartmentModel? department;

  const AssetModel({
    required this.id,
    required this.assetCode,
    required this.name,
    this.serialNumber,
    required this.purchaseDate,
    this.expireDate,
    required this.purchasePrice,
    this.vendor,
    this.quantity = 0,
    required this.status,
    this.category,
    this.location,
    this.department,
  });

  bool get isAvailable => status.toLowerCase() == 'available';
}
