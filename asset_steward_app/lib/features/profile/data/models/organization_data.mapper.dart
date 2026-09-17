// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'organization_data.dart';

class OrganizationDataMapper extends ClassMapperBase<OrganizationData> {
  OrganizationDataMapper._();

  static OrganizationDataMapper? _instance;
  static OrganizationDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = OrganizationDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'OrganizationData';

  static int _$id(OrganizationData v) => v.id;
  static const Field<OrganizationData, int> _f$id = Field('id', _$id);
  static String _$name(OrganizationData v) => v.name;
  static const Field<OrganizationData, String> _f$name = Field('name', _$name);
  static String _$phone(OrganizationData v) => v.phone;
  static const Field<OrganizationData, String> _f$phone = Field(
    'phone',
    _$phone,
  );
  static String _$email(OrganizationData v) => v.email;
  static const Field<OrganizationData, String> _f$email = Field(
    'email',
    _$email,
  );
  static String _$location(OrganizationData v) => v.location;
  static const Field<OrganizationData, String> _f$location = Field(
    'location',
    _$location,
  );

  @override
  final MappableFields<OrganizationData> fields = const {
    #id: _f$id,
    #name: _f$name,
    #phone: _f$phone,
    #email: _f$email,
    #location: _f$location,
  };

  static OrganizationData _instantiate(DecodingData data) {
    return OrganizationData(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
      email: data.dec(_f$email),
      location: data.dec(_f$location),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static OrganizationData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<OrganizationData>(map);
  }

  static OrganizationData fromJson(String json) {
    return ensureInitialized().decodeJson<OrganizationData>(json);
  }
}

mixin OrganizationDataMappable {
  String toJson() {
    return OrganizationDataMapper.ensureInitialized()
        .encodeJson<OrganizationData>(this as OrganizationData);
  }

  Map<String, dynamic> toMap() {
    return OrganizationDataMapper.ensureInitialized()
        .encodeMap<OrganizationData>(this as OrganizationData);
  }

  OrganizationDataCopyWith<OrganizationData, OrganizationData, OrganizationData>
  get copyWith =>
      _OrganizationDataCopyWithImpl<OrganizationData, OrganizationData>(
        this as OrganizationData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return OrganizationDataMapper.ensureInitialized().stringifyValue(
      this as OrganizationData,
    );
  }

  @override
  bool operator ==(Object other) {
    return OrganizationDataMapper.ensureInitialized().equalsValue(
      this as OrganizationData,
      other,
    );
  }

  @override
  int get hashCode {
    return OrganizationDataMapper.ensureInitialized().hashValue(
      this as OrganizationData,
    );
  }
}

extension OrganizationDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, OrganizationData, $Out> {
  OrganizationDataCopyWith<$R, OrganizationData, $Out>
  get $asOrganizationData =>
      $base.as((v, t, t2) => _OrganizationDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class OrganizationDataCopyWith<$R, $In extends OrganizationData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? location,
  });
  OrganizationDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _OrganizationDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, OrganizationData, $Out>
    implements OrganizationDataCopyWith<$R, OrganizationData, $Out> {
  _OrganizationDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<OrganizationData> $mapper =
      OrganizationDataMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    String? name,
    String? phone,
    String? email,
    String? location,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (phone != null) #phone: phone,
      if (email != null) #email: email,
      if (location != null) #location: location,
    }),
  );
  @override
  OrganizationData $make(CopyWithData data) => OrganizationData(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    email: data.get(#email, or: $value.email),
    location: data.get(#location, or: $value.location),
  );

  @override
  OrganizationDataCopyWith<$R2, OrganizationData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _OrganizationDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

