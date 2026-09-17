// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProfileCtrl)
final profileCtrlProvider = ProfileCtrlProvider._();

final class ProfileCtrlProvider
    extends $AsyncNotifierProvider<ProfileCtrl, ProfileData> {
  ProfileCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileCtrlHash();

  @$internal
  @override
  ProfileCtrl create() => ProfileCtrl();
}

String _$profileCtrlHash() => r'35f35e7b595f7bc81d8e785f0fb3f68afea12693';

abstract class _$ProfileCtrl extends $AsyncNotifier<ProfileData> {
  FutureOr<ProfileData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProfileData>, ProfileData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProfileData>, ProfileData>,
              AsyncValue<ProfileData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(OrganizationCtrl)
final organizationCtrlProvider = OrganizationCtrlProvider._();

final class OrganizationCtrlProvider
    extends $AsyncNotifierProvider<OrganizationCtrl, OrganizationData> {
  OrganizationCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'organizationCtrlProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$organizationCtrlHash();

  @$internal
  @override
  OrganizationCtrl create() => OrganizationCtrl();
}

String _$organizationCtrlHash() => r'b2b36badc2c7f2992a5f6063091c6754f4adf80a';

abstract class _$OrganizationCtrl extends $AsyncNotifier<OrganizationData> {
  FutureOr<OrganizationData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<OrganizationData>, OrganizationData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<OrganizationData>, OrganizationData>,
              AsyncValue<OrganizationData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
