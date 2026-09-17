import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:recase/recase.dart';

import 'package:asset_steward_app/features/profile/data/models/profile_data.dart';
import '../controllers/users_controller.dart';
import 'create_user_sheet.dart';

class ManageUsersPage extends HookConsumerWidget {
  const ManageUsersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersAsync = ref.watch(usersCtrlProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users'),
        centerTitle: true,
      ),
      body: AsyncBuilder(
        asyncValue: usersAsync,
        providers: [usersCtrlProvider],
        builder: (users) {
          if (users.isEmpty) {
            return const Center(child: Text('No users found.'));
          }

          return RefreshIndicator(
            onRefresh: () => ref.refresh(usersCtrlProvider.future),
            child: ListView.separated(
              padding: const EdgeInsets.all(Insets.lg),
              itemCount: users.length,
              separatorBuilder: (context, index) => const Gap(Insets.md),
              itemBuilder: (context, index) {
                final user = users[index];
                return _UserTile(user: user);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            showDragHandle: true,
            builder: (context) => const CreateUserSheet(),
          );
        },
        icon: const Icon(HIStroke.userAdd01),
        label: const Text('New User'),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  final ProfileData user;

  const _UserTile({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.md),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: context.colors.primaryContainer,
            backgroundImage: user.profilePicture != null ? NetworkImage(user.profilePicture!) : null,
            child: user.profilePicture == null
                ? Text(
                    '${user.firstname[0]}${user.lastname[0]}',
                    style: context.text.titleMedium?.copyWith(color: context.colors.onPrimaryContainer),
                  )
                : null,
          ),
          const Gap(Insets.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.firstname} ${user.lastname}',
                  style: context.text.titleMedium?.bold,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(2),
                Text(
                  user.email,
                  style: context.text.bodySmall?.textColor(context.colors.onSurfaceVariant),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const Gap(Insets.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: context.colors.primaryContainer,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              user.role.name.titleCase,
              style: context.text.labelSmall?.bold.letterSpace(.5).textColor(context.colors.onPrimaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}
