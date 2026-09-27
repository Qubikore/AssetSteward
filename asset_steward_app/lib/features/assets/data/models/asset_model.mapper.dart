// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'asset_model.dart';

class AssetStatusMapper extends EnumMapper<AssetStatus> {
  AssetStatusMapper._();

  static AssetStatusMapper? _instance;
  static AssetStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetStatusMapper._());
    }
    return _instance!;
  }

  static AssetStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AssetStatus decode(dynamic value) {
    switch (value) {
      case r'AVAILABLE':
        return AssetStatus.available;
      case r'ASSIGNED':
        return AssetStatus.assigned;
      case r'MAINTENANCE':
        return AssetStatus.maintenance;
      case r'PENDING_APPROVAL':
        return AssetStatus.pendingApproval;
      case r'RETIRED':
        return AssetStatus.retired;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AssetStatus self) {
    switch (self) {
      case AssetStatus.available:
        return r'AVAILABLE';
      case AssetStatus.assigned:
        return r'ASSIGNED';
      case AssetStatus.maintenance:
        return r'MAINTENANCE';
      case AssetStatus.pendingApproval:
        return r'PENDING_APPROVAL';
      case AssetStatus.retired:
        return r'RETIRED';
    }
  }
}

extension AssetStatusMapperExtension on AssetStatus {
  String toValue() {
    AssetStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AssetStatus>(this) as String;
  }
}

class AssetModelMapper extends ClassMapperBase<AssetModel> {
  AssetModelMapper._();

  static AssetModelMapper? _instance;
  static AssetModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AssetModelMapper._());
      AssetStatusMapper.ensureInitialized();
      CategoryModelMapper.ensureInitialized();
      LocationModelMapper.ensureInitialized();
      DepartmentModelMapper.ensureInitialized();
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
  static double _$purchasePrice(AssetModel v) => v.purchasePrice;
  static const Field<AssetModel, double> _f$purchasePrice = Field(
    'purchasePrice',
    _$purchasePrice,
  );
  static String _$purchaseDate(AssetModel v) => v.purchaseDate;
  static const Field<AssetModel, String> _f$purchaseDate = Field(
    'purchaseDate',
    _$purchaseDate,
  );
  static AssetStatus _$status(AssetModel v) => v.status;
  static const Field<AssetModel, AssetStatus> _f$status = Field(
    'status',
    _$status,
  );
  static String? _$serialNumber(AssetModel v) => v.serialNumber;
  static const Field<AssetModel, String> _f$serialNumber = Field(
    'serialNumber',
    _$serialNumber,
    opt: true,
  );
  static String? _$expireDate(AssetModel v) => v.expireDate;
  static const Field<AssetModel, String> _f$expireDate = Field(
    'expireDate',
    _$expireDate,
    opt: true,
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
  static CategoryModel? _$category(AssetModel v) => v.category;
  static const Field<AssetModel, CategoryModel> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );
  static LocationModel? _$location(AssetModel v) => v.location;
  static const Field<AssetModel, LocationModel> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static DepartmentModel? _$department(AssetModel v) => v.department;
  static const Field<AssetModel, DepartmentModel> _f$department = Field(
    'department',
    _$department,
    opt: true,
  );

  @override
  final MappableFields<AssetModel> fields = const {
    #id: _f$id,
    #assetCode: _f$assetCode,
    #name: _f$name,
    #purchasePrice: _f$purchasePrice,
    #purchaseDate: _f$purchaseDate,
    #status: _f$status,
    #serialNumber: _f$serialNumber,
    #expireDate: _f$expireDate,
    #vendor: _f$vendor,
    #quantity: _f$quantity,
    #category: _f$category,
    #location: _f$location,
    #department: _f$department,
  };

  static AssetModel _instantiate(DecodingData data) {
    return AssetModel(
      id: data.dec(_f$id),
      assetCode: data.dec(_f$assetCode),
      name: data.dec(_f$name),
      purchasePrice: data.dec(_f$purchasePrice),
      purchaseDate: data.dec(_f$purchaseDate),
      status: data.dec(_f$status),
      serialNumber: data.dec(_f$serialNumber),
      expireDate: data.dec(_f$expireDate),
      vendor: data.dec(_f$vendor),
      quantity: data.dec(_f$quantity),
      category: data.dec(_f$category),
      location: data.dec(_f$location),
      department: data.dec(_f$department),
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
  CategoryModelCopyWith<$R, CategoryModel, CategoryModel>? get category;
  LocationModelCopyWith<$R, LocationModel, LocationModel>? get location;
  DepartmentModelCopyWith<$R, DepartmentModel, DepartmentModel>? get department;
  $R call({
    int? id,
    String? assetCode,
    String? name,
    double? purchasePrice,
    String? purchaseDate,
    AssetStatus? status,
    String? serialNumber,
    String? expireDate,
    String? vendor,
    int? quantity,
    CategoryModel? category,
    LocationModel? location,
    DepartmentModel? department,
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
  CategoryModelCopyWith<$R, CategoryModel, CategoryModel>? get category =>
      $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  LocationModelCopyWith<$R, LocationModel, LocationModel>? get location =>
      $value.location?.copyWith.$chain((v) => call(location: v));
  @override
  DepartmentModelCopyWith<$R, DepartmentModel, DepartmentModel>?
  get department =>
      $value.department?.copyWith.$chain((v) => call(department: v));
  @override
  $R call({
    int? id,
    String? assetCode,
    String? name,
    double? purchasePrice,
    String? purchaseDate,
    AssetStatus? status,
    Object? serialNumber = $none,
    Object? expireDate = $none,
    Object? vendor = $none,
    int? quantity,
    Object? category = $none,
    Object? location = $none,
    Object? department = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (assetCode != null) #assetCode: assetCode,
      if (name != null) #name: name,
      if (purchasePrice != null) #purchasePrice: purchasePrice,
      if (purchaseDate != null) #purchaseDate: purchaseDate,
      if (status != null) #status: status,
      if (serialNumber != $none) #serialNumber: serialNumber,
      if (expireDate != $none) #expireDate: expireDate,
      if (vendor != $none) #vendor: vendor,
      if (quantity != null) #quantity: quantity,
      if (category != $none) #category: category,
      if (location != $none) #location: location,
      if (department != $none) #department: department,
    }),
  );
  @override
  AssetModel $make(CopyWithData data) => AssetModel(
    id: data.get(#id, or: $value.id),
    assetCode: data.get(#assetCode, or: $value.assetCode),
    name: data.get(#name, or: $value.name),
    purchasePrice: data.get(#purchasePrice, or: $value.purchasePrice),
    purchaseDate: data.get(#purchaseDate, or: $value.purchaseDate),
    status: data.get(#status, or: $value.status),
    serialNumber: data.get(#serialNumber, or: $value.serialNumber),
    expireDate: data.get(#expireDate, or: $value.expireDate),
    vendor: data.get(#vendor, or: $value.vendor),
    quantity: data.get(#quantity, or: $value.quantity),
    category: data.get(#category, or: $value.category),
    location: data.get(#location, or: $value.location),
    department: data.get(#department, or: $value.department),
  );

  @override
  AssetModelCopyWith<$R2, AssetModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AssetModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

