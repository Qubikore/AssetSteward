import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.label,
    this.icon,
    this.subLabel,
    this.onReload,
    this.actions = const [],
  });

  final String label;
  final Widget? icon;
  final String? subLabel;
  final VoidCallback? onReload;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: Pads.allXL,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              IconTheme(
                data: IconThemeData(
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                child: icon!,
              ),
              const SizedBox(height: Insets.lg),
            ],
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            if (subLabel != null) ...[
              const SizedBox(height: Insets.sm),
              Text(
                subLabel!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
            if (onReload != null || actions.isNotEmpty) ...[
              const SizedBox(height: Insets.xl),
              Wrap(
                spacing: Insets.md,
                runSpacing: Insets.md,
                alignment: WrapAlignment.center,
                children: [
                  if (onReload != null)
                    FilledButton.tonalIcon(
                      onPressed: onReload,
                      icon: const Icon(HIStroke.refresh),
                      label: const Text('Reload'),
                    ),
                  ...actions,
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
