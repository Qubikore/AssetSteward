// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocationsCtrl)
final locationsCtrlProvider = LocationsCtrlProvider._();

final class LocationsCtrlProvider
    extends $AsyncNotifierProvider<LocationsCtrl, List<LocationModel>> {
  LocationsCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationsCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationsCtrlHash();

  @$internal
  @override
  LocationsCtrl create() => LocationsCtrl();
}

String _$locationsCtrlHash() => r'519f578fca9ff0e6f1845b59c1265e1b950101e2';

abstract class _$LocationsCtrl extends $AsyncNotifier<List<LocationModel>> {
  FutureOr<List<LocationModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<LocationModel>>, List<LocationModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<LocationModel>>, List<LocationModel>>,
              AsyncValue<List<LocationModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
