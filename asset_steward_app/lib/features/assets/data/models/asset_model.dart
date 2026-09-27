import 'package:asset_steward_app/features/categories/data/models/category_model.dart';
import 'package:asset_steward_app/features/departments/data/models/department_model.dart';
import 'package:asset_steward_app/features/locations/data/models/location_model.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'asset_model.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.snakeCase)
enum AssetStatus {
  available,
  assigned,
  maintenance,
  pendingApproval,
  retired;

  Color get color {
    switch (this) {
      case AssetStatus.available:
        return Colors.green;
      case AssetStatus.assigned:
        return Colors.blue;
      case AssetStatus.maintenance:
        return Colors.orange;
      case AssetStatus.pendingApproval:
        return Colors.orange.shade700;
      case AssetStatus.retired:
        return Colors.grey;
    }
  }
}

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
  final AssetStatus status;
  final CategoryModel? category;
  final LocationModel? location;
  final DepartmentModel? department;

  const AssetModel({
    required this.id,
    required this.assetCode,
    required this.name,
    required this.purchasePrice,
    required this.purchaseDate,
    required this.status,
    this.serialNumber,
    this.expireDate,
    this.vendor,
    this.quantity = 0,
    this.category,
    this.location,
    this.department,
  });

  bool get isAvailable => status == AssetStatus.available;
}
