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

String _$assetDetailsCtrlHash() => r'ff3b94b10ef0d08c6fa8320117fbd4e4079f46e4';

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

@ProviderFor(assetHistory)
final assetHistoryProvider = AssetHistoryFamily._();

final class AssetHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AssetHistoryModel>>,
          List<AssetHistoryModel>,
          FutureOr<List<AssetHistoryModel>>
        >
    with
        $FutureModifier<List<AssetHistoryModel>>,
        $FutureProvider<List<AssetHistoryModel>> {
  AssetHistoryProvider._({
    required AssetHistoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'assetHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$assetHistoryHash();

  @override
  String toString() {
    return r'assetHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AssetHistoryModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AssetHistoryModel>> create(Ref ref) {
    final argument = this.argument as int;
    return assetHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$assetHistoryHash() => r'ff82221a5e5ae32fa92cf4e7e65ed4671add106c';

final class AssetHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<AssetHistoryModel>>, int> {
  AssetHistoryFamily._()
    : super(
        retry: null,
        name: r'assetHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AssetHistoryProvider call(int id) =>
      AssetHistoryProvider._(argument: id, from: this);

  @override
  String toString() => r'assetHistoryProvider';
}

@ProviderFor(assetAssignments)
final assetAssignmentsProvider = AssetAssignmentsFamily._();

final class AssetAssignmentsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<AssignmentModel>>,
          List<AssignmentModel>,
          FutureOr<List<AssignmentModel>>
        >
    with
        $FutureModifier<List<AssignmentModel>>,
        $FutureProvider<List<AssignmentModel>> {
  AssetAssignmentsProvider._({
    required AssetAssignmentsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'assetAssignmentsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$assetAssignmentsHash();

  @override
  String toString() {
    return r'assetAssignmentsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<AssignmentModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<AssignmentModel>> create(Ref ref) {
    final argument = this.argument as int;
    return assetAssignments(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AssetAssignmentsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$assetAssignmentsHash() => r'db7986a44ea328cb9657b328f580b825b03e1ecd';

final class AssetAssignmentsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<AssignmentModel>>, int> {
  AssetAssignmentsFamily._()
    : super(
        retry: null,
        name: r'assetAssignmentsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AssetAssignmentsProvider call(int id) =>
      AssetAssignmentsProvider._(argument: id, from: this);

  @override
  String toString() => r'assetAssignmentsProvider';
}
