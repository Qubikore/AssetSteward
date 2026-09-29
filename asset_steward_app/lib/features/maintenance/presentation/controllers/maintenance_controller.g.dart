// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maintenance_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MaintenanceCtrl)
final maintenanceCtrlProvider = MaintenanceCtrlProvider._();

final class MaintenanceCtrlProvider
    extends $AsyncNotifierProvider<MaintenanceCtrl, List<MaintenanceModel>> {
  MaintenanceCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'maintenanceCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$maintenanceCtrlHash();

  @$internal
  @override
  MaintenanceCtrl create() => MaintenanceCtrl();
}

String _$maintenanceCtrlHash() => r'80082b282c47c06df498de8fbc5a413afa3444bb';

abstract class _$MaintenanceCtrl
    extends $AsyncNotifier<List<MaintenanceModel>> {
  FutureOr<List<MaintenanceModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<MaintenanceModel>>, List<MaintenanceModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MaintenanceModel>>,
                List<MaintenanceModel>
              >,
              AsyncValue<List<MaintenanceModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
