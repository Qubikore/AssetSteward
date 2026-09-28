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
    extends $AsyncNotifierProvider<UsersCtrl, List<ProfileModel>> {
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

String _$usersCtrlHash() => r'2d60387e86cc87aea2d0c56b629e4f9984f65729';

abstract class _$UsersCtrl extends $AsyncNotifier<List<ProfileModel>> {
  FutureOr<List<ProfileModel>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ProfileModel>>, List<ProfileModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProfileModel>>, List<ProfileModel>>,
              AsyncValue<List<ProfileModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
