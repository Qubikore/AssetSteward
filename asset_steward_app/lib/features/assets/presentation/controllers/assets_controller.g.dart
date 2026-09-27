// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssetsCtrl)
final assetsCtrlProvider = AssetsCtrlProvider._();

final class AssetsCtrlProvider
    extends $AsyncNotifierProvider<AssetsCtrl, List<AssetModel>> {
  AssetsCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'assetsCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$assetsCtrlHash();

  @$internal
  @override
  AssetsCtrl create() => AssetsCtrl();
}

String _$assetsCtrlHash() => r'991f5005e8132fff467b4f46b35b68d544a1a5a7';

abstract class _$AssetsCtrl extends $AsyncNotifier<List<AssetModel>> {
  FutureOr<List<AssetModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<AssetModel>>, List<AssetModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AssetModel>>, List<AssetModel>>,
              AsyncValue<List<AssetModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
