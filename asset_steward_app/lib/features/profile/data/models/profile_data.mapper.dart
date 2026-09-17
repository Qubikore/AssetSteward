// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile_data.dart';

class ProfileDataMapper extends ClassMapperBase<ProfileData> {
  ProfileDataMapper._();

  static ProfileDataMapper? _instance;
  static ProfileDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileData';

  static int _$id(ProfileData v) => v.id;
  static const Field<ProfileData, int> _f$id = Field('id', _$id);
  static String _$firstname(ProfileData v) => v.firstname;
  static const Field<ProfileData, String> _f$firstname = Field(
    'firstname',
    _$firstname,
  );
  static String _$lastname(ProfileData v) => v.lastname;
  static const Field<ProfileData, String> _f$lastname = Field(
    'lastname',
    _$lastname,
  );
  static String _$email(ProfileData v) => v.email;
  static const Field<ProfileData, String> _f$email = Field('email', _$email);
  static String _$role(ProfileData v) => v.role;
  static const Field<ProfileData, String> _f$role = Field('role', _$role);
  static String? _$gender(ProfileData v) => v.gender;
  static const Field<ProfileData, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
  );
  static String? _$dob(ProfileData v) => v.dob;
  static const Field<ProfileData, String> _f$dob = Field(
    'dob',
    _$dob,
    opt: true,
  );
  static String? _$profilePicture(ProfileData v) => v.profilePicture;
  static const Field<ProfileData, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    key: r'profile_picture',
    opt: true,
  );

  @override
  final MappableFields<ProfileData> fields = const {
    #id: _f$id,
    #firstname: _f$firstname,
    #lastname: _f$lastname,
    #email: _f$email,
    #role: _f$role,
    #gender: _f$gender,
    #dob: _f$dob,
    #profilePicture: _f$profilePicture,
  };

  static ProfileData _instantiate(DecodingData data) {
    return ProfileData(
      id: data.dec(_f$id),
      firstname: data.dec(_f$firstname),
      lastname: data.dec(_f$lastname),
      email: data.dec(_f$email),
      role: data.dec(_f$role),
      gender: data.dec(_f$gender),
      dob: data.dec(_f$dob),
      profilePicture: data.dec(_f$profilePicture),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProfileData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileData>(map);
  }

  static ProfileData fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileData>(json);
  }
}

mixin ProfileDataMappable {
  String toJson() {
    return ProfileDataMapper.ensureInitialized().encodeJson<ProfileData>(
      this as ProfileData,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileDataMapper.ensureInitialized().encodeMap<ProfileData>(
      this as ProfileData,
    );
  }

  ProfileDataCopyWith<ProfileData, ProfileData, ProfileData> get copyWith =>
      _ProfileDataCopyWithImpl<ProfileData, ProfileData>(
        this as ProfileData,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileDataMapper.ensureInitialized().stringifyValue(
      this as ProfileData,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProfileDataMapper.ensureInitialized().equalsValue(
      this as ProfileData,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileDataMapper.ensureInitialized().hashValue(this as ProfileData);
  }
}

extension ProfileDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileData, $Out> {
  ProfileDataCopyWith<$R, ProfileData, $Out> get $asProfileData =>
      $base.as((v, t, t2) => _ProfileDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileDataCopyWith<$R, $In extends ProfileData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? role,
    String? gender,
    String? dob,
    String? profilePicture,
  });
  ProfileDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileData, $Out>
    implements ProfileDataCopyWith<$R, ProfileData, $Out> {
  _ProfileDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileData> $mapper =
      ProfileDataMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    String? role,
    Object? gender = $none,
    Object? dob = $none,
    Object? profilePicture = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (firstname != null) #firstname: firstname,
      if (lastname != null) #lastname: lastname,
      if (email != null) #email: email,
      if (role != null) #role: role,
      if (gender != $none) #gender: gender,
      if (dob != $none) #dob: dob,
      if (profilePicture != $none) #profilePicture: profilePicture,
    }),
  );
  @override
  ProfileData $make(CopyWithData data) => ProfileData(
    id: data.get(#id, or: $value.id),
    firstname: data.get(#firstname, or: $value.firstname),
    lastname: data.get(#lastname, or: $value.lastname),
    email: data.get(#email, or: $value.email),
    role: data.get(#role, or: $value.role),
    gender: data.get(#gender, or: $value.gender),
    dob: data.get(#dob, or: $value.dob),
    profilePicture: data.get(#profilePicture, or: $value.profilePicture),
  );

  @override
  ProfileDataCopyWith<$R2, ProfileData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProfileDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

