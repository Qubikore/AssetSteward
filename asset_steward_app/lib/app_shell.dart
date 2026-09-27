import 'package:asset_steward_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:asset_steward_app/main.export.dart';
import 'package:cue/cue.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:progressive_blur/progressive_blur.dart';
import 'package:screwdriver/screwdriver.dart';

final _navBarItems = [
  (icon: HIStroke.home01, label: 'Dashboard'),
  (icon: HIStroke.archive02, label: 'Assets'),
  (icon: HIStroke.scan, label: 'Scan'),
  (icon: HIStroke.repair, label: 'Maintenance'),
  (icon: HIStroke.userCircle, label: 'Profile'),
];

class AppShell extends HookConsumerWidget {
  const AppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);
    final rootPath = context.routeState.fullPath?.split('/').lastOrNull;

    useEffect(() {
      final index = RPaths.navRoutes.indexWhere((e) => e.path.removePrefix('/') == rootPath);
      if (index != -1) {
        currentIndex.value = index;
      }
      return null;
    }, [rootPath]);

    useEffect(() {
      final subscription = AppEventBus().on<SessionExpiredEvent>().listen((event) {
        Toast.showError('Session expired. Please log in again.');
        ref.read(authCtrlProvider.notifier).logout();
      });
      return subscription.cancel;
    }, const []);

    final mq = context.mq;
    final bottomPadding = mq.padding.bottom + 56 + 10;

    return Scaffold(
      extendBody: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final blurHeight = bottomPadding + 32 + 18;
          final startBlurFraction = 1.0 - (blurHeight / constraints.maxHeight).clamp(0.0, 1.0);

          return ProgressiveBlurWidget(
            sigma: 10.0,
            linearGradientBlur: LinearGradientBlur(
              start: .topCenter,
              end: .bottomCenter,
              stops: [0.0, startBlurFraction, 1.0],
              values: [0.0, 0.0, 1.0],
            ),
            child: MediaQuery(
              data: mq.copyWith(
                padding: EdgeInsets.only(
                  left: mq.padding.left,
                  top: mq.padding.top,
                  right: mq.padding.right,
                  bottom: bottomPadding,
                ),
              ),
              child: child,
            ),
          );
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: Container(
            height: 56,
            decoration: ShapeDecoration(
              color: context.colors.surface,
              shape: const StadiumBorder(),
              shadows: [BoxShadow(color: context.colors.shadow.op(0.1), blurRadius: 12, offset: const Offset(0, 8))],
            ),
            child: Row(
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
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({required this.item, required this.onTap, required this.selected});

  final ({IconData icon, String label}) item;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: selected ? 3 : 8),
        child: Cue.onToggle(
          toggled: selected,
          motion: const Spring.spatialSlow(),
          child: TweenActor<double>.value(
            from: 0.0,
            to: 1.0,
            builder: (context, value, child) {
              final positiveValue = value.clamp(0.0, double.infinity);
              final alphaValue = value.clamp(0.0, 1.0);

              final iconScale = (1.0 + (value * 0.15)).clamp(0.0, double.infinity);

              final indicatorWidth = positiveValue * 16.0;
              final indicatorHeight = positiveValue * 3.0;
              final gapHeight = positiveValue * 4.0;

              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.scale(
                    scale: iconScale,
                    child: Icon(
                      item.icon,
                      size: 20.0,
                      color: Color.lerp(context.colors.outline, context.colors.primary, alphaValue),
                    ),
                  ),
                  Gap(gapHeight),

                  Container(
                    height: indicatorHeight,
                    width: indicatorWidth,
                    decoration: ShapeDecoration(
                      color: context.colors.primary.withAlpha((alphaValue * 255).toInt()),
                      shape: const StadiumBorder(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
