// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'location_model.dart';

class LocationModelMapper extends ClassMapperBase<LocationModel> {
  LocationModelMapper._();

  static LocationModelMapper? _instance;
  static LocationModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LocationModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LocationModel';

  static int _$id(LocationModel v) => v.id;
  static const Field<LocationModel, int> _f$id = Field('id', _$id);
  static String _$name(LocationModel v) => v.name;
  static const Field<LocationModel, String> _f$name = Field('name', _$name);
  static String? _$address(LocationModel v) => v.address;
  static const Field<LocationModel, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );

  @override
  final MappableFields<LocationModel> fields = const {
    #id: _f$id,
    #name: _f$name,
    #address: _f$address,
  };

  static LocationModel _instantiate(DecodingData data) {
    return LocationModel(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      address: data.dec(_f$address),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LocationModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LocationModel>(map);
  }

  static LocationModel fromJson(String json) {
    return ensureInitialized().decodeJson<LocationModel>(json);
  }
}

mixin LocationModelMappable {
  String toJson() {
    return LocationModelMapper.ensureInitialized().encodeJson<LocationModel>(
      this as LocationModel,
    );
  }

  Map<String, dynamic> toMap() {
    return LocationModelMapper.ensureInitialized().encodeMap<LocationModel>(
      this as LocationModel,
    );
  }

  LocationModelCopyWith<LocationModel, LocationModel, LocationModel>
  get copyWith => _LocationModelCopyWithImpl<LocationModel, LocationModel>(
    this as LocationModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return LocationModelMapper.ensureInitialized().stringifyValue(
      this as LocationModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return LocationModelMapper.ensureInitialized().equalsValue(
      this as LocationModel,
      other,
    );
  }

  @override
  int get hashCode {
    return LocationModelMapper.ensureInitialized().hashValue(
      this as LocationModel,
    );
  }
}

extension LocationModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LocationModel, $Out> {
  LocationModelCopyWith<$R, LocationModel, $Out> get $asLocationModel =>
      $base.as((v, t, t2) => _LocationModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class LocationModelCopyWith<$R, $In extends LocationModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? name, String? address});
  LocationModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _LocationModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LocationModel, $Out>
    implements LocationModelCopyWith<$R, LocationModel, $Out> {
  _LocationModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LocationModel> $mapper =
      LocationModelMapper.ensureInitialized();
  @override
  $R call({int? id, String? name, Object? address = $none}) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (address != $none) #address: address,
    }),
  );
  @override
  LocationModel $make(CopyWithData data) => LocationModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    address: data.get(#address, or: $value.address),
  );

  @override
  LocationModelCopyWith<$R2, LocationModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LocationModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

