import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class AppShell extends HookConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex.value,
        onDestinationSelected: (index) {
          currentIndex.value = index;
          RPaths.navRoutes[index].go(context);
        },
        destinations: const [
          NavigationDestination(icon: Icon(HIStroke.home01, size: 20), label: 'Home'),
          NavigationDestination(icon: Icon(HIStroke.archive02, size: 20), label: 'Assets'),
          NavigationDestination(icon: Icon(HIStroke.qrCodeScan, size: 20), label: 'Scan'),
          NavigationDestination(icon: Icon(HIStroke.wrench01, size: 20), label: 'Maintenance'),
          NavigationDestination(icon: Icon(HIStroke.user, size: 20), label: 'Profile'),
        ],
      ),
    );
  }
}
