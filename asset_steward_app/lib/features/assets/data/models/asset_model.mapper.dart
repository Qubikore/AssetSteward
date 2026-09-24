// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_model.dart';

class AssetModelMapper extends ClassMapperBase<AssetModel> {
  AssetModelMapper._();

  static AssetModelMapper? _instance;
  static AssetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AssetModel';

  static int _$id(AssetModel v) => v.id;
  static const Field<AssetModel, int> _f$id = Field('id', _$id);
  static String _$assetCode(AssetModel v) => v.assetCode;
  static const Field<AssetModel, String> _f$assetCode = Field(
    'assetCode',
    _$assetCode,
  );
  static String _$name(AssetModel v) => v.name;
  static const Field<AssetModel, String> _f$name = Field('name', _$name);
  static String? _$serialNumber(AssetModel v) => v.serialNumber;
  static const Field<AssetModel, String> _f$serialNumber = Field(
    'serialNumber',
    _$serialNumber,
    opt: true,
  );
  static String _$purchaseDate(AssetModel v) => v.purchaseDate;
  static const Field<AssetModel, String> _f$purchaseDate = Field(
    'purchaseDate',
    _$purchaseDate,
  );
  static String? _$expireDate(AssetModel v) => v.expireDate;
  static const Field<AssetModel, String> _f$expireDate = Field(
    'expireDate',
    _$expireDate,
    opt: true,
  );
  static double _$purchasePrice(AssetModel v) => v.purchasePrice;
  static const Field<AssetModel, double> _f$purchasePrice = Field(
    'purchasePrice',
    _$purchasePrice,
  );
  static String? _$vendor(AssetModel v) => v.vendor;
  static const Field<AssetModel, String> _f$vendor = Field(
    'vendor',
    _$vendor,
    opt: true,
  );
  static int _$quantity(AssetModel v) => v.quantity;
  static const Field<AssetModel, int> _f$quantity = Field(
    'quantity',
    _$quantity,
    opt: true,
    def: 0,
  );
  static String _$status(AssetModel v) => v.status;
  static const Field<AssetModel, String> _f$status = Field('status', _$status);
  static String? _$categoryName(AssetModel v) => v.categoryName;
  static const Field<AssetModel, String> _f$categoryName = Field(
    'categoryName',
    _$categoryName,
    opt: true,
  );
  static String? _$locationName(AssetModel v) => v.locationName;
  static const Field<AssetModel, String> _f$locationName = Field(
    'locationName',
    _$locationName,
    opt: true,
  );
  static String? _$departmentName(AssetModel v) => v.departmentName;
  static const Field<AssetModel, String> _f$departmentName = Field(
    'departmentName',
    _$departmentName,
    opt: true,
  );

  @override
  final MappableFields<AssetModel> fields = const {
    #id: _f$id,
    #assetCode: _f$assetCode,
    #name: _f$name,
    #serialNumber: _f$serialNumber,
    #purchaseDate: _f$purchaseDate,
    #expireDate: _f$expireDate,
    #purchasePrice: _f$purchasePrice,
    #vendor: _f$vendor,
    #quantity: _f$quantity,
    #status: _f$status,
    #categoryName: _f$categoryName,
    #locationName: _f$locationName,
    #departmentName: _f$departmentName,
  };

  static AssetModel _instantiate(DecodingData data) {
    return AssetModel(
      id: data.dec(_f$id),
      assetCode: data.dec(_f$assetCode),
      name: data.dec(_f$name),
      serialNumber: data.dec(_f$serialNumber),
      purchaseDate: data.dec(_f$purchaseDate),
      expireDate: data.dec(_f$expireDate),
      purchasePrice: data.dec(_f$purchasePrice),
      vendor: data.dec(_f$vendor),
      quantity: data.dec(_f$quantity),
      status: data.dec(_f$status),
      categoryName: data.dec(_f$categoryName),
      locationName: data.dec(_f$locationName),
      departmentName: data.dec(_f$departmentName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AssetModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AssetModel>(map);
  }

  static AssetModel fromJson(String json) {
    return ensureInitialized().decodeJson<AssetModel>(json);
  }
}

mixin AssetModelMappable {
  String toJson() {
    return AssetModelMapper.ensureInitialized().encodeJson<AssetModel>(
      this as AssetModel,
    );
  }

  Map<String, dynamic> toMap() {
    return AssetModelMapper.ensureInitialized().encodeMap<AssetModel>(
      this as AssetModel,
    );
  }

  AssetModelCopyWith<AssetModel, AssetModel, AssetModel> get copyWith =>
      _AssetModelCopyWithImpl<AssetModel, AssetModel>(
        this as AssetModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AssetModelMapper.ensureInitialized().stringifyValue(
      this as AssetModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return AssetModelMapper.ensureInitialized().equalsValue(
      this as AssetModel,
      other,
    );
  }

  @override
  int get hashCode {
    return AssetModelMapper.ensureInitialized().hashValue(this as AssetModel);
  }
}

extension AssetModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AssetModel, $Out> {
  AssetModelCopyWith<$R, AssetModel, $Out> get $asAssetModel =>
      $base.as((v, t, t2) => _AssetModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AssetModelCopyWith<$R, $In extends AssetModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? id,
    String? assetCode,
    String? name,
    String? serialNumber,
    String? purchaseDate,
    String? expireDate,
    double? purchasePrice,
    String? vendor,
    int? quantity,
    String? status,
    String? categoryName,
    String? locationName,
    String? departmentName,
  });
  AssetModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AssetModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AssetModel, $Out>
    implements AssetModelCopyWith<$R, AssetModel, $Out> {
  _AssetModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AssetModel> $mapper =
      AssetModelMapper.ensureInitialized();
  @override
  $R call({
    int? id,
    String? assetCode,
    String? name,
    Object? serialNumber = $none,
    String? purchaseDate,
    Object? expireDate = $none,
    double? purchasePrice,
    Object? vendor = $none,
    int? quantity,
    String? status,
    Object? categoryName = $none,
    Object? locationName = $none,
    Object? departmentName = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (assetCode != null) #assetCode: assetCode,
      if (name != null) #name: name,
      if (serialNumber != $none) #serialNumber: serialNumber,
      if (purchaseDate != null) #purchaseDate: purchaseDate,
      if (expireDate != $none) #expireDate: expireDate,
      if (purchasePrice != null) #purchasePrice: purchasePrice,
      if (vendor != $none) #vendor: vendor,
      if (quantity != null) #quantity: quantity,
      if (status != null) #status: status,
      if (categoryName != $none) #categoryName: categoryName,
      if (locationName != $none) #locationName: locationName,
      if (departmentName != $none) #departmentName: departmentName,
    }),
  );
  @override
  AssetModel $make(CopyWithData data) => AssetModel(
    id: data.get(#id, or: $value.id),
    assetCode: data.get(#assetCode, or: $value.assetCode),
    name: data.get(#name, or: $value.name),
    serialNumber: data.get(#serialNumber, or: $value.serialNumber),
    purchaseDate: data.get(#purchaseDate, or: $value.purchaseDate),
    expireDate: data.get(#expireDate, or: $value.expireDate),
    purchasePrice: data.get(#purchasePrice, or: $value.purchasePrice),
    vendor: data.get(#vendor, or: $value.vendor),
    quantity: data.get(#quantity, or: $value.quantity),
    status: data.get(#status, or: $value.status),
    categoryName: data.get(#categoryName, or: $value.categoryName),
    locationName: data.get(#locationName, or: $value.locationName),
    departmentName: data.get(#departmentName, or: $value.departmentName),
  );

  @override
  AssetModelCopyWith<$R2, AssetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

