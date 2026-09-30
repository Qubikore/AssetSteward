import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../controllers/profile_controller.dart';
import 'edit_profile_sheet.dart';
import 'local_widget/profile_header.dart';
import 'local_widget/profile_shimmer.dart';
import 'local_widget/section_title.dart';
import 'local_widget/settings_tile.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileCtrlProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(HIStroke.logout05),
            onPressed: () => ref.read(authCtrlProvider.notifier).logout(),
          ),
        ],
      ),
      body: AsyncBuilder(
        asyncValue: profileAsync,
        providers: [profileCtrlProvider],
        onLoading: () => const ProfilePageShimmer(),
        builder: (data) => RefreshIndicator(
          onRefresh: () =>
              Future.wait([ref.refresh(profileCtrlProvider.future), ref.refresh(organizationCtrlProvider.future)]),
          child: ListView(
            physics: kScrollPhysics,
            padding: const EdgeInsets.symmetric(
              horizontal: Insets.lg,
              vertical: Insets.md,
            ).copyWith(top: 6).withBottomEx(),
            children: [
              ProfileHeader(data: data),

              const Gap(Insets.lg),

              const SectionTitle(title: 'Settings'),
              const Gap(Insets.xs),
              Container(
                decoration: BoxDecoration(
                  color: context.colors.surfaceContainerHighest.op(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.colors.outlineVariant.op(0.5)),
                ),
                child: Column(
                  children:
                      [
                        SettingsTile(
                          icon: HIStroke.userEdit01,
                          title: 'Edit Profile',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              useRootNavigator: true,
                              showDragHandle: true,
                              builder: (context) => EditProfileSheet(profile: data),
                            );
                          },
                        ),

                        if (data.role == .superAdmin || data.role == .hr) ...[
                          SettingsTile(
                            icon: HIStroke.userGroup,
                            title: 'Manage Users',
                            onTap: () => RPaths.manageUsers.push(context),
                          ),

                          SettingsTile(
                            icon: HIStroke.location01,
                            title: 'Locations',
                            onTap: () => RPaths.locations.push(context),
                          ),

                          SettingsTile(
                            icon: HIStroke.building02,
                            title: 'Departments',
                            onTap: () => RPaths.departments.push(context),
                          ),

                          SettingsTile(
                            icon: HIStroke.tag01,
                            title: 'Categories',
                            onTap: () => RPaths.categories.push(context),
                          ),
                        ],

                        SettingsTile(
                          icon: HIStroke.moon02,
                          title: 'Dark Mode',
                          trailing: ScaleTransition(
                            scale: const AlwaysStoppedAnimation(.9),
                            child: Switch.adaptive(
                              thumbColor: WidgetStateProperty.resolveWith((s) {
                                if (s.isSelected) return context.colors.primary.lighten(50);
                                return null;
                              }),
                              padding: .zero,
                              value: ref.watch(themeModeControllerProvider) == .dark,
                              onChanged: (value) =>
                                  ref.read(themeModeControllerProvider.notifier).setThemeMode(value ? .dark : .light),
                            ),
                          ),
                          onTap: () => ref.read(themeModeControllerProvider.notifier).toggleTheme(),
                        ),

                        SettingsTile(
                          icon: HIStroke.informationCircle,
                          title: 'About App',
                          onTap: () => Toast.showInfo('$kAppName $kAppVersion'),
                        ),

                        SettingsTile(
                          icon: HIStroke.logout05,
                          title: 'Logout',
                          isDestructive: true,
                          onTap: () => ref.read(authCtrlProvider.notifier).logout(),
                        ),
                      ].separatedBy(
                        Divider(
                          height: 1,
                          indent: 56,
                          endIndent: Insets.md,
                          color: context.colors.outlineVariant.op(0.5),
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
