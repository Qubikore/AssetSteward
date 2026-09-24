// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dashboard_metrics.dart';

class DashboardMetricsMapper extends ClassMapperBase<DashboardMetrics> {
  DashboardMetricsMapper._();

  static DashboardMetricsMapper? _instance;
  static DashboardMetricsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DashboardMetricsMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DashboardMetrics';

  static int _$totalAssets(DashboardMetrics v) => v.totalAssets;
  static const Field<DashboardMetrics, int> _f$totalAssets = Field(
    'totalAssets',
    _$totalAssets,
    key: r'total_assets',
    opt: true,
    def: 0,
  );
  static int _$availableAssets(DashboardMetrics v) => v.availableAssets;
  static const Field<DashboardMetrics, int> _f$availableAssets = Field(
    'availableAssets',
    _$availableAssets,
    key: r'available_assets',
    opt: true,
    def: 0,
  );
  static int _$assignedAssets(DashboardMetrics v) => v.assignedAssets;
  static const Field<DashboardMetrics, int> _f$assignedAssets = Field(
    'assignedAssets',
    _$assignedAssets,
    key: r'assigned_assets',
    opt: true,
    def: 0,
  );
  static int _$maintenanceAssets(DashboardMetrics v) => v.maintenanceAssets;
  static const Field<DashboardMetrics, int> _f$maintenanceAssets = Field(
    'maintenanceAssets',
    _$maintenanceAssets,
    key: r'maintenance_assets',
    opt: true,
    def: 0,
  );
  static double _$totalAssetValue(DashboardMetrics v) => v.totalAssetValue;
  static const Field<DashboardMetrics, double> _f$totalAssetValue = Field(
    'totalAssetValue',
    _$totalAssetValue,
    key: r'total_asset_value',
    opt: true,
    def: 0,
  );

  @override
  final MappableFields<DashboardMetrics> fields = const {
    #totalAssets: _f$totalAssets,
    #availableAssets: _f$availableAssets,
    #assignedAssets: _f$assignedAssets,
    #maintenanceAssets: _f$maintenanceAssets,
    #totalAssetValue: _f$totalAssetValue,
  };

  static DashboardMetrics _instantiate(DecodingData data) {
    return DashboardMetrics(
      totalAssets: data.dec(_f$totalAssets),
      availableAssets: data.dec(_f$availableAssets),
      assignedAssets: data.dec(_f$assignedAssets),
      maintenanceAssets: data.dec(_f$maintenanceAssets),
      totalAssetValue: data.dec(_f$totalAssetValue),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DashboardMetrics fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DashboardMetrics>(map);
  }

  static DashboardMetrics fromJson(String json) {
    return ensureInitialized().decodeJson<DashboardMetrics>(json);
  }
}

mixin DashboardMetricsMappable {
  String toJson() {
    return DashboardMetricsMapper.ensureInitialized()
        .encodeJson<DashboardMetrics>(this as DashboardMetrics);
  }

  Map<String, dynamic> toMap() {
    return DashboardMetricsMapper.ensureInitialized()
        .encodeMap<DashboardMetrics>(this as DashboardMetrics);
  }

  DashboardMetricsCopyWith<DashboardMetrics, DashboardMetrics, DashboardMetrics>
  get copyWith =>
      _DashboardMetricsCopyWithImpl<DashboardMetrics, DashboardMetrics>(
        this as DashboardMetrics,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DashboardMetricsMapper.ensureInitialized().stringifyValue(
      this as DashboardMetrics,
    );
  }

  @override
  bool operator ==(Object other) {
    return DashboardMetricsMapper.ensureInitialized().equalsValue(
      this as DashboardMetrics,
      other,
    );
  }

  @override
  int get hashCode {
    return DashboardMetricsMapper.ensureInitialized().hashValue(
      this as DashboardMetrics,
    );
  }
}

extension DashboardMetricsValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DashboardMetrics, $Out> {
  DashboardMetricsCopyWith<$R, DashboardMetrics, $Out>
  get $asDashboardMetrics =>
      $base.as((v, t, t2) => _DashboardMetricsCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DashboardMetricsCopyWith<$R, $In extends DashboardMetrics, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? totalAssets,
    int? availableAssets,
    int? assignedAssets,
    int? maintenanceAssets,
    double? totalAssetValue,
  });
  DashboardMetricsCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DashboardMetricsCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DashboardMetrics, $Out>
    implements DashboardMetricsCopyWith<$R, DashboardMetrics, $Out> {
  _DashboardMetricsCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DashboardMetrics> $mapper =
      DashboardMetricsMapper.ensureInitialized();
  @override
  $R call({
    int? totalAssets,
    int? availableAssets,
    int? assignedAssets,
    int? maintenanceAssets,
    double? totalAssetValue,
  }) => $apply(
    FieldCopyWithData({
      if (totalAssets != null) #totalAssets: totalAssets,
      if (availableAssets != null) #availableAssets: availableAssets,
      if (assignedAssets != null) #assignedAssets: assignedAssets,
      if (maintenanceAssets != null) #maintenanceAssets: maintenanceAssets,
      if (totalAssetValue != null) #totalAssetValue: totalAssetValue,
    }),
  );
  @override
  DashboardMetrics $make(CopyWithData data) => DashboardMetrics(
    totalAssets: data.get(#totalAssets, or: $value.totalAssets),
    availableAssets: data.get(#availableAssets, or: $value.availableAssets),
    assignedAssets: data.get(#assignedAssets, or: $value.assignedAssets),
    maintenanceAssets: data.get(
      #maintenanceAssets,
      or: $value.maintenanceAssets,
    ),
    totalAssetValue: data.get(#totalAssetValue, or: $value.totalAssetValue),
  );

  @override
  DashboardMetricsCopyWith<$R2, DashboardMetrics, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DashboardMetricsCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

