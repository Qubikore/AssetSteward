import 'package:asset_steward_app/main.export.dart';
import 'package:material_ui/material_ui.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Insets.xs),
      child: Text(
        title.toUpperCase(),
        style: context.text.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: context.colors.onSurfaceVariant.op(0.7),
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
