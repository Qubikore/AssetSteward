import 'package:asset_steward_app/main.export.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';

class CollapsibleSection extends HookWidget {
  final String title;
  final IconData? icon;
  final List<Widget> children;
  final bool initiallyExpanded;

  const CollapsibleSection({
    super.key,
    required this.title,
    required this.children,
    this.icon,
    this.initiallyExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    final expanded = useState(initiallyExpanded);
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.outlineVariant.op(0.3)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => expanded.value = !expanded.value,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(Insets.md),
              child: Row(
                children: [
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
              padding: const EdgeInsets.only(left: Insets.md, right: Insets.md, bottom: Insets.md),
              child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
            ),
            crossFadeState: expanded.value ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
