import 'package:dart_mappable/dart_mappable.dart';

part 'asset_label_response.mapper.dart';

@MappableClass(caseStyle: CaseStyle.camelCase)
class AssetLabelResponse with AssetLabelResponseMappable {
  static const fromMap = AssetLabelResponseMapper.fromMap;
  static const fromJson = AssetLabelResponseMapper.fromJson;

  final int id;
  final String name;
  final String assetCode;
  final double purchasePrice;
  final String purchaseDate;
  final String? expireDate;
  final String qrCodeBase64;

  const AssetLabelResponse({
    required this.id,
    required this.name,
    required this.assetCode,
    required this.purchasePrice,
    required this.purchaseDate,
    this.expireDate,
    required this.qrCodeBase64,
  });
}
