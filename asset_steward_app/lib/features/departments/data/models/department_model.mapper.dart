// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'department_model.dart';

class DepartmentModelMapper extends ClassMapperBase<DepartmentModel> {
  DepartmentModelMapper._();

  static DepartmentModelMapper? _instance;
  static DepartmentModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DepartmentModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DepartmentModel';

  static int _$id(DepartmentModel v) => v.id;
  static const Field<DepartmentModel, int> _f$id = Field('id', _$id);
  static String _$name(DepartmentModel v) => v.name;
  static const Field<DepartmentModel, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<DepartmentModel> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static DepartmentModel _instantiate(DecodingData data) {
    return DepartmentModel(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static DepartmentModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DepartmentModel>(map);
  }

  static DepartmentModel fromJson(String json) {
    return ensureInitialized().decodeJson<DepartmentModel>(json);
  }
}

mixin DepartmentModelMappable {
  String toJson() {
    return DepartmentModelMapper.ensureInitialized()
        .encodeJson<DepartmentModel>(this as DepartmentModel);
  }

  Map<String, dynamic> toMap() {
    return DepartmentModelMapper.ensureInitialized().encodeMap<DepartmentModel>(
      this as DepartmentModel,
    );
  }

  DepartmentModelCopyWith<DepartmentModel, DepartmentModel, DepartmentModel>
  get copyWith =>
      _DepartmentModelCopyWithImpl<DepartmentModel, DepartmentModel>(
        this as DepartmentModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DepartmentModelMapper.ensureInitialized().stringifyValue(
      this as DepartmentModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return DepartmentModelMapper.ensureInitialized().equalsValue(
      this as DepartmentModel,
      other,
    );
  }

  @override
  int get hashCode {
    return DepartmentModelMapper.ensureInitialized().hashValue(
      this as DepartmentModel,
    );
  }
}

extension DepartmentModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DepartmentModel, $Out> {
  DepartmentModelCopyWith<$R, DepartmentModel, $Out> get $asDepartmentModel =>
      $base.as((v, t, t2) => _DepartmentModelCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DepartmentModelCopyWith<$R, $In extends DepartmentModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({int? id, String? name});
  DepartmentModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DepartmentModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DepartmentModel, $Out>
    implements DepartmentModelCopyWith<$R, DepartmentModel, $Out> {
  _DepartmentModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DepartmentModel> $mapper =
      DepartmentModelMapper.ensureInitialized();
  @override
  $R call({int? id, String? name}) => $apply(
    FieldCopyWithData({if (id != null) #id: id, if (name != null) #name: name}),
  );
  @override
  DepartmentModel $make(CopyWithData data) => DepartmentModel(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
  );

  @override
  DepartmentModelCopyWith<$R2, DepartmentModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DepartmentModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

