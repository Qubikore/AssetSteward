import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
          NavigationDestination(icon: Icon(HIStroke.home01), selectedIcon: Icon(HISolid.home01), label: 'Home'),
          NavigationDestination(icon: Icon(HIStroke.archive02), selectedIcon: Icon(HISolid.archive02), label: 'Assets'),
          NavigationDestination(icon: Icon(HIStroke.qrCode01), selectedIcon: Icon(HISolid.qrCode01), label: 'Scan'),
          NavigationDestination(
            icon: Icon(HIStroke.wrench01),
            selectedIcon: Icon(HISolid.wrench01),
            label: 'Maintenance',
          ),
          NavigationDestination(icon: Icon(HIStroke.user), selectedIcon: Icon(HISolid.user), label: 'Profile'),
        ],
      ),
    );
  }
}
