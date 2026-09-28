// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'assignment_model.dart';

class AssignmentModelMapper extends ClassMapperBase<AssignmentModel> {
  AssignmentModelMapper._();

  static AssignmentModelMapper? _instance;
  static AssignmentModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssignmentModelMapper._());
      AssetModelMapper.ensureInitialized();
      ProfileModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AssignmentModel';

  static int _$id(AssignmentModel v) => v.id;
  static const Field<AssignmentModel, int> _f$id = Field('id', _$id);
  static AssetModel _$asset(AssignmentModel v) => v.asset;
  static const Field<AssignmentModel, AssetModel> _f$asset = Field(
    'asset',
    _$asset,
  );
  static ProfileModel _$assignedTo(AssignmentModel v) => v.assignedTo;
  static const Field<AssignmentModel, ProfileModel> _f$assignedTo = Field(
    'assignedTo',
    _$assignedTo,
  );
  static ProfileModel _$assignedBy(AssignmentModel v) => v.assignedBy;
  static const Field<AssignmentModel, ProfileModel> _f$assignedBy = Field(
    'assignedBy',
    _$assignedBy,
  );
  static String _$assignedAt(AssignmentModel v) => v.assignedAt;
  static const Field<AssignmentModel, String> _f$assignedAt = Field(
    'assignedAt',
    _$assignedAt,
  );
  static String? _$returnedAt(AssignmentModel v) => v.returnedAt;
  static const Field<AssignmentModel, String> _f$returnedAt = Field(
    'returnedAt',
    _$returnedAt,
    opt: true,
  );
  static String? _$returnReason(AssignmentModel v) => v.returnReason;
  static const Field<AssignmentModel, String> _f$returnReason = Field(
    'returnReason',
    _$returnReason,
    opt: true,
  );

  @override
  final MappableFields<AssignmentModel> fields = const {
    #id: _f$id,
    #asset: _f$asset,
    #assignedTo: _f$assignedTo,
    #assignedBy: _f$assignedBy,
    #assignedAt: _f$assignedAt,
    #returnedAt: _f$returnedAt,
    #returnReason: _f$returnReason,
  };

  static AssignmentModel _instantiate(DecodingData data) {
    return AssignmentModel(
      id: data.dec(_f$id),
      asset: data.dec(_f$asset),
      assignedTo: data.dec(_f$assignedTo),
      assignedBy: data.dec(_f$assignedBy),
      assignedAt: data.dec(_f$assignedAt),
      returnedAt: data.dec(_f$returnedAt),
      returnReason: data.dec(_f$returnReason),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AssignmentModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssignmentModel>(map);
  }

  static AssignmentModel fromJson(String json) {
    return ensureInitialized().decodeJson<AssignmentModel>(json);
  }
}

mixin AssignmentModelMappable {
  String toJson() {
    return AssignmentModelMapper.ensureInitialized()
        .encodeJson<AssignmentModel>(this as AssignmentModel);
  }

  Map<String, dynamic> toMap() {
    return AssignmentModelMapper.ensureInitialized().encodeMap<AssignmentModel>(
      this as AssignmentModel,
    );
  }

  AssignmentModelCopyWith<AssignmentModel, AssignmentModel, AssignmentModel>
  get copyWith =>
      _AssignmentModelCopyWithImpl<AssignmentModel, AssignmentModel>(
        this as AssignmentModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssignmentModelMapper.ensureInitialized().stringifyValue(
      this as AssignmentModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssignmentModelMapper.ensureInitialized().equalsValue(
      this as AssignmentModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AssignmentModelMapper.ensureInitialized().hashValue(
      this as AssignmentModel,
    );
  }
}

extension AssignmentModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssignmentModel, $Out> {
  AssignmentModelCopyWith<$R, AssignmentModel, $Out> get $asAssignmentModel =>
      $base.as((v, t, t2) => _AssignmentModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AssignmentModelCopyWith<$R, $In extends AssignmentModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AssetModelCopyWith<$R, AssetModel, AssetModel> get asset;
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel> get assignedTo;
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel> get assignedBy;
  $R call({
    int? id,
    AssetModel? asset,
    ProfileModel? assignedTo,
    ProfileModel? assignedBy,
    String? assignedAt,
    String? returnedAt,
    String? returnReason,
  });
  AssignmentModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AssignmentModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssignmentModel, $Out>
    implements AssignmentModelCopyWith<$R, AssignmentModel, $Out> {
  _AssignmentModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssignmentModel> $mapper =
      AssignmentModelMapper.ensureInitialized();
  @override
  AssetModelCopyWith<$R, AssetModel, AssetModel> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel> get assignedTo =>
      $value.assignedTo.copyWith.$chain((v) => call(assignedTo: v));
  @override
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel> get assignedBy =>
      $value.assignedBy.copyWith.$chain((v) => call(assignedBy: v));
  @override
  $R call({
    int? id,
    AssetModel? asset,
    ProfileModel? assignedTo,
    ProfileModel? assignedBy,
    String? assignedAt,
    Object? returnedAt = $none,
    Object? returnReason = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (asset != null) #asset: asset,
      if (assignedTo != null) #assignedTo: assignedTo,
      if (assignedBy != null) #assignedBy: assignedBy,
      if (assignedAt != null) #assignedAt: assignedAt,
      if (returnedAt != $none) #returnedAt: returnedAt,
      if (returnReason != $none) #returnReason: returnReason,
    }),
  );
  @override
  AssignmentModel $make(CopyWithData data) => AssignmentModel(
    id: data.get(#id, or: $value.id),
    asset: data.get(#asset, or: $value.asset),
    assignedTo: data.get(#assignedTo, or: $value.assignedTo),
    assignedBy: data.get(#assignedBy, or: $value.assignedBy),
    assignedAt: data.get(#assignedAt, or: $value.assignedAt),
    returnedAt: data.get(#returnedAt, or: $value.returnedAt),
    returnReason: data.get(#returnReason, or: $value.returnReason),
  );

  @override
  AssignmentModelCopyWith<$R2, AssignmentModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssignmentModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

