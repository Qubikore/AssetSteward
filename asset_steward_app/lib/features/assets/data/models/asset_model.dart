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
  final String? categoryName;
  final String? locationName;
  final String? departmentName;

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
    this.categoryName,
    this.locationName,
    this.departmentName,
  });

  bool get isAvailable => status.toLowerCase() == 'available';
}
