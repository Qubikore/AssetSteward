import 'package:asset_steward_app/features/assets/data/models/asset_model.dart';
import 'package:asset_steward_app/features/profile/data/models/profile_model.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'assignment_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.camelCase)
class AssignmentModel with AssignmentModelMappable {
  static const fromMap = AssignmentModelMapper.fromMap;
  static const fromJson = AssignmentModelMapper.fromJson;

  final int id;
  final AssetModel asset;
  final ProfileModel assignedTo;
  final ProfileModel? assignedBy;
  final String assignedAt;
  final String? returnedAt;
  final String? returnReason;

  const AssignmentModel({
    required this.id,
    required this.asset,
    required this.assignedTo,
    this.assignedBy,
    required this.assignedAt,
    this.returnedAt,
    this.returnReason,
  });

  // Helpers for UI backward compatibility
  int get assetId => asset.id;
  String get assetName => asset.name;
  String get assetCode => asset.assetCode;

  DateTime? get assignedAtDate => DateTime.tryParse(assignedAt);
  DateTime? get returnedAtDate => DateTime.tryParse(returnedAt ?? '');
}
