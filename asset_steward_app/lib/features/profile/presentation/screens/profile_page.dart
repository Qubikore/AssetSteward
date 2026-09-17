import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../controllers/profile_controller.dart';

class ProfilePage extends HookConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileCtrlProvider);
    final orgAsync = ref.watch(organizationCtrlProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(HIStroke.logout05),
            onPressed: () => ref.read(authCtrlProvider.notifier).logout(),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(Insets.xl),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionTitle(context, 'Personal Information'),
                const Gap(Insets.md),
                profileAsync.when(
                  data: (data) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(Insets.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: data.profilePicture != null
                                    ? NetworkImage(data.profilePicture!)
                                    : null,
                                child: data.profilePicture == null ? Text(data.firstname[0] + data.lastname[0]) : null,
                              ),
                              const Gap(Insets.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${data.firstname} ${data.lastname}', style: context.text.titleLarge),
                                    Text(
                                      data.role,
                                      style: context.text.bodyMedium?.copyWith(color: context.colors.primary),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(Insets.lg),
                          _buildInfoRow(context, HIStroke.mail01, 'Email', data.email),
                          const Gap(Insets.sm),
                          _buildInfoRow(context, HIStroke.user, 'Gender', data.gender),
                          const Gap(Insets.sm),
                          if (data.dob != null) _buildInfoRow(context, HIStroke.calendar01, 'Date of Birth', data.dob!),
                        ],
                      ),
                    ),
                  ),
                  loading: () => const Center(child: Loader()),
                  error: (e, s) => Center(child: Text('Error: $e')),
                ),
                const Gap(Insets.xxl),
                _buildSectionTitle(context, 'Organization Information'),
                const Gap(Insets.md),
                orgAsync.when(
                  data: (data) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(Insets.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: context.colors.primaryContainer,
                                child: Icon(HIStroke.building04, color: context.colors.onPrimaryContainer),
                              ),
                              const Gap(Insets.md),
                              Expanded(child: Text(data.name, style: context.text.titleLarge)),
                            ],
                          ),
                          const Gap(Insets.lg),
                          _buildInfoRow(context, HIStroke.mail01, 'Email', data.email),
                          const Gap(Insets.sm),
                          _buildInfoRow(context, HIStroke.call02, 'Phone', data.phone),
                          const Gap(Insets.sm),
                          _buildInfoRow(context, HIStroke.location01, 'Location', data.location),
                        ],
                      ),
                    ),
                  ),
                  loading: () => const Center(child: Loader()),
                  error: (e, s) => Center(child: Text('Error: $e')),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.text.titleMedium?.copyWith(fontWeight: FontWeight.bold, color: context.colors.onSurfaceVariant),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: context.colors.onSurfaceVariant),
          const Gap(Insets.md),
          Expanded(
            flex: 2,
            child: Text(label, style: context.text.bodyMedium?.copyWith(color: context.colors.onSurfaceVariant)),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }
}
