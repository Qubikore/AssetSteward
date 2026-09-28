import 'package:asset_steward_app/features/profile/data/models/profile_model.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'asset_history_model.mapper.dart';

@MappableClass(caseStyle: CaseStyle.camelCase)
class AssetHistoryModel with AssetHistoryModelMappable {
  static const fromMap = AssetHistoryModelMapper.fromMap;
  static const fromJson = AssetHistoryModelMapper.fromJson;

  final int id;
  final String? action;
  final String? timestamp;
  final String? notes;
  final ProfileModel? actionBy;

  const AssetHistoryModel({
    required this.id,
    this.action,
    this.timestamp,
    this.notes,
    this.actionBy,
  });
}
