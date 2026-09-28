// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'maintenance_model.dart';

class MaintenanceStatusMapper extends EnumMapper<MaintenanceStatus> {
  MaintenanceStatusMapper._();

  static MaintenanceStatusMapper? _instance;
  static MaintenanceStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MaintenanceStatusMapper._());
    }
    return _instance!;
  }

  static MaintenanceStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  MaintenanceStatus decode(dynamic value) {
    switch (value) {
      case r'IN_PROGRESS':
        return MaintenanceStatus.inProgress;
      case r'COMPLETED':
        return MaintenanceStatus.completed;
      case r'UNKNOWN':
        return MaintenanceStatus.unknown;
      default:
        return MaintenanceStatus.values[2];
    }
  }

  @override
  dynamic encode(MaintenanceStatus self) {
    switch (self) {
      case MaintenanceStatus.inProgress:
        return r'IN_PROGRESS';
      case MaintenanceStatus.completed:
        return r'COMPLETED';
      case MaintenanceStatus.unknown:
        return r'UNKNOWN';
    }
  }
}

extension MaintenanceStatusMapperExtension on MaintenanceStatus {
  String toValue() {
    MaintenanceStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<MaintenanceStatus>(this) as String;
  }
}

class MaintenanceModelMapper extends ClassMapperBase<MaintenanceModel> {
  MaintenanceModelMapper._();

  static MaintenanceModelMapper? _instance;
  static MaintenanceModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MaintenanceModelMapper._());
      AssetModelMapper.ensureInitialized();
      MaintenanceStatusMapper.ensureInitialized();
      ProfileModelMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MaintenanceModel';

  static int _$id(MaintenanceModel v) => v.id;
  static const Field<MaintenanceModel, int> _f$id = Field('id', _$id);
  static AssetModel _$asset(MaintenanceModel v) => v.asset;
  static const Field<MaintenanceModel, AssetModel> _f$asset = Field(
    'asset',
    _$asset,
  );
  static String _$description(MaintenanceModel v) => v.description;
  static const Field<MaintenanceModel, String> _f$description = Field(
    'description',
    _$description,
  );
  static double _$cost(MaintenanceModel v) => v.cost;
  static const Field<MaintenanceModel, double> _f$cost = Field('cost', _$cost);
  static String? _$provider(MaintenanceModel v) => v.provider;
  static const Field<MaintenanceModel, String> _f$provider = Field(
    'provider',
    _$provider,
    opt: true,
  );
  static String _$startDate(MaintenanceModel v) => v.startDate;
  static const Field<MaintenanceModel, String> _f$startDate = Field(
    'startDate',
    _$startDate,
  );
  static String? _$endDate(MaintenanceModel v) => v.endDate;
  static const Field<MaintenanceModel, String> _f$endDate = Field(
    'endDate',
    _$endDate,
    opt: true,
  );
  static MaintenanceStatus _$status(MaintenanceModel v) => v.status;
  static const Field<MaintenanceModel, MaintenanceStatus> _f$status = Field(
    'status',
    _$status,
  );
  static ProfileModel? _$startedBy(MaintenanceModel v) => v.startedBy;
  static const Field<MaintenanceModel, ProfileModel> _f$startedBy = Field(
    'startedBy',
    _$startedBy,
    opt: true,
  );
  static ProfileModel? _$endedBy(MaintenanceModel v) => v.endedBy;
  static const Field<MaintenanceModel, ProfileModel> _f$endedBy = Field(
    'endedBy',
    _$endedBy,
    opt: true,
  );

  @override
  final MappableFields<MaintenanceModel> fields = const {
    #id: _f$id,
    #asset: _f$asset,
    #description: _f$description,
    #cost: _f$cost,
    #provider: _f$provider,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #status: _f$status,
    #startedBy: _f$startedBy,
    #endedBy: _f$endedBy,
  };

  static MaintenanceModel _instantiate(DecodingData data) {
    return MaintenanceModel(
      id: data.dec(_f$id),
      asset: data.dec(_f$asset),
      description: data.dec(_f$description),
      cost: data.dec(_f$cost),
      provider: data.dec(_f$provider),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      status: data.dec(_f$status),
      startedBy: data.dec(_f$startedBy),
      endedBy: data.dec(_f$endedBy),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MaintenanceModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MaintenanceModel>(map);
  }

  static MaintenanceModel fromJson(String json) {
    return ensureInitialized().decodeJson<MaintenanceModel>(json);
  }
}

mixin MaintenanceModelMappable {
  String toJson() {
    return MaintenanceModelMapper.ensureInitialized()
        .encodeJson<MaintenanceModel>(this as MaintenanceModel);
  }

  Map<String, dynamic> toMap() {
    return MaintenanceModelMapper.ensureInitialized()
        .encodeMap<MaintenanceModel>(this as MaintenanceModel);
  }

  MaintenanceModelCopyWith<MaintenanceModel, MaintenanceModel, MaintenanceModel>
  get copyWith =>
      _MaintenanceModelCopyWithImpl<MaintenanceModel, MaintenanceModel>(
        this as MaintenanceModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MaintenanceModelMapper.ensureInitialized().stringifyValue(
      this as MaintenanceModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return MaintenanceModelMapper.ensureInitialized().equalsValue(
      this as MaintenanceModel,
      other,
    );
  }

  @override
  int get hashCode {
    return MaintenanceModelMapper.ensureInitialized().hashValue(
      this as MaintenanceModel,
    );
  }
}

extension MaintenanceModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MaintenanceModel, $Out> {
  MaintenanceModelCopyWith<$R, MaintenanceModel, $Out>
  get $asMaintenanceModel =>
      $base.as((v, t, t2) => _MaintenanceModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MaintenanceModelCopyWith<$R, $In extends MaintenanceModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  AssetModelCopyWith<$R, AssetModel, AssetModel> get asset;
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel>? get startedBy;
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel>? get endedBy;
  $R call({
    int? id,
    AssetModel? asset,
    String? description,
    double? cost,
    String? provider,
    String? startDate,
    String? endDate,
    MaintenanceStatus? status,
    ProfileModel? startedBy,
    ProfileModel? endedBy,
  });
  MaintenanceModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MaintenanceModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MaintenanceModel, $Out>
    implements MaintenanceModelCopyWith<$R, MaintenanceModel, $Out> {
  _MaintenanceModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MaintenanceModel> $mapper =
      MaintenanceModelMapper.ensureInitialized();
  @override
  AssetModelCopyWith<$R, AssetModel, AssetModel> get asset =>
      $value.asset.copyWith.$chain((v) => call(asset: v));
  @override
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel>? get startedBy =>
      $value.startedBy?.copyWith.$chain((v) => call(startedBy: v));
  @override
  ProfileModelCopyWith<$R, ProfileModel, ProfileModel>? get endedBy =>
      $value.endedBy?.copyWith.$chain((v) => call(endedBy: v));
  @override
  $R call({
    int? id,
    AssetModel? asset,
    String? description,
    double? cost,
    Object? provider = $none,
    String? startDate,
    Object? endDate = $none,
    MaintenanceStatus? status,
    Object? startedBy = $none,
    Object? endedBy = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (asset != null) #asset: asset,
      if (description != null) #description: description,
      if (cost != null) #cost: cost,
      if (provider != $none) #provider: provider,
      if (startDate != null) #startDate: startDate,
      if (endDate != $none) #endDate: endDate,
      if (status != null) #status: status,
      if (startedBy != $none) #startedBy: startedBy,
      if (endedBy != $none) #endedBy: endedBy,
    }),
  );
  @override
  MaintenanceModel $make(CopyWithData data) => MaintenanceModel(
    id: data.get(#id, or: $value.id),
    asset: data.get(#asset, or: $value.asset),
    description: data.get(#description, or: $value.description),
    cost: data.get(#cost, or: $value.cost),
    provider: data.get(#provider, or: $value.provider),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    status: data.get(#status, or: $value.status),
    startedBy: data.get(#startedBy, or: $value.startedBy),
    endedBy: data.get(#endedBy, or: $value.endedBy),
  );

  @override
  MaintenanceModelCopyWith<$R2, MaintenanceModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MaintenanceModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

