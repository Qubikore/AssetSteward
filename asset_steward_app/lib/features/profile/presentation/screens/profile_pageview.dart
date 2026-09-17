import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class ProfilePageview extends HookConsumerWidget {
  const ProfilePageview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: const Center(child: Text('Profile Page')),
    );
  }
}
