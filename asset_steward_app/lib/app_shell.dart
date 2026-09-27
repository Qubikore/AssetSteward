import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:screwdriver/screwdriver.dart';

class AppShell extends HookConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    useEffect(() {
      final subscription = AppEventBus().on<SessionExpiredEvent>().listen((event) {
        Toast.showError('Session expired. Please log in again.');
        ref.read(authCtrlProvider.notifier).logout();
      });
      return subscription.cancel;
    }, const []);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        constraints: const .tightFor(height: kBottomNavigationBarHeight),
        decoration: ShapeDecoration(
          color: context.colors.surfaceContainer,
          shape: const RoundedSuperellipseBorder(borderRadius: .vertical(top: Radius.circular(24))),
        ),
        child: Row(
          spacing: Insets.md,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ..._navBarItems.mapIndexed((i, item) {
              final selected = currentIndex.value == i;
              return _NavItem(
                item: item,
                onTap: () {
                  currentIndex.value = i;
                  RPaths.navRoutes[i].go(context);
                },
                selected: selected,
              );
            }),
          ],
        ),
      ),
    );

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex.value,
        onDestinationSelected: (index) {
          currentIndex.value = index;
          RPaths.navRoutes[index].go(context);
        },
        destinations: const [
          NavigationDestination(icon: Icon(HIStroke.home01, size: 20), label: 'Dashboard'),
          NavigationDestination(icon: Icon(HIStroke.archive02, size: 20), label: 'Assets'),
          NavigationDestination(icon: Icon(HIStroke.qrCodeScan, size: 20), label: 'Scan'),
          NavigationDestination(icon: Icon(HIStroke.wrench01, size: 20), label: 'Maintenance'),
          NavigationDestination(icon: Icon(HIStroke.user, size: 20), label: 'Profile'),
        ],
      ),
    );
  }
}

final _navBarItems = [
  (icon: HIStroke.home01, label: 'Dashboard'),
  (icon: HIStroke.archive02, label: 'Assets'),
  (icon: HIStroke.qrCodeScan, label: 'Scan'),
  (icon: HIStroke.wrench01, label: 'Maintenance'),
  (icon: HIStroke.user, label: 'Profile'),
];

class _NavItem extends StatelessWidget {
  const new({required this.item, required this.onTap, required this.selected});

  final ({IconData icon, String label}) item;
  final Function() onTap;

  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: Insets.sm, vertical: Insets.sm),
        decoration: BoxDecoration(color: context.colors.surfaceContainerHighest.op3),
        child: Icon(
          item.icon,
          size: selected ? 25 : 20,
          color: selected ? context.colors.primary : context.colors.outline,
        ),
      ),
    );
  }
}
