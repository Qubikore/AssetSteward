// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_details_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssetDetailsCtrl)
final assetDetailsCtrlProvider = AssetDetailsCtrlFamily._();

final class AssetDetailsCtrlProvider
    extends $AsyncNotifierProvider<AssetDetailsCtrl, AssetModel> {
  AssetDetailsCtrlProvider._({
    required AssetDetailsCtrlFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'assetDetailsCtrlProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$assetDetailsCtrlHash();

  @override
  String toString() {
    return r'assetDetailsCtrlProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AssetDetailsCtrl create() => AssetDetailsCtrl();

  @override
  bool operator ==(Object other) {
    return other is AssetDetailsCtrlProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$assetDetailsCtrlHash() => r'93952c3dbc88099e4d8c96066d9d3ed8871ff80f';

final class AssetDetailsCtrlFamily extends $Family
    with
        $ClassFamilyOverride<
          AssetDetailsCtrl,
          AsyncValue<AssetModel>,
          AssetModel,
          FutureOr<AssetModel>,
          int
        > {
  AssetDetailsCtrlFamily._()
    : super(
        retry: null,
        name: r'assetDetailsCtrlProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  AssetDetailsCtrlProvider call(int id) =>
      AssetDetailsCtrlProvider._(argument: id, from: this);

  @override
  String toString() => r'assetDetailsCtrlProvider';
}

abstract class _$AssetDetailsCtrl extends $AsyncNotifier<AssetModel> {
  late final _$args = ref.$arg as int;
  int get id => _$args;

  FutureOr<AssetModel> build(int id);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AssetModel>, AssetModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AssetModel>, AssetModel>,
              AsyncValue<AssetModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
