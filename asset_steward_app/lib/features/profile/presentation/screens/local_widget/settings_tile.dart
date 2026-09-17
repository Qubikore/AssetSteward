import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? context.colors.error : context.colors.onSurface;
    final iconColor = isDestructive ? context.colors.error : context.colors.primary;

    return Material(
      type: .transparency,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: Insets.lg, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: iconColor.op(0.1), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: context.text.titleMedium?.copyWith(color: color, fontWeight: FontWeight.w500),
        ),
        trailing: isDestructive ? null : Icon(HIStroke.arrowRight01, size: 20, color: context.colors.onSurfaceVariant),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
