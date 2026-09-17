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
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileCtrlHash();

  @$internal
  @override
  ProfileCtrl create() => ProfileCtrl();
}

String _$profileCtrlHash() => r'5a8456181d8bfe74758fc7f3db506502d4623e23';

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
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$organizationCtrlHash();

  @$internal
  @override
  OrganizationCtrl create() => OrganizationCtrl();
}

String _$organizationCtrlHash() => r'99e4e32dab95ab9e58593be8934e2cff55df824a';

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
