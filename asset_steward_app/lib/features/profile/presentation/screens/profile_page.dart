import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../data/models/profile_data.dart';
import '../controllers/profile_controller.dart';
import 'edit_profile_sheet.dart';

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

        builder: (data) => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(Insets.xl),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildProfileHeader(context, data),
                  const Gap(Insets.xxl),
                  _buildSectionTitle(context, 'Settings'),
                  const Gap(Insets.md),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        _buildSettingsTile(
                          context,
                          icon: HIStroke.userEdit01,
                          title: 'Edit Profile',
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              builder: (context) => EditProfileSheet(profile: data),
                            );
                          },
                        ),
                        const Divider(height: 1),
                        _buildSettingsTile(
                          context,
                          icon: HIStroke.informationCircle,
                          title: 'About App',
                          onTap: () {
                            Toast.showInfo('Asset Steward v1.0.0');
                          },
                        ),
                        const Divider(height: 1),
                        _buildSettingsTile(
                          context,
                          icon: HIStroke.logout05,
                          title: 'Logout',
                          isDestructive: true,
                          onTap: () => ref.read(authCtrlProvider.notifier).logout(),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileData data) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: data.profilePicture != null ? NetworkImage(data.profilePicture!) : null,
          child: data.profilePicture == null
              ? Text('${data.firstname[0]}${data.lastname[0]}', style: context.text.displaySmall)
              : null,
        ),
        const Gap(Insets.lg),
        Text(
          '${data.firstname} ${data.lastname}',
          style: context.text.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(Insets.xs),
        Text(
          data.role,
          style: context.text.bodyLarge?.copyWith(color: context.colors.primary, fontWeight: FontWeight.w500),
        ),
        const Gap(Insets.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(HIStroke.mail01, size: 16, color: context.colors.onSurfaceVariant),
            const Gap(Insets.sm),
            Text(data.email, style: context.text.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant)),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: context.colors.onSurfaceVariant),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? context.colors.error : context.colors.onSurface;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
      trailing: isDestructive ? null : const Icon(HIStroke.arrowRight01, size: 20),
      onTap: onTap,
    );
  }
}
