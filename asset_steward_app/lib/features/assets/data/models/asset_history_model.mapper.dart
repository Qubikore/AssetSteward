// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_history_model.dart';

class AssetHistoryModelMapper extends ClassMapperBase<AssetHistoryModel> {
  AssetHistoryModelMapper._();

  static AssetHistoryModelMapper? _instance;
  static AssetHistoryModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetHistoryModelMapper._());
      ProfileModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AssetHistoryModel';

  static int _$id(AssetHistoryModel v) => v.id;
  static const Field<AssetHistoryModel, int> _f$id = Field('id', _$id);
  static String _$action(AssetHistoryModel v) => v.action;
  static const Field<AssetHistoryModel, String> _f$action = Field(
    'action',
    _$action,
  );
  static String _$timestamp(AssetHistoryModel v) => v.timestamp;
  static const Field<AssetHistoryModel, String> _f$timestamp = Field(
    'timestamp',
    _$timestamp,
  );
  static String? _$notes(AssetHistoryModel v) => v.notes;
  static const Field<AssetHistoryModel, String> _f$notes = Field(
    'notes',
    _$notes,
    opt: true,
  );
  static ProfileModel? _$actionBy(AssetHistoryModel v) => v.actionBy;
  static const Field<AssetHistoryModel, ProfileModel> _f$actionBy = Field(
    'actionBy',
    _$actionBy,
    opt: true,
  );

  @override
  final MappableFields<AssetHistoryModel> fields = const {
    #id: _f$id,
    #action: _f$action,
    #timestamp: _f$timestamp,
    #notes: _f$notes,
    #actionBy: _f$actionBy,
  };

  static AssetHistoryModel _instantiate(DecodingData data) {
    return AssetHistoryModel(
      id: data.dec(_f$id),
      action: data.dec(_f$action),
      timestamp: data.dec(_f$timestamp),
      notes: data.dec(_f$notes),
      actionBy: data.dec(_f$actionBy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AssetHistoryModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssetHistoryModel>(map);
  }

  static AssetHistoryModel fromJson(String json) {
    return ensureInitialized().decodeJson<AssetHistoryModel>(json);
  }
}

mixin AssetHistoryModelMappable {
  String toJson() {
    return AssetHistoryModelMapper.ensureInitialized()
        .encodeJson<AssetHistoryModel>(this as AssetHistoryModel);
  }

  Map<String, dynamic> toMap() {
    return AssetHistoryModelMapper.ensureInitialized()
        .encodeMap<AssetHistoryModel>(this as AssetHistoryModel);
  }

  AssetHistoryModelCopyWith<
    AssetHistoryModel,
    AssetHistoryModel,
    AssetHistoryModel
  >
  get copyWith =>
      _AssetHistoryModelCopyWithImpl<AssetHistoryModel, AssetHistoryModel>(
        this as AssetHistoryModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssetHistoryModelMapper.ensureInitialized().stringifyValue(
      this as AssetHistoryModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssetHistoryModelMapper.ensureInitialized().equalsValue(
      this as AssetHistoryModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AssetHistoryModelMapper.ensureInitialized().hashValue(
      this as AssetHistoryModel,
    );
  }
}

extension AssetHistoryModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssetHistoryModel, $Out> {
  AssetHistoryModelCopyWith<$R, AssetHistoryModel, $Out>
  get $asAssetHistoryModel => $base.as(
    (v, t, t2) => _AssetHistoryModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AssetHistoryModelCopyWith<
  $R,
  $In extends AssetHistoryModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel>? get actionBy;
  $R call({
    int? id,
    String? action,
    String? timestamp,
    String? notes,
    ProfileModel? actionBy,
  });
  AssetHistoryModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AssetHistoryModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssetHistoryModel, $Out>
    implements AssetHistoryModelCopyWith<$R, AssetHistoryModel, $Out> {
  _AssetHistoryModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssetHistoryModel> $mapper =
      AssetHistoryModelMapper.ensureInitialized();
  @override
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel>? get actionBy =>
      $value.actionBy?.copyWith.$chain((v) => call(actionBy: v));
  @override
  $R call({
    int? id,
    String? action,
    String? timestamp,
    Object? notes = $none,
    Object? actionBy = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (action != null) #action: action,
      if (timestamp != null) #timestamp: timestamp,
      if (notes != $none) #notes: notes,
      if (actionBy != $none) #actionBy: actionBy,
    }),
  );
  @override
  AssetHistoryModel $make(CopyWithData data) => AssetHistoryModel(
    id: data.get(#id, or: $value.id),
    action: data.get(#action, or: $value.action),
    timestamp: data.get(#timestamp, or: $value.timestamp),
    notes: data.get(#notes, or: $value.notes),
    actionBy: data.get(#actionBy, or: $value.actionBy),
  );

  @override
  AssetHistoryModelCopyWith<$R2, AssetHistoryModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssetHistoryModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

