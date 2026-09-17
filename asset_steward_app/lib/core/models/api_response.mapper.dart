// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'api_response.dart';

class ApiResponseMapper extends ClassMapperBase<ApiResponse> {
  ApiResponseMapper._();

  static ApiResponseMapper? _instance;
  static ApiResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ApiResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ApiResponse';
  @override
  Function get typeFactory =>
      <T>(f) => f<ApiResponse<T>>();

  static bool _$success(ApiResponse v) => v.success;
  static const Field<ApiResponse, bool> _f$success = Field(
    'success',
    _$success,
  );
  static int _$status(ApiResponse v) => v.status;
  static const Field<ApiResponse, int> _f$status = Field('status', _$status);
  static String _$message(ApiResponse v) => v.message;
  static const Field<ApiResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
    def: '',
  );
  static dynamic _$data(ApiResponse v) => v.data;
  static dynamic _arg$data<T>(f) => f<T>();
  static const Field<ApiResponse, dynamic> _f$data = Field(
    'data',
    _$data,
    opt: true,
    arg: _arg$data,
  );

  @override
  final MappableFields<ApiResponse> fields = const {
    #success: _f$success,
    #status: _f$status,
    #message: _f$message,
    #data: _f$data,
  };

  static ApiResponse<T> _instantiate<T>(DecodingData data) {
    return ApiResponse(
      success: data.dec(_f$success),
      status: data.dec(_f$status),
      message: data.dec(_f$message),
      data: data.dec(_f$data),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ApiResponse<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ApiResponse<T>>(map);
  }

  static ApiResponse<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<ApiResponse<T>>(json);
  }
}

mixin ApiResponseMappable<T> {
  String toJson() {
    return ApiResponseMapper.ensureInitialized().encodeJson<ApiResponse<T>>(
      this as ApiResponse<T>,
    );
  }

  Map<String, dynamic> toMap() {
    return ApiResponseMapper.ensureInitialized().encodeMap<ApiResponse<T>>(
      this as ApiResponse<T>,
    );
  }

  ApiResponseCopyWith<ApiResponse<T>, ApiResponse<T>, ApiResponse<T>, T>
  get copyWith => _ApiResponseCopyWithImpl<ApiResponse<T>, ApiResponse<T>, T>(
    this as ApiResponse<T>,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ApiResponseMapper.ensureInitialized().stringifyValue(
      this as ApiResponse<T>,
    );
  }

  @override
  bool operator ==(Object other) {
    return ApiResponseMapper.ensureInitialized().equalsValue(
      this as ApiResponse<T>,
      other,
    );
  }

  @override
  int get hashCode {
    return ApiResponseMapper.ensureInitialized().hashValue(
      this as ApiResponse<T>,
    );
  }
}

extension ApiResponseValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, ApiResponse<T>, $Out> {
  ApiResponseCopyWith<$R, ApiResponse<T>, $Out, T> get $asApiResponse =>
      $base.as((v, t, t2) => _ApiResponseCopyWithImpl<$R, $Out, T>(v, t, t2));
}

abstract class ApiResponseCopyWith<$R, $In extends ApiResponse<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? success, int? status, String? message, T? data});
  ApiResponseCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ApiResponseCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, ApiResponse<T>, $Out>
    implements ApiResponseCopyWith<$R, ApiResponse<T>, $Out, T> {
  _ApiResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ApiResponse> $mapper =
      ApiResponseMapper.ensureInitialized();
  @override
  $R call({
    bool? success,
    int? status,
    String? message,
    Object? data = $none,
  }) => $apply(
    FieldCopyWithData({
      if (success != null) #success: success,
      if (status != null) #status: status,
      if (message != null) #message: message,
      if (data != $none) #data: data,
    }),
  );
  @override
  ApiResponse<T> $make(CopyWithData data) => ApiResponse(
    success: data.get(#success, or: $value.success),
    status: data.get(#status, or: $value.status),
    message: data.get(#message, or: $value.message),
    data: data.get(#data, or: $value.data),
  );

  @override
  ApiResponseCopyWith<$R2, ApiResponse<T>, $Out2, T> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ApiResponseCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}

