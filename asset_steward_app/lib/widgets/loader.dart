import 'package:material_ui/material_ui.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    this.size = 24,
    this.color,
    this.strokeWidth = 3.0,
  });

  final double? size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: size,
        child: CircularProgressIndicator.adaptive(
          strokeWidth: strokeWidth,
          valueColor: color != null ? AlwaysStoppedAnimation<Color>(color!) : null,
        ),
      ),
    );
  }
}
