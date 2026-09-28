// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'profile_model.dart';

class UserRoleMapper extends EnumMapper<UserRole> {
  UserRoleMapper._();

  static UserRoleMapper? _instance;
  static UserRoleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UserRoleMapper._());
    }
    return _instance!;
  }

  static UserRole fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  UserRole decode(dynamic value) {
    switch (value) {
      case r'SUPER_ADMIN':
        return UserRole.superAdmin;
      case r'HR':
        return UserRole.hr;
      case r'USER':
        return UserRole.user;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(UserRole self) {
    switch (self) {
      case UserRole.superAdmin:
        return r'SUPER_ADMIN';
      case UserRole.hr:
        return r'HR';
      case UserRole.user:
        return r'USER';
    }
  }
}

extension UserRoleMapperExtension on UserRole {
  String toValue() {
    UserRoleMapper.ensureInitialized();
    return MapperContainer.globals.toValue<UserRole>(this) as String;
  }
}

class ProfileModelMapper extends ClassMapperBase<ProfileModel> {
  ProfileModelMapper._();

  static ProfileModelMapper? _instance;
  static ProfileModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProfileModelMapper._());
      UserRoleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProfileModel';

  static int _$id(ProfileModel v) => v.id;
  static const Field<ProfileModel, int> _f$id = Field('id', _$id);
  static String _$firstname(ProfileModel v) => v.firstname;
  static const Field<ProfileModel, String> _f$firstname = Field(
    'firstname',
    _$firstname,
  );
  static String _$lastname(ProfileModel v) => v.lastname;
  static const Field<ProfileModel, String> _f$lastname = Field(
    'lastname',
    _$lastname,
  );
  static String _$email(ProfileModel v) => v.email;
  static const Field<ProfileModel, String> _f$email = Field('email', _$email);
  static UserRole _$role(ProfileModel v) => v.role;
  static const Field<ProfileModel, UserRole> _f$role = Field('role', _$role);
  static String? _$gender(ProfileModel v) => v.gender;
  static const Field<ProfileModel, String> _f$gender = Field(
    'gender',
    _$gender,
    opt: true,
  );
  static String? _$dob(ProfileModel v) => v.dob;
  static const Field<ProfileModel, String> _f$dob = Field(
    'dob',
    _$dob,
    opt: true,
  );
  static String? _$profilePicture(ProfileModel v) => v.profilePicture;
  static const Field<ProfileModel, String> _f$profilePicture = Field(
    'profilePicture',
    _$profilePicture,
    key: r'profile_picture',
    opt: true,
  );

  @override
  final MappableFields<ProfileModel> fields = const {
    #id: _f$id,
    #firstname: _f$firstname,
    #lastname: _f$lastname,
    #email: _f$email,
    #role: _f$role,
    #gender: _f$gender,
    #dob: _f$dob,
    #profilePicture: _f$profilePicture,
  };

  static ProfileModel _instantiate(DecodingData data) {
    return ProfileModel(
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

  static ProfileModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProfileModel>(map);
  }

  static ProfileModel fromJson(String json) {
    return ensureInitialized().decodeJson<ProfileModel>(json);
  }
}

mixin ProfileModelMappable {
  String toJson() {
    return ProfileModelMapper.ensureInitialized().encodeJson<ProfileModel>(
      this as ProfileModel,
    );
  }

  Map<String, dynamic> toMap() {
    return ProfileModelMapper.ensureInitialized().encodeMap<ProfileModel>(
      this as ProfileModel,
    );
  }

  ProfileModelCopyWith<ProfileModel, ProfileModel, ProfileModel> get copyWith =>
      _ProfileModelCopyWithImpl<ProfileModel, ProfileModel>(
        this as ProfileModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProfileModelMapper.ensureInitialized().stringifyValue(
      this as ProfileModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProfileModelMapper.ensureInitialized().equalsValue(
      this as ProfileModel,
      other,
    );
  }

  @override
  int get hashCode {
    return ProfileModelMapper.ensureInitialized().hashValue(
      this as ProfileModel,
    );
  }
}

extension ProfileModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProfileModel, $Out> {
  ProfileModelCopyWith<$R, ProfileModel, $Out> get $asProfileModel =>
      $base.as((v, t, t2) => _ProfileModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProfileModelCopyWith<$R, $In extends ProfileModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    UserRole? role,
    String? gender,
    String? dob,
    String? profilePicture,
  });
  ProfileModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProfileModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProfileModel, $Out>
    implements ProfileModelCopyWith<$R, ProfileModel, $Out> {
  _ProfileModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProfileModel> $mapper =
      ProfileModelMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    String? firstname,
    String? lastname,
    String? email,
    UserRole? role,
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
  ProfileModel $make(CopyWithData data) => ProfileModel(
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
  ProfileModelCopyWith<$R2, ProfileModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProfileModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

