// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'departments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DepartmentsCtrl)
final departmentsCtrlProvider = DepartmentsCtrlProvider._();

final class DepartmentsCtrlProvider
    extends $AsyncNotifierProvider<DepartmentsCtrl, List<DepartmentModel>> {
  DepartmentsCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'departmentsCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$departmentsCtrlHash();

  @$internal
  @override
  DepartmentsCtrl create() => DepartmentsCtrl();
}

String _$departmentsCtrlHash() => r'6f9d4dff1fb1a40b1ad9b7a8a963a1feabe70d19';

abstract class _$DepartmentsCtrl extends $AsyncNotifier<List<DepartmentModel>> {
  FutureOr<List<DepartmentModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<DepartmentModel>>, List<DepartmentModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<DepartmentModel>>,
                List<DepartmentModel>
              >,
              AsyncValue<List<DepartmentModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
