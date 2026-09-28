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
    extends $AsyncNotifierProvider<MaintenanceCtrl, List<MaintenanceResponse>> {
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

String _$maintenanceCtrlHash() => r'8a756da593013878c3065c819275483bf6998214';

abstract class _$MaintenanceCtrl
    extends $AsyncNotifier<List<MaintenanceResponse>> {
  FutureOr<List<MaintenanceResponse>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<MaintenanceResponse>>,
              List<MaintenanceResponse>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<MaintenanceResponse>>,
                List<MaintenanceResponse>
              >,
              AsyncValue<List<MaintenanceResponse>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
