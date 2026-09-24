// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardMetricsCtrl)
final dashboardMetricsCtrlProvider = DashboardMetricsCtrlProvider._();

final class DashboardMetricsCtrlProvider
    extends $AsyncNotifierProvider<DashboardMetricsCtrl, DashboardMetrics> {
  DashboardMetricsCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardMetricsCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardMetricsCtrlHash();

  @$internal
  @override
  DashboardMetricsCtrl create() => DashboardMetricsCtrl();
}

String _$dashboardMetricsCtrlHash() =>
    r'97d79169a4a85701b47fe87a1218a4007f169098';

abstract class _$DashboardMetricsCtrl extends $AsyncNotifier<DashboardMetrics> {
  FutureOr<DashboardMetrics> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<DashboardMetrics>, DashboardMetrics>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DashboardMetrics>, DashboardMetrics>,
              AsyncValue<DashboardMetrics>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(AssetUtilizationCtrl)
final assetUtilizationCtrlProvider = AssetUtilizationCtrlProvider._();

final class AssetUtilizationCtrlProvider
    extends
        $AsyncNotifierProvider<AssetUtilizationCtrl, List<AssetUtilization>> {
  AssetUtilizationCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetUtilizationCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetUtilizationCtrlHash();

  @$internal
  @override
  AssetUtilizationCtrl create() => AssetUtilizationCtrl();
}

String _$assetUtilizationCtrlHash() =>
    r'cae46d15f2cc2d0261f99f86d5095ad00c030897';

abstract class _$AssetUtilizationCtrl
    extends $AsyncNotifier<List<AssetUtilization>> {
  FutureOr<List<AssetUtilization>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AssetUtilization>>, List<AssetUtilization>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AssetUtilization>>,
                List<AssetUtilization>
              >,
              AsyncValue<List<AssetUtilization>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
