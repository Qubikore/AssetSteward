// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_utilization.dart';

class AssetUtilizationMapper extends ClassMapperBase<AssetUtilization> {
  AssetUtilizationMapper._();

  static AssetUtilizationMapper? _instance;
  static AssetUtilizationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetUtilizationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AssetUtilization';

  static int _$assetId(AssetUtilization v) => v.assetId;
  static const Field<AssetUtilization, int> _f$assetId = Field(
    'assetId',
    _$assetId,
  );
  static String _$assetName(AssetUtilization v) => v.assetName;
  static const Field<AssetUtilization, String> _f$assetName = Field(
    'assetName',
    _$assetName,
  );
  static String _$assetCode(AssetUtilization v) => v.assetCode;
  static const Field<AssetUtilization, String> _f$assetCode = Field(
    'assetCode',
    _$assetCode,
  );
  static String _$status(AssetUtilization v) => v.status;
  static const Field<AssetUtilization, String> _f$status = Field(
    'status',
    _$status,
  );
  static int _$assignmentCount(AssetUtilization v) => v.assignmentCount;
  static const Field<AssetUtilization, int> _f$assignmentCount = Field(
    'assignmentCount',
    _$assignmentCount,
    opt: true,
    def: 0,
  );
  static int _$maintenanceCount(AssetUtilization v) => v.maintenanceCount;
  static const Field<AssetUtilization, int> _f$maintenanceCount = Field(
    'maintenanceCount',
    _$maintenanceCount,
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<AssetUtilization> fields = const {
    #assetId: _f$assetId,
    #assetName: _f$assetName,
    #assetCode: _f$assetCode,
    #status: _f$status,
    #assignmentCount: _f$assignmentCount,
    #maintenanceCount: _f$maintenanceCount,
  };

  static AssetUtilization _instantiate(DecodingData data) {
    return AssetUtilization(
      assetId: data.dec(_f$assetId),
      assetName: data.dec(_f$assetName),
      assetCode: data.dec(_f$assetCode),
      status: data.dec(_f$status),
      assignmentCount: data.dec(_f$assignmentCount),
      maintenanceCount: data.dec(_f$maintenanceCount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AssetUtilization fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssetUtilization>(map);
  }

  static AssetUtilization fromJson(String json) {
    return ensureInitialized().decodeJson<AssetUtilization>(json);
  }
}

mixin AssetUtilizationMappable {
  String toJson() {
    return AssetUtilizationMapper.ensureInitialized()
        .encodeJson<AssetUtilization>(this as AssetUtilization);
  }

  Map<String, dynamic> toMap() {
    return AssetUtilizationMapper.ensureInitialized()
        .encodeMap<AssetUtilization>(this as AssetUtilization);
  }

  AssetUtilizationCopyWith<AssetUtilization, AssetUtilization, AssetUtilization>
  get copyWith =>
      _AssetUtilizationCopyWithImpl<AssetUtilization, AssetUtilization>(
        this as AssetUtilization,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssetUtilizationMapper.ensureInitialized().stringifyValue(
      this as AssetUtilization,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssetUtilizationMapper.ensureInitialized().equalsValue(
      this as AssetUtilization,
      other,
    );
  }

  @override
  int get hashCode {
    return AssetUtilizationMapper.ensureInitialized().hashValue(
      this as AssetUtilization,
    );
  }
}

extension AssetUtilizationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssetUtilization, $Out> {
  AssetUtilizationCopyWith<$R, AssetUtilization, $Out>
  get $asAssetUtilization =>
      $base.as((v, t, t2) => _AssetUtilizationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AssetUtilizationCopyWith<$R, $In extends AssetUtilization, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? assetId,
    String? assetName,
    String? assetCode,
    String? status,
    int? assignmentCount,
    int? maintenanceCount,
  });
  AssetUtilizationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AssetUtilizationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssetUtilization, $Out>
    implements AssetUtilizationCopyWith<$R, AssetUtilization, $Out> {
  _AssetUtilizationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssetUtilization> $mapper =
      AssetUtilizationMapper.ensureInitialized();
  @override
  $R call({
    int? assetId,
    String? assetName,
    String? assetCode,
    String? status,
    int? assignmentCount,
    int? maintenanceCount,
  }) => $apply(
    FieldCopyWithData({
      if (assetId != null) #assetId: assetId,
      if (assetName != null) #assetName: assetName,
      if (assetCode != null) #assetCode: assetCode,
      if (status != null) #status: status,
      if (assignmentCount != null) #assignmentCount: assignmentCount,
      if (maintenanceCount != null) #maintenanceCount: maintenanceCount,
    }),
  );
  @override
  AssetUtilization $make(CopyWithData data) => AssetUtilization(
    assetId: data.get(#assetId, or: $value.assetId),
    assetName: data.get(#assetName, or: $value.assetName),
    assetCode: data.get(#assetCode, or: $value.assetCode),
    status: data.get(#status, or: $value.status),
    assignmentCount: data.get(#assignmentCount, or: $value.assignmentCount),
    maintenanceCount: data.get(#maintenanceCount, or: $value.maintenanceCount),
  );

  @override
  AssetUtilizationCopyWith<$R2, AssetUtilization, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssetUtilizationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

