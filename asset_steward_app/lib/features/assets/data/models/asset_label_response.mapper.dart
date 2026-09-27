// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_label_response.dart';

class AssetLabelResponseMapper extends ClassMapperBase<AssetLabelResponse> {
  AssetLabelResponseMapper._();

  static AssetLabelResponseMapper? _instance;
  static AssetLabelResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetLabelResponseMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AssetLabelResponse';

  static int _$id(AssetLabelResponse v) => v.id;
  static const Field<AssetLabelResponse, int> _f$id = Field('id', _$id);
  static String _$name(AssetLabelResponse v) => v.name;
  static const Field<AssetLabelResponse, String> _f$name = Field(
    'name',
    _$name,
  );
  static String _$assetCode(AssetLabelResponse v) => v.assetCode;
  static const Field<AssetLabelResponse, String> _f$assetCode = Field(
    'assetCode',
    _$assetCode,
  );
  static double _$purchasePrice(AssetLabelResponse v) => v.purchasePrice;
  static const Field<AssetLabelResponse, double> _f$purchasePrice = Field(
    'purchasePrice',
    _$purchasePrice,
  );
  static String _$purchaseDate(AssetLabelResponse v) => v.purchaseDate;
  static const Field<AssetLabelResponse, String> _f$purchaseDate = Field(
    'purchaseDate',
    _$purchaseDate,
  );
  static String? _$expireDate(AssetLabelResponse v) => v.expireDate;
  static const Field<AssetLabelResponse, String> _f$expireDate = Field(
    'expireDate',
    _$expireDate,
    opt: true,
  );
  static String _$qrCodeBase64(AssetLabelResponse v) => v.qrCodeBase64;
  static const Field<AssetLabelResponse, String> _f$qrCodeBase64 = Field(
    'qrCodeBase64',
    _$qrCodeBase64,
  );

  @override
  final MappableFields<AssetLabelResponse> fields = const {
    #id: _f$id,
    #name: _f$name,
    #assetCode: _f$assetCode,
    #purchasePrice: _f$purchasePrice,
    #purchaseDate: _f$purchaseDate,
    #expireDate: _f$expireDate,
    #qrCodeBase64: _f$qrCodeBase64,
  };

  static AssetLabelResponse _instantiate(DecodingData data) {
    return AssetLabelResponse(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      assetCode: data.dec(_f$assetCode),
      purchasePrice: data.dec(_f$purchasePrice),
      purchaseDate: data.dec(_f$purchaseDate),
      expireDate: data.dec(_f$expireDate),
      qrCodeBase64: data.dec(_f$qrCodeBase64),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AssetLabelResponse fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssetLabelResponse>(map);
  }

  static AssetLabelResponse fromJson(String json) {
    return ensureInitialized().decodeJson<AssetLabelResponse>(json);
  }
}

mixin AssetLabelResponseMappable {
  String toJson() {
    return AssetLabelResponseMapper.ensureInitialized()
        .encodeJson<AssetLabelResponse>(this as AssetLabelResponse);
  }

  Map<String, dynamic> toMap() {
    return AssetLabelResponseMapper.ensureInitialized()
        .encodeMap<AssetLabelResponse>(this as AssetLabelResponse);
  }

  AssetLabelResponseCopyWith<
    AssetLabelResponse,
    AssetLabelResponse,
    AssetLabelResponse
  >
  get copyWith =>
      _AssetLabelResponseCopyWithImpl<AssetLabelResponse, AssetLabelResponse>(
        this as AssetLabelResponse,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssetLabelResponseMapper.ensureInitialized().stringifyValue(
      this as AssetLabelResponse,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssetLabelResponseMapper.ensureInitialized().equalsValue(
      this as AssetLabelResponse,
      other,
    );
  }

  @override
  int get hashCode {
    return AssetLabelResponseMapper.ensureInitialized().hashValue(
      this as AssetLabelResponse,
    );
  }
}

extension AssetLabelResponseValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssetLabelResponse, $Out> {
  AssetLabelResponseCopyWith<$R, AssetLabelResponse, $Out>
  get $asAssetLabelResponse => $base.as(
    (v, t, t2) => _AssetLabelResponseCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class AssetLabelResponseCopyWith<
  $R,
  $In extends AssetLabelResponse,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? name,
    String? assetCode,
    double? purchasePrice,
    String? purchaseDate,
    String? expireDate,
    String? qrCodeBase64,
  });
  AssetLabelResponseCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AssetLabelResponseCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssetLabelResponse, $Out>
    implements AssetLabelResponseCopyWith<$R, AssetLabelResponse, $Out> {
  _AssetLabelResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssetLabelResponse> $mapper =
      AssetLabelResponseMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    String? name,
    String? assetCode,
    double? purchasePrice,
    String? purchaseDate,
    Object? expireDate = $none,
    String? qrCodeBase64,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (assetCode != null) #assetCode: assetCode,
      if (purchasePrice != null) #purchasePrice: purchasePrice,
      if (purchaseDate != null) #purchaseDate: purchaseDate,
      if (expireDate != $none) #expireDate: expireDate,
      if (qrCodeBase64 != null) #qrCodeBase64: qrCodeBase64,
    }),
  );
  @override
  AssetLabelResponse $make(CopyWithData data) => AssetLabelResponse(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    assetCode: data.get(#assetCode, or: $value.assetCode),
    purchasePrice: data.get(#purchasePrice, or: $value.purchasePrice),
    purchaseDate: data.get(#purchaseDate, or: $value.purchaseDate),
    expireDate: data.get(#expireDate, or: $value.expireDate),
    qrCodeBase64: data.get(#qrCodeBase64, or: $value.qrCodeBase64),
  );

  @override
  AssetLabelResponseCopyWith<$R2, AssetLabelResponse, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssetLabelResponseCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

