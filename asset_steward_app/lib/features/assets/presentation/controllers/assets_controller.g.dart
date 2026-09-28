// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AssetsCtrl)
final assetsCtrlProvider = AssetsCtrlFamily._();

final class AssetsCtrlProvider
    extends $AsyncNotifierProvider<AssetsCtrl, List<AssetModel>> {
  AssetsCtrlProvider._({
    required AssetsCtrlFamily super.from,
    required AssetStatus? super.argument,
  }) : super(
         retry: null,
         name: r'assetsCtrlProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$assetsCtrlHash();

  @override
  String toString() {
    return r'assetsCtrlProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AssetsCtrl create() => AssetsCtrl();

  @override
  bool operator ==(Object other) {
    return other is AssetsCtrlProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$assetsCtrlHash() => r'53585a1b6d3266f4fa86adef0505c5755a99163b';

final class AssetsCtrlFamily extends $Family
    with
        $ClassFamilyOverride<
          AssetsCtrl,
          AsyncValue<List<AssetModel>>,
          List<AssetModel>,
          FutureOr<List<AssetModel>>,
          AssetStatus?
        > {
  AssetsCtrlFamily._()
    : super(
        retry: null,
        name: r'assetsCtrlProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  AssetsCtrlProvider call([AssetStatus? status]) =>
      AssetsCtrlProvider._(argument: status, from: this);

  @override
  String toString() => r'assetsCtrlProvider';
}

abstract class _$AssetsCtrl extends $AsyncNotifier<List<AssetModel>> {
  late final _$args = ref.$arg as AssetStatus?;
  AssetStatus? get status => _$args;

  FutureOr<List<AssetModel>> build([AssetStatus? status]);
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
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(MyAssetsCtrl)
final myAssetsCtrlProvider = MyAssetsCtrlProvider._();

final class MyAssetsCtrlProvider
    extends $AsyncNotifierProvider<MyAssetsCtrl, List<AssignmentModel>> {
  MyAssetsCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myAssetsCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myAssetsCtrlHash();

  @$internal
  @override
  MyAssetsCtrl create() => MyAssetsCtrl();
}

String _$myAssetsCtrlHash() => r'794f7b7cc1a55f944d9571182a611ef85ca80344';

abstract class _$MyAssetsCtrl extends $AsyncNotifier<List<AssignmentModel>> {
  FutureOr<List<AssignmentModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AssignmentModel>>, List<AssignmentModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AssignmentModel>>,
                List<AssignmentModel>
              >,
              AsyncValue<List<AssignmentModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
