// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'maintenance_response.dart';

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

class MaintenanceResponseMapper extends ClassMapperBase<MaintenanceResponse> {
  MaintenanceResponseMapper._();

  static MaintenanceResponseMapper? _instance;
  static MaintenanceResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MaintenanceResponseMapper._());
      MaintenanceStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MaintenanceResponse';

  static int _$id(MaintenanceResponse v) => v.id;
  static const Field<MaintenanceResponse, int> _f$id = Field('id', _$id);
  static int _$assetId(MaintenanceResponse v) => v.assetId;
  static const Field<MaintenanceResponse, int> _f$assetId = Field(
    'assetId',
    _$assetId,
  );
  static String? _$assetName(MaintenanceResponse v) => v.assetName;
  static const Field<MaintenanceResponse, String> _f$assetName = Field(
    'assetName',
    _$assetName,
    opt: true,
  );
  static String? _$description(MaintenanceResponse v) => v.description;
  static const Field<MaintenanceResponse, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static double? _$cost(MaintenanceResponse v) => v.cost;
  static const Field<MaintenanceResponse, double> _f$cost = Field(
    'cost',
    _$cost,
    opt: true,
  );
  static String? _$provider(MaintenanceResponse v) => v.provider;
  static const Field<MaintenanceResponse, String> _f$provider = Field(
    'provider',
    _$provider,
    opt: true,
  );
  static String? _$startDate(MaintenanceResponse v) => v.startDate;
  static const Field<MaintenanceResponse, String> _f$startDate = Field(
    'startDate',
    _$startDate,
    opt: true,
  );
  static String? _$endDate(MaintenanceResponse v) => v.endDate;
  static const Field<MaintenanceResponse, String> _f$endDate = Field(
    'endDate',
    _$endDate,
    opt: true,
  );
  static MaintenanceStatus? _$status(MaintenanceResponse v) => v.status;
  static const Field<MaintenanceResponse, MaintenanceStatus> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );

  @override
  final MappableFields<MaintenanceResponse> fields = const {
    #id: _f$id,
    #assetId: _f$assetId,
    #assetName: _f$assetName,
    #description: _f$description,
    #cost: _f$cost,
    #provider: _f$provider,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #status: _f$status,
  };

  static MaintenanceResponse _instantiate(DecodingData data) {
    return MaintenanceResponse(
      id: data.dec(_f$id),
      assetId: data.dec(_f$assetId),
      assetName: data.dec(_f$assetName),
      description: data.dec(_f$description),
      cost: data.dec(_f$cost),
      provider: data.dec(_f$provider),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      status: data.dec(_f$status),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MaintenanceResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MaintenanceResponse>(map);
  }

  static MaintenanceResponse fromJson(String json) {
    return ensureInitialized().decodeJson<MaintenanceResponse>(json);
  }
}

mixin MaintenanceResponseMappable {
  String toJson() {
    return MaintenanceResponseMapper.ensureInitialized()
        .encodeJson<MaintenanceResponse>(this as MaintenanceResponse);
  }

  Map<String, dynamic> toMap() {
    return MaintenanceResponseMapper.ensureInitialized()
        .encodeMap<MaintenanceResponse>(this as MaintenanceResponse);
  }

  MaintenanceResponseCopyWith<
    MaintenanceResponse,
    MaintenanceResponse,
    MaintenanceResponse
  >
  get copyWith =>
      _MaintenanceResponseCopyWithImpl<
        MaintenanceResponse,
        MaintenanceResponse
      >(this as MaintenanceResponse, $identity, $identity);
  @override
  String toString() {
    return MaintenanceResponseMapper.ensureInitialized().stringifyValue(
      this as MaintenanceResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return MaintenanceResponseMapper.ensureInitialized().equalsValue(
      this as MaintenanceResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return MaintenanceResponseMapper.ensureInitialized().hashValue(
      this as MaintenanceResponse,
    );
  }
}

extension MaintenanceResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MaintenanceResponse, $Out> {
  MaintenanceResponseCopyWith<$R, MaintenanceResponse, $Out>
  get $asMaintenanceResponse => $base.as(
    (v, t, t2) => _MaintenanceResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class MaintenanceResponseCopyWith<
  $R,
  $In extends MaintenanceResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    int? assetId,
    String? assetName,
    String? description,
    double? cost,
    String? provider,
    String? startDate,
    String? endDate,
    MaintenanceStatus? status,
  });
  MaintenanceResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MaintenanceResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MaintenanceResponse, $Out>
    implements MaintenanceResponseCopyWith<$R, MaintenanceResponse, $Out> {
  _MaintenanceResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MaintenanceResponse> $mapper =
      MaintenanceResponseMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    int? assetId,
    Object? assetName = $none,
    Object? description = $none,
    Object? cost = $none,
    Object? provider = $none,
    Object? startDate = $none,
    Object? endDate = $none,
    Object? status = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (assetId != null) #assetId: assetId,
      if (assetName != $none) #assetName: assetName,
      if (description != $none) #description: description,
      if (cost != $none) #cost: cost,
      if (provider != $none) #provider: provider,
      if (startDate != $none) #startDate: startDate,
      if (endDate != $none) #endDate: endDate,
      if (status != $none) #status: status,
    }),
  );
  @override
  MaintenanceResponse $make(CopyWithData data) => MaintenanceResponse(
    id: data.get(#id, or: $value.id),
    assetId: data.get(#assetId, or: $value.assetId),
    assetName: data.get(#assetName, or: $value.assetName),
    description: data.get(#description, or: $value.description),
    cost: data.get(#cost, or: $value.cost),
    provider: data.get(#provider, or: $value.provider),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    status: data.get(#status, or: $value.status),
  );

  @override
  MaintenanceResponseCopyWith<$R2, MaintenanceResponse, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _MaintenanceResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

