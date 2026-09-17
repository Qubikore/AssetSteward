import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';

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
        builder: (data) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.md),
          children: [
            _buildProfileHeader(context, data),
            const Gap(Insets.xxl),
            _buildSectionTitle(context, 'Settings'),
            const Gap(Insets.md),
            Container(
              decoration: BoxDecoration(
                color: context.colors.surfaceContainerHighest.op(0.3),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: context.colors.outlineVariant.op(0.5)),
              ),
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
                        useRootNavigator: true,
                        builder: (context) => EditProfileSheet(profile: data),
                      );
                    },
                  ),
                  Divider(height: 1, indent: 56, endIndent: Insets.md, color: context.colors.outlineVariant.op(0.5)),
                  _buildSettingsTile(
                    context,
                    icon: HIStroke.informationCircle,
                    title: 'About App',
                    onTap: () {
                      Toast.showInfo('Asset Steward v1.0.0');
                    },
                  ),
                  Divider(height: 1, indent: 56, endIndent: Insets.md, color: context.colors.outlineVariant.op(0.5)),
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
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileData data) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: context.colors.primary.op(0.2), width: 2),
          ),
          child: CircleAvatar(
            radius: 35,
            backgroundColor: context.colors.primaryContainer,
            backgroundImage: data.profilePicture != null ? NetworkImage(data.profilePicture!) : null,
            child: data.profilePicture == null
                ? Text(
                    '${data.firstname[0]}${data.lastname[0]}',
                    style: context.text.headlineMedium?.copyWith(color: context.colors.onPrimaryContainer),
                  )
                : null,
          ),
        ),
        const Gap(Insets.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${data.firstname} ${data.lastname}',
                style: context.text.titleLarge?.bold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              Row(
                children: [
                  Icon(HIStroke.mail01, size: 16, color: context.colors.onSurfaceVariant),
                  const Gap(Insets.sm),
                  Expanded(
                    child: Text(
                      data.email,
                      style: context.text.bodyMedium?.textColor(context.colors.onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (data.gender != null || data.dob != null) ...[
                const Gap(Insets.xs),
                Row(
                  children: [
                    if (data.gender != null) ...[
                      Icon(HIStroke.user, size: 14, color: context.colors.onSurfaceVariant),
                      const Gap(Insets.xs),
                      Text(
                        data.gender!.titleCase,
                        style: context.text.bodySmall?.copyWith(color: context.colors.onSurfaceVariant),
                      ),
                    ],
                    if (data.gender != null && data.dob != null) ...[
                      const Gap(Insets.sm),
                      Container(
                        width: 3,
                        height: 3,
                        decoration: BoxDecoration(color: context.colors.outlineVariant, shape: BoxShape.circle),
                      ),
                      const Gap(Insets.sm),
                    ],
                    if (data.dob != null) ...[
                      Icon(HIStroke.calendar01, size: 14, color: context.colors.onSurfaceVariant),
                      const Gap(Insets.xs),
                      Text(data.dob!, style: context.text.bodySmall?.copyWith(color: context.colors.onSurfaceVariant)),
                    ],
                  ],
                ),
              ],
              const Gap(Insets.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: context.colors.primaryContainer,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  data.role.titleCase,
                  style: context.text.labelSmall?.bold.letterSpace(.5).textColor(context.colors.onPrimaryContainer),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: Insets.xs),
      child: Text(
        title.toUpperCase(),
        style: context.text.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: context.colors.onSurfaceVariant.op(0.7),
          letterSpacing: 1.2,
        ),
      ),
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
    final iconColor = isDestructive ? context.colors.error : context.colors.primary;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: Insets.lg, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: iconColor.op(0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: context.text.titleMedium?.copyWith(color: color, fontWeight: FontWeight.w500),
      ),
      trailing: isDestructive ? null : Icon(HIStroke.arrowRight01, size: 20, color: context.colors.onSurfaceVariant),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}
