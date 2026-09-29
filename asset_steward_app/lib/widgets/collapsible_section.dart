import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

class CollapsibleSection extends HookWidget {
  final String title;
  final IconData? icon;
  final List<Widget> children;
  final bool initiallyExpanded;
  final double? paddings;
  final double? spacing;
  final double? titleGap;

  const CollapsibleSection({
    super.key,
    required this.title,
    required this.children,
    this.icon,
    this.initiallyExpanded = false,
    this.paddings,
    this.spacing,
    this.titleGap,
  });

  @override
  Widget build(BuildContext context) {
    final expanded = useState(initiallyExpanded);
    final effectivePaddings = paddings ?? Insets.lg;
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceContainerHighest.op2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.4)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => expanded.value = !expanded.value,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: EdgeInsets.all(effectivePaddings).copyWith(bottom: titleGap ?? effectivePaddings),
              child: Row(
                children: [
                  if (icon != null) ...[Icon(icon, color: context.colors.primary, size: 18), const Gap(Insets.md)],
                  Expanded(child: Text(title, style: context.text.titleMedium?.bold)),
                  AnimatedRotation(
                    turns: expanded.value ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(HIStroke.arrowDown01, color: context.colors.outline),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: EdgeInsets.only(left: effectivePaddings, right: effectivePaddings, bottom: effectivePaddings),
              child: Column(spacing: spacing ?? 0, crossAxisAlignment: .stretch, children: children),
            ),
            crossFadeState: expanded.value ? .showSecond : .showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
