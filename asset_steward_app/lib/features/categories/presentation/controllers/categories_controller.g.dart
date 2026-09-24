// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CategoriesCtrl)
final categoriesCtrlProvider = CategoriesCtrlProvider._();

final class CategoriesCtrlProvider
    extends $AsyncNotifierProvider<CategoriesCtrl, List<CategoryModel>> {
  CategoriesCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'categoriesCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$categoriesCtrlHash();

  @$internal
  @override
  CategoriesCtrl create() => CategoriesCtrl();
}

String _$categoriesCtrlHash() => r'8e9113910f418ae9fed6a777e08f4dee291721b1';

abstract class _$CategoriesCtrl extends $AsyncNotifier<List<CategoryModel>> {
  FutureOr<List<CategoryModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<CategoryModel>>, List<CategoryModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<CategoryModel>>, List<CategoryModel>>,
              AsyncValue<List<CategoryModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
