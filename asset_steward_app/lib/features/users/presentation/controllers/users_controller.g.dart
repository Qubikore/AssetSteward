// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UsersCtrl)
final usersCtrlProvider = UsersCtrlProvider._();

final class UsersCtrlProvider
    extends $AsyncNotifierProvider<UsersCtrl, List<ProfileData>> {
  UsersCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usersCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usersCtrlHash();

  @$internal
  @override
  UsersCtrl create() => UsersCtrl();
}

String _$usersCtrlHash() => r'cc9e35d66e87593c9971a4e9f489c6d5b180fa2a';

abstract class _$UsersCtrl extends $AsyncNotifier<List<ProfileData>> {
  FutureOr<List<ProfileData>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ProfileData>>, List<ProfileData>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProfileData>>, List<ProfileData>>,
              AsyncValue<List<ProfileData>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
