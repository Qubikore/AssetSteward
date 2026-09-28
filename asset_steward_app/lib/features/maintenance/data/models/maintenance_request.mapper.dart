// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'maintenance_request.dart';

class MaintenanceRequestMapper extends ClassMapperBase<MaintenanceRequest> {
  MaintenanceRequestMapper._();

  static MaintenanceRequestMapper? _instance;
  static MaintenanceRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MaintenanceRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MaintenanceRequest';

  static int _$assetId(MaintenanceRequest v) => v.assetId;
  static const Field<MaintenanceRequest, int> _f$assetId = Field(
    'assetId',
    _$assetId,
  );
  static String _$description(MaintenanceRequest v) => v.description;
  static const Field<MaintenanceRequest, String> _f$description = Field(
    'description',
    _$description,
  );
  static double _$cost(MaintenanceRequest v) => v.cost;
  static const Field<MaintenanceRequest, double> _f$cost = Field(
    'cost',
    _$cost,
  );
  static String _$provider(MaintenanceRequest v) => v.provider;
  static const Field<MaintenanceRequest, String> _f$provider = Field(
    'provider',
    _$provider,
  );
  static String _$startDate(MaintenanceRequest v) => v.startDate;
  static const Field<MaintenanceRequest, String> _f$startDate = Field(
    'startDate',
    _$startDate,
  );

  @override
  final MappableFields<MaintenanceRequest> fields = const {
    #assetId: _f$assetId,
    #description: _f$description,
    #cost: _f$cost,
    #provider: _f$provider,
    #startDate: _f$startDate,
  };

  static MaintenanceRequest _instantiate(DecodingData data) {
    return MaintenanceRequest(
      assetId: data.dec(_f$assetId),
      description: data.dec(_f$description),
      cost: data.dec(_f$cost),
      provider: data.dec(_f$provider),
      startDate: data.dec(_f$startDate),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MaintenanceRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MaintenanceRequest>(map);
  }

  static MaintenanceRequest fromJson(String json) {
    return ensureInitialized().decodeJson<MaintenanceRequest>(json);
  }
}

mixin MaintenanceRequestMappable {
  String toJson() {
    return MaintenanceRequestMapper.ensureInitialized()
        .encodeJson<MaintenanceRequest>(this as MaintenanceRequest);
  }

  Map<String, dynamic> toMap() {
    return MaintenanceRequestMapper.ensureInitialized()
        .encodeMap<MaintenanceRequest>(this as MaintenanceRequest);
  }

  MaintenanceRequestCopyWith<
    MaintenanceRequest,
    MaintenanceRequest,
    MaintenanceRequest
  >
  get copyWith =>
      _MaintenanceRequestCopyWithImpl<MaintenanceRequest, MaintenanceRequest>(
        this as MaintenanceRequest,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MaintenanceRequestMapper.ensureInitialized().stringifyValue(
      this as MaintenanceRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return MaintenanceRequestMapper.ensureInitialized().equalsValue(
      this as MaintenanceRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return MaintenanceRequestMapper.ensureInitialized().hashValue(
      this as MaintenanceRequest,
    );
  }
}

extension MaintenanceRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MaintenanceRequest, $Out> {
  MaintenanceRequestCopyWith<$R, MaintenanceRequest, $Out>
  get $asMaintenanceRequest => $base.as(
    (v, t, t2) => _MaintenanceRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MaintenanceRequestCopyWith<
  $R,
  $In extends MaintenanceRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? assetId,
    String? description,
    double? cost,
    String? provider,
    String? startDate,
  });
  MaintenanceRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MaintenanceRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MaintenanceRequest, $Out>
    implements MaintenanceRequestCopyWith<$R, MaintenanceRequest, $Out> {
  _MaintenanceRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MaintenanceRequest> $mapper =
      MaintenanceRequestMapper.ensureInitialized();
  @override
  $R call({
    int? assetId,
    String? description,
    double? cost,
    String? provider,
    String? startDate,
  }) => $apply(
    FieldCopyWithData({
      if (assetId != null) #assetId: assetId,
      if (description != null) #description: description,
      if (cost != null) #cost: cost,
      if (provider != null) #provider: provider,
      if (startDate != null) #startDate: startDate,
    }),
  );
  @override
  MaintenanceRequest $make(CopyWithData data) => MaintenanceRequest(
    assetId: data.get(#assetId, or: $value.assetId),
    description: data.get(#description, or: $value.description),
    cost: data.get(#cost, or: $value.cost),
    provider: data.get(#provider, or: $value.provider),
    startDate: data.get(#startDate, or: $value.startDate),
  );

  @override
  MaintenanceRequestCopyWith<$R2, MaintenanceRequest, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MaintenanceRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

