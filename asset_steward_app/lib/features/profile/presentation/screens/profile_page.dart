import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../controllers/profile_controller.dart';
import 'edit_profile_sheet.dart';
import 'local_widget/profile_header.dart';
import 'local_widget/section_title.dart';
import 'local_widget/settings_tile.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileCtrlProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: AsyncBuilder(
        asyncValue: profileAsync,
        providers: [profileCtrlProvider],
        builder: (data) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.md),
          children: [
            ProfileHeader(data: data),
            const Gap(Insets.xxl),
            const SectionTitle(title: 'Settings'),
            const Gap(Insets.md),
            Container(
              decoration: BoxDecoration(
                color: context.colors.surfaceContainerHighest.op(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.colors.outlineVariant.op(0.5)),
              ),
              child: Column(
                children: [
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
                  Divider(height: 1, indent: 56, endIndent: Insets.md, color: context.colors.outlineVariant.op(0.5)),

                  if (data.role == .superAdmin || data.role == .hr) ...[
                    SettingsTile(
                      icon: HIStroke.userGroup,
                      title: 'Manage Users',
                      onTap: () {
                        Toast.showInfo('Manage Users Feature Coming Soon');
                      },
                    ),
                    Divider(height: 1, indent: 56, endIndent: Insets.md, color: context.colors.outlineVariant.op(0.5)),
                  ],

                  SettingsTile(
                    icon: HIStroke.informationCircle,
                    title: 'About App',
                    onTap: () {
                      Toast.showInfo('Asset Steward v1.0.0');
                    },
                  ),
                  Divider(height: 1, indent: 56, endIndent: Insets.md, color: context.colors.outlineVariant.op(0.5)),
                  SettingsTile(
                    icon: HIStroke.logout05,
                    title: 'Logout',
                    isDestructive: true,
                    onTap: () => ref.read(authCtrlProvider.notifier).logout(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
