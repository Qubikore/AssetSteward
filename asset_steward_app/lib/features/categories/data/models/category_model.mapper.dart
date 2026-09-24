// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'category_model.dart';

class CategoryModelMapper extends ClassMapperBase<CategoryModel> {
  CategoryModelMapper._();

  static CategoryModelMapper? _instance;
  static CategoryModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CategoryModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CategoryModel';

  static int _$id(CategoryModel v) => v.id;
  static const Field<CategoryModel, int> _f$id = Field('id', _$id);
  static String _$name(CategoryModel v) => v.name;
  static const Field<CategoryModel, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<CategoryModel> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static CategoryModel _instantiate(DecodingData data) {
    return CategoryModel(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static CategoryModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CategoryModel>(map);
  }

  static CategoryModel fromJson(String json) {
    return ensureInitialized().decodeJson<CategoryModel>(json);
  }
}

mixin CategoryModelMappable {
  String toJson() {
    return CategoryModelMapper.ensureInitialized().encodeJson<CategoryModel>(
      this as CategoryModel,
    );
  }

  Map<String, dynamic> toMap() {
    return CategoryModelMapper.ensureInitialized().encodeMap<CategoryModel>(
      this as CategoryModel,
    );
  }

  CategoryModelCopyWith<CategoryModel, CategoryModel, CategoryModel>
  get copyWith => _CategoryModelCopyWithImpl<CategoryModel, CategoryModel>(
    this as CategoryModel,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return CategoryModelMapper.ensureInitialized().stringifyValue(
      this as CategoryModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return CategoryModelMapper.ensureInitialized().equalsValue(
      this as CategoryModel,
      other,
    );
  }

  @override
  int get hashCode {
    return CategoryModelMapper.ensureInitialized().hashValue(
      this as CategoryModel,
    );
  }
}

extension CategoryModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CategoryModel, $Out> {
  CategoryModelCopyWith<$R, CategoryModel, $Out> get $asCategoryModel =>
      $base.as((v, t, t2) => _CategoryModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CategoryModelCopyWith<$R, $In extends CategoryModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? name});
  CategoryModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CategoryModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CategoryModel, $Out>
    implements CategoryModelCopyWith<$R, CategoryModel, $Out> {
  _CategoryModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CategoryModel> $mapper =
      CategoryModelMapper.ensureInitialized();
  @override
  $R call({int? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  CategoryModel $make(CopyWithData data) => CategoryModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  CategoryModelCopyWith<$R2, CategoryModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CategoryModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

