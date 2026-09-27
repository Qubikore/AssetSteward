// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'assignment_response.dart';

class AssignmentResponseMapper extends ClassMapperBase<AssignmentResponse> {
  AssignmentResponseMapper._();

  static AssignmentResponseMapper? _instance;
  static AssignmentResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssignmentResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AssignmentResponse';

  static int _$id(AssignmentResponse v) => v.id;
  static const Field<AssignmentResponse, int> _f$id = Field('id', _$id);
  static int _$assetId(AssignmentResponse v) => v.assetId;
  static const Field<AssignmentResponse, int> _f$assetId = Field(
    'assetId',
    _$assetId,
  );
  static String _$assetName(AssignmentResponse v) => v.assetName;
  static const Field<AssignmentResponse, String> _f$assetName = Field(
    'assetName',
    _$assetName,
  );
  static String _$assetCode(AssignmentResponse v) => v.assetCode;
  static const Field<AssignmentResponse, String> _f$assetCode = Field(
    'assetCode',
    _$assetCode,
  );
  static int _$assignedToUserId(AssignmentResponse v) => v.assignedToUserId;
  static const Field<AssignmentResponse, int> _f$assignedToUserId = Field(
    'assignedToUserId',
    _$assignedToUserId,
  );
  static String _$assignedToEmail(AssignmentResponse v) => v.assignedToEmail;
  static const Field<AssignmentResponse, String> _f$assignedToEmail = Field(
    'assignedToEmail',
    _$assignedToEmail,
  );
  static int _$assignedByUserId(AssignmentResponse v) => v.assignedByUserId;
  static const Field<AssignmentResponse, int> _f$assignedByUserId = Field(
    'assignedByUserId',
    _$assignedByUserId,
  );
  static String _$assignedByEmail(AssignmentResponse v) => v.assignedByEmail;
  static const Field<AssignmentResponse, String> _f$assignedByEmail = Field(
    'assignedByEmail',
    _$assignedByEmail,
  );
  static String _$assignedAt(AssignmentResponse v) => v.assignedAt;
  static const Field<AssignmentResponse, String> _f$assignedAt = Field(
    'assignedAt',
    _$assignedAt,
  );
  static String? _$returnedAt(AssignmentResponse v) => v.returnedAt;
  static const Field<AssignmentResponse, String> _f$returnedAt = Field(
    'returnedAt',
    _$returnedAt,
    opt: true,
  );

  @override
  final MappableFields<AssignmentResponse> fields = const {
    #id: _f$id,
    #assetId: _f$assetId,
    #assetName: _f$assetName,
    #assetCode: _f$assetCode,
    #assignedToUserId: _f$assignedToUserId,
    #assignedToEmail: _f$assignedToEmail,
    #assignedByUserId: _f$assignedByUserId,
    #assignedByEmail: _f$assignedByEmail,
    #assignedAt: _f$assignedAt,
    #returnedAt: _f$returnedAt,
  };

  static AssignmentResponse _instantiate(DecodingData data) {
    return AssignmentResponse(
      id: data.dec(_f$id),
      assetId: data.dec(_f$assetId),
      assetName: data.dec(_f$assetName),
      assetCode: data.dec(_f$assetCode),
      assignedToUserId: data.dec(_f$assignedToUserId),
      assignedToEmail: data.dec(_f$assignedToEmail),
      assignedByUserId: data.dec(_f$assignedByUserId),
      assignedByEmail: data.dec(_f$assignedByEmail),
      assignedAt: data.dec(_f$assignedAt),
      returnedAt: data.dec(_f$returnedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AssignmentResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssignmentResponse>(map);
  }

  static AssignmentResponse fromJson(String json) {
    return ensureInitialized().decodeJson<AssignmentResponse>(json);
  }
}

mixin AssignmentResponseMappable {
  String toJson() {
    return AssignmentResponseMapper.ensureInitialized()
        .encodeJson<AssignmentResponse>(this as AssignmentResponse);
  }

  Map<String, dynamic> toMap() {
    return AssignmentResponseMapper.ensureInitialized()
        .encodeMap<AssignmentResponse>(this as AssignmentResponse);
  }

  AssignmentResponseCopyWith<
    AssignmentResponse,
    AssignmentResponse,
    AssignmentResponse
  >
  get copyWith =>
      _AssignmentResponseCopyWithImpl<AssignmentResponse, AssignmentResponse>(
        this as AssignmentResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssignmentResponseMapper.ensureInitialized().stringifyValue(
      this as AssignmentResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssignmentResponseMapper.ensureInitialized().equalsValue(
      this as AssignmentResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return AssignmentResponseMapper.ensureInitialized().hashValue(
      this as AssignmentResponse,
    );
  }
}

extension AssignmentResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssignmentResponse, $Out> {
  AssignmentResponseCopyWith<$R, AssignmentResponse, $Out>
  get $asAssignmentResponse => $base.as(
    (v, t, t2) => _AssignmentResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AssignmentResponseCopyWith<
  $R,
  $In extends AssignmentResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    int? assetId,
    String? assetName,
    String? assetCode,
    int? assignedToUserId,
    String? assignedToEmail,
    int? assignedByUserId,
    String? assignedByEmail,
    String? assignedAt,
    String? returnedAt,
  });
  AssignmentResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AssignmentResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssignmentResponse, $Out>
    implements AssignmentResponseCopyWith<$R, AssignmentResponse, $Out> {
  _AssignmentResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssignmentResponse> $mapper =
      AssignmentResponseMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    int? assetId,
    String? assetName,
    String? assetCode,
    int? assignedToUserId,
    String? assignedToEmail,
    int? assignedByUserId,
    String? assignedByEmail,
    String? assignedAt,
    Object? returnedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (assetId != null) #assetId: assetId,
      if (assetName != null) #assetName: assetName,
      if (assetCode != null) #assetCode: assetCode,
      if (assignedToUserId != null) #assignedToUserId: assignedToUserId,
      if (assignedToEmail != null) #assignedToEmail: assignedToEmail,
      if (assignedByUserId != null) #assignedByUserId: assignedByUserId,
      if (assignedByEmail != null) #assignedByEmail: assignedByEmail,
      if (assignedAt != null) #assignedAt: assignedAt,
      if (returnedAt != $none) #returnedAt: returnedAt,
    }),
  );
  @override
  AssignmentResponse $make(CopyWithData data) => AssignmentResponse(
    id: data.get(#id, or: $value.id),
    assetId: data.get(#assetId, or: $value.assetId),
    assetName: data.get(#assetName, or: $value.assetName),
    assetCode: data.get(#assetCode, or: $value.assetCode),
    assignedToUserId: data.get(#assignedToUserId, or: $value.assignedToUserId),
    assignedToEmail: data.get(#assignedToEmail, or: $value.assignedToEmail),
    assignedByUserId: data.get(#assignedByUserId, or: $value.assignedByUserId),
    assignedByEmail: data.get(#assignedByEmail, or: $value.assignedByEmail),
    assignedAt: data.get(#assignedAt, or: $value.assignedAt),
    returnedAt: data.get(#returnedAt, or: $value.returnedAt),
  );

  @override
  AssignmentResponseCopyWith<$R2, AssignmentResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssignmentResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

