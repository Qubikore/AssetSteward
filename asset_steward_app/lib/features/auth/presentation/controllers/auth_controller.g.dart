// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthCtrl)
final authCtrlProvider = AuthCtrlProvider._();

final class AuthCtrlProvider extends $AsyncNotifierProvider<AuthCtrl, bool> {
  AuthCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authCtrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authCtrlHash();

  @$internal
  @override
  AuthCtrl create() => AuthCtrl();
}

String _$authCtrlHash() => r'a2719622141eaa9ed4ef34ea484e9215c5c77fff';

abstract class _$AuthCtrl extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
